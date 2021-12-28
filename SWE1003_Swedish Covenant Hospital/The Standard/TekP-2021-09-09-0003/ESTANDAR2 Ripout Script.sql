/**********************************************************************************

ESTANDAR2: The Standard Export V2

FormatCode:     ESTANDAR2
Project:        The Standard Export V2
Client ID:      SWE1003
Date/time:      2021-12-27 12:40:41.437
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    EZ17
Server:         EZ1SUP7DB04
Database:       ULTIPRO_SCHMC
ExportPath:    \\us.saas\ez\Public\SWE1003\Exports_Test
TestPath:      \\us.saas\ez\Public\SWE1003\Exports_TestStandard\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESTANDAR2_SavePath') IS NOT NULL DROP TABLE dbo.U_ESTANDAR2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESTANDAR2'


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
WHERE FormatCode = 'ESTANDAR2'
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
WHERE ExpFormatCode = 'ESTANDAR2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESTANDAR2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESTANDAR2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESTANDAR2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESTANDAR2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESTANDAR2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESTANDAR2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESTANDAR2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESTANDAR2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESTANDAR2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESTANDAR2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESTANDAR2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTANDAR2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTANDAR2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDAR2];
GO
IF OBJECT_ID('U_ESTANDAR2_File') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_File];
GO
IF OBJECT_ID('U_ESTANDAR2_EmpAge') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_EmpAge];
GO
IF OBJECT_ID('U_ESTANDAR2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_EEList];
GO
IF OBJECT_ID('U_ESTANDAR2_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_DedList];
GO
IF OBJECT_ID('U_ESTANDAR2_D10') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_D10];
GO
IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_AuditFields];
GO
IF OBJECT_ID('U_ESTANDAR2_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTANDAR2','The Standard Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','ESTANDAR20Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTANDAR20Z0','20','H','01','1',NULL,'Organization ID Code',NULL,NULL,'"Organization ID Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTANDAR20Z0','12','H','01','2',NULL,'Sub Org Text',NULL,NULL,'"Sub Org Text"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTANDAR20Z0','22','H','01','3',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTANDAR20Z0','11','H','01','4',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTANDAR20Z0','11','H','01','5',NULL,'Name Prefix',NULL,NULL,'"Name Prefix"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTANDAR20Z0','10','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTANDAR20Z0','11','H','01','7',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTANDAR20Z0','9','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTANDAR20Z0','11','H','01','9',NULL,'Name Suffix',NULL,NULL,'"Name Suffix"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTANDAR20Z0','13','H','01','10',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTANDAR20Z0','13','H','01','11',NULL,'Date of Death',NULL,NULL,'"Date of Death"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTANDAR20Z0','6','H','01','12',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTANDAR20Z0','14','H','01','13',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTANDAR20Z0','14','H','01','14',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTANDAR20Z0','14','H','01','15',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTANDAR20Z0','14','H','01','16',NULL,'Address Line 3',NULL,NULL,'"Address Line 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTANDAR20Z0','4','H','01','17',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTANDAR20Z0','14','H','01','18',NULL,'State/Province',NULL,NULL,'"State/Province"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTANDAR20Z0','11','H','01','19',NULL,'Postal Code',NULL,NULL,'"Postal Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTANDAR20Z0','7','H','01','20',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTANDAR20Z0','14','H','01','21',NULL,'Non-Work Phone',NULL,NULL,'"Non-Work Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTANDAR20Z0','17','H','01','22',NULL,'Current Hire Date',NULL,NULL,'"Current Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTANDAR20Z0','18','H','01','23',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTANDAR20Z0','18','H','01','24',NULL,'Adjusted Hire Date',NULL,NULL,'"Adjusted Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTANDAR20Z0','27','H','01','25',NULL,'Employment Termination Date',NULL,NULL,'"Employment Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTANDAR20Z0','10','H','01','26',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTANDAR20Z0','9','H','01','27',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTANDAR20Z0','17','H','01','28',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTANDAR20Z0','20','H','01','29',NULL,'Scheduled Work Hours',NULL,NULL,'"Scheduled Work Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTANDAR20Z0','30','H','01','30',NULL,'Scheduled Work Hours Frequency',NULL,NULL,'"Scheduled Work Hours Frequency"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTANDAR20Z0','17','H','01','31',NULL,'Employee Pay Type',NULL,NULL,'"Employee Pay Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTANDAR20Z0','14','H','01','32',NULL,'Full/Part Time',NULL,NULL,'"Full/Part Time"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTANDAR20Z0','15','H','01','33',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTANDAR20Z0','18','H','01','34',NULL,'Work Email Address',NULL,NULL,'"Work Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTANDAR20Z0','13','H','01','35',NULL,'Exempt Status',NULL,NULL,'"Exempt Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTANDAR20Z0','10','H','01','36',NULL,'Union Flag',NULL,NULL,'"Union Flag"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTANDAR20Z0','10','H','01','37',NULL,'Union Name',NULL,NULL,'"Union Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTANDAR20Z0','18','H','01','38',NULL,'Employer Affiliate',NULL,NULL,'"Employer Affiliate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTANDAR20Z0','22','H','01','39',NULL,'Employer Location Code',NULL,NULL,'"Employer Location Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTANDAR20Z0','22','H','01','40',NULL,'Employer Location Name',NULL,NULL,'"Employer Location Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTANDAR20Z0','15','H','01','41',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTANDAR20Z0','15','H','01','42',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTANDAR20Z0','15','H','01','43',NULL,'Occupation code',NULL,NULL,'"Occupation code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTANDAR20Z0','15','H','01','44',NULL,'User Specific 1',NULL,NULL,'"User Specific 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTANDAR20Z0','15','H','01','45',NULL,'User Specific 2',NULL,NULL,'"User Specific 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTANDAR20Z0','15','H','01','46',NULL,'User Specific 3',NULL,NULL,'"User Specific 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTANDAR20Z0','15','H','01','47',NULL,'User Specific 4',NULL,NULL,'"User Specific 4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTANDAR20Z0','15','H','01','48',NULL,'User Specific 5',NULL,NULL,'"User Specific 5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTANDAR20Z0','18','H','01','49',NULL,'Earning Category 1',NULL,NULL,'"Earning Category 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTANDAR20Z0','15','H','01','50',NULL,'Earnings Type 1',NULL,NULL,'"Earnings Type 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESTANDAR20Z0','17','H','01','51',NULL,'Earnings Amount 1',NULL,NULL,'"Earnings Amount 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESTANDAR20Z0','28','H','01','52',NULL,'Earnings Amount Expression 1',NULL,NULL,'"Earnings Amount Expression 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESTANDAR20Z0','48','H','01','53',NULL,'Earnings Effective Date 1 OR Earnings Pay Date 1',NULL,NULL,'"Earnings Effective Date 1 OR Earnings Pay Date 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESTANDAR20Z0','19','H','01','54',NULL,'Payroll Frequency 1',NULL,NULL,'"Payroll Frequency 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESTANDAR20Z0','16','H','01','55',NULL,'Pay Start Date 1',NULL,NULL,'"Pay Start Date 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESTANDAR20Z0','14','H','01','56',NULL,'Pay End Date 1',NULL,NULL,'"Pay End Date 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESTANDAR20Z0','18','H','01','57',NULL,'Pay Period Hours 1',NULL,NULL,'"Pay Period Hours 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESTANDAR20Z0','18','H','01','58',NULL,'Earning Category 2',NULL,NULL,'"Earning Category 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESTANDAR20Z0','15','H','01','59',NULL,'Earnings Type 2',NULL,NULL,'"Earnings Type 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESTANDAR20Z0','17','H','01','60',NULL,'Earnings Amount 2',NULL,NULL,'"Earnings Amount 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESTANDAR20Z0','28','H','01','61',NULL,'Earnings Amount Expression 2',NULL,NULL,'"Earnings Amount Expression 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESTANDAR20Z0','25','H','01','62',NULL,'Earnings Effective Date 2',NULL,NULL,'"Earnings Effective Date 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESTANDAR20Z0','19','H','01','63',NULL,'Payroll Frequency 2',NULL,NULL,'"Payroll Frequency 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESTANDAR20Z0','16','H','01','64',NULL,'Pay Start Date 2',NULL,NULL,'"Pay Start Date 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESTANDAR20Z0','14','H','01','65',NULL,'Pay End Date 2',NULL,NULL,'"Pay End Date 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESTANDAR20Z0','18','H','01','66',NULL,'Pay Period Hours 2',NULL,NULL,'"Pay Period Hours 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESTANDAR20Z0','18','H','01','67',NULL,'Earning Category 3',NULL,NULL,'"Earning Category 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESTANDAR20Z0','15','H','01','68',NULL,'Earnings Type 3',NULL,NULL,'"Earnings Type 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESTANDAR20Z0','17','H','01','69',NULL,'Earnings Amount 3',NULL,NULL,'"Earnings Amount 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESTANDAR20Z0','28','H','01','70',NULL,'Earnings Amount Expression 3',NULL,NULL,'"Earnings Amount Expression 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESTANDAR20Z0','25','H','01','71',NULL,'Earnings Effective Date 3',NULL,NULL,'"Earnings Effective Date 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESTANDAR20Z0','19','H','01','72',NULL,'Payroll Frequency 3',NULL,NULL,'"Payroll Frequency 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESTANDAR20Z0','16','H','01','73',NULL,'Pay Start Date 3',NULL,NULL,'"Pay Start Date 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESTANDAR20Z0','14','H','01','74',NULL,'Pay End Date 3',NULL,NULL,'"Pay End Date 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESTANDAR20Z0','18','H','01','75',NULL,'Pay Period Hours 3',NULL,NULL,'"Pay Period Hours 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESTANDAR20Z0','34','H','01','76',NULL,'Hours Worked in the Last 12 months',NULL,NULL,'"Hours Worked in the Last 12 months"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESTANDAR20Z0','45','H','01','77',NULL,'Hours Worked in the Last 12 Months THRU DATE',NULL,NULL,'"Hours Worked in the Last 12 Months THRU DATE "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESTANDAR20Z0','30','H','01','78',NULL,'Supervisor/Manager Employee ID',NULL,NULL,'"Supervisor/Manager Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESTANDAR20Z0','16','H','01','79',NULL,'Future use field',NULL,NULL,'"Future use field"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESTANDAR20Z0','21','H','01','80',NULL,'AMS Reporting Group 1',NULL,NULL,'"AMS Reporting Group 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESTANDAR20Z0','21','H','01','81',NULL,'AMS Reporting Group 2',NULL,NULL,'"AMS Reporting Group 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESTANDAR20Z0','21','H','01','82',NULL,'AMS Reporting Group 3',NULL,NULL,'"AMS Reporting Group 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESTANDAR20Z0','21','H','01','83',NULL,'AMS Reporting Group 4',NULL,NULL,'"AMS Reporting Group 4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESTANDAR20Z0','21','H','01','84',NULL,'AMS Reporting Group 5',NULL,NULL,'"AMS Reporting Group 5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ESTANDAR20Z0','21','H','01','85',NULL,'AMS Reporting Group 6',NULL,NULL,'"AMS Reporting Group 6"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ESTANDAR20Z0','21','H','01','86',NULL,'AMS Reporting Group 7',NULL,NULL,'"AMS Reporting Group 7"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ESTANDAR20Z0','21','H','01','87',NULL,'AMS Reporting Group 8',NULL,NULL,'"AMS Reporting Group 8"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ESTANDAR20Z0','21','H','01','88',NULL,'AMS Reporting Group 9',NULL,NULL,'"AMS Reporting Group 9"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ESTANDAR20Z0','20','H','01','89',NULL,'HR Contact Recipient',NULL,NULL,'"HR Contact Recipient"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ESTANDAR20Z0','24','H','01','90',NULL,'HR Contact Email Address',NULL,NULL,'"HR Contact Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ESTANDAR20Z0','21','H','01','91',NULL,'HR Contact Work Phone',NULL,NULL,'"HR Contact Work Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ESTANDAR20Z0','20','H','01','92',NULL,'Reporting Category 1',NULL,NULL,'"Reporting Category 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ESTANDAR20Z0','20','H','01','93',NULL,'Reporting Category 2',NULL,NULL,'"Reporting Category 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ESTANDAR20Z0','20','H','01','94',NULL,'Reporting Category 3',NULL,NULL,'"Reporting Category 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ESTANDAR20Z0','20','H','01','95',NULL,'Reporting Category 4',NULL,NULL,'"Reporting Category 4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ESTANDAR20Z0','20','H','01','96',NULL,'Reporting Category 5',NULL,NULL,'"Reporting Category 5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ESTANDAR20Z0','6','H','01','97',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ESTANDAR20Z0','4','H','01','98',NULL,'Plan',NULL,NULL,'"Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ESTANDAR20Z0','7','H','01','99',NULL,'Product',NULL,NULL,'"Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ESTANDAR20Z0','18','H','01','100',NULL,'Employer Plan Code',NULL,NULL,'"Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ESTANDAR20Z0','22','H','01','101',NULL,'Benefit Waiting Period',NULL,NULL,'"Benefit Waiting Period"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ESTANDAR20Z0','15','H','01','102',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ESTANDAR20Z0','15','H','01','103',NULL,'Selected Amount',NULL,NULL,'"Selected Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ESTANDAR20Z0','8','H','01','104',NULL,'Am Class',NULL,NULL,'"Am Class"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ESTANDAR20Z0','10','H','01','105',NULL,'Class Name',NULL,NULL,'"Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ESTANDAR20Z0','14','H','01','106',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ESTANDAR20Z0','16','H','01','107',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ESTANDAR20Z0','6','H','01','108',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ESTANDAR20Z0','4','H','01','109',NULL,'Plan',NULL,NULL,'"Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ESTANDAR20Z0','7','H','01','110',NULL,'Product',NULL,NULL,'"Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ESTANDAR20Z0','18','H','01','111',NULL,'Employer Plan Code',NULL,NULL,'"Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ESTANDAR20Z0','22','H','01','112',NULL,'Benefit Waiting Period',NULL,NULL,'"Benefit Waiting Period"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ESTANDAR20Z0','15','H','01','113',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ESTANDAR20Z0','15','H','01','114',NULL,'Selected Amount',NULL,NULL,'"Selected Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ESTANDAR20Z0','8','H','01','115',NULL,'Am Class',NULL,NULL,'"Am Class"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ESTANDAR20Z0','10','H','01','116',NULL,'Class Name',NULL,NULL,'"Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ESTANDAR20Z0','14','H','01','117',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ESTANDAR20Z0','16','H','01','118',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ESTANDAR20Z0','6','H','01','119',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ESTANDAR20Z0','4','H','01','120',NULL,'Plan',NULL,NULL,'"Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ESTANDAR20Z0','7','H','01','121',NULL,'Product',NULL,NULL,'"Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ESTANDAR20Z0','18','H','01','122',NULL,'Employer Plan Code',NULL,NULL,'"Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ESTANDAR20Z0','22','H','01','123',NULL,'Benefit Waiting Period',NULL,NULL,'"Benefit Waiting Period"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ESTANDAR20Z0','15','H','01','124',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ESTANDAR20Z0','15','H','01','125',NULL,'Selected Amount',NULL,NULL,'"Selected Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ESTANDAR20Z0','10','H','01','126',NULL,'Class Name',NULL,NULL,'"Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ESTANDAR20Z0','14','H','01','127',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ESTANDAR20Z0','16','H','01','128',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ESTANDAR20Z0','6','H','01','129',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ESTANDAR20Z0','4','H','01','130',NULL,'Plan',NULL,NULL,'"Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ESTANDAR20Z0','7','H','01','131',NULL,'Product',NULL,NULL,'"Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ESTANDAR20Z0','18','H','01','132',NULL,'Employer Plan Code',NULL,NULL,'"Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ESTANDAR20Z0','22','H','01','133',NULL,'Benefit Waiting Period',NULL,NULL,'"Benefit Waiting Period"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ESTANDAR20Z0','15','H','01','134',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ESTANDAR20Z0','15','H','01','135',NULL,'Selected Amount',NULL,NULL,'"Selected Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ESTANDAR20Z0','10','H','01','136',NULL,'Class Name',NULL,NULL,'"Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ESTANDAR20Z0','14','H','01','137',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ESTANDAR20Z0','16','H','01','138',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ESTANDAR20Z0','12','H','01','139',NULL,'OTHER Policy',NULL,NULL,'"OTHER Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ESTANDAR20Z0','10','H','01','140',NULL,'OTHER Plan',NULL,NULL,'"OTHER Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ESTANDAR20Z0','13','H','01','141',NULL,'OTHER Product',NULL,NULL,'"OTHER Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ESTANDAR20Z0','24','H','01','142',NULL,'OTHER Employer Plan Code',NULL,NULL,'"OTHER Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ESTANDAR20Z0','28','H','01','143',NULL,'OTHER Benefit Waiting Period',NULL,NULL,'"OTHER Benefit Waiting Period"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ESTANDAR20Z0','21','H','01','144',NULL,'OTHER Benefit Percent',NULL,NULL,'"OTHER Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ESTANDAR20Z0','21','H','01','145',NULL,'OTHER Selected Amount',NULL,NULL,'"OTHER Selected Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ESTANDAR20Z0','14','H','01','146',NULL,'OTHER AM Class',NULL,NULL,'"OTHER AM Class"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ESTANDAR20Z0','16','H','01','147',NULL,'OTHER Class Name',NULL,NULL,'"OTHER Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ESTANDAR20Z0','20','H','01','148',NULL,'OTHER Effective Date',NULL,NULL,'"OTHER Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ESTANDAR20Z0','22','H','01','149',NULL,'OTHER Termination Date',NULL,NULL,'"OTHER Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ESTANDAR20Z0','13','H','01','150',NULL,'NJ TDB Policy',NULL,NULL,'"NJ TDB Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ESTANDAR20Z0','11','H','01','151',NULL,'NJ TDB Plan',NULL,NULL,'"NJ TDB Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ESTANDAR20Z0','25','H','01','152',NULL,'NJ TDB Employer Plan Code',NULL,NULL,'"NJ TDB Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ESTANDAR20Z0','24','H','01','153',NULL,'NJ TDB Policy Begin Date',NULL,NULL,'"NJ TDB Policy Begin Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ESTANDAR20Z0','13','H','01','154',NULL,'NY DBL Policy',NULL,NULL,'"NY DBL Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ESTANDAR20Z0','11','H','01','155',NULL,'NY DBL Plan',NULL,NULL,'"NY DBL Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ESTANDAR20Z0','25','H','01','156',NULL,'NY DBL Employer Plan Code',NULL,NULL,'"NY DBL Employer Plan Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ESTANDAR20Z0','24','H','01','157',NULL,'NY DBL Policy Begin Date',NULL,NULL,'"NY DBL Policy Begin Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ESTANDAR20Z0','17','H','01','158',NULL,'Basic Life Policy',NULL,NULL,'"Basic Life Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ESTANDAR20Z0','15','H','01','159',NULL,'Basic Life Plan',NULL,NULL,'"Basic Life Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ESTANDAR20Z0','18','H','01','160',NULL,'Basic Life Product',NULL,NULL,'"Basic Life Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ESTANDAR20Z0','17','H','01','161',NULL,'Basic Life Amount',NULL,NULL,'"Basic Life Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ESTANDAR20Z0','21','H','01','162',NULL,'Basic Life Class Name',NULL,NULL,'"Basic Life Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ESTANDAR20Z0','24','H','01','163',NULL,'Basic Life User Specific',NULL,NULL,'"Basic Life User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ESTANDAR20Z0','25','H','01','164',NULL,'Basic Life Effective Date',NULL,NULL,'"Basic Life Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ESTANDAR20Z0','27','H','01','165',NULL,'Basic Life Termination Date',NULL,NULL,'"Basic Life Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ESTANDAR20Z0','17','H','01','166',NULL,'Basic AD&D Policy',NULL,NULL,'"Basic AD&D Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ESTANDAR20Z0','15','H','01','167',NULL,'Basic AD&D Plan',NULL,NULL,'"Basic AD&D Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ESTANDAR20Z0','18','H','01','168',NULL,'Basic AD&D Product',NULL,NULL,'"Basic AD&D Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','ESTANDAR20Z0','17','H','01','169',NULL,'Basic AD&D Amount',NULL,NULL,'"Basic AD&D Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','ESTANDAR20Z0','24','H','01','170',NULL,'Basic AD&D User Specific',NULL,NULL,'"Basic AD&D User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','ESTANDAR20Z0','25','H','01','171',NULL,'Basic AD&D Effective Date',NULL,NULL,'"Basic AD&D Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','ESTANDAR20Z0','27','H','01','172',NULL,'Basic AD&D Termination Date',NULL,NULL,'"Basic AD&D Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','ESTANDAR20Z0','22','H','01','173',NULL,'Additional Life Policy',NULL,NULL,'"Additional Life Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','ESTANDAR20Z0','20','H','01','174',NULL,'Additional Life Plan',NULL,NULL,'"Additional Life Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','ESTANDAR20Z0','23','H','01','175',NULL,'Additional Life Product',NULL,NULL,'"Additional Life Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','ESTANDAR20Z0','22','H','01','176',NULL,'Additional Life Amount',NULL,NULL,'"Additional Life Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','ESTANDAR20Z0','35','H','01','177',NULL,'Additional Life Earnings Multiplier',NULL,NULL,'"Additional Life Earnings Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','ESTANDAR20Z0','28','H','01','178',NULL,'Additional Life Tobacco User',NULL,NULL,'"Additional Life Tobacco User"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','ESTANDAR20Z0','29','H','01','179',NULL,'Additional Life User Specific',NULL,NULL,'"Additional Life User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','ESTANDAR20Z0','30','H','01','180',NULL,'Additional Life Effective Date',NULL,NULL,'"Additional Life Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','ESTANDAR20Z0','32','H','01','181',NULL,'Additional Life Termination Date',NULL,NULL,'"Additional Life Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','ESTANDAR20Z0','22','H','01','182',NULL,'Additional AD&D Policy',NULL,NULL,'"Additional AD&D Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','ESTANDAR20Z0','20','H','01','183',NULL,'Additional AD&D Plan',NULL,NULL,'"Additional AD&D Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','ESTANDAR20Z0','23','H','01','184',NULL,'Additional AD&D Product',NULL,NULL,'"Additional AD&D Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','ESTANDAR20Z0','22','H','01','185',NULL,'Additional AD&D Amount',NULL,NULL,'"Additional AD&D Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','ESTANDAR20Z0','26','H','01','186',NULL,'Additional AD&D Class Name',NULL,NULL,'"Additional AD&D Class Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','ESTANDAR20Z0','29','H','01','187',NULL,'Additional AD&D User Specific',NULL,NULL,'"Additional AD&D User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','ESTANDAR20Z0','30','H','01','188',NULL,'Additional AD&D Effective Date',NULL,NULL,'"Additional AD&D Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','ESTANDAR20Z0','32','H','01','189',NULL,'Additional AD&D Termination Date',NULL,NULL,'"Additional AD&D Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','ESTANDAR20Z0','18','H','01','190',NULL,'Spouse Life Policy',NULL,NULL,'"Spouse Life Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','ESTANDAR20Z0','16','H','01','191',NULL,'Spouse Life Plan',NULL,NULL,'"Spouse Life Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','ESTANDAR20Z0','19','H','01','192',NULL,'Spouse Life Product',NULL,NULL,'"Spouse Life Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','ESTANDAR20Z0','18','H','01','193',NULL,'Spouse Life Amount',NULL,NULL,'"Spouse Life Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','ESTANDAR20Z0','24','H','01','194',NULL,'Spouse Life Tobacco User',NULL,NULL,'"Spouse Life Tobacco User"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','ESTANDAR20Z0','20','H','01','195',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','ESTANDAR20Z0','25','H','01','196',NULL,'Spouse Life User Specific',NULL,NULL,'"Spouse Life User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','ESTANDAR20Z0','26','H','01','197',NULL,'Spouse Life Effective Date',NULL,NULL,'"Spouse Life Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','ESTANDAR20Z0','28','H','01','198',NULL,'Spouse Life Termination Date',NULL,NULL,'"Spouse Life Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','ESTANDAR20Z0','18','H','01','199',NULL,'Spouse AD&D Policy',NULL,NULL,'"Spouse AD&D Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','ESTANDAR20Z0','16','H','01','200',NULL,'Spouse AD&D Plan',NULL,NULL,'"Spouse AD&D Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','ESTANDAR20Z0','19','H','01','201',NULL,'Spouse AD&D Product',NULL,NULL,'"Spouse AD&D Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','ESTANDAR20Z0','18','H','01','202',NULL,'Spouse AD&D Amount',NULL,NULL,'"Spouse AD&D Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','ESTANDAR20Z0','20','H','01','203',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','ESTANDAR20Z0','25','H','01','204',NULL,'Spouse AD&D User Specific',NULL,NULL,'"Spouse AD&D User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','ESTANDAR20Z0','26','H','01','205',NULL,'Spouse AD&D Effective Date',NULL,NULL,'"Spouse AD&D Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','ESTANDAR20Z0','28','H','01','206',NULL,'Spouse AD&D Termination Date',NULL,NULL,'"Spouse AD&D Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','ESTANDAR20Z0','17','H','01','207',NULL,'Child Life Policy',NULL,NULL,'"Child Life Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','ESTANDAR20Z0','15','H','01','208',NULL,'Child Life Plan',NULL,NULL,'"Child Life Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','ESTANDAR20Z0','18','H','01','209',NULL,'Child Life Product',NULL,NULL,'"Child Life Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','ESTANDAR20Z0','17','H','01','210',NULL,'Child Life Amount',NULL,NULL,'"Child Life Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','ESTANDAR20Z0','24','H','01','211',NULL,'Child Life User Specific',NULL,NULL,'"Child Life User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','ESTANDAR20Z0','25','H','01','212',NULL,'Child Life Effective Date',NULL,NULL,'"Child Life Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','ESTANDAR20Z0','27','H','01','213',NULL,'Child Life Termination Date',NULL,NULL,'"Child Life Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','ESTANDAR20Z0','17','H','01','214',NULL,'Child AD&D Policy',NULL,NULL,'"Child AD&D Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','ESTANDAR20Z0','15','H','01','215',NULL,'Child AD&D Plan',NULL,NULL,'"Child AD&D Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','ESTANDAR20Z0','18','H','01','216',NULL,'Child AD&D Product',NULL,NULL,'"Child AD&D Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','ESTANDAR20Z0','17','H','01','217',NULL,'Child AD&D Amount',NULL,NULL,'"Child AD&D Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','ESTANDAR20Z0','24','H','01','218',NULL,'Child AD&D User Specific',NULL,NULL,'"Child AD&D User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','ESTANDAR20Z0','25','H','01','219',NULL,'Child AD&D Effective Date',NULL,NULL,'"Child AD&D Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','ESTANDAR20Z0','27','H','01','220',NULL,'Child AD&D Termination Date',NULL,NULL,'"Child AD&D Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','ESTANDAR20Z0','22','H','01','221',NULL,'StandAlone AD&D Policy',NULL,NULL,'"StandAlone AD&D Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','ESTANDAR20Z0','20','H','01','222',NULL,'StandAlone AD&D Plan',NULL,NULL,'"StandAlone AD&D Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','ESTANDAR20Z0','23','H','01','223',NULL,'StandAlone AD&D Product',NULL,NULL,'"StandAlone AD&D Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','ESTANDAR20Z0','22','H','01','224',NULL,'StandAlone AD&D Amount',NULL,NULL,'"StandAlone AD&D Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','ESTANDAR20Z0','35','H','01','225',NULL,'StandAlone AD&D Earnings Multiplier',NULL,NULL,'"StandAlone AD&D Earnings Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','ESTANDAR20Z0','28','H','01','226',NULL,'StandAlone AD&D Tobacco User',NULL,NULL,'"StandAlone AD&D Tobacco User"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','ESTANDAR20Z0','39','H','01','227',NULL,'StandAlone AD&D Date of Birth (SP only)',NULL,NULL,'"StandAlone AD&D Date of Birth (SP only)"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','ESTANDAR20Z0','29','H','01','228',NULL,'StandAlone AD&D User Specific',NULL,NULL,'"StandAlone AD&D User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','ESTANDAR20Z0','30','H','01','229',NULL,'StandAlone AD&D Effective Date',NULL,NULL,'"StandAlone AD&D Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','ESTANDAR20Z0','32','H','01','230',NULL,'StandAlone AD&D Termination Date',NULL,NULL,'"StandAlone AD&D Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','ESTANDAR20Z0','19','H','01','231',NULL,'OTHER LIFE 2 Policy',NULL,NULL,'"OTHER LIFE 2 Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','ESTANDAR20Z0','17','H','01','232',NULL,'OTHER LIFE 2 Plan',NULL,NULL,'"OTHER LIFE 2 Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','ESTANDAR20Z0','20','H','01','233',NULL,'OTHER LIFE 2 Product',NULL,NULL,'"OTHER LIFE 2 Product"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','ESTANDAR20Z0','19','H','01','234',NULL,'OTHER LIFE 2 Amount',NULL,NULL,'"OTHER LIFE 2 Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','ESTANDAR20Z0','32','H','01','235',NULL,'OTHER LIFE 2 Earnings Multiplier',NULL,NULL,'"OTHER LIFE 2 Earnings Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','ESTANDAR20Z0','25','H','01','236',NULL,'OTHER LIFE 2 Tobacco User',NULL,NULL,'"OTHER LIFE 2 Tobacco User"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','ESTANDAR20Z0','36','H','01','237',NULL,'OTHER LIFE 2 Date of Birth (SP only)',NULL,NULL,'"OTHER LIFE 2 Date of Birth (SP only)"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','ESTANDAR20Z0','26','H','01','238',NULL,'OTHER LIFE 2 User Specific',NULL,NULL,'"OTHER LIFE 2 User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','ESTANDAR20Z0','27','H','01','239',NULL,'OTHER LIFE 2 Effective Date',NULL,NULL,'"OTHER LIFE 2 Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','ESTANDAR20Z0','29','H','01','240',NULL,'OTHER LIFE 2 Termination Date',NULL,NULL,'"OTHER LIFE 2 Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','ESTANDAR20Z0','26','H','01','241',NULL,'Federal Allowances Claimed',NULL,NULL,'"Federal Allowances Claimed"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','ESTANDAR20Z0','25','H','01','242',NULL,'Federal Additional Amount',NULL,NULL,'"Federal Additional Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','ESTANDAR20Z0','26','H','01','243',NULL,'Federal Claimed Exemptions',NULL,NULL,'"Federal Claimed Exemptions"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','ESTANDAR20Z0','21','H','01','244',NULL,'Federal Filing Status',NULL,NULL,'"Federal Filing Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','ESTANDAR20Z0','9','H','01','245',NULL,'Tax State',NULL,NULL,'"Tax State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','ESTANDAR20Z0','24','H','01','246',NULL,'State Allowances Claimed',NULL,NULL,'"State Allowances Claimed"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','ESTANDAR20Z0','23','H','01','247',NULL,'State Additional Amount',NULL,NULL,'"State Additional Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','ESTANDAR20Z0','24','H','01','248',NULL,'State Claimed Exemptions',NULL,NULL,'"State Claimed Exemptions"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','ESTANDAR20Z0','19','H','01','249',NULL,'State Filing Status',NULL,NULL,'"State Filing Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','ESTANDAR20Z0','6','H','01','250',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','ESTANDAR20Z0','5','H','01','251',NULL,'Plan',NULL,NULL,'"Plan "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','ESTANDAR20Z0','8','H','01','252',NULL,'Product',NULL,NULL,'"Product "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','ESTANDAR20Z0','6','H','01','253',NULL,'Amount',NULL,NULL,'"Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','ESTANDAR20Z0','10','H','01','254',NULL,'Multiplier',NULL,NULL,'"Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','ESTANDAR20Z0','15','H','01','255',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','ESTANDAR20Z0','4','H','01','256',NULL,'Type',NULL,NULL,'"Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','ESTANDAR20Z0','13','H','01','257',NULL,'User Specific',NULL,NULL,'"User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','ESTANDAR20Z0','16','H','01','258',NULL,'Application Date',NULL,NULL,'"Application Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','ESTANDAR20Z0','6','H','01','259',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','ESTANDAR20Z0','5','H','01','260',NULL,'Plan',NULL,NULL,'"Plan "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','ESTANDAR20Z0','8','H','01','261',NULL,'Product',NULL,NULL,'"Product "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','ESTANDAR20Z0','6','H','01','262',NULL,'Amount',NULL,NULL,'"Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','ESTANDAR20Z0','10','H','01','263',NULL,'Multiplier',NULL,NULL,'"Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','ESTANDAR20Z0','15','H','01','264',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','ESTANDAR20Z0','4','H','01','265',NULL,'Type',NULL,NULL,'"Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','ESTANDAR20Z0','13','H','01','266',NULL,'User Specific',NULL,NULL,'"User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','ESTANDAR20Z0','16','H','01','267',NULL,'Application Date',NULL,NULL,'"Application Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','ESTANDAR20Z0','6','H','01','268',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','ESTANDAR20Z0','5','H','01','269',NULL,'Plan',NULL,NULL,'"Plan "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','ESTANDAR20Z0','8','H','01','270',NULL,'Product',NULL,NULL,'"Product "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','ESTANDAR20Z0','6','H','01','271',NULL,'Amount',NULL,NULL,'"Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','ESTANDAR20Z0','10','H','01','272',NULL,'Multiplier',NULL,NULL,'"Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','ESTANDAR20Z0','15','H','01','273',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','ESTANDAR20Z0','4','H','01','274',NULL,'Type',NULL,NULL,'"Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','ESTANDAR20Z0','13','H','01','275',NULL,'User Specific',NULL,NULL,'"User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','ESTANDAR20Z0','16','H','01','276',NULL,'Application Date',NULL,NULL,'"Application Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','ESTANDAR20Z0','6','H','01','277',NULL,'Policy',NULL,NULL,'"Policy"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','ESTANDAR20Z0','5','H','01','278',NULL,'Plan',NULL,NULL,'"Plan "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','ESTANDAR20Z0','8','H','01','279',NULL,'Product',NULL,NULL,'"Product "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','ESTANDAR20Z0','6','H','01','280',NULL,'Amount',NULL,NULL,'"Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','ESTANDAR20Z0','10','H','01','281',NULL,'Multiplier',NULL,NULL,'"Multiplier"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','ESTANDAR20Z0','15','H','01','282',NULL,'Benefit Percent',NULL,NULL,'"Benefit Percent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','ESTANDAR20Z0','4','H','01','283',NULL,'Type',NULL,NULL,'"Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','ESTANDAR20Z0','13','H','01','284',NULL,'User Specific',NULL,NULL,'"User Specific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','ESTANDAR20Z0','16','H','01','285',NULL,'Application Date',NULL,NULL,'"Application Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTANDAR20Z0','8','D','10','1',NULL,'Organization ID Code',NULL,NULL,'"drvOrganizationIDCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTANDAR20Z0','50','D','10','2',NULL,'Sub Org Text',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTANDAR20Z0','9','D','10','3',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTANDAR20Z0','20','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTANDAR20Z0','20','D','10','5',NULL,'Name Prefix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTANDAR20Z0','40','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTANDAR20Z0','40','D','10','7',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTANDAR20Z0','40','D','10','8',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTANDAR20Z0','10','D','10','9',NULL,'Name Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTANDAR20Z0','8','D','10','10',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTANDAR20Z0','8','D','10','11',NULL,'Date of Death',NULL,NULL,'"drvDateofDeath"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTANDAR20Z0','1','D','10','12',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTANDAR20Z0','16','D','10','13',NULL,'Marital Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTANDAR20Z0','50','D','10','14',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTANDAR20Z0','50','D','10','15',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTANDAR20Z0','50','D','10','16',NULL,'Address Line 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTANDAR20Z0','50','D','10','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTANDAR20Z0','6','D','10','18',NULL,'State/Province',NULL,NULL,'"drvStateProvince"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTANDAR20Z0','20','D','10','19',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTANDAR20Z0','50','D','10','20',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTANDAR20Z0','15','D','10','21',NULL,'Non-Work Phone',NULL,NULL,'"drvNonWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTANDAR20Z0','8','D','10','22',NULL,'Current Hire Date',NULL,NULL,'"drvCurrentHireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTANDAR20Z0','8','D','10','23',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTANDAR20Z0','8','D','10','24',NULL,'Adjusted Hire Date',NULL,NULL,'"drvAdjustedHireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTANDAR20Z0','8','D','10','25',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTerminationDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTANDAR20Z0','2','D','10','26',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTANDAR20Z0','50','D','10','27',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTANDAR20Z0','26','D','10','28',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTANDAR20Z0','8','D','10','29',NULL,'Scheduled Work Hours',NULL,NULL,'"drvScheduledWorkHours"','(''UNT0''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTANDAR20Z0','12','D','10','30',NULL,'Scheduled Work Hours Frequency',NULL,NULL,'"drvSchWorkHoursFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTANDAR20Z0','11','D','10','31',NULL,'Employee Pay Type',NULL,NULL,'"drvEmployeePayType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTANDAR20Z0','9','D','10','32',NULL,'Full/Part Time',NULL,NULL,'"drvFullPartTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTANDAR20Z0','9','D','10','33',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTANDAR20Z0','50','D','10','34',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTANDAR20Z0','10','D','10','35',NULL,'Exempt Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTANDAR20Z0','1','D','10','36',NULL,'Union Flag',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTANDAR20Z0','50','D','10','37',NULL,'Union Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTANDAR20Z0','50','D','10','38',NULL,'Employer Affiliate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTANDAR20Z0','50','D','10','39',NULL,'Employer Location Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTANDAR20Z0','50','D','10','40',NULL,'Employer Location Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTANDAR20Z0','50','D','10','41',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTANDAR20Z0','50','D','10','42',NULL,'Department Name',NULL,NULL,'"drvDepartmentName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTANDAR20Z0','50','D','10','43',NULL,'Occupation code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTANDAR20Z0','50','D','10','44',NULL,'User Specific 1',NULL,NULL,'"drvUserSpecific1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTANDAR20Z0','50','D','10','45',NULL,'User Specific 2',NULL,NULL,'"drvUserSpecific2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTANDAR20Z0','50','D','10','46',NULL,'User Specific 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTANDAR20Z0','50','D','10','47',NULL,'User Specific 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTANDAR20Z0','50','D','10','48',NULL,'User Specific 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTANDAR20Z0','9','D','10','49',NULL,'Earning Category 1',NULL,NULL,'"drvEarningCategory1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTANDAR20Z0','18','D','10','50',NULL,'Earnings Type 1',NULL,NULL,'"drvEarningsType1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESTANDAR20Z0','13','D','10','51',NULL,'Earnings Amount 1',NULL,NULL,'"drvEarningsAmount1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESTANDAR20Z0','22','D','10','52',NULL,'Earnings Amount Expression 1',NULL,NULL,'"drvEarningsAmtExp1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESTANDAR20Z0','8','D','10','53',NULL,'Earnings Effective Date 1 OR Earnings Pay Date 1',NULL,NULL,'"drvEarningsEffectiveDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESTANDAR20Z0','50','D','10','54',NULL,'Payroll Frequency 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESTANDAR20Z0','8','D','10','55',NULL,'Pay Start Date 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESTANDAR20Z0','8','D','10','56',NULL,'Pay End Date 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESTANDAR20Z0','10','D','10','57',NULL,'Pay Period Hours 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESTANDAR20Z0','9','D','10','58',NULL,'Earning Category 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESTANDAR20Z0','18','D','10','59',NULL,'Earnings Type 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESTANDAR20Z0','13','D','10','60',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESTANDAR20Z0','1','D','10','61',NULL,'Earnings Amount Expression 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESTANDAR20Z0','8','D','10','62',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESTANDAR20Z0','50','D','10','63',NULL,'Payroll Frequency 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESTANDAR20Z0','8','D','10','64',NULL,'Pay Start Date 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESTANDAR20Z0','8','D','10','65',NULL,'Pay End Date 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESTANDAR20Z0','10','D','10','66',NULL,'Pay Period Hours 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESTANDAR20Z0','9','D','10','67',NULL,'Earning Category 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESTANDAR20Z0','18','D','10','68',NULL,'Earnings Type 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESTANDAR20Z0','13','D','10','69',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESTANDAR20Z0','1','D','10','70',NULL,'Earnings Amount Expression 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESTANDAR20Z0','8','D','10','71',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESTANDAR20Z0','50','D','10','72',NULL,'Payroll Frequency 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESTANDAR20Z0','8','D','10','73',NULL,'Pay Start Date 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESTANDAR20Z0','8','D','10','74',NULL,'Pay End Date 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESTANDAR20Z0','10','D','10','75',NULL,'Pay Period Hours 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESTANDAR20Z0','8','D','10','76',NULL,'Hours Worked in the Last 12 months',NULL,NULL,'"drvHoursWorked12Mnths"','(''UNT0''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESTANDAR20Z0','8','D','10','77',NULL,'Hours Worked in the Last 12 Months THRU DATE',NULL,NULL,'"drvHoursWorked12MnthTHRUDATE"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESTANDAR20Z0','20','D','10','78',NULL,'Supervisor/Manager Employee ID',NULL,NULL,'"drvSupervisorNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESTANDAR20Z0','1','D','10','79',NULL,'Future use field',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESTANDAR20Z0','50','D','10','80',NULL,'AMS Reporting Group 1',NULL,NULL,'"drvAMSReportingGroup1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESTANDAR20Z0','50','D','10','81',NULL,'AMS Reporting Group 2',NULL,NULL,'"drvAMSReportingGroup2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESTANDAR20Z0','50','D','10','82',NULL,'AMS Reporting Group 3',NULL,NULL,'"drvAMSReportingGroup3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESTANDAR20Z0','50','D','10','83',NULL,'AMS Reporting Group 4',NULL,NULL,'"drvAMSReportingGroup4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESTANDAR20Z0','50','D','10','84',NULL,'AMS Reporting Group 5',NULL,NULL,'"drvAMSReportingGroup5"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ESTANDAR20Z0','50','D','10','85',NULL,'AMS Reporting Group 6',NULL,NULL,'"drvAMSReportingGroup6"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ESTANDAR20Z0','50','D','10','86',NULL,'AMS Reporting Group 7',NULL,NULL,'"drvAMSReportingGroup7"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ESTANDAR20Z0','50','D','10','87',NULL,'AMS Reporting Group 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ESTANDAR20Z0','50','D','10','88',NULL,'AMS Reporting Group 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ESTANDAR20Z0','50','D','10','89',NULL,'HR Contact Recipient',NULL,NULL,'"drvHRContactRecipient"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ESTANDAR20Z0','100','D','10','90',NULL,'HR Contact Email Address',NULL,NULL,'"drvHRContactEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ESTANDAR20Z0','15','D','10','91',NULL,'HR Contact Work Phone',NULL,NULL,'"drvHRContactWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ESTANDAR20Z0','50','D','10','92',NULL,'Reporting Category 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ESTANDAR20Z0','50','D','10','93',NULL,'Reporting Category 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ESTANDAR20Z0','50','D','10','94',NULL,'Reporting Category 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ESTANDAR20Z0','50','D','10','95',NULL,'Reporting Category 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ESTANDAR20Z0','50','D','10','96',NULL,'Reporting Category 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ESTANDAR20Z0','6','D','10','97',NULL,'Policy',NULL,NULL,'"drvPolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ESTANDAR20Z0','1','D','10','98',NULL,'Plan',NULL,NULL,'"drvPlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ESTANDAR20Z0','4','D','10','99',NULL,'Product',NULL,NULL,'"drvProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ESTANDAR20Z0','50','D','10','100',NULL,'Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ESTANDAR20Z0','50','D','10','101',NULL,'Benefit Waiting Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ESTANDAR20Z0','20','D','10','102',NULL,'Benefit Percent',NULL,NULL,'"drvBenefitPercent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ESTANDAR20Z0','13','D','10','103',NULL,'Selected Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ESTANDAR20Z0','10','D','10','104',NULL,'Am Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ESTANDAR20Z0','50','D','10','105',NULL,'Class Name',NULL,NULL,'"drvClassName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ESTANDAR20Z0','8','D','10','106',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ESTANDAR20Z0','8','D','10','107',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ESTANDAR20Z0','6','D','10','108',NULL,'Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ESTANDAR20Z0','1','D','10','109',NULL,'Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ESTANDAR20Z0','4','D','10','110',NULL,'Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ESTANDAR20Z0','50','D','10','111',NULL,'Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ESTANDAR20Z0','50','D','10','112',NULL,'Benefit Waiting Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ESTANDAR20Z0','20','D','10','113',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ESTANDAR20Z0','13','D','10','114',NULL,'Selected Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ESTANDAR20Z0','10','D','10','115',NULL,'Am Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ESTANDAR20Z0','50','D','10','116',NULL,'Class Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ESTANDAR20Z0','8','D','10','117',NULL,'Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ESTANDAR20Z0','8','D','10','118',NULL,'Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ESTANDAR20Z0','6','D','10','119',NULL,'Policy',NULL,NULL,'"drvPolicy1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ESTANDAR20Z0','1','D','10','120',NULL,'Plan',NULL,NULL,'"drvPlan1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ESTANDAR20Z0','4','D','10','121',NULL,'Product',NULL,NULL,'"drvProduct1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ESTANDAR20Z0','50','D','10','122',NULL,'Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ESTANDAR20Z0','50','D','10','123',NULL,'Benefit Waiting Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ESTANDAR20Z0','20','D','10','124',NULL,'Benefit Percent',NULL,NULL,'"drvBenefitPercent1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ESTANDAR20Z0','13','D','10','125',NULL,'Selected Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ESTANDAR20Z0','50','D','10','126',NULL,'Class Name',NULL,NULL,'"drvClassName1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ESTANDAR20Z0','8','D','10','127',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ESTANDAR20Z0','8','D','10','128',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ESTANDAR20Z0','6','D','10','129',NULL,'Policy',NULL,NULL,'"drvPolicy2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ESTANDAR20Z0','1','D','10','130',NULL,'Plan',NULL,NULL,'"drvPlan2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ESTANDAR20Z0','4','D','10','131',NULL,'Product',NULL,NULL,'"drvProduct2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ESTANDAR20Z0','50','D','10','132',NULL,'Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ESTANDAR20Z0','50','D','10','133',NULL,'Benefit Waiting Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ESTANDAR20Z0','20','D','10','134',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ESTANDAR20Z0','13','D','10','135',NULL,'Selected Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ESTANDAR20Z0','50','D','10','136',NULL,'Class Name',NULL,NULL,'"drvClassName2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ESTANDAR20Z0','8','D','10','137',NULL,'Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ESTANDAR20Z0','8','D','10','138',NULL,'Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ESTANDAR20Z0','6','D','10','139',NULL,'OTHER Policy',NULL,NULL,'"drvPolicy3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ESTANDAR20Z0','1','D','10','140',NULL,'OTHER Plan',NULL,NULL,'"drvPlan3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ESTANDAR20Z0','4','D','10','141',NULL,'OTHER Product',NULL,NULL,'"drvProduct3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ESTANDAR20Z0','50','D','10','142',NULL,'OTHER Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ESTANDAR20Z0','50','D','10','143',NULL,'OTHER Benefit Waiting Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ESTANDAR20Z0','20','D','10','144',NULL,'OTHER Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ESTANDAR20Z0','13','D','10','145',NULL,'OTHER Selected Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ESTANDAR20Z0','10','D','10','146',NULL,'OTHER AM Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ESTANDAR20Z0','50','D','10','147',NULL,'OTHER Class Name',NULL,NULL,'"drvClassName3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ESTANDAR20Z0','8','D','10','148',NULL,'OTHER Effective Date',NULL,NULL,'"drvEffectiveDate3"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ESTANDAR20Z0','8','D','10','149',NULL,'OTHER Termination Date',NULL,NULL,'"drvTerminationDate3"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ESTANDAR20Z0','6','D','10','150',NULL,'NJ TDB Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ESTANDAR20Z0','1','D','10','151',NULL,'NJ TDB Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ESTANDAR20Z0','50','D','10','152',NULL,'NJ TDB Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ESTANDAR20Z0','8','D','10','153',NULL,'NJ TDB Policy Begin Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ESTANDAR20Z0','6','D','10','154',NULL,'NY DBL Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ESTANDAR20Z0','1','D','10','155',NULL,'NY DBL Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ESTANDAR20Z0','50','D','10','156',NULL,'NY DBL Employer Plan Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ESTANDAR20Z0','8','D','10','157',NULL,'NY DBL Policy Begin Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ESTANDAR20Z0','6','D','10','158',NULL,'Basic Life Policy',NULL,NULL,'"drvBasicLifePolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ESTANDAR20Z0','2','D','10','159',NULL,'Basic Life Plan',NULL,NULL,'"drvBasicLifePlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ESTANDAR20Z0','4','D','10','160',NULL,'Basic Life Product',NULL,NULL,'"drvBasicLifeProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ESTANDAR20Z0','10','D','10','161',NULL,'Basic Life Amount',NULL,NULL,'"drvBasicLifeAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ESTANDAR20Z0','50','D','10','162',NULL,'Basic Life Class Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ESTANDAR20Z0','50','D','10','163',NULL,'Basic Life User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ESTANDAR20Z0','8','D','10','164',NULL,'Basic Life Effective Date',NULL,NULL,'"drvBasicLifeEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ESTANDAR20Z0','8','D','10','165',NULL,'Basic Life Termination Date',NULL,NULL,'"drvBasicLifeTerminationDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ESTANDAR20Z0','6','D','10','166',NULL,'Basic AD&D Policy',NULL,NULL,'"drvBasicADDPolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ESTANDAR20Z0','2','D','10','167',NULL,'Basic AD&D Plan',NULL,NULL,'"drvBasicADDPlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ESTANDAR20Z0','4','D','10','168',NULL,'Basic AD&D Product',NULL,NULL,'"drvBasicADDProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','ESTANDAR20Z0','10','D','10','169',NULL,'Basic AD&D Amount',NULL,NULL,'"drvBasicADDAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','ESTANDAR20Z0','50','D','10','170',NULL,'Basic AD&D User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','ESTANDAR20Z0','8','D','10','171',NULL,'Basic AD&D Effective Date',NULL,NULL,'"drvBasicADDEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','ESTANDAR20Z0','8','D','10','172',NULL,'Basic AD&D Termination Date',NULL,NULL,'"drvBasicADDTerminationDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','ESTANDAR20Z0','6','D','10','173',NULL,'Additional Life Policy',NULL,NULL,'"drvAdditionalLifePolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','ESTANDAR20Z0','2','D','10','174',NULL,'Additional Life Plan',NULL,NULL,'"drvAdditionalLifePlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','ESTANDAR20Z0','4','D','10','175',NULL,'Additional Life Product',NULL,NULL,'"drvAdditionalLifeProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','ESTANDAR20Z0','10','D','10','176',NULL,'Additional Life Amount',NULL,NULL,'"drvAdditionalLifeAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','ESTANDAR20Z0','10','D','10','177',NULL,'Additional Life Earnings Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','ESTANDAR20Z0','1','D','10','178',NULL,'Additional Life Tobacco User',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','ESTANDAR20Z0','50','D','10','179',NULL,'Additional Life User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','ESTANDAR20Z0','8','D','10','180',NULL,'Additional Life Effective Date',NULL,NULL,'"drvAdditionalLifeEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','ESTANDAR20Z0','8','D','10','181',NULL,'Additional Life Termination Date',NULL,NULL,'"drvAdditionalLifeTermDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','ESTANDAR20Z0','6','D','10','182',NULL,'Additional AD&D Policy',NULL,NULL,'"drvAADandDPolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','ESTANDAR20Z0','2','D','10','183',NULL,'Additional AD&D Plan',NULL,NULL,'"drvAADandDPlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','ESTANDAR20Z0','4','D','10','184',NULL,'Additional AD&D Product',NULL,NULL,'"drvAADandDProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','ESTANDAR20Z0','10','D','10','185',NULL,'Additional AD&D Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','ESTANDAR20Z0','50','D','10','186',NULL,'Additional AD&D Class Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','ESTANDAR20Z0','50','D','10','187',NULL,'Additional AD&D User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','ESTANDAR20Z0','8','D','10','188',NULL,'Additional AD&D Effective Date',NULL,NULL,'"drvAADandDEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','ESTANDAR20Z0','8','D','10','189',NULL,'Additional AD&D Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','ESTANDAR20Z0','6','D','10','190',NULL,'Spouse Life Policy',NULL,NULL,'"drvSpouseLifePolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','ESTANDAR20Z0','2','D','10','191',NULL,'Spouse Life Plan',NULL,NULL,'"drvSpouseLifePlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','ESTANDAR20Z0','4','D','10','192',NULL,'Spouse Life Product',NULL,NULL,'"drvSpouseLifeProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','ESTANDAR20Z0','10','D','10','193',NULL,'Spouse Life Amount',NULL,NULL,'"drvSpouseLifeAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','ESTANDAR20Z0','1','D','10','194',NULL,'Spouse Life Tobacco User',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','ESTANDAR20Z0','8','D','10','195',NULL,'Spouse Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','ESTANDAR20Z0','50','D','10','196',NULL,'Spouse Life User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','ESTANDAR20Z0','8','D','10','197',NULL,'Spouse Life Effective Date',NULL,NULL,'"drvSpouseLifeEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','ESTANDAR20Z0','8','D','10','198',NULL,'Spouse Life Termination Date',NULL,NULL,'"drvSpouseLifeTermDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','ESTANDAR20Z0','6','D','10','199',NULL,'Spouse AD&D Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','ESTANDAR20Z0','2','D','10','200',NULL,'Spouse AD&D Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','ESTANDAR20Z0','4','D','10','201',NULL,'Spouse AD&D Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','ESTANDAR20Z0','10','D','10','202',NULL,'Spouse AD&D Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','ESTANDAR20Z0','8','D','10','203',NULL,'Spouse Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','ESTANDAR20Z0','50','D','10','204',NULL,'Spouse AD&D User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','ESTANDAR20Z0','8','D','10','205',NULL,'Spouse AD&D Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','ESTANDAR20Z0','8','D','10','206',NULL,'Spouse AD&D Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','ESTANDAR20Z0','6','D','10','207',NULL,'Child Life Policy',NULL,NULL,'"drvChildLifePolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','ESTANDAR20Z0','2','D','10','208',NULL,'Child Life Plan',NULL,NULL,'"drvChildLifePlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','ESTANDAR20Z0','4','D','10','209',NULL,'Child Life Product',NULL,NULL,'"drvChildLifeProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','ESTANDAR20Z0','10','D','10','210',NULL,'Child Life Amount',NULL,NULL,'"drvChildLifeAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','ESTANDAR20Z0','50','D','10','211',NULL,'Child Life User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','ESTANDAR20Z0','8','D','10','212',NULL,'Child Life Effective Date',NULL,NULL,'"drvChildLifeEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','ESTANDAR20Z0','8','D','10','213',NULL,'Child Life Termination Date',NULL,NULL,'"drvChildLifeTermDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','ESTANDAR20Z0','6','D','10','214',NULL,'Child AD&D Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','ESTANDAR20Z0','2','D','10','215',NULL,'Child AD&D Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','ESTANDAR20Z0','4','D','10','216',NULL,'Child AD&D Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','ESTANDAR20Z0','10','D','10','217',NULL,'Child AD&D Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','ESTANDAR20Z0','50','D','10','218',NULL,'Child AD&D User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','ESTANDAR20Z0','8','D','10','219',NULL,'Child AD&D Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','ESTANDAR20Z0','8','D','10','220',NULL,'Child AD&D Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','ESTANDAR20Z0','6','D','10','221',NULL,'StandAlone AD&D Policy',NULL,NULL,'"drvStandAloneADDPolicy"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','ESTANDAR20Z0','2','D','10','222',NULL,'StandAlone AD&D Plan',NULL,NULL,'"drvStandAloneADDPlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','ESTANDAR20Z0','4','D','10','223',NULL,'StandAlone AD&D Product',NULL,NULL,'"drvStandAloneADDProduct"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','ESTANDAR20Z0','10','D','10','224',NULL,'StandAlone AD&D Amount',NULL,NULL,'"drvStandAloneADDAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','ESTANDAR20Z0','10','D','10','225',NULL,'StandAlone AD&D Earnings Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','ESTANDAR20Z0','1','D','10','226',NULL,'StandAlone AD&D Tobacco User',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','ESTANDAR20Z0','8','D','10','227',NULL,'StandAlone AD&D Date of Birth (SP only)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','ESTANDAR20Z0','50','D','10','228',NULL,'StandAlone AD&D User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','ESTANDAR20Z0','8','D','10','229',NULL,'StandAlone AD&D Effective Date',NULL,NULL,'"drvStandAloneADDEffDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','ESTANDAR20Z0','8','D','10','230',NULL,'StandAlone AD&D Termination Date',NULL,NULL,'"drvStandAloneADDTermDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','ESTANDAR20Z0','6','D','10','231',NULL,'OTHER LIFE 2 Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','ESTANDAR20Z0','2','D','10','232',NULL,'OTHER LIFE 2 Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','ESTANDAR20Z0','4','D','10','233',NULL,'OTHER LIFE 2 Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','ESTANDAR20Z0','10','D','10','234',NULL,'OTHER LIFE 2 Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','ESTANDAR20Z0','10','D','10','235',NULL,'OTHER LIFE 2 Earnings Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','ESTANDAR20Z0','1','D','10','236',NULL,'OTHER LIFE 2 Tobacco User',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','ESTANDAR20Z0','8','D','10','237',NULL,'OTHER LIFE 2 Date of Birth (SP only)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','ESTANDAR20Z0','50','D','10','238',NULL,'OTHER LIFE 2 User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','ESTANDAR20Z0','8','D','10','239',NULL,'OTHER LIFE 2 Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','ESTANDAR20Z0','8','D','10','240',NULL,'OTHER LIFE 2 Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','ESTANDAR20Z0','50','D','10','241',NULL,'Federal Allowances Claimed',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','ESTANDAR20Z0','10','D','10','242',NULL,'Federal Additional Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','ESTANDAR20Z0','50','D','10','243',NULL,'Federal Claimed Exemptions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','ESTANDAR20Z0','50','D','10','244',NULL,'Federal Filing Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','ESTANDAR20Z0','2','D','10','245',NULL,'Tax State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','ESTANDAR20Z0','50','D','10','246',NULL,'State Allowances Claimed',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','ESTANDAR20Z0','10','D','10','247',NULL,'State Additional Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','ESTANDAR20Z0','50','D','10','248',NULL,'State Claimed Exemptions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','ESTANDAR20Z0','50','D','10','249',NULL,'State Filing Status',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','ESTANDAR20Z0','6','D','10','250',NULL,'Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','ESTANDAR20Z0','1','D','10','251',NULL,'Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','ESTANDAR20Z0','4','D','10','252',NULL,'Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','ESTANDAR20Z0','10','D','10','253',NULL,'Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','ESTANDAR20Z0','10','D','10','254',NULL,'Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','ESTANDAR20Z0','20','D','10','255',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','ESTANDAR20Z0','1','D','10','256',NULL,'Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','ESTANDAR20Z0','50','D','10','257',NULL,'User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','ESTANDAR20Z0','20','D','10','258',NULL,'Application Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','ESTANDAR20Z0','6','D','10','259',NULL,'Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','ESTANDAR20Z0','1','D','10','260',NULL,'Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','ESTANDAR20Z0','4','D','10','261',NULL,'Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','ESTANDAR20Z0','10','D','10','262',NULL,'Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','ESTANDAR20Z0','10','D','10','263',NULL,'Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','ESTANDAR20Z0','20','D','10','264',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','ESTANDAR20Z0','1','D','10','265',NULL,'Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','ESTANDAR20Z0','50','D','10','266',NULL,'User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','ESTANDAR20Z0','20','D','10','267',NULL,'Application Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','ESTANDAR20Z0','6','D','10','268',NULL,'Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','ESTANDAR20Z0','1','D','10','269',NULL,'Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','ESTANDAR20Z0','4','D','10','270',NULL,'Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','ESTANDAR20Z0','10','D','10','271',NULL,'Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','ESTANDAR20Z0','10','D','10','272',NULL,'Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','ESTANDAR20Z0','20','D','10','273',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','ESTANDAR20Z0','1','D','10','274',NULL,'Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','ESTANDAR20Z0','50','D','10','275',NULL,'User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','ESTANDAR20Z0','20','D','10','276',NULL,'Application Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','ESTANDAR20Z0','6','D','10','277',NULL,'Policy',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','ESTANDAR20Z0','1','D','10','278',NULL,'Plan',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','ESTANDAR20Z0','4','D','10','279',NULL,'Product',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','ESTANDAR20Z0','10','D','10','280',NULL,'Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','ESTANDAR20Z0','10','D','10','281',NULL,'Multiplier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','ESTANDAR20Z0','20','D','10','282',NULL,'Benefit Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','ESTANDAR20Z0','1','D','10','283',NULL,'Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','ESTANDAR20Z0','50','D','10','284',NULL,'User Specific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','ESTANDAR20Z0','20','D','10','285',NULL,'Application Date',NULL,NULL,'""','(''SS''=''T'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202112319','EMPEXPORT','OEACTIVE',NULL,'ESTANDAR2',NULL,NULL,NULL,'202112319','Nov 28 2020  6:51AM','Nov 28 2020  6:51AM','202112011',NULL,'','','202112011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202112319','EMPEXPORT','OEPASSIVE','Dec 29 2020 12:35PM','ESTANDAR2',NULL,NULL,NULL,'202112319','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202112011','2532','','','202112011',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The Standard Export','202112319','EMPEXPORT','ONDEMAND','Feb 15 2021 10:33AM','ESTANDAR2',NULL,NULL,NULL,'202112319','Feb 14 2021 12:00AM','Dec 30 1899 12:00AM','202112011','2626','','','202112011',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202112319','EMPEXPORT','SCHEDULED','Oct 24 2021 10:30PM','ESTANDAR2',NULL,NULL,NULL,'202112319','Jan 10 2021 12:00AM','Dec 30 1899 12:00AM','202112011','2562','','','202112011',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\N2\Public\SWE1003\Exports\Standard\SCHMC_ESTANDAR2_20211222.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202112319','EMPEXPORT','TEST','Dec 23 2021 11:47AM','ESTANDAR2',NULL,NULL,NULL,'202112319','Dec  2 2021 12:00AM','Nov 27 2021 12:00AM','202112011','2516','','','202112011',dbo.fn_GetTimedKey(),NULL,'us3rVaSWE1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','ExportPath','V','\\us.saas\ez\Public\SWE1003\Exports_Test');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','TestPath','V','\\us.saas\ez\Public\SWE1003\Exports_TestStandard\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','UDESPath','C','\\us.saas\ez\Public\SWE1003\Exports_Test');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDAR2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDAR2','D10','dbo.U_ESTANDAR2_D10',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESTANDAR2_Audit
-----------

IF OBJECT_ID('U_ESTANDAR2_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL
);

-----------
-- Create table U_ESTANDAR2_AuditFields
-----------

IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESTANDAR2_D10
-----------

IF OBJECT_ID('U_ESTANDAR2_D10') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_D10] (
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvOrganizationIDCode] varchar(8) NOT NULL,
    [drvSubOrgText] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofDeath] datetime NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvStateProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvNonWorkPhone] varchar(50) NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvAdjustedHireDate] datetime NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvWorkState] varchar(2) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvEmploymentStatus] varchar(25) NOT NULL,
    [drvScheduledWorkHours] decimal NULL,
    [drvSchWorkHoursFrequency] varchar(6) NOT NULL,
    [drvEmployeePayType] varchar(6) NOT NULL,
    [drvFullPartTime] varchar(9) NOT NULL,
    [drvEmploymentType] varchar(7) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvDepartmentCode] char(10) NULL,
    [drvDepartmentName] varchar(25) NULL,
    [drvUserSpecific1] varchar(40) NULL,
    [drvUserSpecific2] char(8) NULL,
    [drvEarningCategory1] varchar(9) NOT NULL,
    [drvEarningsType1] varchar(9) NOT NULL,
    [drvEarningsAmount1] varchar(20) NULL,
    [drvEarningsAmtExp1] varchar(6) NOT NULL,
    [drvEarningsEffectiveDate1] datetime NULL,
    [drvHoursWorked12Mnths] decimal NOT NULL,
    [drvHoursWorked12MnthTHRUDATE] datetime NOT NULL,
    [drvSupervisorNum] char(9) NOT NULL,
    [drvAMSReportingGroup1] char(1) NULL,
    [drvAMSReportingGroup2] varchar(50) NOT NULL,
    [drvAMSReportingGroup3] varchar(11) NOT NULL,
    [drvAMSReportingGroup4] varchar(40) NULL,
    [drvAMSReportingGroup5] char(5) NULL,
    [drvAMSReportingGroup6] varchar(1) NOT NULL,
    [drvAMSReportingGroup7] varchar(1) NOT NULL,
    [drvHRContactRecipient] varchar(11) NOT NULL,
    [drvHRContactEmailAddress] varchar(25) NOT NULL,
    [drvHRContactWorkPhone] varchar(10) NOT NULL,
    [drvPolicy] varchar(6) NULL,
    [drvPlan] varchar(1) NULL,
    [drvProduct] varchar(2) NULL,
    [drvBenefitPercent] varchar(3) NULL,
    [drvClassName] varchar(7) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvPolicy1] varchar(6) NULL,
    [drvPlan1] varchar(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvBenefitPercent1] varchar(2) NOT NULL,
    [drvClassName1] varchar(7) NULL,
    [drvEffectiveDate1] datetime NULL,
    [drvTerminationDate1] datetime NULL,
    [drvPolicy2] varchar(6) NULL,
    [drvPlan2] varchar(1) NULL,
    [drvProduct2] varchar(3) NULL,
    [drvClassName2] varchar(7) NULL,
    [drvPolicy3] varchar(6) NULL,
    [drvPlan3] varchar(1) NULL,
    [drvProduct3] varchar(2) NULL,
    [drvClassName3] varchar(7) NULL,
    [drvEffectiveDate3] datetime NULL,
    [drvTerminationDate3] datetime NULL,
    [drvBasicLifePolicy] varchar(6) NULL,
    [drvBasicLifePlan] varchar(1) NULL,
    [drvBasicLifeProduct] varchar(2) NULL,
    [drvBasicLifeAmount] varchar(30) NULL,
    [drvBasicLifeEffectiveDate] datetime NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvBasicADDPolicy] varchar(6) NULL,
    [drvBasicADDPlan] varchar(1) NULL,
    [drvBasicADDProduct] varchar(2) NULL,
    [drvBasicADDAmount] varchar(30) NULL,
    [drvBasicADDEffectiveDate] datetime NULL,
    [drvBasicADDTerminationDate] datetime NULL,
    [drvAdditionalLifePolicy] varchar(6) NULL,
    [drvAdditionalLifePlan] varchar(1) NULL,
    [drvAdditionalLifeProduct] varchar(2) NULL,
    [drvAdditionalLifeAmount] varchar(30) NULL,
    [drvAdditionalLifeEffDate] datetime NULL,
    [drvAdditionalLifeTermDate] datetime NULL,
    [drvAADandDPolicy] varchar(6) NULL,
    [drvAADandDPlan] varchar(2) NULL,
    [drvAADandDProduct] varchar(2) NULL,
    [drvAADandDEffDate] datetime NULL,
    [drvSpouseLifePolicy] varchar(6) NULL,
    [drvSpouseLifePlan] varchar(1) NULL,
    [drvSpouseLifeProduct] varchar(3) NULL,
    [drvSpouseLifeAmount] varchar(30) NULL,
    [drvSpouseLifeEffDate] datetime NULL,
    [drvSpouseLifeTermDate] datetime NULL,
    [drvChildLifePolicy] varchar(6) NULL,
    [drvChildLifePlan] varchar(1) NULL,
    [drvChildLifeProduct] varchar(3) NULL,
    [drvChildLifeAmount] varchar(8) NULL,
    [drvChildLifeEffDate] datetime NULL,
    [drvChildLifeTermDate] datetime NULL,
    [drvStandAloneADDPolicy] varchar(6) NULL,
    [drvStandAloneADDPlan] varchar(1) NULL,
    [drvStandAloneADDProduct] varchar(3) NULL,
    [drvStandAloneADDAmount] varchar(30) NULL,
    [drvStandAloneADDEffDate] datetime NULL,
    [drvStandAloneADDTermDate] datetime NULL,
    [drvInitialSort] char(9) NULL
);

-----------
-- Create table U_ESTANDAR2_DedList
-----------

IF OBJECT_ID('U_ESTANDAR2_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESTANDAR2_EEList
-----------

IF OBJECT_ID('U_ESTANDAR2_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESTANDAR2_EmpAge
-----------

IF OBJECT_ID('U_ESTANDAR2_EmpAge') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_EmpAge] (
    [drvEmployeeSSN] char(11) NULL,
    [Gender] char(1) NULL,
    [IsSmoker] varchar(1) NULL,
    [Age] int NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);

-----------
-- Create table U_ESTANDAR2_File
-----------

IF OBJECT_ID('U_ESTANDAR2_File') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDAR2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Swedish Covenant Hospital

Created By: Sai Kiran Gandu (COM4 Global)
Business Analyst: Bridget Amsden
Create Date: 10/29/2020
Service Request Number: 2020-00282672

Purpose: The Standard Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTANDAR2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTANDAR2';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESTANDAR2', @AllObjects = 'Y', @IsWeb = 'N'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode     VARCHAR(10)
        ,@ExportCode        VARCHAR(10)
        ,@StartDate         DATETIME
        ,@EndDate           DATETIME
        ,@StartPerControl   VARCHAR(9)
        ,@EndPerControl     VARCHAR(9);

    -- Declare dates from Parameter file
    SELECT
        @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ESTANDAR2';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESTANDAR2_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NOT NULL
    DROP TABLE dbo.U_ESTANDAR2_AuditFields;
    CREATE TABLE dbo.U_ESTANDAR2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESTANDAR2_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESTANDAR2_Audit') IS NOT NULL
        DROP TABLE dbo.U_ESTANDAR2_Audit;
    SELECT 
        audEEID = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    INTO dbo.U_ESTANDAR2_Audit
    FROM dbo.U_ESTANDAR2_EEList WITH (NOLOCK)
    JOIN dbo.U_ESTANDAR2_AuditFields WITH (NOLOCK) 
        ON 1 = 1
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
        AND audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- BDM Section                                
    --========================================== 
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LFE1X,LFE2X,LFX4X,LFP4X,LFP3X,ADPHY,SLEE1,SLEE2,SLEX1,SLEX2,SLSPS,SLCHL,SLADE,SLADF,SLTD4,SLTD6,GRLTD,STDHR,STDSL,STDPH');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','SLFE1X,LAE1X,LFE2X,LAE2X,LFX4X,LAX4X,LFP4X,LFP3X,LPH3X,LPH1X,ADPHY,ADPHA,SLEE1,SLAE1,SLEE2,SLAE2,SLAE3,SLAE4,SLEX1,SLAX1,SLEX2,SLAX2,SLAX3,SLAX4,SLSPS,SLSPA,SLCHL,SLCHA,SLADE,SLADF,SLTD4,SLTD6,VLTD6,GRLTD,GLTD6,GLTD5,LTDBU,STDHR,STDSL,STDPH,STDC,STD60,LAX1X,LFE1X');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'AllowMultiDedType', 'N');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsChild','CHA,CHL,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsDomPartner','PAR'); 

    -- Required OE parameters
    IF @ExportCode LIKE '%ACTIVE%'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');  
    END;

    If @exportcode like '%PASSIVE%' 
    BEGIN
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')
    END

    -- Run BDM Module
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;
    
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    ---------------------------------
    -- DETAIL RECORD - U_ESTANDAR2_D10
    ---------------------------------
    IF OBJECT_ID('U_ESTANDAR2_D10') IS NOT NULL
        DROP TABLE dbo.U_ESTANDAR2_D10;
    SELECT DISTINCT
         drvEEID                        = xEEID 
        ,drvCOID                        = xCOID
        ,drvOrganizationIDCode          = '10149659'
        ,drvSubOrgText                  = ''
        ,drvSSN                         = EepSSN
        ,drvEmployeeID                  = EecEmpNo
        ,drvFirstName                   = EepNameFirst
        ,drvMiddleName                  = ISNULL(LTRIM(RTRIM(EepNameMiddle)),'')
        ,drvLastName                    = EepNameLast
        ,drvNameSuffix                  = CASE WHEN ISNULL(LTRIM(RTRIM(NULLIF(EepNameSuffix,'Z'))),'') > '' 
                                                THEN LTRIM(RTRIM(EepNameSuffix)) ELSE '' END 
        ,drvDateofBirth                 = EepDateOfBirth
        ,drvDateofDeath                 = CASE WHEN EecTermReason = '203' 
                                                THEN COALESCE(EepDateDeceased,EecDateOfTermination) 
                                                ELSE NULLIF('',SPACE(0)) END 
        ,drvGender                      = CASE EepGender WHEN 'M' THEN 'M'
                                                         WHEN 'F' THEN 'F'  
                                                         ELSE 'U' END 
        ,drvAddressLine1                = EepAddressLine1
        ,drvAddressLine2                = ISNULL(LTRIM(RTRIM(EepAddressLine2)),'')
        ,drvCity                        = EepAddressCity
        ,drvStateProvince               = EepAddressState
        ,drvPostalCode                  = EepAddressZipCode
        ,drvCountry                     = EepAddressCountry
        ,drvNonWorkPhone                = CASE WHEN ISNULL(LTRIM(RTRIM(EepPhoneHomeNumber)),'') > '' THEN EepPhoneHomeNumber 
                                                ELSE ISNULL((SELECT TOP 1 EfoPhoneNumber FROM dbo.EmpMPhon WITH (NOLOCK)
                                                                 WHERE EfoPhoneType='CEL' AND EfoEEID = EecEEID),'')  END 
        ,drvCurrentHireDate             = NULLIF(EecDateOfLastHire,SPACE(0))
        ,drvOriginalHireDate            = EecDateOfSeniority
        ,drvAdjustedHireDate            = EecDateofSeniority
        ,drvEmploymentTerminationDate   = CASE WHEN EecEmplStatus = 'T' THEN NULLIF(EecDateOfTermination,SPACE(0)) 
                                                ELSE NULLIF('',SPACE(0)) END
        ,drvWorkState                   = SUBSTRING(EecStateSUI,1,2)  
        ,drvJobTitle                    = JbcLongDesc            
        ,drvEmploymentStatus            = CASE WHEN EecEmplStatus= 'S' THEN 'Suspended'
                                                 WHEN EecEmplStatus= 'R' THEN 'Retired'
                                                 WHEN EecEmplStatus= 'T' THEN
                                                    CASE WHEN EecTermReason = '203' THEN 'Deceased' 
                                                         WHEN EecTermReason = '202' THEN 'Retired' 
                                                         ELSE 'Terminated' END 
                                                 WHEN EecEmplStatus= 'L'THEN
                                                    CASE WHEN LchFMLAQualified = 'Y' THEN 'Leave of Absence FMLA' 
                                                         WHEN EecLeaveReason  = '300' THEN 'Leave of Absence Military' 
                                                         ELSE 'Leave of Absence' END 
                                                ELSE 'Active' END  
        ,drvScheduledWorkHours          = CASE WHEN EecScheduledAnnualHrs = 0 THEN '1.00' ELSE (EecScheduledAnnualHrs/52) END
        ,drvSchWorkHoursFrequency       = 'Weekly'
        ,drvEmployeePayType             = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly' ELSE 'Salary' END 
        ,drvFullPartTime                =  CASE WHEN  EecFullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvEmploymentType              = 'Regular'
        ,drvWorkEmailAddress            = EepAddressEmail
        ,drvDepartmentCode              = EecOrgLvl2
        ,drvDepartmentName              = OrgDesc 
        ,drvUserSpecific1               = CmpCompanyName
        ,drvUserSpecific2               = EecJobCode
        ,drvEarningCategory1            = 'Scheduled' 
        ,drvEarningsType1               = 'Base Rate'
        ,drvEarningsAmount1             = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN CONVERT(VARCHAR(20),CAST(EecAnnSalary AS DECIMAL(18,2)))
                                                ELSE '' END 
        ,drvEarningsAmtExp1             = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN 'Annual' ELSE '' END 
        ,drvEarningsEffectiveDate1      = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN 
                                                 ISNULL((SELECT TOP 1 MAX(EjhJobEffDate) FROM dbo.EmpHJob WITH (NOLOCK) 
                                                    WHERE EjhCOID = EecCOID AND EjhEEID = EecEEID AND EjhIsRateChange = 'Y' 
                                                    AND EjhJobEffDate <= @EndDate),EecDateOfLasthire) 
                                                    ELSE NULLIF('',SPACE(0)) END
        ,drvHoursWorked12Mnths           = isnull((select TOP 1 sum(PehCurhrs) from PayReg as P with(nolock) 
                                                     join iPEarHist as ER with (nolock)  
                                                    ON  P.PrgGenNumber  = ER.PehGenNumber and P.Prgpaydate between dateadd(year,-1,@EndDate) and @EndDate
                                                    WHERE prgcoid = xCOID and prgeeid = xEEID
                                                    AND ER.PehInclInTotalHoursWorked ='Y'),0) 
        ,drvHoursWorked12MnthTHRUDATE    = GETDATE()
        ,drvSupervisorNum                = ISNULL((SELECT TOP 1 SUP.EecEmpno FROM dbo.EmpComp SUP WITH (NOLOCK)
                                                     WHERE SUP.EecEEID = EmpComp.EecSuperVisorID),'')
        ,drvAMSReportingGroup1           = EecIsKeyEmployee
        ,drvAMSReportingGroup2           = ISNULL((SELECT TOP 1 SUPE.EepAddressEmail FROM dbo.Emppers SUPE WITH (NOLOCK) 
                                                    JOIN dbo.EmpComp SUP WITH (NOLOCK) ON SUPE.EepEEID = SUP.EecEEID  
                                                    WHERE SUP.EecEEID = EmpComp.EecSuperVisorID),'')
        ,drvAMSReportingGroup3           = CASE WHEN JbcIsSuperVisor = 'Y' THEN 'Manager' ELSE 'Non-Manager' END   
        ,drvAMSReportingGroup4           = CmpCompanyName
        ,drvAMSReportingGroup5           = CmpCompanyCode
        ,drvAMSReportingGroup6           = 'N'
        ,drvAMSReportingGroup7           = 'N'
        ,drvHRContactRecipient           = 'HR Services'
        ,drvHRContactEmailAddress        = 'HRServices@northshore.org'
        ,drvHRContactWorkPhone           = '8475705111'
-----
        -- 97
        ,drvPolicy                       = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN '758191' END
        ,drvPlan                         = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN 'C' END
                                        -- CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN 'A' END
        ,drvProduct                      = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN 'ST' END
        ,drvBenefitPercent               =    CASE WHEN A.EedDedCode IN ('STDHR','STD60') THEN '60'
                                            WHEN A.EedDedCode IN ('STDC','STDPH','STDSL') THEN '100'
                                            END
                                        /* CASE WHEN ISNULL(A.EedEEID,'') <> '' AND A.EedDedCode = 'STDHR' THEN '60'
                                               WHEN A.EedDedCode IN ('STDSL','STDPH') THEN '100' 
                                               ELSE '' 
                                        END*/ 
        -- 105
        ,drvClassName                    =    CASE WHEN A.EedDedCode = 'STD60' THEN 'Class 4'
                                            WHEN A.EedDedcode = 'STDHR' THEN 'Class 3'
                                            WHEN A.EedDedcode = 'STDSL' THEN 'Class 2'
                                            WHEN A.EedDedcode IN ('STDC', 'STDPH') THEN 'Class 1'
                                            END
        ,drvEffectiveDate                = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN NULLIF(A.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvTerminationDate              = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN NULLIF(A.EedBenStopDate,SPACE(0))  ELSE NULLIF('',SPACE(0)) END 
-----
        -- 119
        ,drvPolicy1                      = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN '758190' END
        ,drvPlan1                        = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN 'K' END
                                        -- CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN 'B' END
        ,drvProduct1                     = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN 'LT' END
        ,drvBenefitPercent1              = CASE WHEN ISNULL(B.EedEEID,'') <> '' AND B.EedDedCode = 'SLTD4' THEN '40'
                                               WHEN B.EedDedCode IN ('SLTD6','GRLTD') THEN '60'  
                                               ELSE '' END 
        -- 126
        ,drvClassName1                  =   CASE WHEN B.EedDedCode = 'VLTD6' THEN 'Class 3'
                                            WHEN B.EedDedCode = 'GLTD6' THEN 'Class 1'
                                            WHEN B.EedDedCode = 'GLTD5' THEN 'Class 2'
                                            END

        ,drvEffectiveDate1               = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN NULLIF(B.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvTerminationDate1             = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN NULLIF(B.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----
        -- 129
        ,drvPolicy2                     = CASE WHEN I.EedDedCode = 'LTDBU' THEN '758190' END
        ,drvPlan2                       = CASE WHEN I.EedDedCode = 'LTDBU' THEN 'K' END
        ,drvProduct2                    = CASE WHEN I.EedDedCode = 'LTDBU' THEN 'BLT' END
        ,drvClassName2                  = CASE WHEN I.EedDedCode = 'LTDBU' THEN 'Class 2' END
-----
        -- 139
        ,drvPolicy3                     = CASE WHEN J.EedDedCode = 'GRLTD' THEN '758190' END
        ,drvPlan3                       = CASE WHEN J.EedDedCode = 'GRLTD' THEN 'F' END
        ,drvProduct3                    = CASE WHEN J.EedDedCode = 'GRLTD' THEN 'LT' END
        ,drvClassName3                  = CASE WHEN J.EedDedCode = 'GRLTD' THEN 'Class 1' END
        ,drvEffectiveDate3 = J.EedBenStartDate
        ,drvTerminationDate3 = J.EedBenStopDate
-----
        -- 158
        ,drvBasicLifePolicy              = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN '758190' END
        ,drvBasicLifePlan                =    CASE WHEN C.EedDedCode in ('LFE1X','LFE2X','LFX4X','LFP3X') THEN 'E' 
                                            WHEN C.EedDedCode in ('LAE1X', 'LAE2X', 'LAX1X', 'LPH1X') THEN 'J'
                                            END

                                        --CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN 'A' END
        ,drvBasicLifeProduct             = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN 'BL' END
        ,drvBasicLifeAmount              = CASE WHEN ISNULL(C.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = C.EedDedCode),'')     
                                           END 
          
        ,drvBasicLifeEffectiveDate       = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN NULLIF(C.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvBasicLifeTerminationDate     = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN NULLIF(C.EedBenStopDate,SPACE(0))  ELSE NULLIF('',SPACE(0)) END 

-----
        -- 166
        ,drvBasicADDPolicy               = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN '758190' END
        ,drvBasicADDPlan                 =    CASE WHEN D.EedDedCode IN ('LFE1X','LFE2X','LFX4X','ADPHY') THEN 'E' 
                                            WHEN D.EedDedCode IN ('LAE1X','LAE2X','LAX1X','ADPHA') then 'J'
                                            END

                                            --CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN 'A' END
        ,drvBasicADDProduct              = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN 'BA' END
        ,drvBasicADDAmount               = CASE WHEN ISNULL(D.EedEEID,'') <> '' 
                                                THEN CASE WHEN ISNULL((SELECT TOP 1 BcaBenAmtCalc FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = D.EedEEID 
                                                                and bcacoid = D.EedCOID 
                                                                and bcaDedCode = D.EedDedCode),0.00)>800000 THEN '800000.00'
                                                           ELSE
                                                           ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = D.EedEEID 
                                                                and bcacoid = D.EedCOID 
                                                                and bcaDedCode = D.EedDedCode),'')
                                                     END 
                                            END
        ,drvBasicADDEffectiveDate        = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN NULLIF(D.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvBasicADDTerminationDate      = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN NULLIF(D.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----
        -- 173
        ,drvAdditionalLifePolicy         = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN '758190' END
        ,drvAdditionalLifePlan           =    CASE WHEN E.EedDedCode IN ('SLEE1','SLEE2','SLEX1','SLEX2') THEN 'E' 
                                            WHEN E.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4') THEN 'J'
                                            END

                                            --CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN 'A' END
        ,drvAdditionalLifeProduct        = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN 'AL' END
        ,drvAdditionalLifeAmount         = CASE WHEN ISNULL(E.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = E.EedDedCode),'')     
                                           END 
        ,drvAdditionalLifeEffDate        = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN NULLIF(E.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvAdditionalLifeTermDate       = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN NULLIF(E.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        -- 182
        ,drvAADandDPolicy               = CASE WHEN K.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4') THEN '758190' END
        ,drvAADandDPlan                 = CASE WHEN K.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4') THEN ' J' END
        ,drvAADandDProduct              = CASE WHEN K.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4') THEN 'AA' END
        ,drvAADandDEffDate = CASE WHEN K.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4') THEN K.EedBenStartDate END
-----
        -- 190
        ,drvSpouseLifePolicy             = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN '758190' END
        ,drvSpouseLifePlan               =    CASE WHEN F.EedDedCode = 'SLSPS' THEN 'E'
                                            WHEN F.EedDedCode = 'SLSPA' THEN 'J'
                                            END

                                        -- CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN 'A' END
        ,drvSpouseLifeProduct            = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN 'XSL' END
        ,drvSpouseLifeAmount             = CASE WHEN ISNULL(F.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = F.EedDedCode),'')     
                                           END 
        ,drvSpouseLifeEffDate            = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN NULLIF(F.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvSpouseLifeTermDate           = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN NULLIF(F.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----
        -- 207
        ,drvChildLifePolicy              = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN '758190' END
        ,drvChildLifePlan                =    CASE WHEN G.EedDedCode = 'SLCHL' THEN 'E'
                                            WHEN G.EedDedCode = 'SLCHA' THEN 'J'
                                            END

                                        -- CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN 'A' END
        ,drvChildLifeProduct             = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN 'XCL' END
        ,drvChildLifeAmount              = CASE G.EedbenOption 
                                                WHEN 'C02' THEN '2000.00'
                                                WHEN 'C04' THEN '4000.00'
                                                WHEN 'C06' THEN '6000.00'
                                                WHEN 'C08' THEN '8000.00'
                                                WHEN 'C10' THEN '10000.00'
                                            END          
        ,drvChildLifeEffDate             = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN NULLIF(G.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvChildLifeTermDate            = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN NULLIF(G.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END

-----
        -- 221
        ,drvStandAloneADDPolicy          = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN '758190' END
        ,drvStandAloneADDPlan            = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN 'C' END
        ,drvStandAloneADDProduct         =   CASE WHEN H.EedDedCode = 'SLADE' THEN 'SA'
                                            WHEN H.EedDedCode = 'SLADF' THEN 'SAF'
                                            END
        ,drvStandAloneADDAmount          =  CASE WHEN ISNULL(H.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = H.EedDedCode),'')     
                                           END 
        ,drvStandAloneADDEffDate         = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN NULLIF(H.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvStandAloneADDTermDate        = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN NULLIF(H.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvInitialSort = EecEmpno
    INTO dbo.U_ESTANDAR2_D10
    FROM dbo.U_ESTANDAR2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS A WITH (NOLOCK)
        ON A.EedEEID = xEEID 
        AND A.EedCoID = xCoID
        AND A.EedFormatCode = @FormatCode 
        AND A.EedValidForExport = 'Y'
        AND A.EedDedCode IN ('STDHR','STDSL','STDPH','STD60','STDC') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS B WITH (NOLOCK)
        ON B.EedEEID = xEEID 
        AND B.EedCoID = xCoID
        AND B.EedFormatCode = @FormatCode 
        AND B.EedValidForExport = 'Y'
        AND B.EedDedCode IN ('SLTD4','SLTD6','VLTD6','GLTD6','GLTD5') -- 'GRLTD', 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS C WITH (NOLOCK)
        ON C.EedEEID = xEEID 
        AND C.EedCoID = xCoID
        AND C.EedFormatCode = @FormatCode 
        AND C.EedValidForExport = 'Y'
        AND C.EedDedCode IN ('LFE1X','LFE2X','LFX4X','LFP4X','LFP3X','LAE1X','LAE2X','LAX1X','LPH1X') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS D WITH (NOLOCK)
        ON D.EedEEID = xEEID 
        AND D.EedCoID = xCoID
        AND D.EedFormatCode = @FormatCode 
        AND D.EedValidForExport = 'Y'
        AND D.EedDedCode IN ('LFE1X','LFE2X','LFX4X','LFP4X','ADPHY','LAE1X','LAE2X','LAX1X','ADPHA') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS E WITH (NOLOCK)
        ON E.EedEEID = xEEID 
        AND E.EedCoID = xCoID
        AND E.EedFormatCode = @FormatCode 
        AND E.EedValidForExport = 'Y'
        AND E.EedDedCode IN ('SLEE1','SLEE2','SLEX1','SLEX2','SLAE1','SLAE2','SLAE3','SLAE','SLAE4')  
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS F WITH (NOLOCK)
        ON F.EedEEID = xEEID 
        AND F.EedCoID = xCoID
        AND F.EedFormatCode = @FormatCode 
        AND F.EedValidForExport = 'Y'
        AND F.EedDedCode IN ('SLSPS','SLSPA')
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS G WITH (NOLOCK)
        ON G.EedEEID = xEEID 
        AND G.EedCoID = xCoID
        AND G.EedFormatCode = @FormatCode 
        AND G.EedValidForExport = 'Y'
        AND G.EedDedCode IN ('SLCHL','SLCHA')
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS H WITH (NOLOCK)
        ON H.EedEEID = xEEID 
        AND H.EedCoID = xCoID
        AND H.EedFormatCode = @FormatCode 
        AND H.EedValidForExport = 'Y'
        AND H.EedDedCode IN ('SLADE','SLADF')
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS I WITH (NOLOCK)
        ON i.EedEEID = xEEID 
        AND I.EedCoID = xCoID
        AND I.EedFormatCode = @FormatCode 
        AND I.EedValidForExport = 'Y'
        AND I.EedDedCode IN ('LTDBU')
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS J WITH (NOLOCK)
        ON J.EedEEID = xEEID 
        AND J.EedCoID = xCoID
        AND J.EedFormatCode = @FormatCode 
        AND J.EedValidForExport = 'Y'
        AND J.EedDedCode IN ('GRLTD')
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS K WITH (NOLOCK)
        ON K.EedEEID = xEEID 
        AND K.EedCoID = xCoID
        AND K.EedFormatCode = @FormatCode 
        AND K.EedValidForExport = 'Y'
        AND K.EedDedCode IN ('SLAE1','SLAE2','SLAE3','SLAE4')
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    LEFT JOIN dbo.LoaReasn WITH (NOLOCK)
        ON LchCode = EecLeaveReason 
    LEFT JOIN dbo.OrgLevel WITH (NOLOCK) 
        ON OrgCode = EecOrgLvl2 
        AND OrgLvl = '2'
    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus= 'T' AND EecTermReason  NOT IN ('TRO','TRI')
              AND EXISTS (SELECT TOP 1 1 FROM dbo.U_ESTANDAR2_Audit AS aud WITH (NOLOCK)
                            WHERE aud.audCOID = xCOID AND aud.audEEID= xEEID AND aud.audFieldName = 'EecEmplStatus' 
             AND ISNULL(aud.audOldValue,' ') <> aud.audNewValue  AND aud.audNewValue ='T'))
             AND EecDateOfTermination >= @EndDate-60)
;
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ESTANDAR2','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'northshoreuniversity_10149659_2_'+CONVERT(VARCHAR(10),GETDATE(),112)+REPLACE(CONVERT(VARCHAR(5),GETDATE(),108),':','')+'.txt'
            WHERE FormatCode = 'ESTANDAR2';
    END
    END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESTANDAR2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTANDAR2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'SCHEDULED';

SELECT * FROM U_ESTANDAR2_D10 ORDER BY drvEmployeeID

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTANDAR2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202010021'
       ,ExpStartPerControl     = '202010021'
       ,ExpLastEndPerControl   = '202010099'
       ,ExpEndPerControl       = '202010099'
WHERE ExpFormatCode = 'ESTANDAR2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTANDAR2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTANDAR2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESTANDAR2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESTANDAR2'
   AND rpoParmType = 'expSystemID'


-- End ripout