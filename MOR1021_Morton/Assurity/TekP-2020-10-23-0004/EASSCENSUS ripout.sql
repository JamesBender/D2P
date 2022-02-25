/**********************************************************************************

EASSCENSUS: Assurity Census Export

FormatCode:     EASSCENSUS
Project:        Assurity Census Export
Client ID:      MOR1021
Date/time:      2022-02-22 04:57:47.013
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP3DB04
Database:       ULTIPRO_WPMOIN
Web Filename:   MOR1021_7CNGT_EEHISTORY_EASSCENSUS_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EASSCENSUS_SavePath') IS NOT NULL DROP TABLE dbo.U_EASSCENSUS_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EASSCENSUS'


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
WHERE FormatCode = 'EASSCENSUS'
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
WHERE ExpFormatCode = 'EASSCENSUS'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EASSCENSUS')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EASSCENSUS'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EASSCENSUS'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EASSCENSUS'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EASSCENSUS'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EASSCENSUS'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EASSCENSUS'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EASSCENSUS'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EASSCENSUS'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EASSCENSUS'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('fn_AddDoubleQuotes_EASSCENSUS') IS NOT NULL DROP FUNCTION [dbo].[fn_AddDoubleQuotes_EASSCENSUS];
GO
IF OBJECT_ID('dsi_vwEASSCENSUS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASSCENSUS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASSCENSUS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASSCENSUS];
GO
IF OBJECT_ID('U_EASSCENSUS_File') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_File];
GO
IF OBJECT_ID('U_EASSCENSUS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_EEList];
GO
IF OBJECT_ID('U_EASSCENSUS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_drvTbl];
GO
IF OBJECT_ID('U_EASSCENSUS_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_DedList];
GO
IF OBJECT_ID('U_EASSCENSUS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_AuditFields];
GO
IF OBJECT_ID('U_EASSCENSUS_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASSCENSUS_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EASSCENSUS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASSCENSUS];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASSCENSUS','Assurity Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EASSCENSUSZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASSCENSUSZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASSCENSUSZ0','50','H','01','2',NULL,'Relation',NULL,NULL,'"Relation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASSCENSUSZ0','50','H','01','3',NULL,'Spouse and/or Child SSN',NULL,NULL,'"Spouse and/or Child SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASSCENSUSZ0','50','H','01','4',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASSCENSUSZ0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASSCENSUSZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASSCENSUSZ0','50','H','01','7',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASSCENSUSZ0','50','H','01','8',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASSCENSUSZ0','50','H','01','9',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASSCENSUSZ0','50','H','01','10',NULL,'Group Identifier',NULL,NULL,'"Group Identifier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASSCENSUSZ0','50','H','01','11',NULL,'Hours Worked Per Week',NULL,NULL,'"Hours Worked Per Week"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASSCENSUSZ0','50','H','01','12',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASSCENSUSZ0','50','H','01','13',NULL,'Used tobacco products in last 12 months? YES or NO',NULL,NULL,'"Used tobacco prod in last 12 months"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASSCENSUSZ0','50','H','01','14',NULL,'Height (FT)',NULL,NULL,'"Height (FT)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASSCENSUSZ0','50','H','01','15',NULL,'Height (IN)',NULL,NULL,'"Height (IN)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASSCENSUSZ0','50','H','01','16',NULL,'Weight',NULL,NULL,'"Weight"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASSCENSUSZ0','50','H','01','17',NULL,'Mailing Address1',NULL,NULL,'"Mailing Address1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASSCENSUSZ0','50','H','01','18',NULL,'Mailing Address2',NULL,NULL,'"Mailing Address2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASSCENSUSZ0','50','H','01','19',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASSCENSUSZ0','50','H','01','20',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASSCENSUSZ0','50','H','01','21',NULL,'Zip',NULL,NULL,'"Zip "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASSCENSUSZ0','50','H','01','22',NULL,'Phone Number',NULL,NULL,'"Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EASSCENSUSZ0','50','H','01','23',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EASSCENSUSZ0','50','H','01','24',NULL,'Beneficiary Relationship',NULL,NULL,'"Beneficiary Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EASSCENSUSZ0','50','H','01','25',NULL,'Beneficiary Share Percent',NULL,NULL,'"Beneficiary Share Percent"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EASSCENSUSZ0','50','H','01','26',NULL,'Comprehensive State Specific Health Question',NULL,NULL,'"Comprehensive State Specific Health Question"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EASSCENSUSZ0','50','H','01','27',NULL,'AE Plan Type',NULL,NULL,'"AE Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EASSCENSUSZ0','50','H','01','28',NULL,'AE Insured Option',NULL,NULL,'"AE Insured Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EASSCENSUSZ0','50','H','01','29',NULL,'AE Premium Amount',NULL,NULL,'"AE Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EASSCENSUSZ0','50','H','01','30',NULL,'AE Issue Date',NULL,NULL,'"AE Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EASSCENSUSZ0','50','H','01','31',NULL,'AE Signed Date',NULL,NULL,'"AE Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EASSCENSUSZ0','50','H','01','32',NULL,'AE Termination Date',NULL,NULL,'"AE Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EASSCENSUSZ0','50','H','01','33',NULL,'DI Plan Type',NULL,NULL,'"DI Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EASSCENSUSZ0','50','H','01','34',NULL,'DI Benefit Amount',NULL,NULL,'"DI Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EASSCENSUSZ0','50','H','01','35',NULL,'DI Premium Amount',NULL,NULL,'"DI Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EASSCENSUSZ0','50','H','01','36',NULL,'DI Issue Date',NULL,NULL,'"DI Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EASSCENSUSZ0','50','H','01','37',NULL,'DI Signed Date',NULL,NULL,'"DI Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EASSCENSUSZ0','50','H','01','38',NULL,'DI Termination Date',NULL,NULL,'"DI Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EASSCENSUSZ0','50','H','01','39',NULL,'CI Plan Type',NULL,NULL,'"CI Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EASSCENSUSZ0','50','H','01','40',NULL,'CI Insured Option',NULL,NULL,'"CI Insured Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EASSCENSUSZ0','50','H','01','41',NULL,'CI Benefit Amount',NULL,NULL,'"CI Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EASSCENSUSZ0','50','H','01','42',NULL,'CI Premium Amount',NULL,NULL,'"CI Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EASSCENSUSZ0','50','H','01','43',NULL,'CI Issue Date',NULL,NULL,'"CI Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EASSCENSUSZ0','50','H','01','44',NULL,'CI Signed Date',NULL,NULL,'"CI Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EASSCENSUSZ0','50','H','01','45',NULL,'CI Termination Date',NULL,NULL,'"CI Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EASSCENSUSZ0','50','H','01','46',NULL,'CE Plan Type',NULL,NULL,'"CE Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EASSCENSUSZ0','50','H','01','47',NULL,'CE Insured Option',NULL,NULL,'"CE Insured Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EASSCENSUSZ0','50','H','01','48',NULL,'CE Benefit Amount',NULL,NULL,'"CE Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EASSCENSUSZ0','50','H','01','49',NULL,'CE Premium Amount',NULL,NULL,'"CE Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EASSCENSUSZ0','50','H','01','50',NULL,'CE Issue Date',NULL,NULL,'"CE Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EASSCENSUSZ0','50','H','01','51',NULL,'CE Signed Date',NULL,NULL,'"CE Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EASSCENSUSZ0','50','H','01','52',NULL,'CE Termination Date',NULL,NULL,'"CE Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EASSCENSUSZ0','50','H','01','53',NULL,'HI Plan Type',NULL,NULL,'"HI Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EASSCENSUSZ0','50','H','01','54',NULL,'HI Insured Option',NULL,NULL,'"HI Insured Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EASSCENSUSZ0','50','H','01','55',NULL,'HI Benefit Amount',NULL,NULL,'"HI Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EASSCENSUSZ0','50','H','01','56',NULL,'HI Premium Amount',NULL,NULL,'"HI Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EASSCENSUSZ0','50','H','01','57',NULL,'HI Issue Date',NULL,NULL,'"HI Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EASSCENSUSZ0','50','H','01','58',NULL,'HI Signed Date',NULL,NULL,'"HI Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EASSCENSUSZ0','50','H','01','59',NULL,'HI Termination Date',NULL,NULL,'"HI Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EASSCENSUSZ0','50','H','01','60',NULL,'Life Plan Type',NULL,NULL,'"Life Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EASSCENSUSZ0','50','H','01','61',NULL,'Life Certificate Amount',NULL,NULL,'"Life Certificate Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EASSCENSUSZ0','50','H','01','62',NULL,'Life Insured Option',NULL,NULL,'"Life Insured Option"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EASSCENSUSZ0','50','H','01','63',NULL,'Life Premium Amount',NULL,NULL,'"Life Premium Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EASSCENSUSZ0','50','H','01','64',NULL,'Life Issue Date',NULL,NULL,'"Life Issue Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EASSCENSUSZ0','50','H','01','65',NULL,'Life Signed Date',NULL,NULL,'"Life Signed Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EASSCENSUSZ0','50','H','01','66',NULL,'Level Term Rider Y/N',NULL,NULL,'"Level Term Rider Y/N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EASSCENSUSZ0','50','H','01','67',NULL,'Spouse Cert. Y/N',NULL,NULL,'"Spouse Cert. Y/N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EASSCENSUSZ0','50','H','01','68',NULL,'Spouse Cert. Amount',NULL,NULL,'"Spouse Cert. Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EASSCENSUSZ0','50','H','01','69',NULL,'Child Cert. Y/N',NULL,NULL,'"Child Cert. Y/N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EASSCENSUSZ0','50','H','01','70',NULL,'Child Cert. Amount',NULL,NULL,'"Child Cert. Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EASSCENSUSZ0','50','H','01','71',NULL,'Childrens Term Insurance Rider Y/N',NULL,NULL,'"Childrens Term Insurance Rider Y/N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EASSCENSUSZ0','50','H','01','72',NULL,'Childrens Term Insurance Rider Amount',NULL,NULL,'"Childrens Term Insurance Rider Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EASSCENSUSZ0','50','H','01','73',NULL,'Life Termination Date',NULL,NULL,'"Life Termination Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASSCENSUSZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASSCENSUSZ0','50','D','10','2',NULL,'Relation',NULL,NULL,'"drvRelation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASSCENSUSZ0','50','D','10','3',NULL,'Spouse and/or Child SSN',NULL,NULL,'"drvSpouseandorChildSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASSCENSUSZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASSCENSUSZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASSCENSUSZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASSCENSUSZ0','50','D','10','7',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASSCENSUSZ0','50','D','10','8',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASSCENSUSZ0','50','D','10','9',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASSCENSUSZ0','50','D','10','10',NULL,'Group Identifier',NULL,NULL,'"drvGroupIdentifier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASSCENSUSZ0','50','D','10','11',NULL,'Hours Worked Per Week',NULL,NULL,'"drvHoursWorkedPerWeek"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASSCENSUSZ0','50','D','10','12',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASSCENSUSZ0','50','D','10','13',NULL,'Used tobacco products in last 12 months? YES or NO',NULL,NULL,'"drvUsedtobaccoLast12mths"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASSCENSUSZ0','50','D','10','14',NULL,'Height (FT)',NULL,NULL,'"drvHeightFT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASSCENSUSZ0','50','D','10','15',NULL,'Height (IN)',NULL,NULL,'"drvHeightIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASSCENSUSZ0','50','D','10','16',NULL,'Weight',NULL,NULL,'"drvWeight"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASSCENSUSZ0','50','D','10','17',NULL,'Mailing Address1',NULL,NULL,'"drvMailingAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASSCENSUSZ0','50','D','10','18',NULL,'Mailing Address2',NULL,NULL,'"drvMailingAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASSCENSUSZ0','50','D','10','19',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASSCENSUSZ0','50','D','10','20',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASSCENSUSZ0','50','D','10','21',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASSCENSUSZ0','50','D','10','22',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EASSCENSUSZ0','50','D','10','23',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EASSCENSUSZ0','50','D','10','24',NULL,'Beneficiary Relationship',NULL,NULL,'"drvBeneficiaryRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EASSCENSUSZ0','50','D','10','25',NULL,'Beneficiary Share Percent',NULL,NULL,'"drvBeneficiarySharePercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EASSCENSUSZ0','50','D','10','26',NULL,'Comprehensive State Specific Health Question',NULL,NULL,'"drvCompStateSpecificHlthQues"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EASSCENSUSZ0','50','D','10','27',NULL,'AE Plan Type',NULL,NULL,'"drvAEPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EASSCENSUSZ0','50','D','10','28',NULL,'AE Insured Option',NULL,NULL,'"drvAEInsuredOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EASSCENSUSZ0','50','D','10','29',NULL,'AE Premium Amount',NULL,NULL,'"drvAEPremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EASSCENSUSZ0','50','D','10','30',NULL,'AE Issue Date',NULL,NULL,'"drvAEIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EASSCENSUSZ0','50','D','10','31',NULL,'AE Signed Date',NULL,NULL,'"drvAESignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EASSCENSUSZ0','50','D','10','32',NULL,'AE Termination Date',NULL,NULL,'"drvAETerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EASSCENSUSZ0','50','D','10','33',NULL,'DI Plan Type',NULL,NULL,'"drvDIPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EASSCENSUSZ0','50','D','10','34',NULL,'DI Benefit Amount',NULL,NULL,'"drvDIBenefitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EASSCENSUSZ0','50','D','10','35',NULL,'DI Premium Amount',NULL,NULL,'"drvDIPremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EASSCENSUSZ0','50','D','10','36',NULL,'DI Issue Date',NULL,NULL,'"drvDIIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EASSCENSUSZ0','50','D','10','37',NULL,'DI Signed Date',NULL,NULL,'"drvDISignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EASSCENSUSZ0','50','D','10','38',NULL,'DI Termination Date',NULL,NULL,'"drvDITerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EASSCENSUSZ0','50','D','10','39',NULL,'CI Plan Type',NULL,NULL,'"drvCIPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EASSCENSUSZ0','50','D','10','40',NULL,'CI Insured Option',NULL,NULL,'"drvCIInsuredOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EASSCENSUSZ0','50','D','10','41',NULL,'CI Benefit Amount',NULL,NULL,'"drvCIBenefitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EASSCENSUSZ0','50','D','10','42',NULL,'CI Premium Amount',NULL,NULL,'"drvCIPremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EASSCENSUSZ0','50','D','10','43',NULL,'CI Issue Date',NULL,NULL,'"drvCIIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EASSCENSUSZ0','50','D','10','44',NULL,'CI Signed Date',NULL,NULL,'"drvCISignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EASSCENSUSZ0','50','D','10','45',NULL,'CI Termination Date',NULL,NULL,'"drvCITerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EASSCENSUSZ0','50','D','10','46',NULL,'CE Plan Type',NULL,NULL,'"drvCEPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EASSCENSUSZ0','50','D','10','47',NULL,'CE Insured Option',NULL,NULL,'"drvCEInsuredOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EASSCENSUSZ0','50','D','10','48',NULL,'CE Benefit Amount',NULL,NULL,'"drvCEBenefitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EASSCENSUSZ0','50','D','10','49',NULL,'CE Premium Amount',NULL,NULL,'"drvCEPremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EASSCENSUSZ0','50','D','10','50',NULL,'CE Issue Date',NULL,NULL,'"drvCEIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EASSCENSUSZ0','50','D','10','51',NULL,'CE Signed Date',NULL,NULL,'"drvCESignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EASSCENSUSZ0','50','D','10','52',NULL,'CE Termination Date',NULL,NULL,'"drvCETerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EASSCENSUSZ0','50','D','10','53',NULL,'HI Plan Type',NULL,NULL,'"drvHIPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EASSCENSUSZ0','50','D','10','54',NULL,'HI Insured Option',NULL,NULL,'"drvHIInsuredOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EASSCENSUSZ0','50','D','10','55',NULL,'HI Benefit Amount',NULL,NULL,'"drvHIBenefitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EASSCENSUSZ0','50','D','10','56',NULL,'HI Premium Amount',NULL,NULL,'"drvHIPremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EASSCENSUSZ0','50','D','10','57',NULL,'HI Issue Date',NULL,NULL,'"drvHIIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EASSCENSUSZ0','50','D','10','58',NULL,'HI Signed Date',NULL,NULL,'"drvHISignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EASSCENSUSZ0','50','D','10','59',NULL,'HI Termination Date',NULL,NULL,'"drvHITerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EASSCENSUSZ0','50','D','10','60',NULL,'Life Plan Type',NULL,NULL,'"drvLifePlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EASSCENSUSZ0','50','D','10','61',NULL,'Life Certificate Amount',NULL,NULL,'"drvLifeCertificateAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EASSCENSUSZ0','50','D','10','62',NULL,'Life Insured Option',NULL,NULL,'"drvLifeInsuredOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EASSCENSUSZ0','50','D','10','63',NULL,'Life Premium Amount',NULL,NULL,'"drvLifePremiumAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EASSCENSUSZ0','50','D','10','64',NULL,'Life Issue Date',NULL,NULL,'"drvLifeIssueDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EASSCENSUSZ0','50','D','10','65',NULL,'Life Signed Date',NULL,NULL,'"drvLifeSignedDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EASSCENSUSZ0','50','D','10','66',NULL,'Level Term Rider Y/N',NULL,NULL,'"drvLevelTermRiderYN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EASSCENSUSZ0','50','D','10','67',NULL,'Spouse Cert. Y/N',NULL,NULL,'"drvSpouseCertYN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EASSCENSUSZ0','50','D','10','68',NULL,'Spouse Cert. Amount',NULL,NULL,'"drvSpouseCertAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EASSCENSUSZ0','50','D','10','69',NULL,'Child Cert. Y/N',NULL,NULL,'"drvChildCertYN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EASSCENSUSZ0','50','D','10','70',NULL,'Child Cert. Amount',NULL,NULL,'"drvChildCertAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EASSCENSUSZ0','50','D','10','71',NULL,'Childrens Term Insurance Rider Y/N',NULL,NULL,'"drvChildrensTermInsRider"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EASSCENSUSZ0','50','D','10','72',NULL,'Childrens Term Insurance Rider Amount',NULL,NULL,'"drvChildrensTermInsRiderAmnt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EASSCENSUSZ0','50','D','10','73',NULL,'Life Termination Date',NULL,NULL,'"drvLifeTerminationDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EASSCENSUS_20220222.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102029','EMPEXPORT','OEACTIVE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102029','EMPEXPORT','OEPASSIVE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Assurity Census Export','202102029','EMPEXPORT','ONDEM_XOE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202102029','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202102021',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8IICB,8IIA4',NULL,NULL,NULL,'Assurity Census Export-Sched','202102029','EMPEXPORT','SCH_EASSCE',NULL,'EASSCENSUS',NULL,NULL,NULL,'202202189','Feb  2 2021  9:46AM','Feb  2 2021  9:46AM','202202111',NULL,'','','202102021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Assurity Census Export-Test','202201149','EMPEXPORT','TEST_XOE','Feb  7 2022 10:21AM','EASSCENSUS',NULL,NULL,NULL,'202201149','Jan 14 2022 12:00AM','Dec 30 1899 12:00AM','202201071','299','','','202201071',dbo.fn_GetTimedKey(),NULL,'us3jBeMOR1021',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASSCENSUS','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASSCENSUS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASSCENSUS','D10','dbo.U_EASSCENSUS_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EASSCENSUS
-----------

IF OBJECT_ID('U_dsi_BDM_EASSCENSUS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASSCENSUS] (
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
-- Create table U_EASSCENSUS_Audit
-----------

IF OBJECT_ID('U_EASSCENSUS_Audit') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_Audit] (
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
-- Create table U_EASSCENSUS_AuditFields
-----------

IF OBJECT_ID('U_EASSCENSUS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EASSCENSUS_DedList
-----------

IF OBJECT_ID('U_EASSCENSUS_DedList') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EASSCENSUS_drvTbl
-----------

IF OBJECT_ID('U_EASSCENSUS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(8) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvRelation] varchar(2) NULL,
    [drvSpouseandorChildSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvDateofHire] datetime NULL,
    [drvGroupIdentifier] varchar(1) NOT NULL,
    [drvHoursWorkedPerWeek] varchar(30) NULL,
    [drvAnnualSalary] varchar(30) NULL,
    [drvUsedtobaccoLast12mths] varchar(1) NOT NULL,
    [drvHeightFT] varchar(1) NOT NULL,
    [drvHeightIN] varchar(1) NOT NULL,
    [drvWeight] varchar(1) NOT NULL,
    [drvMailingAddress1] varchar(8000) NULL,
    [drvMailingAddress2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvBeneficiaryRelationship] char(3) NULL,
    [drvBeneficiarySharePercent] varchar(1) NOT NULL,
    [drvCompStateSpecificHlthQues] varchar(255) NULL,
    [drvAEPlanType] varchar(8) NULL,
    [drvAEInsuredOption] varchar(3) NULL,
    [drvAEPremiumAmount] nvarchar(4000) NULL,
    [drvAEIssueDate] datetime NULL,
    [drvAESignedDate] datetime NULL,
    [drvAETerminationDate] datetime NULL,
    [drvDIPlanType] varchar(1) NOT NULL,
    [drvDIBenefitAmount] varchar(1) NOT NULL,
    [drvDIPremiumAmount] varchar(1) NOT NULL,
    [drvDIIssueDate] int NULL,
    [drvDISignedDate] int NULL,
    [drvDITerminationDate] int NULL,
    [drvCIPlanType] varchar(6) NULL,
    [drvCIInsuredOption] varchar(3) NULL,
    [drvCIBenefitAmount] varchar(5) NULL,
    [drvCIPremiumAmount] nvarchar(4000) NULL,
    [drvCIIssueDate] datetime NULL,
    [drvCISignedDate] datetime NULL,
    [drvCITerminationDate] datetime NULL,
    [drvCEPlanType] varchar(1) NOT NULL,
    [drvCEInsuredOption] varchar(1) NOT NULL,
    [drvCEBenefitAmount] varchar(1) NOT NULL,
    [drvCEPremiumAmount] varchar(1) NOT NULL,
    [drvCEIssueDate] int NULL,
    [drvCESignedDate] int NULL,
    [drvCETerminationDate] int NULL,
    [drvHIPlanType] varchar(2) NULL,
    [drvHIInsuredOption] varchar(3) NULL,
    [drvHIBenefitAmount] varchar(256) NULL,
    [drvHIPremiumAmount] nvarchar(4000) NULL,
    [drvHIIssueDate] datetime NULL,
    [drvHISignedDate] datetime NULL,
    [drvHITerminationDate] datetime NULL,
    [drvLifePlanType] varchar(1) NOT NULL,
    [drvLifeCertificateAmount] varchar(1) NOT NULL,
    [drvLifeInsuredOption] varchar(1) NOT NULL,
    [drvLifePremiumAmount] varchar(1) NOT NULL,
    [drvLifeIssueDate] int NULL,
    [drvLifeSignedDate] int NULL,
    [drvLevelTermRiderYN] varchar(1) NOT NULL,
    [drvSpouseCertYN] varchar(1) NOT NULL,
    [drvSpouseCertAmount] varchar(1) NOT NULL,
    [drvChildCertYN] varchar(1) NOT NULL,
    [drvChildCertAmount] varchar(1) NOT NULL,
    [drvChildrensTermInsRider] varchar(1) NOT NULL,
    [drvChildrensTermInsRiderAmnt] varchar(1) NOT NULL,
    [drvLifeTerminationDate] int NULL
);

-----------
-- Create table U_EASSCENSUS_EEList
-----------

IF OBJECT_ID('U_EASSCENSUS_EEList') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EASSCENSUS_File
-----------

IF OBJECT_ID('U_EASSCENSUS_File') IS NULL
CREATE TABLE [dbo].[U_EASSCENSUS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASSCENSUS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Morton Industries LLC

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 02/02/2021
Service Request Number: TekP-2020-10-23-0004

Purpose: Assurity Census Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASSCENSUS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASSCENSUS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASSCENSUS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASSCENSUS', 'SCH_EASSCE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASSCENSUS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EASSCENSUS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASSCENSUS';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EASSCENSUS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASSCENSUS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EASSCENSUS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_AuditFields;
    CREATE TABLE dbo.U_EASSCENSUS_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EASSCENSUS_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EASSCENSUS_AuditFields VALUES ('EmpDed','EedDatetimeChanged');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EASSCENSUS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_Audit;
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
    INTO dbo.U_EASSCENSUS_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EASSCENSUS_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EASSCENSUS_Audit ON dbo.U_EASSCENSUS_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EASSCENSUS_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EASSCENSUS_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ASHOS,ASACC,ECI10,ECI20,ECI30,ECS10,ECS20,ECS30';

    IF OBJECT_ID('U_EASSCENSUS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASSCENSUS_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard')

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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EASSCENSUS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASSCENSUS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASSCENSUS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort =  ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvRelation =  CASE WHEN bdmRectype= 'EMP' THEN 'EE'
                             WHEN bdmRectype = 'DEP' and Conrelationship = 'SPS' THEN 'SP'
                             WHEN bdmRecType = 'DEP' and Conrelationship = 'CHL' THEN 'CH'
                         END
        ,drvSpouseandorChildSSN = ConSSN
        ,drvFirstName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvLastName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMiddleName = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvDateofHire = EecDateOfLastHire
        ,drvGroupIdentifier = '' -- leave blank
        ,drvHoursWorkedPerWeek = CONVERT(VARCHAR, CONVERT(DECIMAL(10,0), EecScheduledWorkHrs))
        ,drvAnnualSalary = CONVERT(VARCHAR, CONVERT(MONEY, EecAnnSalary))
        ,drvUsedtobaccoLast12mths = '' -- leave blank
        ,drvHeightFT = '' -- leave blank
        ,drvHeightIN = '' -- leave blank
        ,drvWeight = '' -- leave blank
        ,drvMailingAddress1 =[dbo].[fn_AddDoubleQuotes_EASSCENSUS](EepAddressLine1)
        ,drvMailingAddress2 = [dbo].[fn_AddDoubleQuotes_EASSCENSUS](EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvBeneficiaryRelationship = ConRelationship
        ,drvBeneficiarySharePercent = ''
        ,drvCompStateSpecificHlthQues = EepAddressState
        ,drvAEPlanType = BdmAEPlanType
        ,drvAEInsuredOption = BdmAEInsuredOption
        ,drvAEPremiumAmount =    CASE WHEN BdmAEPlanType <> '' THEN
                                    CASE WHEN AeAmount IS NOT NULL THEN FORMAT(AeAmount,'#0.00') 
                                    ELSE (
                                            SELECT TOP 1 FORMAT(ISNULL(CorEERate*100, -1), '#0.00')
                                            FROM dbo.OptRate WITH (NOLOCK)
                                            WHERE CorDedCode = 'ASACC'
                                                AND CorBenOption = BdmAEBenOption
                                            ORDER BY CorEffDate DESC)
                                    END    
                                END
                                -- JCB
        ,drvAEIssueDate = BdmAEIssueDate
        ,drvAESignedDate = BdmAESignedDate
        ,drvAETerminationDate =  BdmAETerminationDate
        ,drvDIPlanType = '' -- leave blank
        ,drvDIBenefitAmount =  '' -- leave blank
        ,drvDIPremiumAmount =  '' -- leave blank
        ,drvDIIssueDate =  NULL -- leave blank
        ,drvDISignedDate =  NULL -- leave blank
        ,drvDITerminationDate = NULL -- leave blank
        ,drvCIPlanType = BdmCIPlanType
        ,drvCIInsuredOption = BdmCIInsuredOption
                                --CASE WHEN Bdmdedcode = 'ECI10' THEN
                                 -- CASE
                                    --WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    --WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    --WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    --WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                 -- END
                              --END
        ,drvCIBenefitAmount = BdmCIBenefitAmount
        ,drvCIPremiumAmount =    CASE WHEN BdmCIDedCode IS NOT NULL THEN
                                    CASE WHEN CiAmount IS NOT NULL THEN FORMAT(CiAmount, '#0.00')
                                    ELSE (
                                            SELECT TOP 1 FORMAT(ISNULL(CorEERate*100, -1), '#0.00')
                                            FROM dbo.OptRate WITH (NOLOCK)
                                            WHERE CorDedCode = BdmCIDedCode
                                                AND CorBenOption = BdmCIBenOption
                                            ORDER BY CorEffDate DESC)
                                    END
                                END
        --FORMAT(CiAmount, '#0.00')
        --BdmCIDedCode
        ,drvCIIssueDate = BdmCIIssueDate
        ,drvCISignedDate = BdmCISignedDate
        ,drvCITerminationDate = BdmCITerminationDate
        ,drvCEPlanType = '' -- leave blank 
        ,drvCEInsuredOption = '' -- leave blank 
        ,drvCEBenefitAmount = '' -- leave blank 
        ,drvCEPremiumAmount = '' -- leave blank 
        ,drvCEIssueDate = NULL -- leave blank 
        ,drvCESignedDate = NULL -- leave blank 
        ,drvCETerminationDate = NULL -- leave blank 
        ,drvHIPlanType = BdmHIPlanType
        ,drvHIInsuredOption = BdmHIInsuredOption
        ,drvHIBenefitAmount = BdmHIBenefitAmount
        ,drvHIPremiumAmount =    CASE WHEN BdmHIPlanType <> '' THEN
                                    CASE WHEN HiAmount IS NOT NULL THEN  FORMAT(HiAmount, '#0.00') 
                                    ELSE (
                                            SELECT TOP 1 FORMAT(ISNULL(CorEERate*100, -1), '#0.00')
                                            FROM dbo.OptRate WITH (NOLOCK)
                                            WHERE CorDedCode = 'ASHOS'
                                                AND CorBenOption = BdmHiBenOption
                                            ORDER BY CorEffDate DESC)                                                            
                                    END                                
                                END
        ,drvHIIssueDate =  BdmHIIssueDate
        ,drvHISignedDate = BdmHISignedDate
        ,drvHITerminationDate = BdmHITerminationDate
        ,drvLifePlanType = '' -- leave blank 
        ,drvLifeCertificateAmount = '' -- leave blank 
        ,drvLifeInsuredOption =  '' -- leave blank 
        ,drvLifePremiumAmount = '' -- leave blank
        ,drvLifeIssueDate = NULL -- leave blank 
        ,drvLifeSignedDate = NULL -- leave blank  
        ,drvLevelTermRiderYN = '' -- leave blank 
        ,drvSpouseCertYN = '' -- leave blank 
        ,drvSpouseCertAmount = '' -- leave blank 
        ,drvChildCertYN = '' -- leave blank 
        ,drvChildCertAmount = '' -- leave blank 
        ,drvChildrensTermInsRider = '' -- leave blank 
        ,drvChildrensTermInsRiderAmnt = '' -- leave blank 
        ,drvLifeTerminationDate = NULL -- leave blank 
    INTO dbo.U_EASSCENSUS_drvTbl
    FROM dbo.U_EASSCENSUS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (SELECT  BdmEEID, BdmCOID, BdmDepRecID
                ,BdmRecType = MAX(bdmRectype)
                ,BdmAEPlanType = MAX(CASE WHEN bdmdedcode = 'ASACC' THEN 'Accident' ELSE '' END)
                ,BdmAEBenOption = MAX(CASE WHEN BdmDedCode = 'ASACC' THEN BdmBenOption END)
                ,BdmAEInsuredOption = MAX(CASE WHEN bdmdedcode = 'ASACC' THEN
                                  CASE
                                    WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                  END
                              END)
        ,BdmAEIssueDate = MAX(CASE WHEN bdmdedcode = 'ASACC' THEN BdmBenStartDate ELSE NULL END)
        ,BdmAESignedDate = MAX(CASE WHEN bdmdedcode = 'ASACC' THEN  DATEADD(D, -1, BdmBenStartDate) ELSE NULL END)
        ,BdmAETerminationDate = MAX(CASE WHEN bdmdedcode = 'ASACC' THEN bdmBenStopDate ELSE NULL END)  
        ,BdmCIDedCode = MAX(CASE WHEN BdmDedCode IN ('ECI10','ECS10','ECI20','ECS20','ECI30','ECS30') THEN BdmDedCode END)
        ,BdmCIBenOption = MAX(CASE WHEN BdmDedCode IN ('ECI10','ECS10','ECI20','ECS20','ECI30','ECS30') THEN BdmBenOption END)
        ,BdmCIPlanType = MAX(CASE 
                            WHEN Bdmdedcode IN ('ECI10','ECS10') THEN 'CI 10K'
                            WHEN Bdmdedcode IN ('ECI20','ECS20') THEN 'CI 20K'
                            WHEN Bdmdedcode IN ('ECI30','ECS30') THEN 'CI 30K'
                         END)
        ,BdmCIInsuredOption = MAX(CASE 
                                WHEN Bdmdedcode IN('ECI10','ECI20','ECI30') THEN 'EE'
                                WHEN Bdmdedcode IN ('ECS10','ECS20','ECS30') THEN 'ESP'
                             END )
        ,BdmCIBenefitAmount = MAX(CASE 
                                WHEN Bdmdedcode IN ('ECI10','ECS10') THEN '10000'
                                WHEN Bdmdedcode IN ('ECI20','ECS20') THEN '20000'
                                WHEN Bdmdedcode IN ('ECI30','ECS30') THEN '30000'
                              END)
        ,BdmCIIssueDate = MAX(CASE WHEN Bdmdedcode IN ('ECI10','ECS10','ECS30','ECI20','ECI30') THEN bdmBenStartDate ELSE NULL END) -- TODO use the audit date (per vendor: The signed date would be the date that is was last modified)
        ,BdmCISignedDate = MAX(CASE WHEN Bdmdedcode IN ('ECI10','ECS10','ECS30','ECI20','ECI30') THEN DATEADD(D, -1, bdmBenStartDate) ELSE NULL END )
        ,BdmCITerminationDate = MAX(CASE WHEN Bdmdedcode IN ('ECI10','ECS10','ECS30') THEN BdmBenStopDate ELSE NULL END )
        ,BdmHIPlanType = MAX(CASE WHEN BdmDedCode = 'ASHOS' THEN 'HI' ELSE '' END)
        ,BdmHIInsuredOption = MAX(CASE WHEN Bdmdedcode = 'ASHOS' THEN
                                  CASE
                                    WHEN BdmBenOption IN ('EE', 'EET', 'IND', 'SING') THEN 'EE'
                                    WHEN BdmBenOption IN ('EES', 'EEDP', 'EESTSPS2', 'SPS3') THEN 'ESP'
                                    WHEN BdmBenOption IN ('EEC', 'EECT')  THEN 'ECH'
                                    WHEN BdmBenOption IN ('EEF', 'EEDPF', 'EEFT', 'FAM')  THEN 'FAM' 
                                  END
                              END)
        ,BdmHIBenOption = MAX(CASE WHEN BdmDedCode = 'ASHOS' THEN BdmBenOption END)
        ,BdmHIBenefitAmount = MAX(CASE WHEN Bdmdedcode = 'ASHOS' THEN  
                                        CASE WHEN BdmDedCode = 'ASHOS' and bdmRecType = 'DEP' THEN bdmUSGField1
                                             WHEN BdmDedCode = 'ASHOS' and bdmRecType = 'EMP' THEN bdmUSGField1
                                        END
                                    END)
        ,BdmHIIssueDate =  MAX(CASE WHEN Bdmdedcode = 'ASHOS' THEN BdmBenStartDate ELSE NULL END)  -- TODO use the audit date (per vendor: The signed date would be the date that is was last modified)
        ,BdmHISignedDate = MAX(CASE WHEN Bdmdedcode = 'ASHOS' THEN  DATEADD(D, -1, bdmBenStartDate) ELSE NULL END)  --CASE WHEN Bdmdedcode = 'ASHOS' THEN bdmBenStartDate ELSE NULL END
        ,BdmHITerminationDate = MAX(CASE WHEN Bdmdedcode = 'ASHOS' THEN bdmBenStopDate ELSE NULL END)
    FROM dbo.U_DSI_BDM_EASSCENSUS WITH (NOLOCK)
    GROUP BY BdmEEID, BdmCOID, BdmDepRecID
    ) Benefits
    ON BdmEEID = xEEID 
    and BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON conSystemId = BdmDepRecID
       AND xEEID = ConEEID
    LEFT JOIN (
                SELECT BcaEEID, BcaCOID
                    ,SUM(CASE WHEN BcaDedCode = 'ASACC' AND BcaEEAmt IS NOT NULL THEN BcaEEAmt END) AS AeAmount
                    ,SUM(CASE WHEN BcaDedCode IN ('ECI10','ECS10','ECI20','ECI30') AND BcaEEAmt IS NOT NULL THEN BcaEEAmt END) AS CiAmount
                    ,SUM(CASE WHEN BcaDedCode = 'ASHOS' AND BcaEEAmt IS NOT NULL THEN BcaEEAmt END) AS HiAmount
                FROM dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
                WHERE BcaFormatCode like '%EASSCENSUS%'
                AND BcaDedCode IN ('ASACC','ECI10','ECS10','ECI20','ECI30','ASHOS')
                GROUP BY BcaEEID, BcaCOID) AS Bca
        ON BcaEEID = xEEID
        AND BcaCOID = xCOID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
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
ALTER VIEW dbo.dsi_vwEASSCENSUS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASSCENSUS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASSCENSUS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101261'
       ,expStartPerControl     = '202101261'
       ,expLastEndPerControl   = '202102029'
       ,expEndPerControl       = '202102029'
WHERE expFormatCode = 'EASSCENSUS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASSCENSUS_Export AS      SELECT TOP 200000000 Data FROM dbo.U_EASSCENSUS_File WITH (NOLOCK)     ORDER BY RIGHT(RecordSet,2), InitialSort
GO
CREATE FUNCTION [dbo].[fn_AddDoubleQuotes_EASSCENSUS] (@InputString VARCHAR(MAX))
RETURNS VARCHAR(8000)
WITH EXECUTE AS CALLER
AS

/************************************************************

Created By: Ethan Lee
Create Date: 06/13/2014

Purpose: Wrap string in double quotes if the string contains a comma.

Command: PRINT dbo.fn_AddDoubleQuotes('He,llo')

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/

BEGIN

    IF CHARINDEX(',',@InputString) > 0    RETURN '"' + @InputString + '"'
    
    RETURN @InputString
    
END

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EASSCENSUS' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EASSCENSUS'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EASSCENSUS'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASSCENSUS', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EASSCENSUS', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASSCENSUS', 'UseFileName', 'V', 'Y'


-- End ripout