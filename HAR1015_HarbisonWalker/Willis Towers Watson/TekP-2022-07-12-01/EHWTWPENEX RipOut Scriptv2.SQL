/**********************************************************************************

EHWTWPENEX: Willis Towers Watson Pension Export

FormatCode:     EHWTWPENEX
Project:        Willis Towers Watson Pension Export
Client ID:      HAR1015
Date/time:      2022-10-04 09:55:25.160
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E32
Server:         E3SUP2DB03
Database:       ULTIPRO_HAWAI
Web Filename:   HAR1015_9D1B0_EEHISTORY_EHWTWPENEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHWTWPENEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EHWTWPENEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHWTWPENEX'


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
WHERE FormatCode = 'EHWTWPENEX'
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
WHERE ExpFormatCode = 'EHWTWPENEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHWTWPENEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHWTWPENEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHWTWPENEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHWTWPENEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHWTWPENEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHWTWPENEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHWTWPENEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHWTWPENEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHWTWPENEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHWTWPENEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHWTWPENEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHWTWPENEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHWTWPENEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHWTWPENEX];
GO
IF OBJECT_ID('U_EHWTWPENEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_PEarHist];
GO
IF OBJECT_ID('U_EHWTWPENEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_PDedHist];
GO
IF OBJECT_ID('U_EHWTWPENEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_Header];
GO
IF OBJECT_ID('U_EHWTWPENEX_File') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_File];
GO
IF OBJECT_ID('U_EHWTWPENEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_EEList];
GO
IF OBJECT_ID('U_EHWTWPENEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_drvTbl];
GO
IF OBJECT_ID('U_EHWTWPENEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_DedList];
GO
IF OBJECT_ID('U_EHWTWPENEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_AuditFields];
GO
IF OBJECT_ID('U_EHWTWPENEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHWTWPENEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHWTWPENEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHWTWPENEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHWTWPENEX','Willis Towers Watson Pension Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EHWTWPENEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHWTWPENEXZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHWTWPENEXZ0','50','H','01','2',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHWTWPENEXZ0','50','H','01','3',NULL,'Honorific',NULL,NULL,'"Honorific"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHWTWPENEXZ0','50','H','01','4',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHWTWPENEXZ0','50','H','01','5',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHWTWPENEXZ0','50','H','01','6',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHWTWPENEXZ0','50','H','01','7',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHWTWPENEXZ0','50','H','01','8',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHWTWPENEXZ0','50','H','01','9',NULL,'Date of Death',NULL,NULL,'"Date of Death"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHWTWPENEXZ0','50','H','01','10',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHWTWPENEXZ0','50','H','01','11',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHWTWPENEXZ0','50','H','01','12',NULL,'Address Type',NULL,NULL,'"Address Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHWTWPENEXZ0','50','H','01','13',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHWTWPENEXZ0','50','H','01','14',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHWTWPENEXZ0','50','H','01','15',NULL,'Address Line 3',NULL,NULL,'"Address Line 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHWTWPENEXZ0','50','H','01','16',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHWTWPENEXZ0','50','H','01','17',NULL,'State',NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHWTWPENEXZ0','50','H','01','18',NULL,'Zip code',NULL,NULL,'"Zip code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHWTWPENEXZ0','50','H','01','19',NULL,'Contact Name',NULL,NULL,'"Contact Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHWTWPENEXZ0','50','H','01','20',NULL,'Phone',NULL,NULL,'"Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHWTWPENEXZ0','50','H','01','21',NULL,'Fax',NULL,NULL,'"Fax"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHWTWPENEXZ0','50','H','01','22',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHWTWPENEXZ0','50','H','01','23',NULL,'Bad Address Flag',NULL,NULL,'"Bad Address Flag"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHWTWPENEXZ0','50','H','01','24',NULL,'Foreign Address Flag',NULL,NULL,'"Foreign Address Flag"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHWTWPENEXZ0','50','H','01','25',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHWTWPENEXZ0','50','H','01','26',NULL,'Adjusted Service Date',NULL,NULL,'"Adjusted Service Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHWTWPENEXZ0','50','H','01','27',NULL,'Location ID',NULL,NULL,'"Location ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHWTWPENEXZ0','50','H','01','28',NULL,'Pay Rate Type',NULL,NULL,'"Pay Rate Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHWTWPENEXZ0','50','H','01','29',NULL,'Union Code',NULL,NULL,'"Union Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHWTWPENEXZ0','50','H','01','30',NULL,'Union ID',NULL,NULL,'"Union ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHWTWPENEXZ0','50','H','01','31',NULL,'Union Effective Date',NULL,NULL,'"Union Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHWTWPENEXZ0','50','H','01','32',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHWTWPENEXZ0','50','H','01','33',NULL,'Vacation Pay',NULL,NULL,'"Vacation Pay"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHWTWPENEXZ0','50','H','01','34',NULL,'QDRO Flag',NULL,NULL,'"QDRO Flag"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHWTWPENEXZ0','50','H','01','35',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHWTWPENEXZ0','50','H','01','36',NULL,'Payroll Status Effective Date',NULL,NULL,'"Payroll Status Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHWTWPENEXZ0','50','H','01','37',NULL,'Status Code',NULL,NULL,'"Status Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHWTWPENEXZ0','50','H','01','38',NULL,'Plan Location',NULL,NULL,'"Plan Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHWTWPENEXZ0','50','H','01','39',NULL,'Sub Plan (Security Context #1)',NULL,NULL,'"drvSubPlanSecurityContext1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHWTWPENEXZ0','50','H','01','40',NULL,'Actual Location (Securtiy Context #2)',NULL,NULL,'"drvActualLocationSecCont2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHWTWPENEXZ0','50','H','01','41',NULL,'Security Context #3',NULL,NULL,'"drvSecurityContext3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHWTWPENEXZ0','50','H','01','42',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHWTWPENEXZ0','50','H','01','43',NULL,'Pension Plan',NULL,NULL,'"Pension Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHWTWPENEXZ0','50','H','01','44',NULL,'Pension Status Effective Date',NULL,NULL,'"Pension Status Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHWTWPENEXZ0','50','H','01','45',NULL,'Pension Status',NULL,NULL,'"Pension Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHWTWPENEXZ0','50','H','01','46',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHWTWPENEXZ0','50','H','01','47',NULL,'Earnings Begin Date',NULL,NULL,'"Earnings Begin Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHWTWPENEXZ0','50','H','01','48',NULL,'Earnings End Date',NULL,NULL,'"Earnings End Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHWTWPENEXZ0','50','H','01','49',NULL,'Comp Class',NULL,NULL,'"Comp Class"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHWTWPENEXZ0','50','H','01','50',NULL,'Currency Code',NULL,NULL,'"Currency Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHWTWPENEXZ0','50','H','01','51',NULL,'Qualified Pensionable Earnings',NULL,NULL,'"drvQualifiedPensionEarnings"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHWTWPENEXZ0','50','H','01','52',NULL,'Pay Rate',NULL,NULL,'"Pay Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHWTWPENEXZ0','50','H','01','53',NULL,'YTD Compensation',NULL,NULL,'"YTD Compensation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHWTWPENEXZ0','50','H','01','54',NULL,'Hours',NULL,NULL,'"Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHWTWPENEXZ0','50','H','01','55',NULL,'YTD Hours',NULL,NULL,'"YTD Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHWTWPENEXZ0','50','H','01','56',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHWTWPENEXZ0','50','H','01','57',NULL,'Pension Plan',NULL,NULL,'"Pension Plan"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHWTWPENEXZ0','50','H','01','58',NULL,'EE Cont Code',NULL,NULL,'"EE Cont Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHWTWPENEXZ0','50','H','01','59',NULL,'Contribution Date',NULL,NULL,'"Contribution Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHWTWPENEXZ0','50','H','01','60',NULL,'Contributions',NULL,NULL,'"Contributions"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHWTWPENEXZ0','50','H','01','61',NULL,'Year (South Shore Only)',NULL,NULL,'"drvYearSouthShoreOnly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHWTWPENEXZ0','50','H','01','62',NULL,'Accrual Rate (South Shore Only)',NULL,NULL,'"drvAccrualRateSouthShoreOnly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHWTWPENEXZ0','50','H','01','63',NULL,'Jan Apr Cal Yr Months (South Shore Only)',NULL,NULL,'"drvJanAprCalYrMonthSouthShore"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHWTWPENEXZ0','50','H','01','64',NULL,'May Dec Cal Yr Months (South Shore Only)',NULL,NULL,'"drvMayDecCalYrMonthSouthShore"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHWTWPENEXZ0','50','H','01','65',NULL,'Annual Accrual (South Shore Only)',NULL,NULL,'"drvAnnAccrualSouthShore"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHWTWPENEXZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHWTWPENEXZ0','50','D','10','2',NULL,'Country',NULL,NULL,'"US"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHWTWPENEXZ0','50','D','10','3',NULL,'Honorific',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHWTWPENEXZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHWTWPENEXZ0','50','D','10','5',NULL,'Middle Name',NULL,NULL,'"drvNMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHWTWPENEXZ0','50','D','10','6',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHWTWPENEXZ0','50','D','10','7',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHWTWPENEXZ0','50','D','10','8',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHWTWPENEXZ0','50','D','10','9',NULL,'Date of Death',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHWTWPENEXZ0','50','D','10','10',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHWTWPENEXZ0','50','D','10','11',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHWTWPENEXZ0','50','D','10','12',NULL,'Address Type',NULL,NULL,'"RES"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHWTWPENEXZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHWTWPENEXZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHWTWPENEXZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHWTWPENEXZ0','50','D','10','16',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHWTWPENEXZ0','50','D','10','17',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHWTWPENEXZ0','50','D','10','18',NULL,'Zip code',NULL,NULL,'"drvAddressZipcode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHWTWPENEXZ0','50','D','10','19',NULL,'Contact Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHWTWPENEXZ0','50','D','10','20',NULL,'Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHWTWPENEXZ0','50','D','10','21',NULL,'Fax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHWTWPENEXZ0','50','D','10','22',NULL,'Email',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHWTWPENEXZ0','50','D','10','23',NULL,'Bad Address Flag',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHWTWPENEXZ0','50','D','10','24',NULL,'Foreign Address Flag',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHWTWPENEXZ0','50','D','10','25',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHWTWPENEXZ0','50','D','10','26',NULL,'Adjusted Service Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHWTWPENEXZ0','50','D','10','27',NULL,'Location ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHWTWPENEXZ0','50','D','10','28',NULL,'Pay Rate Type',NULL,NULL,'"drvPayRateType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHWTWPENEXZ0','50','D','10','29',NULL,'Union Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHWTWPENEXZ0','50','D','10','30',NULL,'Union ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHWTWPENEXZ0','50','D','10','31',NULL,'Union Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHWTWPENEXZ0','50','D','10','32',NULL,'Employee Type',NULL,NULL,'"REG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHWTWPENEXZ0','50','D','10','33',NULL,'Vacation Pay',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHWTWPENEXZ0','50','D','10','34',NULL,'QDRO Flag',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHWTWPENEXZ0','50','D','10','35',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHWTWPENEXZ0','50','D','10','36',NULL,'Payroll Status Effective Date',NULL,NULL,'"drvPayrollStatusEffectiveDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHWTWPENEXZ0','50','D','10','37',NULL,'Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHWTWPENEXZ0','50','D','10','38',NULL,'Plan Location',NULL,NULL,'"drvPlanLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHWTWPENEXZ0','50','D','10','39',NULL,'Sub Plan (Security Context #1)',NULL,NULL,'"drvSubPlanSecurityContext1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHWTWPENEXZ0','50','D','10','40',NULL,'Actual Location (Securtiy Context #2)',NULL,NULL,'"drvActualLocSecurtiyContext2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHWTWPENEXZ0','50','D','10','41',NULL,'Security Context #3',NULL,NULL,'"drvSecurityContex3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHWTWPENEXZ0','50','D','10','42',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHWTWPENEXZ0','50','D','10','43',NULL,'Pension Plan',NULL,NULL,'"drvPensionPlan"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHWTWPENEXZ0','50','D','10','44',NULL,'Pension Status Effective Date',NULL,NULL,'"drvPensionStatusEffectiveDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHWTWPENEXZ0','50','D','10','45',NULL,'Pension Status',NULL,NULL,'"drvPensionStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHWTWPENEXZ0','50','D','10','46',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHWTWPENEXZ0','50','D','10','47',NULL,'Earnings Begin Date',NULL,NULL,'"drvEarningsBeginDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHWTWPENEXZ0','50','D','10','48',NULL,'Earnings End Date',NULL,NULL,'"drvEarningsEndDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHWTWPENEXZ0','50','D','10','49',NULL,'Comp Class',NULL,NULL,'"ANNUAL"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHWTWPENEXZ0','50','D','10','50',NULL,'Currency Code',NULL,NULL,'"DOLLAR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHWTWPENEXZ0','50','D','10','51',NULL,'Qualified Pensionable Earnings',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHWTWPENEXZ0','50','D','10','52',NULL,'Pay Rate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHWTWPENEXZ0','50','D','10','53',NULL,'YTD Compensation',NULL,NULL,'"drvYTDCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHWTWPENEXZ0','50','D','10','54',NULL,'Hours',NULL,NULL,'"drvHours"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHWTWPENEXZ0','50','D','10','55',NULL,'YTD Hours',NULL,NULL,'"drvYTDHours"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHWTWPENEXZ0','50','D','10','56',NULL,'Social Security Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHWTWPENEXZ0','50','D','10','57',NULL,'Pension Plan',NULL,NULL,'"HWHRLY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHWTWPENEXZ0','50','D','10','58',NULL,'EE Cont Code',NULL,NULL,'"drvEEContCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHWTWPENEXZ0','50','D','10','59',NULL,'Contribution Date',NULL,NULL,'"drvContributionDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHWTWPENEXZ0','50','D','10','60',NULL,'Contributions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHWTWPENEXZ0','50','D','10','61',NULL,'Year (South Shore Only)',NULL,NULL,'"drvYearSouthShoreOnly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHWTWPENEXZ0','50','D','10','62',NULL,'Accrual Rate (South Shore Only)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHWTWPENEXZ0','50','D','10','63',NULL,'Jan Apr Cal Yr Months (South Shore Only)',NULL,NULL,'"drvJanAprCalYrMonthsSSOnly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHWTWPENEXZ0','50','D','10','64',NULL,'May Dec Cal Yr Months (South Shore Only)',NULL,NULL,'"drvMayDecCalYrMonthsSSOnly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHWTWPENEXZ0','50','D','10','65',NULL,'Annual Accrual (South Shore Only)',NULL,NULL,'"drvAnnualAccrualSSOnly"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHWTWPENEX_20221004.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208319','EMPEXPORT','OEACTIVE',NULL,'EHWTWPENEX',NULL,NULL,NULL,'202208319','Sep 21 2022  2:56PM','Sep 21 2022  2:56PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208319','EMPEXPORT','OEPASSIVE',NULL,'EHWTWPENEX',NULL,NULL,NULL,'202208319','Sep 21 2022  2:56PM','Sep 21 2022  2:56PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Willis Towers Watson Pension E','202208319','EMPEXPORT','ONDEM_XOE',NULL,'EHWTWPENEX',NULL,NULL,NULL,'202208319','Sep 21 2022  2:56PM','Sep 21 2022  2:56PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Willis Towers Watson Pen-Sched','202208319','EMPEXPORT','SCH_EHWTWP',NULL,'EHWTWPENEX',NULL,NULL,NULL,'202208319','Sep 21 2022  2:56PM','Sep 21 2022  2:56PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Willis Towers Watson Pen-Test','202208319','EMPEXPORT','TEST_XOE',NULL,'EHWTWPENEX',NULL,NULL,NULL,'202208319','Sep 21 2022  2:56PM','Sep 21 2022  2:56PM','202208011',NULL,'','','202208011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHWTWPENEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHWTWPENEX','H01','dbo.U_EHWTWPENEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHWTWPENEX','D10','dbo.U_EHWTWPENEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHWTWPENEX
-----------

IF OBJECT_ID('U_dsi_BDM_EHWTWPENEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHWTWPENEX] (
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
-- Create table U_EHWTWPENEX_Audit
-----------

IF OBJECT_ID('U_EHWTWPENEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EHWTWPENEX_AuditFields
-----------

IF OBJECT_ID('U_EHWTWPENEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EHWTWPENEX_DedList
-----------

IF OBJECT_ID('U_EHWTWPENEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHWTWPENEX_drvTbl
-----------

IF OBJECT_ID('U_EHWTWPENEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvNMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipcode] varchar(51) NULL,
    [drvPayRateType] varchar(1) NULL,
    [drvPayrollStatusEffectiveDate] datetime NULL,
    [drvStatusCode] varchar(3) NOT NULL,
    [drvPlanLocation] char(6) NULL,
    [drvSubPlanSecurityContext1] char(6) NULL,
    [drvActualLocSecurtiyContext2] char(6) NULL,
    [drvPensionPlan] varchar(6) NULL,
    [drvSecurityContex3] varchar(4) NOT NULL,
    [drvPensionStatusEffectiveDate] datetime NULL,
    [drvPensionStatus] varchar(21) NOT NULL,
    [drvEarningsBeginDate] datetime NULL,
    [drvEarningsEndDate] datetime NULL,
    [drvYTDCompensation] nvarchar(4000) NULL,
    [drvHours] varchar(1) NOT NULL,
    [drvYTDHours] nvarchar(4000) NULL,
    [drvEEContCode] varchar(12) NULL,
    [drvContributionDate] varchar(3) NULL,
    [drvYearSouthShoreOnly] varchar(4) NULL,
    [drvJanAprCalYrMonthsSSOnly] nvarchar(4000) NULL,
    [drvMayDecCalYrMonthsSSOnly] nvarchar(4000) NULL,
    [drvAnnualAccrualSSOnly] nvarchar(4000) NULL
);

-----------
-- Create table U_EHWTWPENEX_EEList
-----------

IF OBJECT_ID('U_EHWTWPENEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHWTWPENEX_File
-----------

IF OBJECT_ID('U_EHWTWPENEX_File') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EHWTWPENEX_Header
-----------

IF OBJECT_ID('U_EHWTWPENEX_Header') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_Header] (
    [drvSubPlanSecurityContext1] varchar(30) NOT NULL,
    [drvActualLocationSecCont2] varchar(37) NOT NULL,
    [drvSecurityContext3] varchar(19) NOT NULL,
    [drvQualifiedPensionEarnings] varchar(30) NOT NULL,
    [drvYearSouthShoreOnly] varchar(23) NOT NULL,
    [drvAccrualRateSouthShoreOnly] varchar(31) NOT NULL,
    [drvJanAprCalYrMonthSouthShore] varchar(40) NOT NULL,
    [drvMayDecCalYrMonthSouthShore] varchar(40) NOT NULL,
    [drvAnnAccrualSouthShore] varchar(33) NOT NULL
);

-----------
-- Create table U_EHWTWPENEX_PDedHist
-----------

IF OBJECT_ID('U_EHWTWPENEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhRETSSEECurAmt] numeric NULL
);

-----------
-- Create table U_EHWTWPENEX_PEarHist
-----------

IF OBJECT_ID('U_EHWTWPENEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHWTWPENEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHWTWPENEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: HarbisonWalker International, Inc.

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 09/21/2022
Service Request Number: TekP-2022-07-12-01

Purpose: Willis Towers Watson Pension Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHWTWPENEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHWTWPENEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHWTWPENEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHWTWPENEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHWTWPENEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHWTWPENEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHWTWPENEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHWTWPENEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHWTWPENEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHWTWPENEX', 'SCH_EHWTWP';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHWTWPENEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHWTWPENEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;;

    -- Set FormatCode
    SELECT @FormatCode = 'EHWTWPENEX';
    SELECT @FileMinCovDate = '10/1/2022';

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
    DELETE FROM dbo.U_EHWTWPENEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHWTWPENEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHWTWPENEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_AuditFields;
    CREATE TABLE dbo.U_EHWTWPENEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

       INSERT INTO dbo.U_EHWTWPENEX_AuditFields VALUES ('EmpComp','EecDateOfTermination');
       INSERT INTO dbo.U_EHWTWPENEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
       INSERT INTO dbo.U_EHWTWPENEX_AuditFields VALUES ('EmpComp','EecDateOfLastHire')


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHWTWPENEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID= audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value ,audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHWTWPENEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EHWTWPENEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(day,-90, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHWTWPENEX_Audit ON dbo.U_EHWTWPENEX_Audit (audEEID,audCOID);

   
    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EHWTWPENEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EHWTWPENEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'RETSS';

    IF OBJECT_ID('U_EHWTWPENEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHWTWPENEX_DedList
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

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHWTWPENEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhRETSSEECurAmt  = SUM(CASE WHEN PdhDedCode IN ('RETSS') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EHWTWPENEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHWTWPENEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, THEN remove or comment out this line.
    and PdhDedCode IN ('RETSS') 
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHWTWPENEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate     = DATEADD(m,-1,DATEADD(mm, DATEDIFF(m,0,Max(PrgPeriodStartDate)), 0))
        ,PrgPeriodEndDate       = DATEADD(d,-1,DATEADD(mm, DATEDIFF(m,0,Max(PrgPeriodEndDate)),0))
        -- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ---- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        --,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EHWTWPENEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHWTWPENEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHWTWPENEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo  
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvFirstName = EepNameFirst
        ,drvNMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvEmployeeNumber = EecEmpNo  
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipcode = STUFF(EepAddressZipCode, 5, 0, '-')
        ,drvPayRateType = CASE WHEN EecSalaryOrHourly = 'H' THEN 'H'
                               WHEN EecSalaryOrHourly = 'S' THEN 'S'
                              END
        ,drvPayrollStatusEffectiveDate = CASE WHEN EecEmplStatus = 'A' THEN EecDateOfLastHire 
                                              WHEN EshEmplStatus = 'L' THEN EshStatusStartDate  --Most recent EshStatusStopDate where EshEmplStatus = 'L' 
                                              WHEN EecEmplStatus = 'T' THEN eecDateOfTermination
                                            END


 


        ,drvStatusCode =  CASE  WHEN EecEmplStatus = 'A' THEN 'A' WHEN EecEmplStatus  IN ('L', 'S') THEN 'LOA' 
                                WHEN EecEmplStatus = 'T' AND EepDateDeceased is not null THEN 'DTH'
                                ELSE 'TRM'
                            END 
        ,drvPlanLocation = EecLocation --desc
        ,drvSubPlanSecurityContext1 = EecLocation
        ,drvActualLocSecurtiyContext2 = EecLocation
        ,drvPensionPlan = CASE WHEN EecSalaryOrHourly = 'H' THEN 'HWHRLY'
                               WHEN EecSalaryOrHourly = 'S' THEN 'HWSAL'
                               END
        ,drvSecurityContex3 = 'SC31' 
        ,drvPensionStatusEffectiveDate = CASe when EecDateofTermination is not null then dateadd(day,-1, EecDateofTermination) Else Null END --minus 1 day from date of file
        ,drvPensionStatus = CASE WHEN EecEmplStatus IN ('A', 'L', 'S') THEN 'Active' 
                                   WHEN EecEmplStatus = 'T' AND EepDateDeceased IS NOT NULL THEN 'Pending Pre-Ret Death'  
                                ELSE 'Pending Term'
                                END
        ,drvEarningsBeginDate = CASE WHEN audFieldName = 'EecDateOfLastHire' and  isnull(audNewvalue,'') = '' THEN  EecDateOfLastHire ELSE  PrgPeriodStartDate END --- prior month PrgPeriodStartDate or DateofHire if hired in the previous month
        ,drvEarningsEndDate = CASE WHEN (audFieldName = 'EecDateOfTermination' and isnull(audOldvalue,'') = '' ) or EecEmplStatus = 'T' THEN EecDateOfTermination ELSE  PrgPeriodEndDate END 
        ,drvYTDCompensation = CASE WHEN bdmDedcode = 'RETSS' AND format(PdhEECurAmtYTD,'0.00') > '0.00'THEN format(PdhEECurAmtYTD,'0.00') ELSE ''  END
        ,drvHours = '' --YTD total for prior month SUM(PdhEECurAmt) where PdhDedCode IN (RETSS) For (1/1 to previous month's of audit run)
        ,drvYTDHours = CASE WHEN FORMAT(PHPeh12MoCurHrs, '0.00') > '0.00' THEN FORMAT(PHPeh12MoCurHrs, '0.00') ELSE Null  END --YTD total -- look back twelve months from prior month SUM(PehCurHrs)  where PehInclinRPP = ‘Y’ For (YTD starting with prior month)
        ,drvEEContCode = CASE WHEN  Bdmdedcode = 'RETSS' and eecpaygroup = 'SSH' and Format(bdmEEamt, '0.00') > '0.00' THEN 'NARCO Hourly'
                              WHEN eecpaygroup = 'SSH'  and  Format(PdhEECurAmtYTD, '0.00') > '0.00' THEN  'South Shore' END  --and  SUM(pdheeamt) for YTD percontrol (?) > 0
        ,drvContributionDate = CASE WHEN EecEmplStatus = 'T' AND EepDateDeceased is Not null THEN 'EOM' END
        ,drvYearSouthShoreOnly = CASE WHEN eecpaygroup = 'SSH' THEN Cast(Year(Getdate()) as Varchar(4)) ELSe ' ' END
        ,drvJanAprCalYrMonthsSSOnly = CASE WHEN eecpaygroup = 'SSH' AND FORMaT(PdhJanApr, '0.00') > '0.00' THEN FORMaT(PdhJanApr, '0.00') ELSE  Null END -- CASE WHEN eecpaygroup = 'SSH' THEN format(pdheecuramt, '0.00') END --pdhDedCode = RETSS  for Jan, Feb, Mar, Apr
        ,drvMayDecCalYrMonthsSSOnly =  CASE WHEN eecpaygroup = 'SSH' AND FORMAT(PdhMayDec, '0.00') > '0.00' THEN FORMAT(PdhMayDec, '0.00') ELSE Null END -- CASE WHEN eecpaygroup = 'SSH' THEN format(pdheecuramt, '0.00') END --and pdhDedCode = RETSS for May, June, July, August, September, October, November, December
        ,drvAnnualAccrualSSOnly = CASE WHEN eecpaygroup = 'SSH' AND format(bdmEEGoalAmt, '0.00') > '0.00' THEN  format(bdmEEGoalAmt, '0.00')ELSE Null END
    INTO dbo.U_EHWTWPENEX_drvTbl
    FROM dbo.U_EHWTWPENEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EHWTWPENEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.U_EHWTWPENEX_PDedHist WITH (NOLOCK)
        ON  PdhEEID = xEEID
    LEFT JOIn dbo.U_EHWTWPENEX_PEarHist WITH (NOLOCK)
        ON  PehEEID = xEEID
    LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStartDate) AS EshStatusStartDate, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
   LEFT JOIN dbo.U_EHWTWPENEX_Audit WITH (NOLOCK)
           ON audEEID = xEEID
        AND audCOID = xCOID
   LEFT JOIn ( SELECT DISTINCT
                         PdhEEID 
                        ,PdhJanApr = sum(Case when (PdhPerControl  Between Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                                                    and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9') 
                                                    and  Datepart(month,Left(PdhPerControl,8)) in ('01','02','03','04') THEN PdhEECurAmt else 0.00  END)
                        ,PdhMayDec = sum(Case when (PdhPerControl Between Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                                                            and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9') 
                                                            and  Datepart(month,Left(PdhPerControl,8)) in ('05','06','07','08', '09', '10', '11', '12') THEN PdhEECurAmt else 0.00 END)
                        ,PdhYTDCurAmt   = SUM(CASE WHEN PdhPerControl BETWEEN Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                                                                        and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9' 
                                                                        and PdhDedCode IN ('RETSS') THEN PdhEECurAmt ELSE 0 END)
                    FROM dbo.PDedHist WITH (NOLOCK)
                    JOIN dbo.U_EHWTWPENEX_DedList WITH (NOLOCK)
                        ON DedCode = PdhDedCode
                    WHERE  PdhDedCode IN ('RETSS') 
                    and PdhPerControl Between Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                        and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9'
                        --and PdhEEID = 'B4LVEJ00J0K0'
                    GROUP BY PdhEEID
                    HAVING (sum(Case when (PdhPerControl  Between Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                                and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9') 
                                and  Datepart(month,Left(PdhPerControl,8)) in ('01','02','03','04') THEN PdhEECurAmt else 0.00  END) <> 0.00
                    OR sum(Case when (PdhPerControl Between Left(convert(varchar,Dateadd(Year, 0,(getdate())),112), 4) +'0101'+'1'
                                and convert(varchar,Dateadd(YY, 0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9') 
                                and  Datepart(month,Left(PdhPerControl,8)) in ('05','06','07','08', '09', '10', '11', '12') THEN PdhEECurAmt else 0.00 END)<> 0.00)
               ) AS  PHMONS 
             ON PHMONS.PdhEEID = xEEID

    LEFT JOIN (    SELECT DISTINCT
                         PdhEEID
                    
                        --,Pdh12MOSCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN 
                                                                        --and PdhDedCode IN ('RETSS') THEN PdhEECurAmt ELSE 0 END)
                        ,PHPeh12MoCurHrs =SUM(CASE WHEN  PehPerControl BETWEEN convert(varchar,cast(DATEADD(d,(DATEPART(d, DATEADD(m,-12,getdate()))*-1)+1, DATEADD(m,-13,getdate())) as DATE),112)+ '1'
                                                                        and convert(varchar,Dateadd(YY, -0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9' 
                                                                        and PdhDedCode IN ('RETSS') THEN PehCURHrs ELSE '' END)
        
                    FROM dbo.PDedHist WITH (NOLOCK)
                    JOIN dbo.U_EHWTWPENEX_DedList WITH (NOLOCK)
                        ON DedCode = PdhDedCode
                    Left JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
                        ON  PehEEID=  PdhEEID and PehPerControl = PdhPerControl
                    WHERE   PdhDedCode IN ('RETSS') and PdhEECurAmt is not null
                    AND PehPerControl BETWEEN convert(varchar,cast(DATEADD(d,(DATEPART(d, DATEADD(m,-12,getdate()))*-1)+1, DATEADD(m,-13,getdate())) as DATE),112)+ '1'
                                                                        and convert(varchar,Dateadd(YY, -0,(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0)))),112) +'9'
                    
                    GROUP BY PdhEEID 
                ) AS PHCUR
            ON PHCUR.PdhEEID = xEEID
    Where  EecEEType = 'REG' 
        and eepAddressCountry <> 'CAN'
        and eecpaygroup = 'SSH'
        and EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN DATEADD(DAY, -90, @StartDate) AND @EndDate)




    
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHWTWPENEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHWTWPENEX_Header;
    SELECT DISTINCT
         drvSubPlanSecurityContext1 = 'Sub Plan (Security Context #1)'
        ,drvActualLocationSecCont2 = 'Actual Location (Securtiy Context #2)'
        ,drvSecurityContext3 = 'Security Context #3'
        ,drvQualifiedPensionEarnings = 'Qualified Pensionable Earnings'
        ,drvYearSouthShoreOnly = 'Year (South Shore Only)'
        ,drvAccrualRateSouthShoreOnly = 'Accrual Rate (South Shore Only)'
        ,drvJanAprCalYrMonthSouthShore = 'Jan Apr Cal Yr Months (South Shore Only)'
        ,drvMayDecCalYrMonthSouthShore = 'May Dec Cal Yr Months (South Shore Only)'
        ,drvAnnAccrualSouthShore = 'Annual Accrual (South Shore Only)'
    INTO dbo.U_EHWTWPENEX_Header
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
ALTER VIEW dbo.dsi_vwEHWTWPENEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHWTWPENEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EHWTWPENEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202208011'
       ,expLastEndPerControl   = '202208319'
       ,expEndPerControl       = '202208319'
WHERE expFormatCode = 'EHWTWPENEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHWTWPENEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHWTWPENEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHWTWPENEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHWTWPENEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHWTWPENEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHWTWPENEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHWTWPENEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHWTWPENEX', 'UseFileName', 'V', 'Y'


-- End ripout