/**********************************************************************************

EROLRSFMLA: Reliance Standard FMLA

FormatCode:     EROLRSFMLA
Project:        Reliance Standard FMLA
Client ID:      ROL1002
Date/time:      2022-06-17 14:36:42.660
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
Web Filename:   ROL1002_C9MXB_EEHISTORY_EROLRSFMLA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EROLRSFMLA_SavePath') IS NOT NULL DROP TABLE dbo.U_EROLRSFMLA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EROLRSFMLA'


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
WHERE FormatCode = 'EROLRSFMLA'
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
WHERE ExpFormatCode = 'EROLRSFMLA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EROLRSFMLA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EROLRSFMLA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EROLRSFMLA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EROLRSFMLA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EROLRSFMLA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EROLRSFMLA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EROLRSFMLA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EROLRSFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EROLRSFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EROLRSFMLA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEROLRSFMLA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEROLRSFMLA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EROLRSFMLA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLRSFMLA];
GO
IF OBJECT_ID('U_EROLRSFMLA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_PEarHist];
GO
IF OBJECT_ID('U_EROLRSFMLA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_PDedHist];
GO
IF OBJECT_ID('U_EROLRSFMLA_Header') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_Header];
GO
IF OBJECT_ID('U_EROLRSFMLA_File') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_File];
GO
IF OBJECT_ID('U_EROLRSFMLA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_EEList];
GO
IF OBJECT_ID('U_EROLRSFMLA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_drvTbl];
GO
IF OBJECT_ID('U_EROLRSFMLA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_DedList];
GO
IF OBJECT_ID('U_EROLRSFMLA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_AuditFields];
GO
IF OBJECT_ID('U_EROLRSFMLA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EROLRSFMLA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EROLRSFMLA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EROLRSFMLA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EROLRSFMLA','Reliance Standard FMLA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EROLRSFMLAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLRSFMLAZ0','50','H','01','1',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLRSFMLAZ0','50','H','01','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"Date of Hire Most Recent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLRSFMLAZ0','50','H','01','3',NULL,'Date of Hire Original',NULL,NULL,'"Date of Hire Original"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLRSFMLAZ0','50','H','01','4',NULL,'Date of Hire Adjusted',NULL,NULL,'"Date of Hire Adjusted"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLRSFMLAZ0','50','H','01','5',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLRSFMLAZ0','50','H','01','6',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLRSFMLAZ0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLRSFMLAZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLRSFMLAZ0','50','H','01','9',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EROLRSFMLAZ0','50','H','01','10',NULL,'Home Address 1',NULL,NULL,'"Home Address 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EROLRSFMLAZ0','50','H','01','11',NULL,'Home Address 2',NULL,NULL,'"Home Address 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EROLRSFMLAZ0','50','H','01','12',NULL,'Home Address 3',NULL,NULL,'"Home Address 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EROLRSFMLAZ0','50','H','01','13',NULL,'Home City',NULL,NULL,'"Home City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EROLRSFMLAZ0','50','H','01','14',NULL,'Home State',NULL,NULL,'"Home State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EROLRSFMLAZ0','50','H','01','15',NULL,'Home Zip',NULL,NULL,'"Home Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EROLRSFMLAZ0','50','H','01','16',NULL,'Home Country',NULL,NULL,'"Home Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EROLRSFMLAZ0','50','H','01','17',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EROLRSFMLAZ0','50','H','01','18',NULL,'Home Email Address',NULL,NULL,'"Home Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EROLRSFMLAZ0','50','H','01','19',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EROLRSFMLAZ0','50','H','01','20',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EROLRSFMLAZ0','50','H','01','21',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EROLRSFMLAZ0','50','H','01','22',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EROLRSFMLAZ0','50','H','01','23',NULL,'Work Email Address',NULL,NULL,'"Work Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EROLRSFMLAZ0','50','H','01','24',NULL,'Department Number',NULL,NULL,'"Department Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EROLRSFMLAZ0','50','H','01','25',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EROLRSFMLAZ0','50','H','01','26',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EROLRSFMLAZ0','50','H','01','27',NULL,'Location Name',NULL,NULL,'"Location Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EROLRSFMLAZ0','50','H','01','28',NULL,'Position',NULL,NULL,'"Position"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EROLRSFMLAZ0','50','H','01','29',NULL,'Shift Worked',NULL,NULL,'"Shift Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EROLRSFMLAZ0','50','H','01','30',NULL,'Is Active',NULL,NULL,'"Is Active"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EROLRSFMLAZ0','50','H','01','31',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EROLRSFMLAZ0','50','H','01','32',NULL,'Is Fulltime',NULL,NULL,'"Is Fulltime"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EROLRSFMLAZ0','50','H','01','33',NULL,'Is Exempt',NULL,NULL,'"Is Exempt"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EROLRSFMLAZ0','50','H','01','34',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EROLRSFMLAZ0','50','H','01','35',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EROLRSFMLAZ0','50','H','01','36',NULL,'FICA Year To Date',NULL,NULL,'"FICA Year To Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EROLRSFMLAZ0','50','H','01','37',NULL,'HR Rep Name',NULL,NULL,'"HR Rep Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EROLRSFMLAZ0','50','H','01','38',NULL,'HR Rep Email Address',NULL,NULL,'"HR Rep Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EROLRSFMLAZ0','50','H','01','39',NULL,'HR Rep Phone',NULL,NULL,'"HR Rep Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EROLRSFMLAZ0','50','H','01','40',NULL,'Supervisor Name',NULL,NULL,'"Supervisor Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EROLRSFMLAZ0','50','H','01','41',NULL,'Supervisor Email Address',NULL,NULL,'"Supervisor Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EROLRSFMLAZ0','50','H','01','42',NULL,'Supervisor Phone',NULL,NULL,'"Supervisor Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EROLRSFMLAZ0','50','H','01','43',NULL,'HR Manager Name',NULL,NULL,'"HR Manager Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EROLRSFMLAZ0','50','H','01','44',NULL,'HR Manager Email',NULL,NULL,'"HR Manager Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EROLRSFMLAZ0','50','H','01','45',NULL,'HR Manager Phone',NULL,NULL,'"HR Manager Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EROLRSFMLAZ0','50','H','01','46',NULL,'Manager Name',NULL,NULL,'"Manager Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EROLRSFMLAZ0','50','H','01','47',NULL,'Manager Email',NULL,NULL,'"Manager Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EROLRSFMLAZ0','50','H','01','48',NULL,'Manager Phone',NULL,NULL,'"Manager Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EROLRSFMLAZ0','50','H','01','49',NULL,'Sub Group A',NULL,NULL,'"Sub Group A"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EROLRSFMLAZ0','50','H','01','50',NULL,'Sub Group B',NULL,NULL,'"Sub Group B"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EROLRSFMLAZ0','50','H','01','51',NULL,'Sub Group C',NULL,NULL,'"Sub Group C"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EROLRSFMLAZ0','50','H','01','52',NULL,'Sub Group D',NULL,NULL,'"Sub Group D"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EROLRSFMLAZ0','50','H','01','53',NULL,'Sub Group E',NULL,NULL,'"Sub Group E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EROLRSFMLAZ0','50','H','01','54',NULL,'Sub Group F',NULL,NULL,'"Sub Group F"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EROLRSFMLAZ0','50','H','01','55',NULL,'Is STD Eligible',NULL,NULL,'"Is STD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EROLRSFMLAZ0','50','H','01','56',NULL,'Std Plan Effective',NULL,NULL,'"Std Plan Effective"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EROLRSFMLAZ0','50','H','01','57',NULL,'Is STD Supp/Buy Up Plan Eligible',NULL,NULL,'"drvSTDSuppBuyUpPlanEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EROLRSFMLAZ0','50','H','01','58',NULL,'STD Supp/Buy Up Plan Effective Date',NULL,NULL,'"drvSTDSuppBuyUpPlanEffecDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EROLRSFMLAZ0','50','H','01','59',NULL,'Is California Voluntary Plan Eligible',NULL,NULL,'"drvCaliVoluntaryPlanEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EROLRSFMLAZ0','50','H','01','60',NULL,'California Voluntary Plan Effective',NULL,NULL,'"drvCaliVoluntaryPlanEffective"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EROLRSFMLAZ0','50','H','01','61',NULL,'Is LTD Eligible',NULL,NULL,'"Is LTD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EROLRSFMLAZ0','50','H','01','62',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EROLRSFMLAZ0','50','H','01','63',NULL,'Is LTD Supp/Buy Up Plan Eligible',NULL,NULL,'"drvIsLTDSuppBuyUpPlanEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EROLRSFMLAZ0','50','H','01','64',NULL,'LTD Supp/Buy Up Plan Effective Date',NULL,NULL,'"drvTDSuppBuyUpPlanEffDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EROLRSFMLAZ0','50','H','01','65',NULL,'Hours Worked',NULL,NULL,'"Hours Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EROLRSFMLAZ0','50','H','01','66',NULL,'At Worksite',NULL,NULL,'"At Worksite"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EROLRSFMLAZ0','50','H','01','67',NULL,'Domestic Partner Indicator',NULL,NULL,'"Domestic Partner Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EROLRSFMLAZ0','50','H','01','68',NULL,'Spouse Working at the Same Company',NULL,NULL,'"drvSpouseWorkingatSameCompany"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EROLRSFMLAZ0','50','H','01','69',NULL,'Key Employee Indicator',NULL,NULL,'"Key Employee Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EROLRSFMLAZ0','50','H','01','70',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'"drvEmp50in75MileIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EROLRSFMLAZ0','50','H','01','71',NULL,'Add Data 01',NULL,NULL,'"Add Data 01"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EROLRSFMLAZ0','50','H','01','72',NULL,'Add Data 02',NULL,NULL,'"Add Data 02"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EROLRSFMLAZ0','50','H','01','73',NULL,'Add Data 03',NULL,NULL,'"Add Data 03"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EROLRSFMLAZ0','50','H','01','74',NULL,'Add Data 04',NULL,NULL,'"Add Data 04"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EROLRSFMLAZ0','50','H','01','75',NULL,'Add Data 05',NULL,NULL,'"Add Data 05"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EROLRSFMLAZ0','50','H','01','76',NULL,'Add Data 06 - NY DBL Opt in',NULL,NULL,'"drvAddData06NYDBLOptin  "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EROLRSFMLAZ0','50','H','01','77',NULL,'Add Data 07 - NY DBL Wages',NULL,NULL,'"drvAddData07NYDBLWages"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EROLRSFMLAZ0','50','H','01','78',NULL,'Add Data 08 - WI Paid Hours Worked',NULL,NULL,'"drvAddData08WIPaidHrsWked"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EROLRSFMLAZ0','50','H','01','79',NULL,'Add Data 09 - MAPFL earnings',NULL,NULL,'"drvAddData09MAPFLearnings"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EROLRSFMLAZ0','50','H','01','80',NULL,'Add Data 10',NULL,NULL,'"Add Data 10"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EROLRSFMLAZ0','50','D','10','1',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EROLRSFMLAZ0','50','D','10','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EROLRSFMLAZ0','50','D','10','3',NULL,'Date of Hire Original',NULL,NULL,'"drvDateOfOriginalHire"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EROLRSFMLAZ0','50','D','10','4',NULL,'Date of Hire Adjusted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EROLRSFMLAZ0','50','D','10','5',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EROLRSFMLAZ0','50','D','10','6',NULL,'Employee ID',NULL,NULL,'"drvEmpno"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EROLRSFMLAZ0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EROLRSFMLAZ0','50','D','10','8',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EROLRSFMLAZ0','50','D','10','9',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EROLRSFMLAZ0','50','D','10','10',NULL,'Home Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EROLRSFMLAZ0','50','D','10','11',NULL,'Home Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EROLRSFMLAZ0','50','D','10','12',NULL,'Home Address 3',NULL,NULL,'"drvAddress3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EROLRSFMLAZ0','50','D','10','13',NULL,'Home City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EROLRSFMLAZ0','50','D','10','14',NULL,'Home State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EROLRSFMLAZ0','50','D','10','15',NULL,'Home Zip',NULL,NULL,'"drvAddressZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EROLRSFMLAZ0','50','D','10','16',NULL,'Home Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EROLRSFMLAZ0','50','D','10','17',NULL,'Home Phone',NULL,NULL,'"drvPhonehomenumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EROLRSFMLAZ0','50','D','10','18',NULL,'Home Email Address',NULL,NULL,'"drvAddressEMailAlternate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EROLRSFMLAZ0','50','D','10','19',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EROLRSFMLAZ0','50','D','10','20',NULL,'Gender',NULL,NULL,'"drvGenderGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EROLRSFMLAZ0','50','D','10','21',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EROLRSFMLAZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EROLRSFMLAZ0','50','D','10','23',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EROLRSFMLAZ0','50','D','10','24',NULL,'Department Number',NULL,NULL,'"drvDepartmentNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EROLRSFMLAZ0','50','D','10','25',NULL,'Department Name',NULL,NULL,'"drvDepartmentName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EROLRSFMLAZ0','50','D','10','26',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EROLRSFMLAZ0','50','D','10','27',NULL,'Location Name',NULL,NULL,'"drvLocationName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EROLRSFMLAZ0','50','D','10','28',NULL,'Position',NULL,NULL,'"drvPositionPosition"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EROLRSFMLAZ0','50','D','10','29',NULL,'Shift Worked',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EROLRSFMLAZ0','50','D','10','30',NULL,'Is Active',NULL,NULL,'"drvIsActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EROLRSFMLAZ0','50','D','10','31',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EROLRSFMLAZ0','50','D','10','32',NULL,'Is Fulltime',NULL,NULL,'"drvIsFulltime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EROLRSFMLAZ0','50','D','10','33',NULL,'Is Exempt',NULL,NULL,'"drvIsExempt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EROLRSFMLAZ0','50','D','10','34',NULL,'Annual Salary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EROLRSFMLAZ0','50','D','10','35',NULL,'Hourly Rate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EROLRSFMLAZ0','50','D','10','36',NULL,'FICA Year To Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EROLRSFMLAZ0','50','D','10','37',NULL,'HR Rep Name',NULL,NULL,'"drvHRName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EROLRSFMLAZ0','50','D','10','38',NULL,'HR Rep Email Address',NULL,NULL,'"drvHRAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EROLRSFMLAZ0','50','D','10','39',NULL,'HR Rep Phone',NULL,NULL,'"drvHRPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EROLRSFMLAZ0','50','D','10','40',NULL,'Supervisor Name',NULL,NULL,'"drvSupervisorName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EROLRSFMLAZ0','50','D','10','41',NULL,'Supervisor Email Address',NULL,NULL,'"drvSupervisorAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EROLRSFMLAZ0','50','D','10','42',NULL,'Supervisor Phone',NULL,NULL,'"drvSupervisorPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EROLRSFMLAZ0','50','D','10','43',NULL,'HR Manager Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EROLRSFMLAZ0','50','D','10','44',NULL,'HR Manager Email',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EROLRSFMLAZ0','50','D','10','45',NULL,'HR Manager Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EROLRSFMLAZ0','50','D','10','46',NULL,'Manager Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EROLRSFMLAZ0','50','D','10','47',NULL,'Manager Email',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EROLRSFMLAZ0','50','D','10','48',NULL,'Manager Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EROLRSFMLAZ0','50','D','10','49',NULL,'Sub Group A',NULL,NULL,'"drvSubA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EROLRSFMLAZ0','50','D','10','50',NULL,'Sub Group B',NULL,NULL,'"drvSubB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EROLRSFMLAZ0','50','D','10','51',NULL,'Sub Group C',NULL,NULL,'"drvSubC"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EROLRSFMLAZ0','50','D','10','52',NULL,'Sub Group D',NULL,NULL,'"drvSubD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EROLRSFMLAZ0','50','D','10','53',NULL,'Sub Group E',NULL,NULL,'"drvSubE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EROLRSFMLAZ0','50','D','10','54',NULL,'Sub Group F',NULL,NULL,'"drvSubF"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EROLRSFMLAZ0','50','D','10','55',NULL,'Is STD Eligible',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EROLRSFMLAZ0','50','D','10','56',NULL,'Std Plan Effective',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EROLRSFMLAZ0','50','D','10','57',NULL,'Is STD Supp/Buy Up Plan Eligible',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EROLRSFMLAZ0','50','D','10','58',NULL,'STD Supp/Buy Up Plan Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EROLRSFMLAZ0','50','D','10','59',NULL,'Is California Voluntary Plan Eligible',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EROLRSFMLAZ0','50','D','10','60',NULL,'California Voluntary Plan Effective',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EROLRSFMLAZ0','50','D','10','61',NULL,'Is LTD Eligible',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EROLRSFMLAZ0','50','D','10','62',NULL,'LTD Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EROLRSFMLAZ0','50','D','10','63',NULL,'Is LTD Supp/Buy Up Plan Eligible',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EROLRSFMLAZ0','50','D','10','64',NULL,'LTD Supp/Buy Up Plan Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EROLRSFMLAZ0','50','D','10','65',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EROLRSFMLAZ0','50','D','10','66',NULL,'At Worksite',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EROLRSFMLAZ0','50','D','10','67',NULL,'Domestic Partner Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EROLRSFMLAZ0','50','D','10','68',NULL,'Spouse Working at the Same Company',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EROLRSFMLAZ0','50','D','10','69',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EROLRSFMLAZ0','50','D','10','70',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EROLRSFMLAZ0','50','D','10','71',NULL,'Add Data 01',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EROLRSFMLAZ0','50','D','10','72',NULL,'Add Data 02',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EROLRSFMLAZ0','50','D','10','73',NULL,'Add Data 03',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EROLRSFMLAZ0','50','D','10','74',NULL,'Add Data 04',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EROLRSFMLAZ0','50','D','10','75',NULL,'Add Data 05',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EROLRSFMLAZ0','50','D','10','76',NULL,'Add Data 06 - NY DBL Opt in',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EROLRSFMLAZ0','50','D','10','77',NULL,'Add Data 07 - NY DBL Wages',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EROLRSFMLAZ0','50','D','10','78',NULL,'Add Data 08 - WI Paid Hours Worked',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EROLRSFMLAZ0','50','D','10','79',NULL,'Add Data 09 - MAPFL earnings',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EROLRSFMLAZ0','50','D','10','80',NULL,'Add Data 10',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EROLRSFMLA_20220617.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance Standard FMLA','202206139','EMPEXPORT','ONDEM_XOE',NULL,'EROLRSFMLA',NULL,NULL,NULL,'202206139','Jun 16 2022  9:57AM','Jun 16 2022  9:57AM','202205061',NULL,'','','202205061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance Standard FMLA-Sched','202206139','EMPEXPORT','SCH_EROLRS',NULL,'EROLRSFMLA',NULL,NULL,NULL,'202206139','Jun 16 2022  9:57AM','Jun 16 2022  9:57AM','202205061',NULL,'','','202205061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Reliance Standard FMLA-Test','202206161','EMPEXPORT','TEST_XOE','Jun 17 2022 12:26PM','EROLRSFMLA',NULL,NULL,NULL,'202206161','Jun 16 2022 12:00AM','Dec 30 1899 12:00AM','202206081','16172','','','202206081',dbo.fn_GetTimedKey(),NULL,'us3cPeROL1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EROLRSFMLA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLRSFMLA','H01','dbo.U_EROLRSFMLA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EROLRSFMLA','D10','dbo.U_EROLRSFMLA_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EROLRSFMLA
-----------

IF OBJECT_ID('U_dsi_BDM_EROLRSFMLA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EROLRSFMLA] (
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
-- Create table U_EROLRSFMLA_Audit
-----------

IF OBJECT_ID('U_EROLRSFMLA_Audit') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_Audit] (
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
-- Create table U_EROLRSFMLA_AuditFields
-----------

IF OBJECT_ID('U_EROLRSFMLA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EROLRSFMLA_DedList
-----------

IF OBJECT_ID('U_EROLRSFMLA_DedList') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EROLRSFMLA_drvTbl
-----------

IF OBJECT_ID('U_EROLRSFMLA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] char(9) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmpno] varchar(8000) NULL,
    [drvNameFirst] varchar(40) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(40) NULL,
    [drvAddress1] varchar(50) NULL,
    [drvAddress2] varchar(50) NULL,
    [drvAddress3] varchar(50) NULL,
    [drvAddressCity] varchar(35) NULL,
    [drvAddressState] varchar(2) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvPhonehomenumber] varchar(50) NULL,
    [drvAddressEMailAlternate] varchar(50) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGenderGender] varchar(1) NOT NULL,
    [drvWorkState] varchar(2) NULL,
    [drvWorkPhone] varchar(25) NULL,
    [drvWorkEMailAddress] varchar(50) NULL,
    [drvDepartmentNumber] varchar(10) NULL,
    [drvDepartmentName] varchar(25) NULL,
    [drvLocationCode] varchar(6) NULL,
    [drvLocationName] varchar(25) NULL,
    [drvPositionPosition] varchar(25) NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvIsFulltime] varchar(1) NOT NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvHRName] nvarchar(50) NULL,
    [drvHRAddress] nvarchar(255) NULL,
    [drvHRPhone] nvarchar(4000) NULL,
    [drvSupervisorName] varchar(50) NULL,
    [drvSupervisorAddress] varchar(255) NULL,
    [drvSupervisorPhone] varchar(25) NULL,
    [drvSubA] varchar(20) NULL,
    [drvSubB] varchar(5) NULL,
    [drvSubC] varchar(10) NULL,
    [drvSubD] varchar(10) NULL,
    [drvSubE] varchar(10) NULL,
    [drvSubF] varchar(20) NULL,
    [drvHoursWorked] nvarchar(25) NOT NULL
);

-----------
-- Create table U_EROLRSFMLA_EEList
-----------

IF OBJECT_ID('U_EROLRSFMLA_EEList') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EROLRSFMLA_File
-----------

IF OBJECT_ID('U_EROLRSFMLA_File') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EROLRSFMLA_Header
-----------

IF OBJECT_ID('U_EROLRSFMLA_Header') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_Header] (
    [drvSTDSuppBuyUpPlanEligible] varchar(32) NOT NULL,
    [drvSTDSuppBuyUpPlanEffecDate] varchar(35) NOT NULL,
    [drvCaliVoluntaryPlanEligible] varchar(37) NOT NULL,
    [drvCaliVoluntaryPlanEffective] varchar(35) NOT NULL,
    [drvIsLTDSuppBuyUpPlanEligible] varchar(32) NOT NULL,
    [drvTDSuppBuyUpPlanEffDate] varchar(35) NOT NULL,
    [drvSpouseWorkingatSameCompany] varchar(34) NOT NULL,
    [drvEmp50in75MileIndicator] varchar(33) NOT NULL,
    [drvAddData06NYDBLOptin] varchar(27) NOT NULL,
    [drvAddData07NYDBLWages] varchar(26) NOT NULL,
    [drvAddData08WIPaidHrsWked] varchar(34) NOT NULL,
    [drvAddData09MAPFLearnings] varchar(28) NOT NULL
);

-----------
-- Create table U_EROLRSFMLA_PDedHist
-----------

IF OBJECT_ID('U_EROLRSFMLA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_PDedHist] (
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
-- Create table U_EROLRSFMLA_PEarHist
-----------

IF OBJECT_ID('U_EROLRSFMLA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EROLRSFMLA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EROLRSFMLA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 06/16/2022
Service Request Number: TekP-2022-05-19-01

Purpose: Reliance Standard FMLA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EROLRSFMLA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EROLRSFMLA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EROLRSFMLA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EROLRSFMLA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EROLRSFMLA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLRSFMLA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLRSFMLA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EROLRSFMLA', 'SCH_EROLRS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EROLRSFMLA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EROLRSFMLA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EROLRSFMLA';

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
    DELETE FROM dbo.U_EROLRSFMLA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EROLRSFMLA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EROLRSFMLA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EROLRSFMLA_AuditFields;
    CREATE TABLE dbo.U_EROLRSFMLA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EROLRSFMLA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EROLRSFMLA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EROLRSFMLA_Audit;
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
    INTO dbo.U_EROLRSFMLA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EROLRSFMLA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND audNewValue = 'T' ;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EROLRSFMLA_Audit ON dbo.U_EROLRSFMLA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EROLRSFMLA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EROLRSFMLA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EROLRSFMLA_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EROLRSFMLA_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EROLRSFMLA_DedList
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
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EROLRSFMLA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EROLRSFMLA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ---- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           =  SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EROLRSFMLA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN EarnCode WITH (NOLOCK) 
        ON ErnEarnCode = pehEarnCode and ErnInclInTotalHoursWorked = 'Y'
     WHERE PehPerControl BETWEEN FORMAT(DATEADD(MONTH, -12, @EndDATE), 'yyyyMMdd') + '1' AND @EndPerControl
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EROLRSFMLA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EROLRSFMLA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EROLRSFMLA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvSSN = eepSSN
        ,drvEmpno = REPLACE(LTRIM(REPLACE(EecEmpNo, '0', ' ')), ' ', '0')
        ,drvNameFirst = Left(EepNameFirst,40)
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast =Left(EepNameLast,40)
        ,drvAddress1 = Left(EepAddressLine1,50)
        ,drvAddress2 = Left(EepAddressLine2,50)
        ,drvAddress3 = Left(EepAddressLine3, 50)
        ,drvAddressCity = Left(EepAddressCity, 35)
        ,drvAddressState = Left(EepAddressState, 2)
        ,drvAddressZip = CASE LEN(LTRIM(RTRIM(EepAddressZipCode)))
                            WHEN 9 THEN LEFT(LTRIM(RTRIM(EepAddressZipCode)),5) + '-' + RIGHT(LTRIM(RTRIM(EepAddressZipCode)),4)
                             ELSE EepAddressZipCode
                            END
        ,drvPhonehomenumber = EepPhoneHomeNumber
        ,drvAddressEMailAlternate = EepAddressEMailAlternate
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGenderGender = CASE WHEN EepGender = 'M' THEN 'M'
                                WHEN EepGender = 'F' THEN 'F'
                                ELSE 'U'
                             END
        ,drvWorkState = Left(EepAddressState, 2)
        ,drvWorkPhone = Left(EecPhoneBusinessNumber, 25)
        ,drvWorkEMailAddress = Left(EepAddressEMail, 255)
        ,drvDepartmentNumber = Left(EecOrgLvl3, 10)
        ,drvDepartmentName = Left(OrgDesc, 40)
        ,drvLocationCode = Left(EecLocation, 20)
        ,drvLocationName = Left(LocDesc, 50)
        ,drvPositionPosition = Left(JbcDesc, 50)
        ,drvIsActive = CASE WHEN eecemplstatus = 'T' THEN 'N' else 'Y' END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN  convert(varchar(10), cast(EecDateOfTermination as date), 101) END
        ,drvIsFulltime = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Y' ELSE 'N' END
        ,drvIsExempt = CASE WHEN EJH.EjhFLSACategory = 'E' THEN 'Y' ELSE  'N' END
        ,drvHRName = Left((SELECT OrgLevel1_HRLeaderName from dbo.fn_MP_CustomFields_vwOrgLevel1_Export (NULL,NULL,NULL,NULL)where EecOrgLvl1 = OrgCode),50)
        ,drvHRAddress = Left((SELECT OrgLevel1_HRLeaderEmail from dbo.fn_MP_CustomFields_vwOrgLevel1_Export (NULL,NULL,NULL,NULL)where EecOrgLvl1 = OrgCode),255)
        ,drvHRPhone = REPLACE(LTRIM(REPLACE((SELECT OrgLevel1_HRLeaderPhone from dbo.fn_MP_CustomFields_vwOrgLevel1_Export (NULL,NULL,NULL,NULL)where EecOrgLvl1 = OrgCode), '1-', ' ')), ' ', '1-')
        ,drvSupervisorName = Left(dbo.dsi_fnlib_GetSupervisorField_v2(EecCoid,EecEEID, 'NameFirst Last'), 50)
        ,drvSupervisorAddress = Left(dbo.dsi_fnlib_GetSupervisorField_v2(EecCoid, EecEEID, 'AddressEmail'), 255)
        ,drvSupervisorPhone = Left(dbo.dsi_fnlib_GetSupervisorField_v2(EecCoid, EecEEID, 'Phone'), 25)
        ,drvSubA = Left(LocAddressState,20)
        ,drvSubB = Left(cmpcompanycode,20)
        ,drvSubC = Left(EecOrgLvl1,20)
        ,drvSubD = Left(EecOrgLvl2,20)
        ,drvSubE = Left(EecOrgLvl3, 20) 
        ,drvSubF = Left(Org3.OrgDesc,20)
        ,drvHoursWorked =  ISNULL(Left(FORMAT(PehCurHrsYTD, '#0.00'),25),'0.00')  
    INTO dbo.U_EROLRSFMLA_drvTbl
    FROM dbo.U_EROLRSFMLA_EEList WITH (NOLOCK)
       JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        and EepAddressCountry = 'USA'
    LEFT JOIN dbo.U_EROLRSFMLA_PEarHist  WITH (NOLOCK) 
        ON PehEEID = xEEID     
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.vw_int_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
    JOIN dbo.OrgLevel AS Org3 WITH (NOLOCK) 
        ON Org3.OrgCode = EecOrgLvl3
        AND Org3.OrgLvl = 3        
    JOIN dbo.JobCode WITH (NOLOCK) 
        ON JbcJobCode = EecJobCode 
    LEFT JOIN dbo.U_EROLRSFMLA_Audit
        ON audEEID = xEEID
        AND audKey2 = xCOID
    JOIN dbo.COMPANY WITH (NOLOCK) 
        ON eeccoid = cmpcoid
        and cmpcompanycode NOT IN ('CPC','OPC')  
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EJH.EjhEEID = xEEID
        AND EJH.EjhCOID = xCOID
        AND EJH.EjhJobCode = EecJobCode 
    Where EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EROLRSFMLA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EROLRSFMLA_Header;
    SELECT DISTINCT
         drvSTDSuppBuyUpPlanEligible = 'Is STD Supp/Buy Up Plan Eligible'
        ,drvSTDSuppBuyUpPlanEffecDate = 'STD Supp/Buy Up Plan Effective Date'
        ,drvCaliVoluntaryPlanEligible = 'Is California Voluntary Plan Eligible'
        ,drvCaliVoluntaryPlanEffective = 'California Voluntary Plan Effective'
        ,drvIsLTDSuppBuyUpPlanEligible = 'Is LTD Supp/Buy Up Plan Eligible'
        ,drvTDSuppBuyUpPlanEffDate = 'LTD Supp/Buy Up Plan Effective Date'
        ,drvSpouseWorkingatSameCompany = 'Spouse Working at the Same Company'
        ,drvEmp50in75MileIndicator = 'Employees 50 in 75 Mile Indicator'
        ,drvAddData06NYDBLOptin = 'Add Data 06 - NY DBL Opt in'
        ,drvAddData07NYDBLWages = 'Add Data 07 - NY DBL Wages'
        ,drvAddData08WIPaidHrsWked = 'Add Data 08 - WI Paid Hours Worked'
        ,drvAddData09MAPFLearnings = 'Add Data 09 - MAPFL earnings'
    INTO dbo.U_EROLRSFMLA_Header
  
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
ALTER VIEW dbo.dsi_vwEROLRSFMLA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EROLRSFMLA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EROLRSFMLA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202205061'
       ,expStartPerControl     = '202205061'
       ,expLastEndPerControl   = '202206139'
       ,expEndPerControl       = '202206139'
WHERE expFormatCode = 'EROLRSFMLA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEROLRSFMLA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EROLRSFMLA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EROLRSFMLA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EROLRSFMLA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EROLRSFMLA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLRSFMLA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EROLRSFMLA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EROLRSFMLA', 'UseFileName', 'V', 'Y'


-- End ripout