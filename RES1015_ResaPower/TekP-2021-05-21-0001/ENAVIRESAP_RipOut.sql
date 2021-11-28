/**********************************************************************************

ENAVIRESAP: Navigator Census Export

FormatCode:     ENAVIRESAP
Project:        Navigator Census Export
Client ID:      RES1015
Date/time:      2021-11-10 00:06:39.360
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB01
Database:       ULTIPRO_WPRPLLC
Web Filename:   RES1015_8SE8O_EEHISTORY_ENAVIRESAP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENAVIRESAP_SavePath') IS NOT NULL DROP TABLE dbo.U_ENAVIRESAP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENAVIRESAP'


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
WHERE FormatCode = 'ENAVIRESAP'
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
WHERE ExpFormatCode = 'ENAVIRESAP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENAVIRESAP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENAVIRESAP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENAVIRESAP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENAVIRESAP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENAVIRESAP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENAVIRESAP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENAVIRESAP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENAVIRESAP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENAVIRESAP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENAVIRESAP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENAVIRESAP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENAVIRESAP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENAVIRESAP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAVIRESAP];
GO
IF OBJECT_ID('U_ENAVIRESAP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_PEarHist];
GO
IF OBJECT_ID('U_ENAVIRESAP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_PDedHist];
GO
IF OBJECT_ID('U_ENAVIRESAP_File') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_File];
GO
IF OBJECT_ID('U_ENAVIRESAP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_EEList];
GO
IF OBJECT_ID('U_ENAVIRESAP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_drvTbl];
GO
IF OBJECT_ID('U_ENAVIRESAP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_DedList];
GO
IF OBJECT_ID('U_ENAVIRESAP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_AuditFields];
GO
IF OBJECT_ID('U_ENAVIRESAP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENAVIRESAP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENAVIRESAP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENAVIRESAP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENAVIRESAP','Navigator Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ENAVIRESAPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAVIRESAPZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAVIRESAPZ0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAVIRESAPZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAVIRESAPZ0','50','H','01','4',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENAVIRESAPZ0','50','H','01','5',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENAVIRESAPZ0','50','H','01','6',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENAVIRESAPZ0','50','H','01','7',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENAVIRESAPZ0','50','H','01','8',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENAVIRESAPZ0','50','H','01','9',NULL,'Class',NULL,NULL,'"Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENAVIRESAPZ0','50','H','01','10',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENAVIRESAPZ0','50','H','01','11',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENAVIRESAPZ0','50','H','01','12',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENAVIRESAPZ0','50','H','01','13',NULL,'Office',NULL,NULL,'"Office"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENAVIRESAPZ0','50','H','01','14',NULL,'Work Email',NULL,NULL,'"Work Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENAVIRESAPZ0','50','H','01','15',NULL,'Personal Email',NULL,NULL,'"Personal Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENAVIRESAPZ0','50','H','01','16',NULL,'Payroll Group',NULL,NULL,'"Payroll Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENAVIRESAPZ0','50','H','01','17',NULL,'Annual Base Salary',NULL,NULL,'"Annual Base Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENAVIRESAPZ0','50','H','01','18',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENAVIRESAPZ0','50','H','01','19',NULL,'Hours Per Week',NULL,NULL,'"Hours Per Week"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENAVIRESAPZ0','50','H','01','20',NULL,'Salary Effective Date',NULL,NULL,'"Salary Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENAVIRESAPZ0','50','H','01','21',NULL,'Annual Benefit Salary',NULL,NULL,'"Annual Benefit Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENAVIRESAPZ0','50','H','01','22',NULL,'Annual Benefit Salary Effective Date',NULL,NULL,'"Annual Benefit Salary Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENAVIRESAPZ0','50','H','01','23',NULL,'ACA Classification',NULL,NULL,'"ACA Classification"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENAVIRESAPZ0','50','H','01','24',NULL,'Reporting Year W2 Earnings',NULL,NULL,'"Reporting Year W2 Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENAVIRESAPZ0','50','H','01','25',NULL,'Statutory Class',NULL,NULL,'"Statutory Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENAVIRESAPZ0','50','H','01','26',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENAVIRESAPZ0','50','H','01','27',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENAVIRESAPZ0','50','H','01','28',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENAVIRESAPZ0','50','H','01','29',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENAVIRESAPZ0','50','H','01','30',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENAVIRESAPZ0','50','H','01','31',NULL,'County',NULL,NULL,'"County"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENAVIRESAPZ0','50','H','01','32',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENAVIRESAPZ0','50','H','01','33',NULL,'Phone Number',NULL,NULL,'"Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENAVIRESAPZ0','50','H','01','34',NULL,'Payroll Work State',NULL,NULL,'"Payroll Work State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENAVIRESAPZ0','50','H','01','35',NULL,'Benefit Work State',NULL,NULL,'"Benefit Work State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENAVIRESAPZ0','50','H','01','36',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENAVIRESAPZ0','50','H','01','37',NULL,'Payroll ID',NULL,NULL,'"Payroll ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENAVIRESAPZ0','50','H','01','38',NULL,'Time Clock ID',NULL,NULL,'"Time Clock ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENAVIRESAPZ0','50','H','01','39',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENAVIRESAPZ0','50','H','01','40',NULL,'Is Full Time',NULL,NULL,'"Is Full Time"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENAVIRESAPZ0','50','H','01','41',NULL,'Is Exempt',NULL,NULL,'"Is Exempt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENAVIRESAPZ0','50','H','01','42',NULL,'Is Collectively Bargained',NULL,NULL,'"Is Collectively Bargained"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENAVIRESAPZ0','50','H','01','43',NULL,'Leased Employee',NULL,NULL,'"Leased Employee"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENAVIRESAPZ0','50','H','01','44',NULL,'Seasonal Employee',NULL,NULL,'"Seasonal Employee"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENAVIRESAPZ0','50','H','01','45',NULL,'EEO Job Category',NULL,NULL,'"EEO Job Category"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENAVIRESAPZ0','50','H','01','46',NULL,'Cost Center',NULL,NULL,'"Cost Center"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENAVIRESAPZ0','50','H','01','47',NULL,'Works Outside US',NULL,NULL,'"Works Outside US"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENAVIRESAPZ0','50','H','01','48',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENAVIRESAPZ0','50','H','01','49',NULL,'Tobacco User',NULL,NULL,'"Tobacco User"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENAVIRESAPZ0','50','H','01','50',NULL,'On Wellness',NULL,NULL,'"On Wellness"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENAVIRESAPZ0','51','H','01','51',NULL,'Race/Ethnicity',NULL,NULL,'"Race/Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENAVIRESAPZ0','52','H','01','52',NULL,'Retire Date',NULL,NULL,'"Retire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENAVIRESAPZ0','53','H','01','53',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENAVIRESAPZ0','54','H','01','54',NULL,'Affiliate Hire Date',NULL,NULL,'"Affiliate Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENAVIRESAPZ0','54','H','01','55',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENAVIRESAPZ0','54','H','01','56',NULL,'Termination Reason',NULL,NULL,'"Termination Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENAVIRESAPZ0','54','H','01','57',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENAVIRESAPZ0','54','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENAVIRESAPZ0','54','D','10','2',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENAVIRESAPZ0','54','D','10','3',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENAVIRESAPZ0','54','D','10','4',NULL,'Middle Name',NULL,NULL,'"drvMName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENAVIRESAPZ0','54','D','10','5',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENAVIRESAPZ0','54','D','10','6',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENAVIRESAPZ0','54','D','10','7',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENAVIRESAPZ0','54','D','10','8',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENAVIRESAPZ0','54','D','10','9',NULL,'Class',NULL,NULL,'"drvClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENAVIRESAPZ0','54','D','10','10',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENAVIRESAPZ0','54','D','10','11',NULL,'Division',NULL,NULL,'"drvDiv"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENAVIRESAPZ0','54','D','10','12',NULL,'Business Unit',NULL,NULL,'"drvBusUnit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENAVIRESAPZ0','54','D','10','13',NULL,'Office',NULL,NULL,'"drvOffice"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENAVIRESAPZ0','54','D','10','14',NULL,'Work Email',NULL,NULL,'"drvWrkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENAVIRESAPZ0','54','D','10','15',NULL,'Personal Email',NULL,NULL,'"drvPersEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENAVIRESAPZ0','54','D','10','16',NULL,'Payroll Group',NULL,NULL,'"drvPayGrp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENAVIRESAPZ0','54','D','10','17',NULL,'Annual Base Salary',NULL,NULL,'"drvAnnBaseSal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENAVIRESAPZ0','54','D','10','18',NULL,'Hourly Rate',NULL,NULL,'"drvHrlyRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENAVIRESAPZ0','54','D','10','19',NULL,'Hours Per Week',NULL,NULL,'"drvHrsPerWk"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENAVIRESAPZ0','54','D','10','20',NULL,'Salary Effective Date',NULL,NULL,'"drvSalEffDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENAVIRESAPZ0','54','D','10','21',NULL,'Annual Benefit Salary',NULL,NULL,'"drvAnnBenSal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENAVIRESAPZ0','54','D','10','22',NULL,'Annual Benefit Salary Effective Date',NULL,NULL,'"drvAnnBenSalEffDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENAVIRESAPZ0','54','D','10','23',NULL,'ACA Classification',NULL,NULL,'"drvACAClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENAVIRESAPZ0','54','D','10','24',NULL,'Reporting Year W2 Earnings',NULL,NULL,'"drvRepYrW2Earn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENAVIRESAPZ0','54','D','10','25',NULL,'Statutory Class',NULL,NULL,'"drvStatutoryClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENAVIRESAPZ0','54','D','10','26',NULL,'Address 1',NULL,NULL,'"drvAdd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENAVIRESAPZ0','54','D','10','27',NULL,'Address 2',NULL,NULL,'"drvAdd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENAVIRESAPZ0','54','D','10','28',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENAVIRESAPZ0','54','D','10','29',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENAVIRESAPZ0','54','D','10','30',NULL,'Zip Code',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENAVIRESAPZ0','54','D','10','31',NULL,'County',NULL,NULL,'"drvCounty"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENAVIRESAPZ0','54','D','10','32',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENAVIRESAPZ0','54','D','10','33',NULL,'Phone Number',NULL,NULL,'"drvPhNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENAVIRESAPZ0','54','D','10','34',NULL,'Payroll Work State',NULL,NULL,'"drvPayWrkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENAVIRESAPZ0','54','D','10','35',NULL,'Benefit Work State',NULL,NULL,'"drvBenWrkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENAVIRESAPZ0','54','D','10','36',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENAVIRESAPZ0','54','D','10','37',NULL,'Payroll ID',NULL,NULL,'"drvPayId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENAVIRESAPZ0','54','D','10','38',NULL,'Time Clock ID',NULL,NULL,'"drvTimeClockId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENAVIRESAPZ0','54','D','10','39',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENAVIRESAPZ0','54','D','10','40',NULL,'Is Full Time',NULL,NULL,'"drvIsFullTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENAVIRESAPZ0','54','D','10','41',NULL,'Is Exempt',NULL,NULL,'"drvIsExempt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENAVIRESAPZ0','54','D','10','42',NULL,'Is Collectively Bargained',NULL,NULL,'"drvIsCollectBargained"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENAVIRESAPZ0','54','D','10','43',NULL,'Leased Employee',NULL,NULL,'"drvLeasedEmp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENAVIRESAPZ0','54','D','10','44',NULL,'Seasonal Employee',NULL,NULL,'"drvSeasonalEmp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENAVIRESAPZ0','54','D','10','45',NULL,'EEO Job Category',NULL,NULL,'"drvEEOJobCat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENAVIRESAPZ0','54','D','10','46',NULL,'Cost Center',NULL,NULL,'"drvCostCent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENAVIRESAPZ0','54','D','10','47',NULL,'Works Outside US',NULL,NULL,'"drvWorksOutsideUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENAVIRESAPZ0','54','D','10','48',NULL,'Marital Status',NULL,NULL,'"drvMaritalStat"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENAVIRESAPZ0','54','D','10','49',NULL,'Tobacco User',NULL,NULL,'"drvTobaccoUser"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENAVIRESAPZ0','54','D','10','50',NULL,'On Wellness',NULL,NULL,'"drvOnWellness"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENAVIRESAPZ0','54','D','10','51',NULL,'Race/Ethnicity',NULL,NULL,'"drvRace"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENAVIRESAPZ0','54','D','10','52',NULL,'Retire Date',NULL,NULL,'"drvRetireDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENAVIRESAPZ0','54','D','10','53',NULL,'Original Hire Date',NULL,NULL,'"drvOrigHireDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENAVIRESAPZ0','54','D','10','54',NULL,'Affiliate Hire Date',NULL,NULL,'"drvAffHireDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENAVIRESAPZ0','54','D','10','55',NULL,'Termination Date',NULL,NULL,'"drvTermDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENAVIRESAPZ0','54','D','10','56',NULL,'Termination Reason',NULL,NULL,'"drvTermReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENAVIRESAPZ0','54','D','10','57',NULL,'Rehire Date',NULL,NULL,'"drvRehireDt"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENAVIRESAP_20211110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Navigator Census Export','202108189','EMPEXPORT','CHANGES','Aug 18 2021 12:00AM','ENAVIRESAP',NULL,NULL,NULL,'202108189','Aug 18 2021 12:00AM','Dec 30 1899 12:00AM','202108041',NULL,'','','202108041',dbo.fn_GetTimedKey(),NULL,'us3rVaRES1015',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Navigator Census Export','202108049','EMPEXPORT','ONDEM_XOE',NULL,'ENAVIRESAP',NULL,NULL,NULL,'202108049','Aug  4 2021  2:14PM','Aug  4 2021  2:14PM','202108041',NULL,'','','202108041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Navigator Census Export-Sched','202108049','EMPEXPORT','SCH_ENAVIR',NULL,'ENAVIRESAP',NULL,NULL,NULL,'202108049','Aug  4 2021  2:14PM','Aug  4 2021  2:14PM','202108041',NULL,'','','202108041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Navigator Census Export-Test','202109021','EMPEXPORT','TEST_XOE','Oct  8 2021 12:20PM','ENAVIRESAP',NULL,NULL,NULL,'202109021','Sep  2 2021 12:00AM','Dec 30 1899 12:00AM','202108201','302','','','202108201',dbo.fn_GetTimedKey(),NULL,'us3rVaRES1015',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAVIRESAP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAVIRESAP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAVIRESAP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAVIRESAP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAVIRESAP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAVIRESAP','D10','dbo.U_ENAVIRESAP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ENAVIRESAP
-----------

IF OBJECT_ID('U_dsi_BDM_ENAVIRESAP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENAVIRESAP] (
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
-- Create table U_ENAVIRESAP_Audit
-----------

IF OBJECT_ID('U_ENAVIRESAP_Audit') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);

-----------
-- Create table U_ENAVIRESAP_AuditFields
-----------

IF OBJECT_ID('U_ENAVIRESAP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ENAVIRESAP_DedList
-----------

IF OBJECT_ID('U_ENAVIRESAP_DedList') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENAVIRESAP_drvTbl
-----------

IF OBJECT_ID('U_ENAVIRESAP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] varchar(14) NULL,
    [drvLName] varchar(100) NULL,
    [drvFName] varchar(100) NULL,
    [drvMName] varchar(1) NOT NULL,
    [drvSuffix] varchar(1) NOT NULL,
    [drvDOB] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvClass] char(1) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvDiv] varchar(40) NULL,
    [drvBusUnit] varchar(25) NULL,
    [drvOffice] varchar(255) NULL,
    [drvWrkEmail] varchar(50) NULL,
    [drvPersEmail] varchar(50) NULL,
    [drvPayGrp] char(6) NULL,
    [drvAnnBaseSal] varchar(30) NULL,
    [drvHrlyRate] char(1) NULL,
    [drvHrsPerWk] varchar(30) NULL,
    [drvSalEffDt] date NULL,
    [drvAnnBenSal] varchar(30) NULL,
    [drvAnnBenSalEffDt] datetime NULL,
    [drvACAClass] varchar(1) NOT NULL,
    [drvRepYrW2Earn] varchar(1) NOT NULL,
    [drvStatutoryClass] varchar(1) NOT NULL,
    [drvAdd1] varchar(8000) NULL,
    [drvAdd2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCounty] varchar(1) NOT NULL,
    [drvCountry] char(3) NULL,
    [drvPhNum] varchar(50) NULL,
    [drvPayWrkState] varchar(1) NOT NULL,
    [drvBenWrkState] varchar(1) NOT NULL,
    [drvEmpId] char(9) NULL,
    [drvPayId] char(9) NULL,
    [drvTimeClockId] char(9) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvIsFullTime] varchar(1) NOT NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvIsCollectBargained] varchar(25) NULL,
    [drvLeasedEmp] varchar(1) NOT NULL,
    [drvSeasonalEmp] varchar(1) NOT NULL,
    [drvEEOJobCat] varchar(1) NOT NULL,
    [drvCostCent] varchar(30) NULL,
    [drvWorksOutsideUS] varchar(1) NOT NULL,
    [drvMaritalStat] char(1) NULL,
    [drvTobaccoUser] varchar(1) NOT NULL,
    [drvOnWellness] varchar(1) NOT NULL,
    [drvRace] char(1) NULL,
    [drvRetireDt] varchar(1) NOT NULL,
    [drvOrigHireDt] datetime NULL,
    [drvAffHireDt] datetime NULL,
    [drvTermDt] varchar(30) NOT NULL,
    [drvTermReason] char(6) NULL,
    [drvRehireDt] datetime NULL,
    [drvO2Code] char(10) NULL
);

-----------
-- Create table U_ENAVIRESAP_EEList
-----------

IF OBJECT_ID('U_ENAVIRESAP_EEList') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENAVIRESAP_File
-----------

IF OBJECT_ID('U_ENAVIRESAP_File') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_ENAVIRESAP_PDedHist
-----------

IF OBJECT_ID('U_ENAVIRESAP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_PDedHist] (
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
-- Create table U_ENAVIRESAP_PEarHist
-----------

IF OBJECT_ID('U_ENAVIRESAP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENAVIRESAP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAVIRESAP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Resa Power

Created By: Andy Pineda
Business Analyst: Richard Vars
Create Date: 08/04/2021
Service Request Number: TekP-2021-05-21-0001

Purpose: Navigator Census Export

Revision History
----------------
08/13/2021 by AP:
        - Removed Canadian employees.
        - Fixed dropped '0' for SSN.
        - Removed hour, minutes and am/pm from Salary Effective Date.

08/26/2021 by AP:
        - Fixed comma in job titles.
        - Annual benefit salary changed to YTD. 

09/28/2021 by AP:
        - Fixed fulltime vs parttime mapping.
        - Adjusted termination type.

10/07/2021 by AP:
        - Removed union employees from output.

11/10/2021 by AP:
		- Updated division and business unit.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENAVIRESAP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENAVIRESAP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENAVIRESAP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENAVIRESAP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENAVIRESAP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENAVIRESAP', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENAVIRESAP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENAVIRESAP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENAVIRESAP', 'SCH_ENAVIR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENAVIRESAP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENAVIRESAP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENAVIRESAP';

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
    DELETE FROM dbo.U_ENAVIRESAP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENAVIRESAP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ENAVIRESAP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENAVIRESAP_AuditFields;
    CREATE TABLE dbo.U_ENAVIRESAP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_ENAVIRESAP_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ENAVIRESAP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENAVIRESAP_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ENAVIRESAP_Audit
    FROM dbo.U_ENAVIRESAP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ENAVIRESAP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('ONDEM_XOE','TEST_XOE','SCH_ENAVIR'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ENAVIRESAP_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ENAVIRESAP_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- Create Deduction List
    --==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_ENAVIRESAP_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_ENAVIRESAP_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_ENAVIRESAP_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    ----INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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
    --IF OBJECT_ID('U_ENAVIRESAP_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ENAVIRESAP_PDedHist;
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
    --INTO dbo.U_ENAVIRESAP_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ENAVIRESAP_DedList WITH (NOLOCK)a
    -- --   ON DedCode = PdhDedCode
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
    IF OBJECT_ID('U_ENAVIRESAP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENAVIRESAP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PehEarnCode
        -- Current Payroll Amount/Hours
        ,PehCurAmt = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtYTD = SUM(PehCurAmt)
    INTO dbo.U_ENAVIRESAP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENAVIRESAP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENAVIRESAP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENAVIRESAP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = '="' + EepSSN + '"' -- Leading 0's drop fixed
        --EepSSN
        ,drvLName = EepNameLast
        ,drvFName = EepNameFirst
        ,drvMName = ''
        ,drvSuffix = ''
        ,drvDOB = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'M'
                            WHEN EepGender = 'F' THEN 'F' END
        ,drvHireDate = EecDateOfLastHire
        ,drvClass = EecFullTimeOrPartTime
        ,drvDepartment = O1.OrgDesc
        ,drvDiv = JbcJobFamily
		--CmpCompanyName
        ,drvBusUnit = CmpCompanyName
		--O3.OrgDesc
        ,drvOffice = LocAddressState
        ,drvWrkEmail = EepAddressEMail
        ,drvPersEmail = EepAddressEMailAlternate
        ,drvPayGrp = EecPayGroup
        ,drvAnnBaseSal = CAST(CAST(EecAnnSalary AS DECIMAL(10,2)) AS VARCHAR)
        ,drvHrlyRate = EecSalaryOrHourly
        ,drvHrsPerWk = CAST(EecScheduledWorkHrs AS VARCHAR)
        ,drvSalEffDt = CAST(dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateInJob) AS DATE)
        ,drvAnnBenSal = CAST(CAST(PehCurAmtYTD AS DECIMAL(10,2)) AS VARCHAR)
        ,drvAnnBenSalEffDt = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateInJob) 
        ,drvACAClass = ''
        ,drvRepYrW2Earn = ''
        ,drvStatutoryClass = ''
        ,drvAdd1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAdd2 = REPLACE(EepAddressLine2, ',', '')
        ,drvCity = REPLACE(EepAddressCity, ',', '')
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCounty = ''
        ,drvCountry = EepAddressCountry
        ,drvPhNum = EecPhoneBusinessNumber
        ,drvPayWrkState = ''
        ,drvBenWrkState = ''
        ,drvEmpId = EecEmpNo
        ,drvPayId = EecEmpNo
        ,drvTimeClockId = EecEmpNo
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvIsFullTime = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Y' ELSE 'N' END
        --CASE WHEN EecFullTimeOrPartTime = 'FT' THEN 'Y' ELSE 'N' END
        ,drvIsExempt = ''
        ,drvIsCollectBargained = O2.OrgDesc 
        ,drvLeasedEmp = ''
        ,drvSeasonalEmp = ''
        ,drvEEOJobCat = ''
        ,drvCostCent = CAST(EedGLExpAcct AS VARCHAR)
        ,drvWorksOutsideUS = ''
        ,drvMaritalStat = EepMaritalStatus
        ,drvTobaccoUser = ''
        ,drvOnWellness = ''
        ,drvRace = EepEthnicID
        ,drvRetireDt = ''
        ,drvOrigHireDt = EecDateOfSeniority
        ,drvAffHireDt = EecDateOfSeniority
        ,drvTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvTermReason = CASE WHEN EecEmplStatus = 'T' THEN EecTermType END
        --CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvRehireDt = EecDateOfLastHire
        ,drvO2Code = O2.OrgCode
    INTO dbo.U_ENAVIRESAP_drvTbl
    FROM dbo.U_ENAVIRESAP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ENAVIRESAP_Audit where  audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --JOIN dbo.U_dsi_BDM_ENAVIRESAP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.Company WITH(NOLOCK)
        ON CmpCOID = xCOID
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.U_ENAVIRESAP_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    --LEFT JOIN dbo.EmpDed WITH(NOLOCK)
    --    ON EedEEID = xEEID
    --    AND EedCOID = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, MAX(EedGLExpAcct) EedGLExpAcct
                FROM dbo.EmpDed WITH(NOLOCK)
                GROUP BY EedEEID, EedCOID) Eed ON EedEEID = xEEID AND EedCOID = xCOID
    LEFT JOIN (SELECT PehEEID, PehCOID, SUM(PehCurAmt) AS PehCurAmt, SUM(PehCurAmtYTD) AS PehCurAmtYTD
                FROM dbo.U_ENAVIRESAP_PEarHist WITH(NOLOCK)
                WHERE PehEarnCode IN ('BONUS', 'COM', 'COMM', 'COMMI', 'COMF', 'REG', 'MBNS', 'PTO')
                GROUP BY PehEEID, PehCOID
                ) Peh ON PehEEID = xEEID AND PehCOID = xCOID
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
        ON O1.OrgCode = EecOrgLvl1
        AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN dbo.OrgLevel O3 WITH(NOLOCK)
        ON O3.OrgCode = EecOrgLvl3
        AND O3.OrgLvl = '3'
    WHERE EepAddressCountry <> 'CAN'
    ;

    ---- REMOVE UNION EMPLOYEES ----
    DELETE dbo.U_ENAVIRESAP_drvTbl
    WHERE drvO2Code <> 'NO'

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
ALTER VIEW dbo.dsi_vwENAVIRESAP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENAVIRESAP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENAVIRESAP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107281'
       ,expStartPerControl     = '202107281'
       ,expLastEndPerControl   = '202108049'
       ,expEndPerControl       = '202108049'
WHERE expFormatCode = 'ENAVIRESAP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENAVIRESAP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENAVIRESAP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENAVIRESAP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENAVIRESAP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENAVIRESAP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAVIRESAP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENAVIRESAP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENAVIRESAP', 'UseFileName', 'V', 'Y'


-- End ripout