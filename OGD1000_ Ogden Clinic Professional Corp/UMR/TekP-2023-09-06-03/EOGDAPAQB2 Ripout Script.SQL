/**********************************************************************************

EOGDAPAQB2: APA Cobra QB TEST

FormatCode:     EOGDAPAQB2
Project:        APA Cobra QB TEST
Client ID:      OGD1000
Date/time:      2023-09-26 14:04:52.163
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP6DB02
Database:       ULTIPRO_WPOGD
Web Filename:   OGD1000_MN3B4_EEHISTORY_EOGDAPAQB2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EOGDAPAQB2_SavePath') IS NOT NULL DROP TABLE dbo.U_EOGDAPAQB2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EOGDAPAQB2'


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
WHERE FormatCode = 'EOGDAPAQB2'
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
WHERE ExpFormatCode = 'EOGDAPAQB2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EOGDAPAQB2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EOGDAPAQB2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EOGDAPAQB2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EOGDAPAQB2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EOGDAPAQB2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EOGDAPAQB2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EOGDAPAQB2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EOGDAPAQB2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EOGDAPAQB2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EOGDAPAQB2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEOGDAPAQB2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOGDAPAQB2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOGDAPAQB2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOGDAPAQB2];
GO
IF OBJECT_ID('U_EOGDAPAQB2_File') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_File];
GO
IF OBJECT_ID('U_EOGDAPAQB2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_EEList];
GO
IF OBJECT_ID('U_EOGDAPAQB2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_drvTbl];
GO
IF OBJECT_ID('U_EOGDAPAQB2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_DedList];
GO
IF OBJECT_ID('U_EOGDAPAQB2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_AuditFields];
GO
IF OBJECT_ID('U_EOGDAPAQB2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EOGDAPAQB2_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EOGDAPAQB2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOGDAPAQB2];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOGDAPAQB2','APA Cobra QB TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EOGDAPAQB20','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOGDAPAQB20','50','H','01','1',NULL,'Company Name',NULL,NULL,'"Company Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOGDAPAQB20','50','H','01','2',NULL,'Division Name',NULL,NULL,'"Division Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOGDAPAQB20','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOGDAPAQB20','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOGDAPAQB20','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOGDAPAQB20','50','H','01','6',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOGDAPAQB20','50','H','01','7',NULL,'Email Address (Optional)',NULL,NULL,'"Email Address (Optional)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOGDAPAQB20','50','H','01','8',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOGDAPAQB20','50','H','01','9',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EOGDAPAQB20','50','H','01','10',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EOGDAPAQB20','50','H','01','11',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EOGDAPAQB20','50','H','01','12',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EOGDAPAQB20','50','H','01','13',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EOGDAPAQB20','50','H','01','14',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EOGDAPAQB20','50','H','01','15',NULL,'Medical Plan',NULL,NULL,'"Medical Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EOGDAPAQB20','50','H','01','16',NULL,'Medical Tier',NULL,NULL,'"Medical Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EOGDAPAQB20','50','H','01','17',NULL,'Medical Effective Date',NULL,NULL,'"Medical Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EOGDAPAQB20','50','H','01','18',NULL,'Dental Plan',NULL,NULL,'"Dental Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EOGDAPAQB20','50','H','01','19',NULL,'Dental Tier',NULL,NULL,'"Dental Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EOGDAPAQB20','50','H','01','20',NULL,'Dental Effective Date',NULL,NULL,'"Dental Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EOGDAPAQB20','50','H','01','21',NULL,'Vision Plan',NULL,NULL,'"Vision Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EOGDAPAQB20','50','H','01','22',NULL,'Vision Tier',NULL,NULL,'"Vision Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EOGDAPAQB20','50','H','01','23',NULL,'Vision Effective Date',NULL,NULL,'"Vision Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EOGDAPAQB20','50','H','01','24',NULL,'FSA Plan',NULL,NULL,'"FSA Plan"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EOGDAPAQB20','50','H','01','25',NULL,'FSA Tier',NULL,NULL,'"FSA Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EOGDAPAQB20','50','H','01','26',NULL,'FSA Effective Date',NULL,NULL,'"FSA Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EOGDAPAQB20','50','H','01','27',NULL,'Active or COBRA',NULL,NULL,'"Active or COBRA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EOGDAPAQB20','50','H','01','28',NULL,'Type of Qualifying Event',NULL,NULL,'"Type of Qualifying Event"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EOGDAPAQB20','50','H','01','29',NULL,'Date of Qualifying Event if on COBRA',NULL,NULL,'"Date of Qualifying Event if on COBRA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EOGDAPAQB20','50','H','01','30',NULL,'Month of Last COBRA Payment Made',NULL,NULL,'"Month of Last COBRA Payment Made"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EOGDAPAQB20','50','H','01','31',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EOGDAPAQB20','50','H','01','32',NULL,'Spouse Last Name',NULL,NULL,'"Spouse Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EOGDAPAQB20','50','H','01','33',NULL,'Spouse First Name',NULL,NULL,'"Spouse First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EOGDAPAQB20','50','H','01','34',NULL,'Spouse DOB',NULL,NULL,'"Spouse DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EOGDAPAQB20','50','H','01','35',NULL,'Spouse Gender',NULL,NULL,'"Spouse Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EOGDAPAQB20','50','H','01','36',NULL,'Dep 1 SSN',NULL,NULL,'"Dep 1 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EOGDAPAQB20','50','H','01','37',NULL,'Dep 1 Last Name',NULL,NULL,'"Dep 1 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EOGDAPAQB20','50','H','01','38',NULL,'Dep 1 First Name',NULL,NULL,'"Dep 1 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EOGDAPAQB20','50','H','01','39',NULL,'Dep 1 DOB',NULL,NULL,'"Dep 1 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EOGDAPAQB20','50','H','01','40',NULL,'Dep 1 Gender',NULL,NULL,'"Dep 1 Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EOGDAPAQB20','50','H','01','41',NULL,'Dep 2 SSN',NULL,NULL,'"Dep 2 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EOGDAPAQB20','50','H','01','42',NULL,'Dep 2 Last Name',NULL,NULL,'"Dep 2 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EOGDAPAQB20','50','H','01','43',NULL,'Dep 2 First Name',NULL,NULL,'"Dep 2 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EOGDAPAQB20','50','H','01','44',NULL,'Dep 2 DOB',NULL,NULL,'"Dep 2 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EOGDAPAQB20','50','H','01','45',NULL,'Dep 2 Gender',NULL,NULL,'"Dep 2 Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EOGDAPAQB20','50','H','01','46',NULL,'Dep 3 SSN',NULL,NULL,'"Dep 3 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EOGDAPAQB20','50','H','01','47',NULL,'Dep 3 Last Name',NULL,NULL,'"Dep 3 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EOGDAPAQB20','50','H','01','48',NULL,'Dep 3 First Name',NULL,NULL,'"Dep 3 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EOGDAPAQB20','50','H','01','49',NULL,'Dep 3 DOB',NULL,NULL,'"Dep 3 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EOGDAPAQB20','50','H','01','50',NULL,'Dep 3 Gender',NULL,NULL,'"Dep 3 Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EOGDAPAQB20','50','H','01','51',NULL,'Dep 4 SSN',NULL,NULL,'"Dep 4 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EOGDAPAQB20','50','H','01','52',NULL,'Dep 4 Last Name',NULL,NULL,'"Dep 4 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EOGDAPAQB20','50','H','01','53',NULL,'Dep 4 First Name',NULL,NULL,'"Dep 4 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EOGDAPAQB20','50','H','01','54',NULL,'Dep 4 DOB',NULL,NULL,'"Dep 4 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EOGDAPAQB20','50','H','01','55',NULL,'Dep 4 Gender',NULL,NULL,'"Dep 4 Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EOGDAPAQB20','50','H','01','56',NULL,'Dep 5 SSN',NULL,NULL,'"Dep 5 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EOGDAPAQB20','50','H','01','57',NULL,'Dep 5 Last Name',NULL,NULL,'"Dep 5 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EOGDAPAQB20','50','H','01','58',NULL,'Dep 5 First Name',NULL,NULL,'"Dep 5 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EOGDAPAQB20','50','H','01','59',NULL,'Dep 5 DOB',NULL,NULL,'"Dep 5 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EOGDAPAQB20','50','H','01','60',NULL,'Dep 5 Gender',NULL,NULL,'"Dep 5 Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EOGDAPAQB20','50','H','01','61',NULL,'Dep 6 SSN',NULL,NULL,'"Dep 6 SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EOGDAPAQB20','50','H','01','62',NULL,'Dep 6 Last Name',NULL,NULL,'"Dep 6 Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EOGDAPAQB20','50','H','01','63',NULL,'Dep 6 First Name',NULL,NULL,'"Dep 6 First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EOGDAPAQB20','50','H','01','64',NULL,'Dep 6 DOB',NULL,NULL,'"Dep 6 DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EOGDAPAQB20','50','H','01','65',NULL,'Dep 6 Gender',NULL,NULL,'"Dep 6 Gender"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOGDAPAQB20','50','D','10','1',NULL,'Company Name',NULL,NULL,'"Ogden Clinic"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOGDAPAQB20','50','D','10','2',NULL,'Division Name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOGDAPAQB20','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvssn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOGDAPAQB20','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvnamelast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOGDAPAQB20','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvnamefirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOGDAPAQB20','50','D','10','6',NULL,'Middle Name',NULL,NULL,'"drvnamemiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOGDAPAQB20','50','D','10','7',NULL,'Email Address (Optional)',NULL,NULL,'"drvpersonalemail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOGDAPAQB20','50','D','10','8',NULL,'Gender',NULL,NULL,'"drvgender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOGDAPAQB20','50','D','10','9',NULL,'DOB',NULL,NULL,'"drvdateofbirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EOGDAPAQB20','50','D','10','10',NULL,'Address',NULL,NULL,'"drvaddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EOGDAPAQB20','50','D','10','11',NULL,'City',NULL,NULL,'"eepaddresscity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EOGDAPAQB20','50','D','10','12',NULL,'State',NULL,NULL,'"eepaddressstate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EOGDAPAQB20','50','D','10','13',NULL,'Zip',NULL,NULL,'"eepaddresszip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EOGDAPAQB20','50','D','10','14',NULL,'Date of Hire',NULL,NULL,'"drvdateoflasthire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EOGDAPAQB20','50','D','10','15',NULL,'Medical Plan',NULL,NULL,'"drvMedicalPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EOGDAPAQB20','50','D','10','16',NULL,'Medical Tier',NULL,NULL,'"drvMedicalTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EOGDAPAQB20','50','D','10','17',NULL,'Medical Effective Date',NULL,NULL,'"drvMedicalEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EOGDAPAQB20','50','D','10','18',NULL,'Dental Plan',NULL,NULL,'"drvDentalPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EOGDAPAQB20','50','D','10','19',NULL,'Dental Tier',NULL,NULL,'"drvDentalTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EOGDAPAQB20','50','D','10','20',NULL,'Dental Effective Date',NULL,NULL,'"drvDentalEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EOGDAPAQB20','50','D','10','21',NULL,'Vision Plan',NULL,NULL,'"drvVisionPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EOGDAPAQB20','50','D','10','22',NULL,'Vision Tier',NULL,NULL,'"drvVisionTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EOGDAPAQB20','50','D','10','23',NULL,'Vision Effective Date',NULL,NULL,'"drvVisionEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EOGDAPAQB20','50','D','10','24',NULL,'FSA Plan',NULL,NULL,'"drvFSAPlan"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EOGDAPAQB20','50','D','10','25',NULL,'FSA Tier',NULL,NULL,'"drvFSATier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EOGDAPAQB20','50','D','10','26',NULL,'FSA Effective Date',NULL,NULL,'"drvFSAEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EOGDAPAQB20','50','D','10','27',NULL,'Active or COBRA',NULL,NULL,'"COBRA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EOGDAPAQB20','50','D','10','28',NULL,'Type of Qualifying Event (Event Type i.e. Terminat',NULL,NULL,'"drvTypeofQualEvent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EOGDAPAQB20','50','D','10','29',NULL,'Date of Qualifying Event if on COBRA',NULL,NULL,'"drvDateofQualEvent"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EOGDAPAQB20','50','D','10','30',NULL,'Month of Last COBRA Payment Made',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EOGDAPAQB20','50','D','10','31',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EOGDAPAQB20','50','D','10','32',NULL,'Spouse Last Name',NULL,NULL,'"drvSpouseLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EOGDAPAQB20','50','D','10','33',NULL,'Spouse First Name',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EOGDAPAQB20','50','D','10','34',NULL,'Spouse DOB',NULL,NULL,'"drvSpouseDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EOGDAPAQB20','50','D','10','35',NULL,'Spouse Gender',NULL,NULL,'"drvSpouseGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EOGDAPAQB20','50','D','10','36',NULL,'Dep 1 SSN',NULL,NULL,'"drvDep1SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EOGDAPAQB20','50','D','10','37',NULL,'Dep 1 Last Name',NULL,NULL,'"drvDep1LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EOGDAPAQB20','50','D','10','38',NULL,'Dep 1 First Name',NULL,NULL,'"drvDep1FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EOGDAPAQB20','50','D','10','39',NULL,'Dep 1 DOB',NULL,NULL,'"drvDep1DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EOGDAPAQB20','50','D','10','40',NULL,'Dep 1 Gender',NULL,NULL,'"drvDep1Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EOGDAPAQB20','50','D','10','41',NULL,'Dep 2 SSN',NULL,NULL,'"drvDep2SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EOGDAPAQB20','50','D','10','42',NULL,'Dep 2 Last Name',NULL,NULL,'"drvDep2LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EOGDAPAQB20','50','D','10','43',NULL,'Dep 2 First Name',NULL,NULL,'"drvDep2FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EOGDAPAQB20','50','D','10','44',NULL,'Dep 2 DOB',NULL,NULL,'"drvDep2DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EOGDAPAQB20','50','D','10','45',NULL,'Dep 2 Gender',NULL,NULL,'"drvDep2Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EOGDAPAQB20','50','D','10','46',NULL,'Dep 3 SSN',NULL,NULL,'"drvDep3SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EOGDAPAQB20','50','D','10','47',NULL,'Dep 3 Last Name',NULL,NULL,'"drvDep3LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EOGDAPAQB20','50','D','10','48',NULL,'Dep 3 First Name',NULL,NULL,'"drvDep3FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EOGDAPAQB20','50','D','10','49',NULL,'Dep 3 DOB',NULL,NULL,'"drvDep3DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EOGDAPAQB20','50','D','10','50',NULL,'Dep 3 Gender',NULL,NULL,'"drvDep3Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EOGDAPAQB20','50','D','10','51',NULL,'Dep 4 SSN',NULL,NULL,'"drvDep4SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EOGDAPAQB20','50','D','10','52',NULL,'Dep 4 Last Name',NULL,NULL,'"drvDep4LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EOGDAPAQB20','50','D','10','53',NULL,'Dep 4 First Name',NULL,NULL,'"drvDep4FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EOGDAPAQB20','50','D','10','54',NULL,'Dep 4 DOB',NULL,NULL,'"drvDep4DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EOGDAPAQB20','50','D','10','55',NULL,'Dep 4 Gender',NULL,NULL,'"drvDep4Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EOGDAPAQB20','50','D','10','56',NULL,'Dep 5 SSN',NULL,NULL,'"drvDep5SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EOGDAPAQB20','50','D','10','57',NULL,'Dep 5 Last Name',NULL,NULL,'"drvDep5LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EOGDAPAQB20','50','D','10','58',NULL,'Dep 5 First Name',NULL,NULL,'"drvDep5FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EOGDAPAQB20','50','D','10','59',NULL,'Dep 5 DOB',NULL,NULL,'"drvDep5DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EOGDAPAQB20','50','D','10','60',NULL,'Dep 5 Gender',NULL,NULL,'"drvDep5Gender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EOGDAPAQB20','50','D','10','61',NULL,'Dep 6 SSN',NULL,NULL,'"drvDep6SSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EOGDAPAQB20','50','D','10','62',NULL,'Dep 6 Last Name',NULL,NULL,'"drvDep6LastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EOGDAPAQB20','50','D','10','63',NULL,'Dep 6 First Name',NULL,NULL,'"drvDep6FirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EOGDAPAQB20','50','D','10','64',NULL,'Dep 6 DOB',NULL,NULL,'"drvDep6DOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EOGDAPAQB20','50','D','10','65',NULL,'Dep 6 Gender',NULL,NULL,'"drvDep6Gender"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EOGDAPAQB2_20230926.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'APA Cobra QB-TEST','202306309','EMPEXPORT','ONDEM_XOE',NULL,'EOGDAPAQB2',NULL,NULL,NULL,'202306309','Apr  5 2023  8:01AM','Apr  5 2023  8:01AM','202001011',NULL,NULL,NULL,'202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'APA Cobra QB-TEST - Mon 5:10am','202306309','EMPEXPORT','SCH_EOGDA2',NULL,'EOGDAPAQB2',NULL,NULL,NULL,'202309259','Apr  5 2023  8:01AM','Apr  5 2023  8:01AM','202309181',NULL,NULL,NULL,'202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'APA Cobra QB-Test','202312259','EMPEXPORT','TEST_XOE',NULL,'EOGDAPAQB2',NULL,NULL,NULL,'202312259','Apr  5 2023  8:01AM','Apr  5 2023  8:01AM','202309181',NULL,NULL,NULL,'202309181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOGDAPAQB2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOGDAPAQB2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOGDAPAQB2','D10','dbo.U_EOGDAPAQB2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EOGDAPAQB2
-----------

IF OBJECT_ID('U_dsi_BDM_EOGDAPAQB2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOGDAPAQB2] (
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
-- Create table U_EOGDAPAQB2_Audit
-----------

IF OBJECT_ID('U_EOGDAPAQB2_Audit') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_Audit] (
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
-- Create table U_EOGDAPAQB2_AuditFields
-----------

IF OBJECT_ID('U_EOGDAPAQB2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EOGDAPAQB2_DedList
-----------

IF OBJECT_ID('U_EOGDAPAQB2_DedList') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EOGDAPAQB2_drvTbl
-----------

IF OBJECT_ID('U_EOGDAPAQB2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(11) NULL,
    [drvssn] char(11) NULL,
    [drvnamelast] varchar(100) NULL,
    [drvnamefirst] varchar(100) NULL,
    [drvnamemiddle] varchar(1) NULL,
    [drvpersonalemail] varchar(50) NULL,
    [drvgender] char(1) NULL,
    [drvdateofbirth] datetime NULL,
    [drvaddress] varchar(6000) NULL,
    [eepaddresscity] varchar(255) NULL,
    [eepaddressstate] varchar(255) NULL,
    [eepaddresszip] varchar(50) NULL,
    [drvdateoflasthire] datetime NULL,
    [drvMedicalPlan] varchar(40) NULL,
    [drvMedicalTier] char(6) NULL,
    [drvMedicalEffDate] datetime NULL,
    [drvDentalPlan] varchar(40) NULL,
    [drvDentalTier] char(6) NULL,
    [drvDentalEffDate] datetime NULL,
    [drvVisionPlan] varchar(40) NULL,
    [drvVisionTier] char(6) NULL,
    [drvVisionEffDate] datetime NULL,
    [drvFSAPlan] varchar(40) NULL,
    [drvFSATier] varchar(1) NOT NULL,
    [drvFSAEffDate] datetime NULL,
    [drvTypeofQualEvent] varchar(25) NULL,
    [drvDateofQualEvent] datetime NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseLastName] varchar(100) NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvSpouseGender] char(1) NULL,
    [drvDep1SSN] char(11) NULL,
    [drvDep1LastName] varchar(100) NULL,
    [drvDep1FirstName] varchar(100) NULL,
    [drvDep1DOB] datetime NULL,
    [drvDep1Gender] char(1) NULL,
    [drvDep2SSN] char(11) NULL,
    [drvDep2LastName] varchar(100) NULL,
    [drvDep2FirstName] varchar(100) NULL,
    [drvDep2DOB] datetime NULL,
    [drvDep2Gender] char(1) NULL,
    [drvDep3SSN] char(11) NULL,
    [drvDep3LastName] varchar(100) NULL,
    [drvDep3FirstName] varchar(100) NULL,
    [drvDep3DOB] datetime NULL,
    [drvDep3Gender] char(1) NULL,
    [drvDep4SSN] char(11) NULL,
    [drvDep4LastName] varchar(100) NULL,
    [drvDep4FirstName] varchar(100) NULL,
    [drvDep4DOB] datetime NULL,
    [drvDep4Gender] char(1) NULL,
    [drvDep5SSN] char(11) NULL,
    [drvDep5LastName] varchar(100) NULL,
    [drvDep5FirstName] varchar(100) NULL,
    [drvDep5DOB] datetime NULL,
    [drvDep5Gender] char(1) NULL,
    [drvDep6SSN] char(11) NULL,
    [drvDep6LastName] varchar(100) NULL,
    [drvDep6FirstName] varchar(100) NULL,
    [drvDep6DOB] datetime NULL,
    [drvDep6Gender] char(1) NULL
);

-----------
-- Create table U_EOGDAPAQB2_EEList
-----------

IF OBJECT_ID('U_EOGDAPAQB2_EEList') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EOGDAPAQB2_File
-----------

IF OBJECT_ID('U_EOGDAPAQB2_File') IS NULL
CREATE TABLE [dbo].[U_EOGDAPAQB2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOGDAPAQB2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ogden Clinic Professional Corp

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 04/05/2023
Service Request Number: TekP-2023-02-22-02 

Purpose: APA Cobra QB TEST

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX
Marie Waters        09/26/2023     TekP-2023-09-06-03 Update dedcodes M07,M08 to M09,M10

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOGDAPAQB2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOGDAPAQB2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOGDAPAQB2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOGDAPAQB2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOGDAPAQB2' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202306309'
       ,expEndPerControl       = '202306309'
WHERE expFormatCode = 'EOGDAPAQB2';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOGDAPAQB2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOGDAPAQB2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOGDAPAQB2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOGDAPAQB2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOGDAPAQB2', 'SCH_EOGDA2';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOGDAPAQB2';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EOGDAPAQB2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOGDAPAQB2';

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
    DELETE FROM dbo.U_EOGDAPAQB2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOGDAPAQB2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EOGDAPAQB2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EOGDAPAQB2_AuditFields;
    CREATE TABLE dbo.U_EOGDAPAQB2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EOGDAPAQB2_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EOGDAPAQB2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EOGDAPAQB2_Audit;
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
    INTO dbo.U_EOGDAPAQB2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EOGDAPAQB2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EOGDAPAQB2_Audit ON dbo.U_EOGDAPAQB2_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'D01,D02,F01,F03,M09,M10,OP1'; --MW removed M07,M08 to be M09,M10

    IF OBJECT_ID('U_EOGDAPAQB2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOGDAPAQB2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOGDAPAQB2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','D01,D02,F01,F03,M09,M10,OP1'); -- MW updated to use DedList vs 'D01,D02,F01,F03,M07,M08,OP1'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #3.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, FIA, SOT');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DIS, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

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

    ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 --   --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EOGDAPAQB2]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
      Select distinct
        'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,'EEC'
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EOGDAPAQB2'
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate;

    --==========================================
    -- Use effective date
    --==========================================

    UPDATE dbo.U_dsi_bdm_EOGDAPAQB2
        SET BdmUSGDate1 = edheffdate
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EmpDeductions 
            ON Eedeeid = edheeid 
            AND  Eedeeid ='DSH7LA011RX0'
            AND EedCoID = EdhCoID
            AND EedDedCode = EdhDedCode
            AND EedBenOption = EdhBenOption
            AND Eedformatcode = 'EOGDAPAQB2'
        AND edhChangeReason = EedChangeREason
        AND EedBenStopDate BETWEEN @StartDate AND @EndDate
        AND EedValidForExport = 'Y'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOGDAPAQB2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOGDAPAQB2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOGDAPAQB2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvssn = eepSSN
        ,drvnamelast = EepNameLast
        ,drvnamefirst = EepNameFirst
        ,drvnamemiddle = LEFT(EepNameMiddle,1)
        ,drvpersonalemail = EepAddressEMail
        ,drvgender = EepGender
        ,drvdateofbirth = EepDateOfBirth
        ,drvaddress = CASE WHEN eepaddressline2 is not null THEN dbo.dsi_fnRemoveChars('.,/-',eepaddressline1 +' '+ eepaddressline2) ELSE dbo.dsi_fnRemoveChars('.,/-',eepaddressline1) END
        ,eepaddresscity = EepAddressCity
        ,eepaddressstate = EepAddressState
        ,eepaddresszip = eepaddresszipCode
        ,drvdateoflasthire = EecDateOfLastHire
        ,drvMedicalPlan = CASE WHEN DedCode_M in ( 'Y') THEN  Desc_M ENd
        ,drvMedicalTier = CASE WHEN DedCode_M in ( 'Y') THEN Option_M ENd
        ,drvMedicalEffDate = CASE WHEN DedCode_M in ( 'Y') THEN StatusDate_M ENd
        ,drvDentalPlan = CASE WHEN DedCode_D in ( 'Y') THEN Desc_D ENd
        ,drvDentalTier = CASE WHEN DedCode_D in ( 'Y') THEN Option_D ENd
        ,drvDentalEffDate = CASE WHEN DedCode_D in ( 'Y') THEN StatusDate_D ENd
        ,drvVisionPlan = CASE WHEN DedCode_O in ( 'Y') THEN Desc_O ENd
        ,drvVisionTier = CASE WHEN DedCode_O in ( 'Y') THEN Option_O ENd
        ,drvVisionEffDate = CASE WHEN DedCode_O in ( 'Y') THEN StatusDate_O ENd
        ,drvFSAPlan = CASE WHEN DedCode_F = 'Y' THEN Desc_F ENd
        ,drvFSATier = ''
        ,drvFSAEffDate = CASE WHEN  DedCode_F = 'Y' THEN StatusDate_F ENd
        ,drvTypeofQualEvent = BchDesc
        ,drvDateofQualEvent = BdmUSGDate1
        ,drvSpouseSSN =  Spouse.ConSSN
        ,drvSpouseLastName = Spouse.ConNameLast
        ,drvSpouseFirstName = Spouse.ConNameFirst
        ,drvSpouseDOB = Spouse.ConDateOfBirth
        ,drvSpouseGender = Spouse.ConGender
        ,drvDep1SSN = Child1.ConSSN 
        ,drvDep1LastName = Child1.ConNameLast
        ,drvDep1FirstName = Child1.ConNameFirst
        ,drvDep1DOB = Child1.ConDateOfBirth 
        ,drvDep1Gender = Child1.ConGender
        ,drvDep2SSN = Child2.ConSSN
        ,drvDep2LastName = Child2.ConNameLast
        ,drvDep2FirstName = Child2.ConNameFirst
        ,drvDep2DOB = Child2.ConDateOfBirth 
        ,drvDep2Gender = Child2.ConGender 
        ,drvDep3SSN = Child3.ConSSN 
        ,drvDep3LastName = Child3.ConNameLast 
        ,drvDep3FirstName = Child3.ConNameFirst 
        ,drvDep3DOB = Child3.ConDateOfBirth 
        ,drvDep3Gender = Child3.ConGender 
        ,drvDep4SSN = Child4.ConSSN
        ,drvDep4LastName = Child4.ConNameLast
        ,drvDep4FirstName = Child4.ConNameFirst
        ,drvDep4DOB = Child4.ConDateOfBirth
        ,drvDep4Gender = Child4.ConGender
        ,drvDep5SSN =  Child5.ConSSN 
        ,drvDep5LastName = Child5.ConNameLast
        ,drvDep5FirstName = Child5.ConNameFirst
        ,drvDep5DOB = Child5.ConDateOfBirth 
        ,drvDep5Gender = Child5.ConGender 
        ,drvDep6SSN = Child6.ConSSN 
        ,drvDep6LastName = Child6.ConNameLast
        ,drvDep6FirstName = Child6.ConNameFirst 
        ,drvDep6DOB = Child6.ConDateOfBirth
        ,drvDep6Gender = Child6.ConGender 
    INTO dbo.U_EOGDAPAQB2_drvTbl
    FROM dbo.U_EOGDAPAQB2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmRunId,BchDesc
                ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
                ,MAX(BdmUSGDate1) as BdmUSGDate1
                ,MAX(CASE WHEN BdmDedCode in ('F01','F03')  THEN 'Y' END) AS DedCode_F
                ,MAX(CASE WHEN BdmDedCode in ('F01','F03')  THEN BdmBenStatusDate END) AS StatusDate_F
                ,MAX(CASE WHEN BdmDedCode in ('F01','F03')  THEN DedLongDesc END) AS Desc_F
                ,MAX(CASE WHEN BdmDedCode in ('OP1') THEN 'Y' END) AS DedCode_O
                ,MAX(CASE WHEN BdmDedCode in ('OP1') THEN BdmBenStatusDate END) AS StatusDate_O
                ,MAX(CASE WHEN BdmDedCode in ('OP1') THEN BdmBenOption END) AS Option_O
                ,MAX(CASE WHEN BdmDedCode in ('OP1')   THEN DedLongDesc END) AS Desc_O
                ,MAX(CASE WHEN BdmDedCode in ('D01','D02') THEN 'Y' END) AS DedCode_D
                ,MAX(CASE WHEN BdmDedCode in ('D01','D02') THEN BdmBenStatusDate END) AS StatusDate_D
                ,MAX(CASE WHEN BdmDedCode in ('D01','D02') THEN BdmBenOption END) AS Option_D
                ,MAX(CASE WHEN BdmDedCode in ('D01','D02') THEN DedLongDesc END) AS Desc_D
                ,MAX(CASE WHEN BdmDedCode in ('M09','M10') THEN 'Y' END) AS DedCode_M --MW removed M07,M08 to be M09,M10
                ,MAX(CASE WHEN BdmDedCode in ('M09','M10') THEN BdmBenStatusDate END) AS StatusDate_M --MW removed M07,M08 to be M09,M10
                ,MAX(CASE WHEN BdmDedCode in ('M09','M10') THEN BdmBenOption END) AS Option_M --MW removed M07,M08 to be M09,M10
                ,MAX(CASE WHEN BdmDedCode in ('M09','M10') THEN DedLongDesc END) AS Desc_M --MW removed M07,M08 to be M09,M10
            FROM dbo.U_dsi_BDM_EOGDAPAQB2 WITH (NOLOCK)
            LEFT JOIN dbo.DedCode WITH (NOLOCK)
                On DedDedCode = BdmDedCode 
            JOIN dbo.benchrsn WITH (NOLOCK)
                ON BchCode = BdmCobraReason
                AND BchIsCOBRAQualifiedEvent = 'Y'
                Where BdmIsCobraCovered = 'Y'
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmRunId,BchDesc
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'EMP'
   LEFT JOIN (
                 SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, '02' AS RN 
                 FROM dbo.Contacts WITH (NOLOCK) 
                 JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMS WITH (NOLOCK)
                 ON ConSystemID = BDMS.BdmDepRecID
                 AND BdmRecType = 'DEP'
                 AND BdmDedCode in ('D01','D02','M09','M10','OP1') --MW removed M07,M08 to be M09,M10
                 WHERE ConRelationship IN     ('FIA','SPS','SOT') 
                    ) AS Spouse
                    ON Spouse.ConEEID = BdmEEID
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN1
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child1
                    ON Child1.ConEEID = BdmEEID
                     AND RN1 = '03'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN2
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child2
                    ON Child2.ConEEID = BdmEEID
                     AND RN2 = '04'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN3
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child3
                    ON Child3.ConEEID = BdmEEID
                     AND RN3 = '05'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN4
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child4
                    ON Child4.ConEEID = BdmEEID
                     AND RN4 = '06'
    LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN5
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child5
                    ON Child5.ConEEID = BdmEEID
                     AND RN5 = '07'
        LEFT JOIN (             
                SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN, 
                 FORMAT(ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC)+2, '00') AS RN6
                 FROM ( SELECT DISTINCT ConEEID, ConSystemID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConSSN 
                        FROM dbo.Contacts WITH (NOLOCK) 
                        JOIN dbo.U_dsi_BDM_EOGDAPAQB2 BDMC WITH (NOLOCK)
                        ON ConSystemID = BDMC.BdmDepRecID
                        WHERE ConRelationship IN ('CHL','DIS','STC') 
                        ) AS CHILD
                    ) AS Child6
                    ON Child6.ConEEID = BdmEEID
                     AND RN6 = '08';


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEOGDAPAQB2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOGDAPAQB2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EOGDAPAQB2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202309181'
       ,expStartPerControl     = '202309181'
       ,expLastEndPerControl   = '202309259'
       ,expEndPerControl       = '202309259'
WHERE expFormatCode = 'EOGDAPAQB2' and expexportcode ='Test_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOGDAPAQB2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOGDAPAQB2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EOGDAPAQB2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EOGDAPAQB2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EOGDAPAQB2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOGDAPAQB2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EOGDAPAQB2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOGDAPAQB2', 'UseFileName', 'V', 'Y'


-- End ripout