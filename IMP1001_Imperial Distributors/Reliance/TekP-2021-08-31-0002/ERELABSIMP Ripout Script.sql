/**********************************************************************************

ERELABSIMP: Reliance Absence Mgmt Export

FormatCode:     ERELABSIMP
Project:        Reliance Absence Mgmt Export
Client ID:      IMP1001
Date/time:      2021-11-11 04:58:53.677
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW3WUP2DB01
Database:       ULTIPRO_WPIMPD
Web Filename:   IMP1001_84194_EEHISTORY_ERELABSIMP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ERELABSIMP_SavePath') IS NOT NULL DROP TABLE dbo.U_ERELABSIMP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ERELABSIMP'


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
WHERE FormatCode = 'ERELABSIMP'
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
WHERE ExpFormatCode = 'ERELABSIMP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ERELABSIMP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ERELABSIMP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ERELABSIMP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ERELABSIMP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ERELABSIMP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ERELABSIMP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ERELABSIMP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ERELABSIMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ERELABSIMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ERELABSIMP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwERELABSIMP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERELABSIMP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELABSIMP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELABSIMP];
GO
IF OBJECT_ID('U_ERELABSIMP_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_PTaxHist];
GO
IF OBJECT_ID('U_ERELABSIMP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_PEarHist];
GO
IF OBJECT_ID('U_ERELABSIMP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_PDedHist];
GO
IF OBJECT_ID('U_ERELABSIMP_File') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_File];
GO
IF OBJECT_ID('U_ERELABSIMP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_EEList];
GO
IF OBJECT_ID('U_ERELABSIMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_drvTbl];
GO
IF OBJECT_ID('U_ERELABSIMP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIMP_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERELABSIMP','Reliance Absence Mgmt Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ERELABSIMPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERELABSIMPZ0','50','H','01','1',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERELABSIMPZ0','50','H','01','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"Date of Hire Most Recent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERELABSIMPZ0','50','H','01','3',NULL,'Date of Hire Original',NULL,NULL,'"Date of Hire Original"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERELABSIMPZ0','50','H','01','4',NULL,'Date of Hire Adjusted',NULL,NULL,'"Date of Hire Adjusted"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERELABSIMPZ0','50','H','01','5',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERELABSIMPZ0','50','H','01','6',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERELABSIMPZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERELABSIMPZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERELABSIMPZ0','50','H','01','9',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERELABSIMPZ0','50','H','01','10',NULL,'Home Address 1',NULL,NULL,'"Home Address 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERELABSIMPZ0','50','H','01','11',NULL,'Home Address 2',NULL,NULL,'"Home Address 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERELABSIMPZ0','50','H','01','12',NULL,'Home Address 3',NULL,NULL,'"Home Address 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERELABSIMPZ0','50','H','01','13',NULL,'Home City',NULL,NULL,'"Home City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERELABSIMPZ0','50','H','01','14',NULL,'Home State',NULL,NULL,'"Home State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERELABSIMPZ0','50','H','01','15',NULL,'Home Zip',NULL,NULL,'"Home Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERELABSIMPZ0','50','H','01','16',NULL,'Home Country',NULL,NULL,'"Home Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERELABSIMPZ0','50','H','01','17',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERELABSIMPZ0','50','H','01','18',NULL,'Home Email Address',NULL,NULL,'"Home Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERELABSIMPZ0','50','H','01','19',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERELABSIMPZ0','50','H','01','20',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERELABSIMPZ0','50','H','01','21',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERELABSIMPZ0','50','H','01','22',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERELABSIMPZ0','50','H','01','23',NULL,'Work Email Address',NULL,NULL,'"Work Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERELABSIMPZ0','50','H','01','24',NULL,'Department Number',NULL,NULL,'"Department Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERELABSIMPZ0','50','H','01','25',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERELABSIMPZ0','50','H','01','26',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ERELABSIMPZ0','50','H','01','27',NULL,'Location Name',NULL,NULL,'"Location Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ERELABSIMPZ0','50','H','01','28',NULL,'Position',NULL,NULL,'"Position"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ERELABSIMPZ0','50','H','01','29',NULL,'Shift Worked',NULL,NULL,'"Shift Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ERELABSIMPZ0','50','H','01','30',NULL,'Is Active',NULL,NULL,'"Is Active"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ERELABSIMPZ0','50','H','01','31',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ERELABSIMPZ0','50','H','01','32',NULL,'Is Fulltime',NULL,NULL,'"Is Fulltime"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ERELABSIMPZ0','50','H','01','33',NULL,'Is Exempt',NULL,NULL,'"Is Exempt"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ERELABSIMPZ0','50','H','01','34',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ERELABSIMPZ0','50','H','01','35',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ERELABSIMPZ0','50','H','01','36',NULL,'FICA Year To Date',NULL,NULL,'"FICA Year To Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ERELABSIMPZ0','50','H','01','37',NULL,'HR Rep Name',NULL,NULL,'"HR Rep Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ERELABSIMPZ0','50','H','01','38',NULL,'HR Rep Email Address',NULL,NULL,'"HR Rep Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ERELABSIMPZ0','50','H','01','39',NULL,'HR Rep Phone',NULL,NULL,'"HR Rep Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ERELABSIMPZ0','50','H','01','40',NULL,'Supervisor Name',NULL,NULL,'"Supervisor Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ERELABSIMPZ0','50','H','01','41',NULL,'Supervisor  Email Address',NULL,NULL,'"Supervisor  Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ERELABSIMPZ0','50','H','01','42',NULL,'Supervisor Phone',NULL,NULL,'"Supervisor Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ERELABSIMPZ0','50','H','01','43',NULL,'HR Manager Name',NULL,NULL,'"HR Manager Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ERELABSIMPZ0','50','H','01','44',NULL,'HR Manager Email',NULL,NULL,'"HR Manager Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ERELABSIMPZ0','50','H','01','45',NULL,'HR Manager Phone',NULL,NULL,'"HR Manager Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ERELABSIMPZ0','50','H','01','46',NULL,'Manager Name',NULL,NULL,'"Manager Namee"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ERELABSIMPZ0','50','H','01','47',NULL,'Manager Email',NULL,NULL,'"Manager Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ERELABSIMPZ0','50','H','01','38',NULL,'Manager Phone',NULL,NULL,'"Manager Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ERELABSIMPZ0','50','H','01','49',NULL,'Sub Group A',NULL,NULL,'"Sub Group A"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ERELABSIMPZ0','50','H','01','51',NULL,'Sub Group B',NULL,NULL,'"Sub Group B"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ERELABSIMPZ0','50','H','01','52',NULL,'Sub Group C',NULL,NULL,'"Sub Group C"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ERELABSIMPZ0','50','H','01','53',NULL,'Sub Group D',NULL,NULL,'"Sub Group D"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ERELABSIMPZ0','50','H','01','54',NULL,'Sub Group E',NULL,NULL,'"Sub Group E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ERELABSIMPZ0','50','H','01','55',NULL,'Sub Group F',NULL,NULL,'"Sub Group F"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ERELABSIMPZ0','50','H','01','56',NULL,'Is STD Eligible',NULL,NULL,'"Is STD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ERELABSIMPZ0','50','H','01','57',NULL,'Std Plan Effective',NULL,NULL,'"Std Plan Effective"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ERELABSIMPZ0','50','H','01','58',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL,'"Is STD Supplemental Eligible (Buy Up / Supp Plan)"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ERELABSIMPZ0','50','H','01','59',NULL,'Std Supp Effective',NULL,NULL,'"Std Supp Effective"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ERELABSIMPZ0','50','H','01','60',NULL,'Is California Voluntary Plan Eligible',NULL,NULL,'"Is California Voluntary Plan Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ERELABSIMPZ0','50','H','01','61',NULL,'California Voluntary Plan Effective',NULL,NULL,'"California Voluntary Plan Effective"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ERELABSIMPZ0','50','H','01','62',NULL,'Is LTD Eligible',NULL,NULL,'"Is LTD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ERELABSIMPZ0','50','H','01','63',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ERELABSIMPZ0','50','H','01','64',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL,'"Is Other Eligible (Buy Up / Supp LTD Plan)"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ERELABSIMPZ0','51','H','01','65',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL,'"Is Other Eligible (Buy Up / Supp LTD Plan) Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ERELABSIMPZ0','50','H','01','66',NULL,'Hours Worked',NULL,NULL,'"Hours Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ERELABSIMPZ0','50','H','01','67',NULL,'At Worksite',NULL,NULL,'"At Worksite"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ERELABSIMPZ0','50','H','01','68',NULL,'Domestic Partner Indicator',NULL,NULL,'"Domestic Partner Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ERELABSIMPZ0','50','H','01','69',NULL,'Spouse Working at the Same Company',NULL,NULL,'"Spouse Working at the Same Company"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ERELABSIMPZ0','50','H','01','70',NULL,'Key Employee Indicator',NULL,NULL,'"Key Employee Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ERELABSIMPZ0','50','H','01','71',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'"Employees 50 in 75 Mile Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ERELABSIMPZ0','52','H','01','72',NULL,'Add Data 01',NULL,NULL,'"Add Data 01"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ERELABSIMPZ0','53','H','01','73',NULL,'Add Data 02',NULL,NULL,'"Add Data 02"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ERELABSIMPZ0','54','H','01','74',NULL,'Add Data 03',NULL,NULL,'"Add Data 03"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ERELABSIMPZ0','55','H','01','75',NULL,'Add Data 04',NULL,NULL,'"Add Data 04"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ERELABSIMPZ0','56','H','01','76',NULL,'Add Data 05',NULL,NULL,'"Add Data 05"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ERELABSIMPZ0','56','H','01','77',NULL,'Add Data 06 - NY DBL Opt in',NULL,NULL,'"Add Data 06 - NY DBL Opt in"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ERELABSIMPZ0','56','H','01','78',NULL,' Add Data 07 - NY DBL Wages',NULL,NULL,'" Add Data 07 - NY DBL Wages"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ERELABSIMPZ0','56','H','01','79',NULL,'Add Data 08 - WI Paid Hours Worked',NULL,NULL,'"Add Data 08 - WI Paid Hours Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ERELABSIMPZ0','56','H','01','80',NULL,'Add Data 09 - MAPFL earnings',NULL,NULL,'"Add Data 09 - MAPFL earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ERELABSIMPZ0','79','H','01','81',NULL,'Add Data 10',NULL,NULL,'"Add Data 10"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERELABSIMPZ0','10','D','10','1',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERELABSIMPZ0','10','D','10','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"drvDateofHireMostRecent"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERELABSIMPZ0','10','D','10','3',NULL,'Date of Hire Original',NULL,NULL,'"drvDateofHireOriginal"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERELABSIMPZ0','10','D','10','4',NULL,'Date of Hire Adjusted',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERELABSIMPZ0','11','D','10','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERELABSIMPZ0','20','D','10','6',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERELABSIMPZ0','40','D','10','7',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERELABSIMPZ0','1','D','10','8',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERELABSIMPZ0','40','D','10','9',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERELABSIMPZ0','50','D','10','10',NULL,'Home Address 1',NULL,NULL,'"drvHomeAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERELABSIMPZ0','50','D','10','11',NULL,'Home Address 2',NULL,NULL,'"drvHomeAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERELABSIMPZ0','50','D','10','12',NULL,'Home Address 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERELABSIMPZ0','35','D','10','13',NULL,'Home City',NULL,NULL,'"drvHomeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERELABSIMPZ0','2','D','10','14',NULL,'Home State',NULL,NULL,'"drvHomeState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERELABSIMPZ0','10','D','10','15',NULL,'Home Zip',NULL,NULL,'"drvHomeZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERELABSIMPZ0','10','D','10','16',NULL,'Home Country',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERELABSIMPZ0','25','D','10','17',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERELABSIMPZ0','255','D','10','18',NULL,'Home Email Address',NULL,NULL,'"drvHomeEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERELABSIMPZ0','10','D','10','19',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERELABSIMPZ0','8','D','10','20',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERELABSIMPZ0','2','D','10','21',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERELABSIMPZ0','25','D','10','22',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERELABSIMPZ0','255','D','10','23',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERELABSIMPZ0','40','D','10','24',NULL,'Department Number',NULL,NULL,'"drvDepartmentNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERELABSIMPZ0','255','D','10','25',NULL,'Department Name',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERELABSIMPZ0','255','D','10','26',NULL,'Location Code',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ERELABSIMPZ0','255','D','10','27',NULL,'Location Name',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ERELABSIMPZ0','50','D','10','28',NULL,'Position',NULL,NULL,'"drvPosition"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ERELABSIMPZ0','25','D','10','29',NULL,'Shift Worked',NULL,NULL,'"drvShiftWorked"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ERELABSIMPZ0','1','D','10','30',NULL,'Is Active',NULL,NULL,'"drvIsActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ERELABSIMPZ0','10','D','10','31',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ERELABSIMPZ0','1','D','10','32',NULL,'Is Fulltime',NULL,NULL,'"drvIsFulltime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ERELABSIMPZ0','1','D','10','33',NULL,'Is Exempt',NULL,NULL,'"drvIsExempt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ERELABSIMPZ0','16','D','10','34',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ERELABSIMPZ0','16','D','10','35',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ERELABSIMPZ0','16','D','10','36',NULL,'FICA Year To Date',NULL,NULL,'"drvFICAYearToDate"','(''UNT2''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ERELABSIMPZ0','50','D','10','37',NULL,'HR Rep Name',NULL,NULL,'"drvHRRepName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ERELABSIMPZ0','255','D','10','38',NULL,'HR Rep Email Address',NULL,NULL,'"drvHRRepEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ERELABSIMPZ0','25','D','10','39',NULL,'HR Rep Phone',NULL,NULL,'"drvHRRepPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ERELABSIMPZ0','50','D','10','40',NULL,'Supervisor Name',NULL,NULL,'"drvSupervisorName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ERELABSIMPZ0','255','D','10','41',NULL,'Supervisor  Email Address',NULL,NULL,'"drvSupervisorEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ERELABSIMPZ0','25','D','10','42',NULL,'Supervisor Phone',NULL,NULL,'"drvSupervisorPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ERELABSIMPZ0','25','D','10','43',NULL,'HR Manager Name',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ERELABSIMPZ0','25','D','10','44',NULL,'HR Manager Email',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ERELABSIMPZ0','25','D','10','45',NULL,'HR Manager Phone',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ERELABSIMPZ0','25','D','10','46',NULL,'Manager Name',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ERELABSIMPZ0','25','D','10','47',NULL,'Manager Email',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ERELABSIMPZ0','25','D','10','48',NULL,'Manager Phone',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ERELABSIMPZ0','2','D','10','49',NULL,'Sub Group A',NULL,NULL,'"drvSubGroupA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ERELABSIMPZ0','20','D','10','50',NULL,'Sub Group B',NULL,NULL,'"drvSubGroupB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ERELABSIMPZ0','20','D','10','51',NULL,'Sub Group C',NULL,NULL,'"drvSubGroupC"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ERELABSIMPZ0','20','D','10','52',NULL,'Sub Group D',NULL,NULL,'"drvSubGroupD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ERELABSIMPZ0','20','D','10','53',NULL,'Sub Group E',NULL,NULL,'"drvSubGroupE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ERELABSIMPZ0','20','D','10','54',NULL,'Sub Group F',NULL,NULL,'"drvSubGroupF"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ERELABSIMPZ0','1','D','10','55',NULL,'Is STD Eligible',NULL,NULL,'"drvIsSTDEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ERELABSIMPZ0','10','D','10','56',NULL,'Std Plan Effective',NULL,NULL,'"drvStdPlanEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ERELABSIMPZ0','1','D','10','57',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL,'"drvIsSTDSuppEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ERELABSIMPZ0','10','D','10','58',NULL,'Std Supp Effective',NULL,NULL,'"drvStdSuppEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ERELABSIMPZ0','1','D','10','59',NULL,'Is California Voluntary Plan Eligible',NULL,NULL,'"drvIsCAVolPlanEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ERELABSIMPZ0','10','D','10','60',NULL,'California Voluntary Plan Effective',NULL,NULL,'"drvCAVolPlanEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ERELABSIMPZ0','1','D','10','61',NULL,'Is LTD Eligible',NULL,NULL,'"drvIsLTDEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ERELABSIMPZ0','10','D','10','62',NULL,'LTD Effective Date',NULL,NULL,'"drvLTDEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ERELABSIMPZ0','1','D','10','63',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL,'"drvIsOtherEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ERELABSIMPZ0','10','D','10','64',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL,'"drvIsOtherEligibleEffDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ERELABSIMPZ0','10','D','10','65',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ERELABSIMPZ0','10','D','10','66',NULL,'At Worksite',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ERELABSIMPZ0','10','D','10','67',NULL,'Domestic Partner Indicator',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ERELABSIMPZ0','10','D','10','68',NULL,'Spouse Working at the Same Company',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ERELABSIMPZ0','10','D','10','69',NULL,'Key Employee Indicator',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ERELABSIMPZ0','10','D','10','70',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ERELABSIMPZ0','50','D','10','71',NULL,'Add Data 01',NULL,NULL,'"drvAddData01"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ERELABSIMPZ0','1','D','10','72',NULL,'Add Data 02',NULL,NULL,'"drvAddData02"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ERELABSIMPZ0','10','D','10','73',NULL,'Add Data 03',NULL,NULL,'"drvAddData03"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ERELABSIMPZ0','1','D','10','74',NULL,'Add Data 04',NULL,NULL,'"drvAddData04"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ERELABSIMPZ0','10','D','10','75',NULL,'Add Data 05',NULL,NULL,'"drvAddData05"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ERELABSIMPZ0','10','D','10','76',NULL,'Add Data 06 - NY DBL Opt in',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ERELABSIMPZ0','10','D','10','77',NULL,'Add Data 07 - NY DBL Wages',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ERELABSIMPZ0','10','D','10','78',NULL,'Add Data 08 - WI Paid Hours Worked',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ERELABSIMPZ0','10','D','10','79',NULL,'Add Data 09 - MAPFL earnings',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ERELABSIMPZ0','10','D','10','80',NULL,'Add Data 10',NULL,NULL,'""','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ERELABSIMP_20211111.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201807109','EMPEXPORT','OEACTIVE',NULL,'ERELABSIMP',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201807109','EMPEXPORT','OEPASSIVE',NULL,'ERELABSIMP',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance Absence Mgmt Export','201807109','EMPEXPORT','ONDEMAND',NULL,'ERELABSIMP',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',SQF6O,WYPAI',NULL,NULL,NULL,'Scheduled Session Friday 5pmES','201808319','EMPEXPORT','SCHEDULED',NULL,'ERELABSIMP',NULL,NULL,NULL,'202111059','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','202110221',NULL,'','','201808171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202110141','EMPEXPORT','TEST','Oct 27 2021  2:09PM','ERELABSIMP',NULL,NULL,NULL,'202110141','Oct 14 2021 12:00AM','Oct  9 2021 12:00AM','202110141','566','','','202110141',dbo.fn_GetTimedKey(),NULL,'us3rVaIMP1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIMP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIMP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIMP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIMP','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIMP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELABSIMP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELABSIMP','D10','dbo.U_ERELABSIMP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ERELABSIMP_DedList
-----------

IF OBJECT_ID('U_ERELABSIMP_DedList') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ERELABSIMP_drvTbl
-----------

IF OBJECT_ID('U_ERELABSIMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofHireMostRecent] datetime NULL,
    [drvDateofHireOriginal] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvHomeAddress1] varchar(255) NULL,
    [drvHomeAddress2] varchar(255) NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomeZip] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvHomeEmailAddress] varchar(1) NOT NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGender] char(1) NULL,
    [drvWorkState] char(2) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkEmailAddress] varchar(1) NOT NULL,
    [drvDepartmentNumber] char(10) NULL,
    [drvPosition] varchar(25) NOT NULL,
    [drvShiftWorked] varchar(1) NOT NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvIsFulltime] varchar(1) NOT NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvAnnualSalary] money NULL,
    [drvHourlyRate] decimal NULL,
    [drvFICAYearToDate] money NULL,
    [drvHRRepName] varchar(1) NOT NULL,
    [drvHRRepEmailAddress] varchar(1) NOT NULL,
    [drvHRRepPhone] varchar(1) NOT NULL,
    [drvSupervisorName] varchar(1) NOT NULL,
    [drvSupervisorEmailAddress] varchar(1) NOT NULL,
    [drvSupervisorPhone] varchar(1) NOT NULL,
    [drvSubGroupA] char(2) NULL,
    [drvSubGroupB] char(10) NULL,
    [drvSubGroupC] char(10) NULL,
    [drvSubGroupD] char(5) NOT NULL,
    [drvSubGroupE] char(5) NOT NULL,
    [drvSubGroupF] varchar(1) NOT NULL,
    [drvIsSTDEligible] varchar(1) NOT NULL,
    [drvStdPlanEffectiveDate] datetime NULL,
    [drvIsSTDSuppEligible] varchar(1) NOT NULL,
    [drvStdSuppEffectiveDate] varchar(1) NOT NULL,
    [drvIsCAVolPlanEligible] varchar(1) NOT NULL,
    [drvCAVolPlanEffectiveDate] varchar(1) NOT NULL,
    [drvIsLTDEligible] varchar(1) NOT NULL,
    [drvLTDEffectiveDate] datetime NULL,
    [drvIsOtherEligible] varchar(1) NOT NULL,
    [drvIsOtherEligibleEffDate] varchar(1) NOT NULL,
    [drvHoursWorked] nvarchar(4000) NULL,
    [drvAddData01] varchar(1) NOT NULL,
    [drvAddData02] varchar(1) NOT NULL,
    [drvAddData03] varchar(1) NOT NULL,
    [drvAddData04] varchar(1) NOT NULL,
    [drvAddData05] varchar(1) NOT NULL
);

-----------
-- Create table U_ERELABSIMP_EEList
-----------

IF OBJECT_ID('U_ERELABSIMP_EEList') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ERELABSIMP_File
-----------

IF OBJECT_ID('U_ERELABSIMP_File') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ERELABSIMP_PDedHist
-----------

IF OBJECT_ID('U_ERELABSIMP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_PDedHist] (
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
-- Create table U_ERELABSIMP_PEarHist
-----------

IF OBJECT_ID('U_ERELABSIMP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_PEarHist] (
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

-----------
-- Create table U_ERELABSIMP_PTaxHist
-----------

IF OBJECT_ID('U_ERELABSIMP_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIMP_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PthTaxAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELABSIMP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Imperial Distributors, Inc.

Created By: Joseph Pham
Business Analyst: Liz Bachan
Create Date: 07/10/2018
Service Request Number: SR-2018-00195969

Purpose: Reliance Absence Mgmt Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2018     SR-2018-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERELABSIMP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERELABSIMP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERELABSIMP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERELABSIMP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERELABSIMP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIMP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIMP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIMP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIMP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERELABSIMP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERELABSIMP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERELABSIMP';

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
    DELETE FROM dbo.U_ERELABSIMP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERELABSIMP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ERELABSIMP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIMP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERELABSIMP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','GTLC1,GTLC2,GTLC3,GTLC4,GTLC5');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ERELABSIMP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIMP_PDedHist;
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
    INTO dbo.U_ERELABSIMP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERELABSIMP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ERELABSIMP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIMP_PEarHist;
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
    INTO dbo.U_ERELABSIMP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - YTD FICA Withholdings
    -----------------------------
    IF OBJECT_ID('U_ERELABSIMP_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIMP_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- YTD Payroll Amount/Hours
        ,PthTaxAmtYTD           = SUM(PthCurTaxAmt)
    INTO dbo.U_ERELABSIMP_PTaxHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode IN ('USSOCEE','USMEDEE')
    GROUP BY PthEEID
    HAVING SUM(PthCurTaxAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERELABSIMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERELABSIMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateofHireMostRecent = EecDateOfLastHire
        ,drvDateofHireOriginal = EecDateOfOriginalHire
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvHomeAddress1 = EepAddressLine1
        ,drvHomeAddress2 = EepAddressLine2
        ,drvHomeCity = EepAddressCity
        ,drvHomeState = EepAddressState
        ,drvHomeZip = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvHomeEmailAddress = ''
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGender = EepGender
        ,drvWorkState = EecWCState
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkEmailAddress = ''
        ,drvDepartmentNumber = EecOrgLvl2
        ,drvPosition = JbcDesc
        ,drvShiftWorked = ''
        ,drvIsActive = CASE WHEN EecEmplStatus = 'T' THEN 'N' ELSE 'Y' END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvIsFulltime = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'N' ELSE 'Y' END
        ,drvIsExempt = CASE WHEN JbcFLSAType = 'N' THEN 'N' ELSE 'Y' END
        ,drvAnnualSalary = EecAnnSalary
        ,drvHourlyRate = EecHourlyPayRate
        ,drvFICAYearToDate = PthTaxAmtYTD
        ,drvHRRepName = ''
        ,drvHRRepEmailAddress = ''
        ,drvHRRepPhone = ''
        ,drvSupervisorName = ''
        ,drvSupervisorEmailAddress = ''
        ,drvSupervisorPhone = ''
        ,drvSubGroupA = EecWCState
        ,drvSubGroupB = EecOrgLvl2
        ,drvSubGroupC = EecOrgLvl4
        ,drvSubGroupD = EedDedCode
        ,drvSubGroupE = EedDedCode
        ,drvSubGroupF = ''
        ,drvIsSTDEligible = CASE
                                WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5') THEN 'Y'
                                ELSE 'N'
                            END
        ,drvStdPlanEffectiveDate = CASE
                                        WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5') THEN EedBenStartDate
                                    END
        ,drvIsSTDSuppEligible = ''
        ,drvStdSuppEffectiveDate = ''
        ,drvIsCAVolPlanEligible = ''
        ,drvCAVolPlanEffectiveDate = ''
        ,drvIsLTDEligible = CASE
                                WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC5') THEN 'Y'
                                ELSE 'N'
                            END
        ,drvLTDEffectiveDate = CASE
                                        WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC5') THEN EedBenStartDate
                                    END
        ,drvIsOtherEligible = ''
        ,drvIsOtherEligibleEffDate = ''
        ,drvHoursWorked = FORMAT(EecScheduledWorkHrs, '#0.00')
        ,drvAddData01 = ''
        ,drvAddData02 = ''
        ,drvAddData03 = ''
        ,drvAddData04 = ''
        ,drvAddData05 = ''
    INTO dbo.U_ERELABSIMP_drvTbl
    FROM dbo.U_ERELABSIMP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedBenStatus = 'A'
        --AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ERELABSIMP_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    --WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOFTermination >= DATEADD(DAY, -30, @EndDate)))
        AND (EecFullTimeOrPartTime = 'F' OR (EecFullTimeOrPartTime = 'P' AND EepAddressState IN ('NY','MA')))
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ERELABSIMP_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ERELABSIMP_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwERELABSIMP_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ERELABSIMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERELABSIMP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201807031'
       ,expStartPerControl     = '201807031'
       ,expLastEndPerControl   = '201807109'
       ,expEndPerControl       = '201807109'
WHERE expFormatCode = 'ERELABSIMP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERELABSIMP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERELABSIMP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ERELABSIMP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ERELABSIMP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ERELABSIMP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERELABSIMP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ERELABSIMP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERELABSIMP', 'UseFileName', 'V', 'Y'


-- End ripout