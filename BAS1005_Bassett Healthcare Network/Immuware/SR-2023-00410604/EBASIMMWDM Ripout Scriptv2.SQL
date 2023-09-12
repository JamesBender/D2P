/**********************************************************************************

EBASIMMWDM: Immuware Demographic

FormatCode:     EBASIMMWDM
Project:        Immuware Demographic
Client ID:      BAS1005
Date/time:      2023-09-12 08:52:46.903
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E11
Server:         E1SUP1DB53
Database:       ULTIPRO_BASH
Web Filename:   BAS1005_P4A13_EEHISTORY_EBASIMMWDM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBASIMMWDM_SavePath') IS NOT NULL DROP TABLE dbo.U_EBASIMMWDM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBASIMMWDM'


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
WHERE FormatCode = 'EBASIMMWDM'
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
WHERE ExpFormatCode = 'EBASIMMWDM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBASIMMWDM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBASIMMWDM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBASIMMWDM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBASIMMWDM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBASIMMWDM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBASIMMWDM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBASIMMWDM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBASIMMWDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBASIMMWDM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBASIMMWDM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBASIMMWDM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBASIMMWDM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBASIMMWDM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBASIMMWDM];
GO
IF OBJECT_ID('U_EBASIMMWDM_Header') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_Header];
GO
IF OBJECT_ID('U_EBASIMMWDM_File') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_File];
GO
IF OBJECT_ID('U_EBASIMMWDM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_EEList];
GO
IF OBJECT_ID('U_EBASIMMWDM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_drvTbl];
GO
IF OBJECT_ID('U_EBASIMMWDM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_AuditFields];
GO
IF OBJECT_ID('U_EBASIMMWDM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBASIMMWDM_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBASIMMWDM','Immuware Demographic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EBASIMMWDMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBASIMMWDMZ0','50','H','01','1',NULL,'Personnel Type Id',NULL,NULL,'"Personnel Type Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBASIMMWDMZ0','50','H','01','2',NULL,'Personnel Type',NULL,NULL,'"Personnel Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBASIMMWDMZ0','50','H','01','3',NULL,'Personnel Id*',NULL,NULL,'"Personnel Id*"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBASIMMWDMZ0','50','H','01','4',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBASIMMWDMZ0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBASIMMWDMZ0','50','H','01','6',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBASIMMWDMZ0','50','H','01','7',NULL,'Date of Birth (mm/dd/yyyy)',NULL,NULL,'"Date of Birth (mm/dd/yyyy)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBASIMMWDMZ0','50','H','01','8',NULL,'Last 4 Digits of SSN',NULL,NULL,'"Last 4 Digits of SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBASIMMWDMZ0','50','H','01','9',NULL,'Job Title Id',NULL,NULL,'"Job Title Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBASIMMWDMZ0','50','H','01','10',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBASIMMWDMZ0','50','H','01','11',NULL,'Phone Number',NULL,NULL,'"Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBASIMMWDMZ0','50','H','01','12',NULL,'Mobile Phone',NULL,NULL,'"Mobile Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBASIMMWDMZ0','50','H','01','13',NULL,'Facility Id',NULL,NULL,'"Facility Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBASIMMWDMZ0','50','H','01','14',NULL,'Facility',NULL,NULL,'"Facility"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBASIMMWDMZ0','50','H','01','15',NULL,'Facility Short',NULL,NULL,'"Facility Short"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBASIMMWDMZ0','50','H','01','16',NULL,'Location/Dept Id',NULL,NULL,'"Location/Dept Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBASIMMWDMZ0','50','H','01','17',NULL,'Location/Dept',NULL,NULL,'"Location/Dept"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBASIMMWDMZ0','50','H','01','18',NULL,'Group Affiliation Id',NULL,NULL,'"Group Affiliation Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBASIMMWDMZ0','50','H','01','19',NULL,'Group Affiliation',NULL,NULL,'"Group Affiliation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBASIMMWDMZ0','50','H','01','20',NULL,'LOA Start Date',NULL,NULL,'"LOA Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBASIMMWDMZ0','50','H','01','21',NULL,'LOA End Date',NULL,NULL,'"LOA End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBASIMMWDMZ0','50','H','01','22',NULL,'Supervisor Personnel Id',NULL,NULL,'"Supervisor Personnel Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBASIMMWDMZ0','50','H','01','23',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBASIMMWDMZ0','50','H','01','24',NULL,'Position Start Date',NULL,NULL,'"Position Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBASIMMWDMZ0','50','H','01','25',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBASIMMWDMZ0','50','H','01','26',NULL,'Is Active',NULL,NULL,'"Is Active"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBASIMMWDMZ0','50','H','01','27',NULL,'Workforce Immuware User',NULL,NULL,'"Workforce Immuware User"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBASIMMWDMZ0','50','H','01','28',NULL,'Immuware Username',NULL,NULL,'"Immuware Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBASIMMWDMZ0','50','H','01','29',NULL,'Mothers Maiden Name',NULL,NULL,'"Mothers Maiden Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBASIMMWDMZ0','50','H','01','30',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBASIMMWDMZ0','50','H','01','31',NULL,'Address1',NULL,NULL,'"Address1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBASIMMWDMZ0','50','H','01','32',NULL,'Address2',NULL,NULL,'"Address2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBASIMMWDMZ0','50','H','01','33',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBASIMMWDMZ0','50','H','01','34',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBASIMMWDMZ0','50','H','01','35',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBASIMMWDMZ0','50','H','01','36',NULL,'Race',NULL,NULL,'"Race"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBASIMMWDMZ0','50','H','01','37',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBASIMMWDMZ0','50','H','01','38',NULL,'Multiple Birth',NULL,NULL,'"drvMultipleBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBASIMMWDMZ0','50','H','01','39',NULL,'Birth Order if Multiple Birth is Yes',NULL,NULL,'"drvBirthOrder"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBASIMMWDMZ0','50','D','10','1',NULL,'Personnel Type Id',NULL,NULL,'"drvPersonnelTypeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBASIMMWDMZ0','50','D','10','2',NULL,'Personnel Type',NULL,NULL,'"drvPersonnelType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBASIMMWDMZ0','50','D','10','3',NULL,'Personnel Id*',NULL,NULL,'"drvPersonnelId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBASIMMWDMZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBASIMMWDMZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBASIMMWDMZ0','50','D','10','6',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBASIMMWDMZ0','50','D','10','7',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBASIMMWDMZ0','50','D','10','8',NULL,'Last 4 Digits of SSN',NULL,NULL,'"drvLastDigitsofSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBASIMMWDMZ0','50','D','10','9',NULL,'Job Title Id',NULL,NULL,'"drvJobTitleID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBASIMMWDMZ0','50','D','10','10',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBASIMMWDMZ0','50','D','10','11',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBASIMMWDMZ0','51','D','10','12',NULL,'Mobile Phone',NULL,NULL,'"drvMobilePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBASIMMWDMZ0','52','D','10','13',NULL,'Facility Id',NULL,NULL,'"drvFacilityId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBASIMMWDMZ0','53','D','10','14',NULL,'Facility',NULL,NULL,'"drvFacility"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBASIMMWDMZ0','54','D','10','15',NULL,'Facility Short',NULL,NULL,'"drvFacilityShort"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBASIMMWDMZ0','55','D','10','16',NULL,'Location/Dept Id',NULL,NULL,'"drvLocationDeptID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBASIMMWDMZ0','56','D','10','17',NULL,'Location/Dept',NULL,NULL,'"drvLocationDept"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBASIMMWDMZ0','57','D','10','18',NULL,'Group Affiliation Id',NULL,NULL,'"drvGroupAffiliationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBASIMMWDMZ0','58','D','10','19',NULL,'Group Affiliation',NULL,NULL,'"drvGroupAffiliation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBASIMMWDMZ0','59','D','10','20',NULL,'LOA Start Date',NULL,NULL,'"drvLOAStartDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBASIMMWDMZ0','60','D','10','21',NULL,'LOA End Date',NULL,NULL,'"drvLOAEndDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBASIMMWDMZ0','61','D','10','22',NULL,'Supervisor Personnel Id',NULL,NULL,'"drvSupervisorPersonnelID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBASIMMWDMZ0','62','D','10','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBASIMMWDMZ0','63','D','10','24',NULL,'Position Start Date',NULL,NULL,'"drvPositionStartDATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBASIMMWDMZ0','64','D','10','25',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBASIMMWDMZ0','65','D','10','26',NULL,'Is Active',NULL,NULL,'"drvIsActive"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBASIMMWDMZ0','66','D','10','27',NULL,'Workforce Immuware User',NULL,NULL,'"drvWorkforceImmuwareUSER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBASIMMWDMZ0','67','D','10','28',NULL,'Immuware Username',NULL,NULL,'"drvImmuwareUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBASIMMWDMZ0','68','D','10','29',NULL,'Mother''s Maiden Name',NULL,NULL,'"drvMothersMaidenNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBASIMMWDMZ0','69','D','10','30',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBASIMMWDMZ0','70','D','10','31',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBASIMMWDMZ0','71','D','10','32',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBASIMMWDMZ0','72','D','10','33',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBASIMMWDMZ0','73','D','10','34',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBASIMMWDMZ0','74','D','10','35',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBASIMMWDMZ0','75','D','10','36',NULL,'Race',NULL,NULL,'"drvRace"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBASIMMWDMZ0','76','D','10','37',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBASIMMWDMZ0','77','D','10','38',NULL,'Multiple Birth',NULL,NULL,'"drvMultipleBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBASIMMWDMZ0','78','D','10','39',NULL,'Birth Order if Multiple Birth is Yes',NULL,NULL,'"drvBirthOrder"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBASIMMWDM_20230912.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Immuware Demographic','202307189','EMPEXPORT','ONDEM_XOE',NULL,'EBASIMMWDM',NULL,NULL,NULL,'202307189','Jul 18 2023  3:14PM','Jul 18 2023  3:14PM','202307181',NULL,'','','202307181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Immuware Demographic-Sched','202307189','EMPEXPORT','SCH_EBASIM',NULL,'EBASIMMWDM',NULL,NULL,NULL,'202307189','Jul 18 2023  3:14PM','Jul 18 2023  3:14PM','202307181',NULL,'','','202307181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',7STZV,7STZ5,7SU10,7SU5E,7STWW,7SU45,7SU6H,7SU78',NULL,NULL,NULL,'Immuware Demographic-Test','202307259','EMPEXPORT','TEST_XOE',NULL,'EBASIMMWDM',NULL,NULL,NULL,'202307259','Jul 18 2023  3:14PM','Jul 18 2023  3:14PM','202307191',NULL,'','','202307191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASIMMWDM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBASIMMWDM','H01','dbo.U_EBASIMMWDM_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBASIMMWDM','D10','dbo.U_EBASIMMWDM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBASIMMWDM_Audit
-----------

IF OBJECT_ID('U_EBASIMMWDM_Audit') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_Audit] (
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
-- Create table U_EBASIMMWDM_AuditFields
-----------

IF OBJECT_ID('U_EBASIMMWDM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBASIMMWDM_drvTbl
-----------

IF OBJECT_ID('U_EBASIMMWDM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPersonnelTypeID] varchar(9) NULL,
    [drvPersonnelType] varchar(21) NULL,
    [drvPersonnelId] char(9) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvEmail] varchar(50) NULL,
    [drvDateofBirth] varchar(10) NULL,
    [drvLastDigitsofSSN] varchar(4) NULL,
    [drvJobTitleID] char(8) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvPhoneNumber] varchar(10) NULL,
    [drvMobilePhone] varchar(10) NULL,
    [drvFacilityId] varchar(8000) NULL,
    [drvFacility] varchar(8000) NULL,
    [drvFacilityShort] varchar(1) NOT NULL,
    [drvLocationDeptID] char(10) NOT NULL,
    [drvLocationDept] varchar(8000) NULL,
    [drvGroupAffiliationID] varchar(8) NOT NULL,
    [drvGroupAffiliation] varchar(8) NOT NULL,
    [drvLOAStartDATE] varchar(10) NULL,
    [drvLOAEndDATE] varchar(10) NULL,
    [drvSupervisorPersonnelID] varchar(256) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvPositionStartDATE] varchar(10) NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvWorkforceImmuwareUSER] varchar(1) NOT NULL,
    [drvImmuwareUsername] char(10) NULL,
    [drvMothersMaidenNAME] varchar(1) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(8000) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvRace] varchar(6) NOT NULL,
    [drvEthnicity] varchar(6) NOT NULL,
    [drvMultipleBirth] varchar(1) NOT NULL,
    [drvBirthOrder] varchar(1) NOT NULL
);

-----------
-- Create table U_EBASIMMWDM_EEList
-----------

IF OBJECT_ID('U_EBASIMMWDM_EEList') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBASIMMWDM_File
-----------

IF OBJECT_ID('U_EBASIMMWDM_File') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EBASIMMWDM_Header
-----------

IF OBJECT_ID('U_EBASIMMWDM_Header') IS NULL
CREATE TABLE [dbo].[U_EBASIMMWDM_Header] (
    [drvMultipleBirth] varchar(15) NOT NULL,
    [drvBirthOrder] varchar(36) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBASIMMWDM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bassett Healthcare Network

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 07/18/2023
Service Request Number: SR-2023-00410604

Purpose: Immuware Demographic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBASIMMWDM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBASIMMWDM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBASIMMWDM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBASIMMWDM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBASIMMWDM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASIMMWDM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASIMMWDM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASIMMWDM', 'SCH_EBASIM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBASIMMWDM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBASIMMWDM';

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
    DELETE FROM dbo.U_EBASIMMWDM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBASIMMWDM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBASIMMWDM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBASIMMWDM_AuditFields;
    CREATE TABLE dbo.U_EBASIMMWDM_AuditFields (aTableName varchar(30),aFieldName varchar(30));
      INSERT INTO dbo.U_EBASIMMWDM_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBASIMMWDM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBASIMMWDM_Audit;
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
    INTO dbo.U_EBASIMMWDM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBASIMMWDM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN Dateadd(d, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBASIMMWDM_Audit ON dbo.U_EBASIMMWDM_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EBASIMMWDM_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBASIMMWDM_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBASIMMWDM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBASIMMWDM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBASIMMWDM_drvTbl;
    
SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
         ,drvPersonnelTypeID =  CASE WHEN EecEEType in ('REG', 'PER', 'INT') THEN '1' 
                                    WHEN EecEEType = 'CON' then '2' 
                                    WHEN EecEEType = 'STU' then '4'
                                    WHEN EecEEType in ('NON', 'TMP') then '7' 
                                    WHEN EecEEType = 'PEN' then '999999999'
                                END
        ,drvPersonnelType = CASE WHEN EecEEType in ('REG', 'PER', 'INT') THEN 'Employee' 
                                    WHEN EecEEType = 'CON' then 'Contractor/Consultant' 
                                    WHEN EecEEType = 'STU' then 'Student'
                                    WHEN EecEEType in ('NON', 'TMP') then 'Agency' 
                                    WHEN EecEEType = 'PEN' then 'New Hire'
                                END    --CASE WHEN coddesc = 'Pending' THEN 'New Hire' 
                                   --ELSE 'Employee'
                                --END
                                --coddesc --coddesc where codtable = EMPTYPE
        ,drvPersonnelId = EecEmpNo
        ,drvFirstName = REPLACE(EepNameFirst, ',', '')
        ,drvLastName = REPLACE(EepNameLast, ',', '')
        ,drvEmail = EepAddressEMail
        ,drvDateofBirth = CONVERT(VARCHAR(10),EepDateOfBirth,101)
        ,drvLastDigitsofSSN = Right(Ltrim(Rtrim(eepSSN)),4)
        ,drvJobTitleID = EecJobCode
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvPhoneNumber = CASE WHEN ISNULL(EecPhoneBusinessNumber , '') <>'' THEN Left(EecPhoneBusinessNumber,10) END
        ,drvMobilePhone = Left(dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL'),10)
        ,drvFacilityId = REPLACE(EecOrgLvl1, ',', '')  --REPLACE(EecLocation, ',', '')
        ,drvFacility = REPLACE(o1.OrgDesc, ',', '')
        ,drvFacilityShort = ''
        ,drvLocationDeptID = o3.OrgCode
        ,drvLocationDept = REPLACE( o3.OrgDesc, ',', '')
        ,drvGroupAffiliationID = CASE WHEN ISNULL(EecUnionLocal, '')  <> '' THEN 'Union' ELSE 'NonUnion' END --REPLACE(EecUnionLocal, ',', '')
        ,drvGroupAffiliation = CASE WHEN ISNULL(EecUnionLocal, '')  <> '' THEN 'Union' ELSE 'NonUnion' END--CASE WHEN ISNULL(EecUnionNational, '')  <> '' THEN REPLACE(EecUnionNational, ',', '') ELSE 'NonUnion' END
        ,drvLOAStartDATE = CASE WHEN EecEmplStatus = 'L' then CONVERT(VARCHAR(10),EecEmplStatusStartDate, 101) END
        ,drvLOAEndDATE = CASE WHEN EecEmplStatus = 'L' then CONVERT(VARCHAR(10),EecPlannedStatusEndDate, 101) END
        ,drvSupervisorPersonnelID = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Empno')  
        ,drvHireDate = CONVERT(VARCHAR(10),EecDateOfOriginalHire, 101)
        ,drvPositionStartDATE = CONVERT(VARCHAR(10),EjhJobEffDate, 101)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' and EecTermReason <> 'TRO' THEN CONVERT(VARCHAR(10),EecDateOfTermination, 101) END
        ,drvIsActive = CASE WHEN EecEmplStatus in ('A','L') THEN '1' ELSE '0' END
        ,drvWorkforceImmuwareUSER = CASE WHEN ISNULL(EECUDFIELD02, '') = '' and ISNULL(EepAddressEMail, '') <> '' THEN '2' 
                                         WHEN ISNULL(EECUDFIELD02, '') = '' and ISNULL(EepAddressEMail, '') = '' THEN '0'    
                                        ELSE '1' 
                                    END
        ,drvImmuwareUsername = CASE WHEN ISNULL(EECUDFIELD02, '') = '' and  ISNULL(EepAddressEMail, '') <> '' THEN EecEmpNo ELSE EECUDFIELD02 END
        ,drvMothersMaidenNAME = ''
        ,drvGender = CASE WHEN EepGender IN ('M', 'F' ) THEN EepGender else 'U' ENd
        ,drvAddress1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(EepAddressLine2, ',', '')
        ,drvCity = REPLACE(EepAddressCity, ',', '')
        ,drvState = REPLACE(EepAddressState, ',', '')
        ,drvZipCode = Left(EepAddressZipCode,5)
        ,drvRace = CASE WHEN eepEthnicID = '5' THEN '1002-5' 
                        WHEN eepEthnicID = '6' THEN '2028-9' 
                        WHEN eepEthnicID = '2' THEN '2054-5' 
                        WHEN eepEthnicID = '7' THEN '2076-8' 
                        WHEN eepEthnicID = '1' THEN '2106-3' 
                        ELSE'2131-1'
                    END

        ,drvEthnicity = CASE WHEN eepEthnicID = '3' THEN '2135-2' ELSE '2186-5' END
        ,drvMultipleBirth = ''
        ,drvBirthOrder = ''
    INTO dbo.U_EBASIMMWDM_drvTbl
    FROM dbo.U_EBASIMMWDM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
     JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
     JOIN dbo.Orglevel o3 WITH (NOLOCK)
        ON  o3.OrgCode = EecOrgLvl3
        and   o3.OrgLvl = 3
         JOIN dbo.Orglevel o1 WITH (NOLOCK)
        ON  o1.OrgCode = EecOrgLvl1
        and   o1.OrgLvl = 1
    --LEFT JOIN dbo.LabUnion LU
 --       ON LU.unicode = EecUnionLocal
     LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID,EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON EjhEEID = EecEEID
                            AND EjhJObEffDate = EecDateOfLastHire
                          
                        ) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID        
        AND EjhCOID = xCOID
    Left Join dbo.U_EBASIMMWDM_Audit WITH (NOLOCK)
        ON audeeid = xeeid
        and audKey2 = xcoid
    JOIN codes WITH (NOLOCK) 
    ON codcode =EecEETYPE
    and codtable = 'EMPTYPE'
         WHERE EecEEType IN ('CON', 'INT', 'NON' ,'PEN', 'PER', 'REG', 'STU', 'TMP') 
         and  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime BETWEEN   @StartDate  AND @EndDate  ))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBASIMMWDM_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBASIMMWDM_Header;
    SELECT DISTINCT
         drvMultipleBirth = 'Multiple Birth?'
        ,drvBirthOrder = 'Birth Order if Multiple Birth is Yes'
    INTO dbo.U_EBASIMMWDM_Header
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
ALTER VIEW dbo.dsi_vwEBASIMMWDM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBASIMMWDM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBASIMMWDM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307111'
       ,expStartPerControl     = '202307111'
       ,expLastEndPerControl   = '202307189'
       ,expEndPerControl       = '202307189'
WHERE expFormatCode = 'EBASIMMWDM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBASIMMWDM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBASIMMWDM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBASIMMWDM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBASIMMWDM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBASIMMWDM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBASIMMWDM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBASIMMWDM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBASIMMWDM', 'UseFileName', 'V', 'Y'


-- End ripout