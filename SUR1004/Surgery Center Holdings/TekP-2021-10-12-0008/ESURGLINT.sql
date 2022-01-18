/**********************************************************************************

ESURGLINT: Glint Survey Demo

FormatCode:     ESURGLINT
Project:        Glint Survey Demo
Client ID:      SUR1004
Date/time:      2022-01-18 08:34:44.293
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_SRGY
Web Filename:   SUR1004_WUIU2_EEHISTORY_ESURGLINT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESURGLINT_SavePath') IS NOT NULL DROP TABLE dbo.U_ESURGLINT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESURGLINT'


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
WHERE FormatCode = 'ESURGLINT'
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
WHERE ExpFormatCode = 'ESURGLINT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESURGLINT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESURGLINT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESURGLINT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESURGLINT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESURGLINT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESURGLINT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESURGLINT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESURGLINT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESURGLINT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESURGLINT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESURGLINT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESURGLINT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESURGLINT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESURGLINT];
GO
IF OBJECT_ID('U_ESURGLINT_File') IS NOT NULL DROP TABLE [dbo].[U_ESURGLINT_File];
GO
IF OBJECT_ID('U_ESURGLINT_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESURGLINT_EEList];
GO
IF OBJECT_ID('U_ESURGLINT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESURGLINT_drvTbl];
GO
IF OBJECT_ID('U_ESURGLINT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESURGLINT_AuditFields];
GO
IF OBJECT_ID('U_ESURGLINT_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESURGLINT_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESURGLINT','Glint Survey Demo','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ESURGLINT0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESURGLINT0Z0','50','H','01','1',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESURGLINT0Z0','50','H','01','2',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESURGLINT0Z0','50','H','01','3',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESURGLINT0Z0','50','H','01','4',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESURGLINT0Z0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESURGLINT0Z0','50','H','01','6',NULL,'Manager ID',NULL,NULL,'"Manager ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESURGLINT0Z0','50','H','01','7',NULL,'Job Level',NULL,NULL,'"Job Level"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESURGLINT0Z0','50','H','01','8',NULL,'Organization Report Category',NULL,NULL,'"Organization Report Category"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESURGLINT0Z0','50','H','01','9',NULL,'Home Company Name',NULL,NULL,'"Home Company Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESURGLINT0Z0','50','H','01','10',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESURGLINT0Z0','50','H','01','11',NULL,'Pay Group',NULL,NULL,'"Pay Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESURGLINT0Z0','50','H','01','12',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESURGLINT0Z0','50','H','01','13',NULL,'State/Province',NULL,NULL,'"State/Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESURGLINT0Z0','50','H','01','14',NULL,'Date In Job',NULL,NULL,'"Date In Job"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESURGLINT0Z0','50','H','01','15',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESURGLINT0Z0','50','H','01','16',NULL,'Last Hire Date',NULL,NULL,'"Last Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESURGLINT0Z0','50','H','01','17',NULL,'Date Of Birth',NULL,NULL,'"Date Of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESURGLINT0Z0','50','H','01','18',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESURGLINT0Z0','50','H','01','19',NULL,'Gender Code',NULL,NULL,'"Gender Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESURGLINT0Z0','50','H','01','20',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESURGLINT0Z0','50','H','01','21',NULL,'Job Code',NULL,NULL,'"Job Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESURGLINT0Z0','50','H','01','22',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESURGLINT0Z0','50','H','01','23',NULL,'Facility Code',NULL,NULL,'"Facility Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESURGLINT0Z0','50','H','01','24',NULL,'Facility',NULL,NULL,'"Facility"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESURGLINT0Z0','50','H','01','25',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESURGLINT0Z0','50','H','01','26',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESURGLINT0Z0','50','H','01','27',NULL,'Full/Part Time',NULL,NULL,'"Full/Part Time"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESURGLINT0Z0','50','H','01','28',NULL,'Salary or Hourly',NULL,NULL,'"Salary or Hourly"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESURGLINT0Z0','50','H','01','29',NULL,'FLSA Category',NULL,NULL,'"FLSA Category"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESURGLINT0Z0','50','H','01','30',NULL,'Supervisor Name',NULL,NULL,'"Supervisor Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESURGLINT0Z0','50','H','01','31',NULL,'Scheduled Work Hours',NULL,NULL,'"Scheduled Work Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESURGLINT0Z0','50','H','01','32',NULL,'Job Family',NULL,NULL,'"Job Family"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESURGLINT0Z0','50','H','01','33',NULL,'Job Group',NULL,NULL,'"Job Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESURGLINT0Z0','50','H','01','34',NULL,'Pay Grade',NULL,NULL,'"Pay Grade"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESURGLINT0Z0','50','H','01','35',NULL,'Employee Goal Score',NULL,NULL,'"Employee Goal Score"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESURGLINT0Z0','50','H','01','36',NULL,'Employee Goal Score Description',NULL,NULL,'"Employee Goal Score Description "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESURGLINT0Z0','50','H','01','37',NULL,'Employee Competency Score',NULL,NULL,'"Employee Competency Score"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESURGLINT0Z0','50','H','01','38',NULL,'Employee Competency Score Description',NULL,NULL,'"Employee Competency Score Description "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESURGLINT0Z0','50','H','01','39',NULL,'Employee Overall Score',NULL,NULL,'"Employee Overall Score"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESURGLINT0Z0','50','H','01','40',NULL,'Employee Overall Score Description',NULL,NULL,'"Employee Overall Score Description "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESURGLINT0Z0','50','H','01','41',NULL,'Review Goal Score',NULL,NULL,'"Review Goal Score"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESURGLINT0Z0','50','H','01','42',NULL,'Review Goal Score Description',NULL,NULL,'"Review Goal Score Description"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESURGLINT0Z0','50','H','01','43',NULL,'Review Competency Score Description',NULL,NULL,'"Review Competency Score Description "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESURGLINT0Z0','50','H','01','44',NULL,'Review Final Score',NULL,NULL,'"Review Final Score "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESURGLINT0Z0','50','H','01','45',NULL,'Review Final Score Description',NULL,NULL,'"Review Final Score Description"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESURGLINT0Z0','50','H','01','46',NULL,'Work Country',NULL,NULL,'"Work Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESURGLINT0Z0','50','H','01','47',NULL,'Manager Role',NULL,NULL,'"Manager Role"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESURGLINT0Z0','50','D','10','1',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESURGLINT0Z0','50','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmpID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESURGLINT0Z0','50','D','10','3',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESURGLINT0Z0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESURGLINT0Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESURGLINT0Z0','50','D','10','6',NULL,'Manager ID',NULL,NULL,'"drvManagerID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESURGLINT0Z0','50','D','10','7',NULL,'Job Level',NULL,NULL,'"drvJobLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESURGLINT0Z0','50','D','10','8',NULL,'Organization Report Category',NULL,NULL,'"drvOrgReportCat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESURGLINT0Z0','50','D','10','9',NULL,'Home Company Name',NULL,NULL,'"drvHomeComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESURGLINT0Z0','50','D','10','10',NULL,'Employee Type',NULL,NULL,'"drvEmpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESURGLINT0Z0','50','D','10','11',NULL,'Pay Group',NULL,NULL,'"drvPayGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESURGLINT0Z0','50','D','10','12',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESURGLINT0Z0','50','D','10','13',NULL,'State/Province',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESURGLINT0Z0','50','D','10','14',NULL,'Date In Job',NULL,NULL,'"drvDateinJob"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESURGLINT0Z0','50','D','10','15',NULL,'Original Hire Date',NULL,NULL,'"drvOrigHireDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESURGLINT0Z0','50','D','10','16',NULL,'Last Hire Date',NULL,NULL,'"drvLastHireDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESURGLINT0Z0','50','D','10','17',NULL,'Date Of Birth',NULL,NULL,'"drvDateofBirth"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESURGLINT0Z0','50','D','10','18',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESURGLINT0Z0','50','D','10','19',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESURGLINT0Z0','50','D','10','20',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESURGLINT0Z0','50','D','10','21',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESURGLINT0Z0','50','D','10','22',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESURGLINT0Z0','50','D','10','23',NULL,'Facility Code',NULL,NULL,'"drvFacilityCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESURGLINT0Z0','50','D','10','24',NULL,'Facility',NULL,NULL,'"drvFacility"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESURGLINT0Z0','50','D','10','25',NULL,'Department Code',NULL,NULL,'"drvDeptCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESURGLINT0Z0','50','D','10','26',NULL,'Department',NULL,NULL,'"drvDept"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESURGLINT0Z0','50','D','10','27',NULL,'Full/Part Time',NULL,NULL,'"drvFullPartTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESURGLINT0Z0','50','D','10','28',NULL,'Salary or Hourly',NULL,NULL,'"drvSalaryorHourly"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESURGLINT0Z0','50','D','10','29',NULL,'FLSA Category',NULL,NULL,'"drvFLSACategory"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESURGLINT0Z0','50','D','10','30',NULL,'Supervisor Name',NULL,NULL,'"drvSupervisorNm"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESURGLINT0Z0','50','D','10','31',NULL,'Scheduled Work Hours',NULL,NULL,'"drvSchedWorkHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESURGLINT0Z0','50','D','10','32',NULL,'Job Family',NULL,NULL,'"drvJobFamily"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESURGLINT0Z0','50','D','10','33',NULL,'Job Group',NULL,NULL,'"drvJobGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESURGLINT0Z0','50','D','10','34',NULL,'Pay Grade',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESURGLINT0Z0','50','D','10','35',NULL,'Employee Goal Score',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESURGLINT0Z0','50','D','10','36',NULL,'Employee Goal Score Description',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESURGLINT0Z0','50','D','10','37',NULL,'Employee Competency Score',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESURGLINT0Z0','50','D','10','38',NULL,'Employee Competency Score Description',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESURGLINT0Z0','50','D','10','39',NULL,'Employee Overall Score',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESURGLINT0Z0','50','D','10','40',NULL,'Employee Overall Score Description',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESURGLINT0Z0','50','D','10','41',NULL,'Review Goal Score',NULL,NULL,'"drvReviewGoalScore"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESURGLINT0Z0','50','D','10','42',NULL,'Review Goal Score Description',NULL,NULL,'"drvReviewGoalScoreDesc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESURGLINT0Z0','50','D','10','43',NULL,'Review Competency Score Description',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESURGLINT0Z0','50','D','10','44',NULL,'Review Final Score',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESURGLINT0Z0','50','D','10','45',NULL,'Review Final Score Description',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESURGLINT0Z0','50','D','10','46',NULL,'Work Country',NULL,NULL,'"US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESURGLINT0Z0','50','D','10','47',NULL,'Manager Role',NULL,NULL,'"drvManagerRole"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESURGLINT_20220118.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Glint Survey Demo-Chngs','202201101','EMPEXPORT','CHNGS_XOE','Jan 10 2022  2:13PM','ESURGLINT',NULL,NULL,NULL,'202201101','Jan 10 2022 12:00AM','Dec 30 1899 12:00AM','202201101','11','','','202201101',dbo.fn_GetTimedKey(),NULL,'us3cPeSUR1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Glint Survey Demo-FULLFILE','202112289','EMPEXPORT','FULLFILE',NULL,'ESURGLINT',NULL,NULL,NULL,'202112289','Dec 28 2021 11:02AM','Dec 28 2021 11:02AM','202112281',NULL,'','','202112281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Glint Survey Demo','202112289','EMPEXPORT','ONDEM_XOE',NULL,'ESURGLINT',NULL,NULL,NULL,'202112289','Dec 28 2021 11:02AM','Dec 28 2021 11:02AM','202112281',NULL,'','','202112281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Glint Survey Demo-Sched','202112289','EMPEXPORT','SCH_ESURGL',NULL,'ESURGLINT',NULL,NULL,NULL,'202112289','Dec 28 2021 11:02AM','Dec 28 2021 11:02AM','202112281',NULL,'','','202112281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESURGLINT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESURGLINT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESURGLINT','D10','dbo.U_ESURGLINT_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESURGLINT_Audit
-----------

IF OBJECT_ID('U_ESURGLINT_Audit') IS NULL
CREATE TABLE [dbo].[U_ESURGLINT_Audit] (
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
-- Create table U_ESURGLINT_AuditFields
-----------

IF OBJECT_ID('U_ESURGLINT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESURGLINT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESURGLINT_drvTbl
-----------

IF OBJECT_ID('U_ESURGLINT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESURGLINT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvStatus] varchar(8) NOT NULL,
    [drvEmpID] char(9) NULL,
    [drvEmail] varchar(50) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvManagerID] varchar(256) NULL,
    [drvJobLevel] nvarchar(4000) NULL,
    [drvOrgReportCat] char(25) NULL,
    [drvHomeComp] varchar(8000) NULL,
    [drvEmpType] nvarchar(1000) NULL,
    [drvPayGroup] char(6) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvDateinJob] datetime NULL,
    [drvOrigHireDate] datetime NULL,
    [drvLastHireDate] datetime NULL,
    [drvDateofBirth] datetime NULL,
    [drvEthnicity] varchar(45) NULL,
    [drvGenderCode] char(1) NULL,
    [drvGender] varchar(6) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvFacilityCode] varchar(10) NULL,
    [drvFacility] varchar(25) NULL,
    [drvDeptCode] varchar(10) NULL,
    [drvDept] varchar(25) NULL,
    [drvFullPartTime] varchar(9) NOT NULL,
    [drvSalaryorHourly] varchar(8) NOT NULL,
    [drvFLSACategory] varchar(10) NOT NULL,
    [drvSupervisorNm] varchar(8000) NULL,
    [drvSchedWorkHours] varchar(30) NULL,
    [drvJobFamily] nvarchar(1000) NULL,
    [drvJobGroup] char(25) NULL,
    [drvReviewGoalScore] char(15) NULL,
    [drvReviewGoalScoreDesc] varchar(60) NULL,
    [drvManagerRole] varchar(1) NOT NULL
);

-----------
-- Create table U_ESURGLINT_EEList
-----------

IF OBJECT_ID('U_ESURGLINT_EEList') IS NULL
CREATE TABLE [dbo].[U_ESURGLINT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESURGLINT_File
-----------

IF OBJECT_ID('U_ESURGLINT_File') IS NULL
CREATE TABLE [dbo].[U_ESURGLINT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESURGLINT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Surgery Center Holdings, Inc.

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/28/2021
Service Request Number: TekP-2021-10-12-0008

Purpose: Glint Survey Demo

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESURGLINT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESURGLINT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESURGLINT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESURGLINT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESURGLINT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURGLINT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURGLINT', 'CHNGS_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURGLINT', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESURGLINT', 'SCH_ESURGL';


EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESURGLINT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESURGLINT';

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
    DELETE FROM dbo.U_ESURGLINT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESURGLINT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESURGLINT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESURGLINT_AuditFields;
    CREATE TABLE dbo.U_ESURGLINT_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESURGLINT_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ESURGLINT_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESURGLINT_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESURGLINT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESURGLINT_Audit;
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
    INTO dbo.U_ESURGLINT_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESURGLINT_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESURGLINT_Audit ON dbo.U_ESURGLINT_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    IF @Exportcode IN ('CHNGS_XOE')
    BEGIN
        -- Remove Employees with No Changes in Audit
    DELETE FROM dbo.U_ESURGLINT_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESURGLINT_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESURGLINT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESURGLINT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESURGLINT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = dbo.vw_int_EmpComp.EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvStatus = CASE WHEN dbo.vw_int_EmpComp.EecEmplStatus = 'T' THEN 'INACTIVE' else 'ACTIVE' END
        ,drvEmpID = dbo.vw_int_EmpComp.EecEmpNo
        ,drvEmail = CASE WHEN EepAddressEMail IS NOT NULL THEN EepAddressEmail ELSE EepAddressEmailAlternate END
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvManagerID = dbo.dsi_fnlib_GetSupervisorField_v2('', dbo.vw_int_EmpComp.EecEEID, 'EmpNo') 
        ,drvJobLevel = CFJC.Job_JobLevel
        ,drvOrgReportCat = orcDescription
        ,drvHomeComp = [dbo].[dsi_fnlib_AddDoubleQuotes](CmpCompanyName)
        ,drvEmpType = FNEC.EETypeDesc
        ,drvPayGroup = dbo.vw_int_EmpComp.EecPayGroup
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvDateinJob = dbo.vw_int_EmpComp.EecDateInJob
        ,drvOrigHireDate = dbo.vw_int_EmpComp.EecDateOfOriginalHire
        ,drvLastHireDate = dbo.vw_int_EmpComp.EecDateOfLastHire
        ,drvDateofBirth = EepDateOfBirth
        ,drvEthnicity = ETH.CodDesc
        ,drvGenderCode = CASE WHEN EepGender in ('M','F') THEN EepGender END
        ,drvGender = CASE WHEN EepGender ='M' THEN 'Male' WHEN EepGender ='F' THEN 'Female' END
        ,drvJobCode = dbo.vw_int_EmpComp.EecJobCode
        ,drvJobTitle = JC.JbcDesc
        ,drvFacilityCode = dbo.vw_int_EmpComp.EecOrgLvl2
        ,drvFacility = OL.OrgDesc
        ,drvDeptCode = dbo.vw_int_EmpComp.EecOrgLvl3
        ,drvDept = OL3.OrgDesc
        ,drvFullPartTime = CASE WHEN dbo.vw_int_EmpComp.EecFullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvSalaryorHourly = CASE WHEN dbo.vw_int_EmpComp.EecSalaryOrHourly = 'S' THEN 'Salaried' ELSE 'Hourly' END
        ,drvFLSACategory = CASE WHEN JHT.NewValue  = 'N' THEN 'Non Exempt' ELSE 'Exempt' END
        ,drvSupervisorNm = REPLACE(dbo.dsi_fnlib_GetSupervisorField_v2('', dbo.vw_int_EmpComp.EecEEID, 'NameLast, First MiddleInit') , ',', '')
        ,drvSchedWorkHours = CAST( dbo.vw_int_EmpComp.EecScheduledWorkHrs AS varchar)
        ,drvJobFamily = JF.codDesc
        ,drvJobGroup = JobGrp.CjgJobGroupDesc
        ,drvReviewGoalScore = sd.ErvRating 
        ,drvReviewGoalScoreDesc = RatingDesc
        ,drvManagerRole = CASE WHEN rolName = 'MGR' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESURGLINT_drvTbl
    FROM dbo.U_ESURGLINT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecPayGroup <> 'TEST'
                and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_ESURGLINT_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v2 ('EjhFLSACategory') JHT
        ON JHT.EEID = EecEEID
        AND JHT.CoID = EecCoID
    LEFT JOIN dbo.codes ETH WITH (NOLOCK)
        ON ETH.CodCode = EepEthnicID
        AND codTable = 'ETHNICCODE'
    JOIN dbo.JobCode JC WITH (NOLOCK)
        ON JC.JbcJobCode = dbo.vw_int_EmpComp.EecJobCode
    LEFT JOIN dbo.fn_MP_CustomFields_JobCode (NULL,NULL,NULL,NULL) CFJC 
        ON CFJC.JbcJobCode = JC.JbcJobCode
    LEFT JOIN dbo.OrgLevel OL WITH (NOLOCK)
        ON OL.OrgCode = dbo.vw_int_EmpComp.EecOrgLvl2
        AND OL.OrgLvl = 2
    LEFT JOIN dbo.OrgLevel OL3 WITH (NOLOCK)
        ON OL3.OrgCode = dbo.vw_int_EmpComp.EecOrgLvl3
        AND OL3.OrgLvl = 3
    LEFT JOIN OrgRpCat WITH (NOLOCK)
        ON orcCode = OL.OrgReportCategory
    LEFT JOIN Company WITH (NOLOCK)
        ON cmpCoID = eepHomeCoID 
    JOIN fn_BI_EmpComp ('en') FNEC
        ON FNEC.EecCoID = xCoID
        AND FNEC.EecEEID = xEEID
    LEFT JOIN  EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCoID
    LEFT JOIN JobGrp WITH (NOLOCK)
        ON CjgJobGroupCode = EjhJobGroupCode
    LEFT JOIN fn_LocalizeCodesForCognos('JOBFAMILY','en') JF
        ON JF.codCode = JC.JbcJobFamily
    LEFT JOIN rbsuserroles WITH (NOLOCK)
        ON rurEEID = xEEID 
    LEFT JOIN RbsRoles WITH (NOLOCK)
        ON rolID = rurRoleID
        AND rolName = 'MGR'
    LEFT JOIN (SELECT ErvEEID, ErvRating, ErvReviewDate, ROW_NUMBER() OVER(PARTITION BY ErvEEID ORDER BY ErvReviewDate DESC) rowNumber FROM vw_PM_EmpHRev) sd 
        ON sd.ErvEEID  = xEEID
        AND sd.rowNumber =1
    LEFT JOIN vw_PMRating WITH (NOLOCK)
        ON sd.ErvRating = RatingCode
    ;
    --==========================================
    -- FOR TESTING BELOW
    --==========================================
    --select * from RbsRoles JOIN rbsuserroles ON rolID = rurRoleID AND rurEEID = 'CP4USA01E020' AND rolName = 'MGR'
    --select top 10 CFJC.Job_JobLevel from dbo.fn_MP_CustomFields_JobCode (NULL,NULL,NULL,NULL) CFJC JOIN EmpComp EC ON CFJC.JbcJobCode = EC.EecJobCode

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'SUR_Glint_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'SUR_Glint_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESURGLINT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESURGLINT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESURGLINT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112211'
       ,expStartPerControl     = '202112211'
       ,expLastEndPerControl   = '202112289'
       ,expEndPerControl       = '202112289'
WHERE expFormatCode = 'ESURGLINT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESURGLINT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESURGLINT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESURGLINT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESURGLINT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESURGLINT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESURGLINT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESURGLINT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESURGLINT', 'UseFileName', 'V', 'Y'


-- End ripout