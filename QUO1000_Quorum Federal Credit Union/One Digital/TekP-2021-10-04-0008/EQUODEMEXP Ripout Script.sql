/**********************************************************************************

EQUODEMEXP: One Digital Employee Export

FormatCode:     EQUODEMEXP
Project:        One Digital Employee Export
Client ID:      QUO1000
Date/time:      2022-01-03 15:36:43.330
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB01
Database:       ULTIPRO_WPQFCU
Web Filename:   QUO1000_E1214_EEHISTORY_EQUODEMEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQUODEMEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EQUODEMEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQUODEMEXP'


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
WHERE FormatCode = 'EQUODEMEXP'
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
WHERE ExpFormatCode = 'EQUODEMEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQUODEMEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQUODEMEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQUODEMEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQUODEMEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQUODEMEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQUODEMEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQUODEMEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQUODEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQUODEMEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQUODEMEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQUODEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQUODEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQUODEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQUODEMEXP];
GO
IF OBJECT_ID('U_EQUODEMEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_PEarHist];
GO
IF OBJECT_ID('U_EQUODEMEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_PDedHist];
GO
IF OBJECT_ID('U_EQUODEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_File];
GO
IF OBJECT_ID('U_EQUODEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_EEList];
GO
IF OBJECT_ID('U_EQUODEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_drvTbl];
GO
IF OBJECT_ID('U_EQUODEMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQUODEMEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EQUODEMEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQUODEMEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQUODEMEXP','One Digital Employee Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EQUODEMEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQUODEMEXPZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"Record Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQUODEMEXPZ0','50','H','01','2',NULL,'Employee Number',NULL,NULL,'"Employee Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQUODEMEXPZ0','50','H','01','3',NULL,'Employee Last Name',NULL,NULL,'"Employee Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQUODEMEXPZ0','50','H','01','4',NULL,'Employee First Name',NULL,NULL,'"Employee First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQUODEMEXPZ0','50','H','01','5',NULL,'Employee Middle Name',NULL,NULL,'"Employee Middle Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQUODEMEXPZ0','50','H','01','6',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQUODEMEXPZ0','50','H','01','7',NULL,'Job Location',NULL,NULL,'"Job Location"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQUODEMEXPZ0','50','H','01','8',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQUODEMEXPZ0','50','H','01','9',NULL,'Empty Column',NULL,NULL,'"Empty Column"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQUODEMEXPZ0','50','H','01','10',NULL,'Employee Phone Home',NULL,NULL,'"Employee Phone Home"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQUODEMEXPZ0','50','H','01','11',NULL,'Employee Phone Work',NULL,NULL,'"Employee Phone Work"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQUODEMEXPZ0','50','H','01','12',NULL,'Employee Phone Mobile',NULL,NULL,'"Employee Phone Mobile"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQUODEMEXPZ0','50','H','01','13',NULL,'Employee Phone Alt',NULL,NULL,'"Employee Phone Alt"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQUODEMEXPZ0','50','H','01','14',NULL,'Employee Email',NULL,NULL,'"Employee Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQUODEMEXPZ0','50','H','01','15',NULL,'Employee Alt Email',NULL,NULL,'"Employee Alt Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQUODEMEXPZ0','50','H','01','16',NULL,'Mailing Address',NULL,NULL,'"Mailing Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQUODEMEXPZ0','50','H','01','17',NULL,'Mailing Address 2',NULL,NULL,'"Mailing Address 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQUODEMEXPZ0','50','H','01','18',NULL,'Mailing City',NULL,NULL,'"Mailing City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQUODEMEXPZ0','50','H','01','19',NULL,'Mailing State/Province',NULL,NULL,'"Mailing State/Province"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQUODEMEXPZ0','50','H','01','20',NULL,'Mailing Postal Code',NULL,NULL,'"Mailing Postal Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQUODEMEXPZ0','50','H','01','21',NULL,'Mailing Country',NULL,NULL,'"Mailing Country"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQUODEMEXPZ0','50','H','01','22',NULL,'PT/FT Status',NULL,NULL,'"PT/FT Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQUODEMEXPZ0','50','H','01','23',NULL,'Manager Employee Number',NULL,NULL,'"Manager Employee Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQUODEMEXPZ0','50','H','01','24',NULL,'Manager Last Name',NULL,NULL,'"Manager Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQUODEMEXPZ0','50','H','01','25',NULL,'Manager First Name',NULL,NULL,'"Manager First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQUODEMEXPZ0','50','H','01','26',NULL,'Manager Phone',NULL,NULL,'"Manager Phone"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQUODEMEXPZ0','50','H','01','27',NULL,'Manager Email',NULL,NULL,'"Manager Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQUODEMEXPZ0','50','H','01','28',NULL,'HR Contact Employee Number',NULL,NULL,'"HR Contact Employee Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQUODEMEXPZ0','50','H','01','29',NULL,'HR Contact Last Name',NULL,NULL,'"HR Contact Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQUODEMEXPZ0','50','H','01','30',NULL,'HR Contact First Name',NULL,NULL,'"HR Contact First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQUODEMEXPZ0','50','H','01','31',NULL,'HR Contact Phone',NULL,NULL,'"HR Contact Phone"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQUODEMEXPZ0','50','H','01','32',NULL,'HR Contact e-mail',NULL,NULL,'"HR Contact e-mail"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQUODEMEXPZ0','50','H','01','33',NULL,'Empty Column',NULL,NULL,'"Empty Column"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQUODEMEXPZ0','50','H','01','34',NULL,'Default to 1/1/1920',NULL,NULL,'"Default to 1/1/1920"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQUODEMEXPZ0','50','H','01','35',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQUODEMEXPZ0','50','H','01','36',NULL,'Exemption Status',NULL,NULL,'"Exemption Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQUODEMEXPZ0','50','H','01','37',NULL,'Meets 50 in 75',NULL,NULL,'"Meets 50 in 75"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQUODEMEXPZ0','50','H','01','38',NULL,'Key Employee',NULL,NULL,'"Key Employee"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQUODEMEXPZ0','50','H','01','39',NULL,'Military Status',NULL,NULL,'"Military Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQUODEMEXPZ0','50','H','01','40',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQUODEMEXPZ0','50','H','01','41',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQUODEMEXPZ0','50','H','01','42',NULL,'Pay Rate',NULL,NULL,'"Pay Rate"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQUODEMEXPZ0','50','H','01','43',NULL,'Pay Type',NULL,NULL,'"Pay Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQUODEMEXPZ0','50','H','01','44',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQUODEMEXPZ0','50','H','01','45',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EQUODEMEXPZ0','50','H','01','46',NULL,'Adjusted Service Date',NULL,NULL,'"Adjusted Service Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EQUODEMEXPZ0','50','H','01','47',NULL,'Scheduled Minutes per Week',NULL,NULL,'"Scheduled Minutes per Week"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EQUODEMEXPZ0','50','H','01','48',NULL,'Acutal Hours Worked in 12 Months',NULL,NULL,'"Acutal Hours Worked in 12 Months"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EQUODEMEXPZ0','50','H','01','49',NULL,'Scheduled Minutes Sunday',NULL,NULL,'"Scheduled Minutes Sunday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EQUODEMEXPZ0','50','H','01','50',NULL,'Scheduled Work Time Monday',NULL,NULL,'"Scheduled Work Time Monday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EQUODEMEXPZ0','50','H','01','51',NULL,'Scheduled Work Time Tuesday',NULL,NULL,'"Scheduled Work Time Tuesday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EQUODEMEXPZ0','50','H','01','52',NULL,'Scheduled Work Time Wednesday',NULL,NULL,'"Scheduled Work Time Wednesday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EQUODEMEXPZ0','50','H','01','53',NULL,'Scheduled Work Time Thursday',NULL,NULL,'"Scheduled Work Time Thursday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EQUODEMEXPZ0','50','H','01','54',NULL,'Scheduled Work Time Friday',NULL,NULL,'"Scheduled Work Time Friday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EQUODEMEXPZ0','50','H','01','55',NULL,'Scheduled Work Time Saturday',NULL,NULL,'"Scheduled Work Time Saturday"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EQUODEMEXPZ0','50','H','01','56',NULL,'Variable Schedule Flag',NULL,NULL,'"Variable Schedule Flag"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EQUODEMEXPZ0','50','H','01','57',NULL,'Job Description',NULL,NULL,'"Job Description"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EQUODEMEXPZ0','50','H','01','58',NULL,'Job Classification',NULL,NULL,'"Job Classification"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EQUODEMEXPZ0','50','H','01','59',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EQUODEMEXPZ0','50','H','01','60',NULL,'Cost Center',NULL,NULL,'"Cost Center"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EQUODEMEXPZ0','50','H','01','61',NULL,'Schedule Effective Date',NULL,NULL,'"Schedule Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EQUODEMEXPZ0','50','H','01','62',NULL,'Employer Reference Code',NULL,NULL,'"Employer Reference Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EQUODEMEXPZ0','50','H','01','63',NULL,'Empty Column',NULL,NULL,'"Empty Column"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EQUODEMEXPZ0','50','H','01','64',NULL,'Pay Schedule Name',NULL,NULL,'"Pay Schedule Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EQUODEMEXPZ0','50','H','01','65',NULL,'Start Day of the Week',NULL,NULL,'"Start Day of the Week"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EQUODEMEXPZ0','50','H','01','66',NULL,'Average Weekly Minutes',NULL,NULL,'"Average Weekly Minutes"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EQUODEMEXPZ0','50','H','01','67',NULL,'Work County',NULL,NULL,'"Work County"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EQUODEMEXPZ0','50','H','01','68',NULL,'Residence County',NULL,NULL,'"Residence County"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EQUODEMEXPZ0','50','H','01','69',NULL,'Work City',NULL,NULL,'"Work City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EQUODEMEXPZ0','50','H','01','70',NULL,'Empty Column',NULL,NULL,'"Empty Column"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EQUODEMEXPZ0','50','H','01','71',NULL,'FTE Percentage',NULL,NULL,'"FTE Percentage"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EQUODEMEXPZ0','50','H','01','72',NULL,'Total Hours Paid in the Last 12 Months',NULL,NULL,'"Total Hours Paid in the Last 12 Months"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQUODEMEXPZ0','50','D','10','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQUODEMEXPZ0','50','D','10','2',NULL,'EmployeeNumber',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQUODEMEXPZ0','50','D','10','3',NULL,'EmployeeLastName',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQUODEMEXPZ0','50','D','10','4',NULL,'EmployeeFirstName',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQUODEMEXPZ0','50','D','10','5',NULL,'EmployeeMiddleName',NULL,NULL,'"drvEmployeeMiddleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQUODEMEXPZ0','50','D','10','6',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQUODEMEXPZ0','50','D','10','7',NULL,'JobLocation',NULL,NULL,'"drvJobLocation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQUODEMEXPZ0','50','D','10','8',NULL,'WorkState',NULL,NULL,'"drvWorkState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQUODEMEXPZ0','50','D','10','9',NULL,'EmptyColumn',NULL,NULL,'"drvEmptyColumn"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQUODEMEXPZ0','50','D','10','10',NULL,'EmployeePhoneHome',NULL,NULL,'"drvEmployeePhoneHome"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQUODEMEXPZ0','50','D','10','11',NULL,'EmployeePhoneWork',NULL,NULL,'"drvEmployeePhoneWork"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQUODEMEXPZ0','50','D','10','12',NULL,'EmployeePhoneMobile',NULL,NULL,'"drvEmployeePhoneMobile"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQUODEMEXPZ0','50','D','10','13',NULL,'EmployeePhoneAlt',NULL,NULL,'"drvEmployeePhoneAlt"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQUODEMEXPZ0','50','D','10','14',NULL,'EmployeeEmail',NULL,NULL,'"drvEmployeeEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQUODEMEXPZ0','50','D','10','15',NULL,'EmployeeAltEmail',NULL,NULL,'"drvEmployeeAltEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQUODEMEXPZ0','50','D','10','16',NULL,'MailingAddress',NULL,NULL,'"drvMailingAddress"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQUODEMEXPZ0','50','D','10','17',NULL,'MailingAddress2',NULL,NULL,'"drvMailingAddress2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQUODEMEXPZ0','50','D','10','18',NULL,'MailingCity',NULL,NULL,'"drvMailingCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQUODEMEXPZ0','50','D','10','19',NULL,'MailingStateProvince',NULL,NULL,'"drvMailingStateProvince"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQUODEMEXPZ0','50','D','10','20',NULL,'MailingPostalCode',NULL,NULL,'"drvMailingPostalCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQUODEMEXPZ0','50','D','10','21',NULL,'MailingCountry',NULL,NULL,'"drvMailingCountry"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQUODEMEXPZ0','50','D','10','22',NULL,'PTFTStatus',NULL,NULL,'"drvPTFTStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQUODEMEXPZ0','50','D','10','23',NULL,'ManagerEmployeeNumber',NULL,NULL,'"drvManagerEmployeeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQUODEMEXPZ0','50','D','10','24',NULL,'ManagerLastName',NULL,NULL,'"drvManagerLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQUODEMEXPZ0','50','D','10','25',NULL,'ManagerFirstName',NULL,NULL,'"drvManagerFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQUODEMEXPZ0','50','D','10','26',NULL,'ManagerPhone',NULL,NULL,'"drvManagerPhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQUODEMEXPZ0','50','D','10','27',NULL,'ManagerEmail',NULL,NULL,'"drvManagerEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQUODEMEXPZ0','50','D','10','28',NULL,'HRContactEmployeeNumber',NULL,NULL,'"drvHRContactEmployeeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQUODEMEXPZ0','50','D','10','29',NULL,'HRContactLastName',NULL,NULL,'"drvHRContactLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQUODEMEXPZ0','50','D','10','30',NULL,'HRContactFirstName',NULL,NULL,'"drvHRContactFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQUODEMEXPZ0','50','D','10','31',NULL,'HRContactPhone',NULL,NULL,'"drvHRContactPhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQUODEMEXPZ0','50','D','10','32',NULL,'HRContacte-mail',NULL,NULL,'"drvHRContactemail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQUODEMEXPZ0','50','D','10','33',NULL,'EmptyColumn',NULL,NULL,'"drvEmptyColumn2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQUODEMEXPZ0','50','D','10','34',NULL,'Defaultto111920',NULL,NULL,'"drvDefaultto111920"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQUODEMEXPZ0','50','D','10','35',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQUODEMEXPZ0','50','D','10','36',NULL,'ExemptionStatus',NULL,NULL,'"drvExemptionStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQUODEMEXPZ0','50','D','10','37',NULL,'Meets50in75',NULL,NULL,'"drvMeets50in75"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQUODEMEXPZ0','50','D','10','38',NULL,'KeyEmployee',NULL,NULL,'"drvKeyEmployee"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQUODEMEXPZ0','50','D','10','39',NULL,'MilitaryStatus',NULL,NULL,'"drvMilitaryStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQUODEMEXPZ0','50','D','10','40',NULL,'EmploymentStatus',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQUODEMEXPZ0','50','D','10','41',NULL,'TerminationDate',NULL,NULL,'"drvTerminationDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQUODEMEXPZ0','50','D','10','42',NULL,'PayRate',NULL,NULL,'"drvPayRate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQUODEMEXPZ0','50','D','10','43',NULL,'PayType',NULL,NULL,'"drvPayType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQUODEMEXPZ0','50','D','10','44',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQUODEMEXPZ0','50','D','10','45',NULL,'RehireDate',NULL,NULL,'"drvRehireDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EQUODEMEXPZ0','50','D','10','46',NULL,'AdjustedServiceDate',NULL,NULL,'"drvAdjustedServiceDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EQUODEMEXPZ0','50','D','10','47',NULL,'ScheduledMinutesperWeek',NULL,NULL,'"drvScheduledMinutesperWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EQUODEMEXPZ0','50','D','10','48',NULL,'AcutalHoursWorkedin12Months',NULL,NULL,'"drvAcutalHoursWorkedin12Mo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EQUODEMEXPZ0','50','D','10','49',NULL,'ScheduledMinutesSunday',NULL,NULL,'"drvScheduledMinutesSunday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EQUODEMEXPZ0','50','D','10','50',NULL,'ScheduledWorkTimeMonday',NULL,NULL,'"drvScheduledWorkTimeMonday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EQUODEMEXPZ0','50','D','10','51',NULL,'ScheduledWorkTimeTuesday',NULL,NULL,'"drvScheduledWorkTimeTuesday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EQUODEMEXPZ0','50','D','10','52',NULL,'ScheduledWorkTimeWednesday',NULL,NULL,'"drvScheduledWorkTimeWednesday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EQUODEMEXPZ0','50','D','10','53',NULL,'ScheduledWorkTimeThursday',NULL,NULL,'"drvScheduledWorkTimeThursday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EQUODEMEXPZ0','50','D','10','54',NULL,'ScheduledWorkTimeFriday',NULL,NULL,'"drvScheduledWorkTimeFriday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EQUODEMEXPZ0','50','D','10','55',NULL,'ScheduledWorkTimeSaturday',NULL,NULL,'"drvScheduledWorkTimeSaturday"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EQUODEMEXPZ0','50','D','10','56',NULL,'VariableScheduleFlag',NULL,NULL,'"drvVariableScheduleFlag"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EQUODEMEXPZ0','50','D','10','57',NULL,'JobDescription',NULL,NULL,'"drvJobDescription"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EQUODEMEXPZ0','50','D','10','58',NULL,'JobClassification',NULL,NULL,'"drvJobClassification"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EQUODEMEXPZ0','50','D','10','59',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EQUODEMEXPZ0','50','D','10','60',NULL,'CostCenter',NULL,NULL,'"drvCostCenter"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EQUODEMEXPZ0','50','D','10','61',NULL,'ScheduleEffectiveDate',NULL,NULL,'"drvScheduleEffectiveDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EQUODEMEXPZ0','50','D','10','62',NULL,'EmployerReferenceCode',NULL,NULL,'"drvEmployerReferenceCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EQUODEMEXPZ0','50','D','10','63',NULL,'EmptyColumn',NULL,NULL,'"drvEmptyColumn3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EQUODEMEXPZ0','50','D','10','64',NULL,'PayScheduleName',NULL,NULL,'"drvPayScheduleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EQUODEMEXPZ0','50','D','10','65',NULL,'StartDayoftheWeek',NULL,NULL,'"drvStartDayoftheWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EQUODEMEXPZ0','50','D','10','66',NULL,'AverageWeeklyMinutes',NULL,NULL,'"drvAverageWeeklyMinutes"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EQUODEMEXPZ0','50','D','10','67',NULL,'WorkCounty',NULL,NULL,'"drvWorkCounty"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EQUODEMEXPZ0','50','D','10','68',NULL,'ResidenceCounty',NULL,NULL,'"drvResidenceCounty"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EQUODEMEXPZ0','50','D','10','69',NULL,'WorkCity',NULL,NULL,'"drvWorkCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EQUODEMEXPZ0','50','D','10','70',NULL,'EmptyColumn',NULL,NULL,'"drvEmptyColumn4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EQUODEMEXPZ0','50','D','10','71',NULL,'FTEPercentage',NULL,NULL,'"drvFTEPercentage"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EQUODEMEXPZ0','50','D','10','72',NULL,'TotalHoursPaidintheLast12Months',NULL,NULL,'"drvTotalHoursPilstmonth"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQUODEMEXP_20220103.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'One Digital Employee Export','202112199','EMPEXPORT','ONDEM_XOE','Dec 21 2021 12:00AM','EQUODEMEXP',NULL,NULL,NULL,'202112199','Dec 19 2021 12:00AM','Dec 30 1899 12:00AM','202112191',NULL,'','','202112191',dbo.fn_GetTimedKey(),NULL,'us3mLaQUO1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'One Digital Employee Exp-Sched','202112199','EMPEXPORT','SCH_EQUODE',NULL,'EQUODEMEXP',NULL,NULL,NULL,'202112199','Dec 19 2021  1:41AM','Dec 19 2021  1:41AM','202112191',NULL,'','','202112191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'One Digital Employee Exp-Test','202112311','EMPEXPORT','TEST_XOE','Dec 31 2021  5:15PM','EQUODEMEXP',NULL,NULL,NULL,'202112311','Dec 31 2021 12:00AM','Dec 30 1899 12:00AM','202112171','415','','','202112171',dbo.fn_GetTimedKey(),NULL,'us3cPeQUO1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','IsUTF','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQUODEMEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQUODEMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQUODEMEXP','D10','dbo.U_EQUODEMEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQUODEMEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EQUODEMEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQUODEMEXP] (
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
-- Create table U_EQUODEMEXP_DedList
-----------

IF OBJECT_ID('U_EQUODEMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQUODEMEXP_drvTbl
-----------

IF OBJECT_ID('U_EQUODEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvJobLocation] varchar(25) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvEmptyColumn] varchar(1) NOT NULL,
    [drvEmployeePhoneHome] nvarchar(4000) NULL,
    [drvEmployeePhoneWork] nvarchar(4000) NULL,
    [drvEmployeePhoneMobile] nvarchar(4000) NULL,
    [drvEmployeePhoneAlt] varchar(1) NOT NULL,
    [drvEmployeeEmail] varchar(50) NULL,
    [drvEmployeeAltEmail] varchar(50) NULL,
    [drvMailingAddress] varchar(255) NULL,
    [drvMailingAddress2] varchar(255) NULL,
    [drvMailingCity] varchar(255) NULL,
    [drvMailingStateProvince] varchar(255) NULL,
    [drvMailingPostalCode] varchar(50) NULL,
    [drvMailingCountry] char(3) NULL,
    [drvPTFTStatus] varchar(1) NULL,
    [drvManagerEmployeeNumber] varchar(256) NULL,
    [drvManagerLastName] varchar(256) NULL,
    [drvManagerFirstName] varchar(256) NULL,
    [drvManagerPhone] nvarchar(4000) NULL,
    [drvManagerEmail] varchar(256) NULL,
    [drvHRContactEmployeeNumber] varchar(7) NOT NULL,
    [drvHRContactLastName] varchar(2) NOT NULL,
    [drvHRContactFirstName] varchar(7) NOT NULL,
    [drvHRContactPhone] varchar(12) NOT NULL,
    [drvHRContactemail] varchar(16) NOT NULL,
    [drvEmptyColumn2] varchar(1) NOT NULL,
    [drvDefaultto111920] varchar(8) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvExemptionStatus] varchar(1) NOT NULL,
    [drvMeets50in75] varchar(1) NOT NULL,
    [drvKeyEmployee] varchar(1) NOT NULL,
    [drvMilitaryStatus] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvPayRate] nvarchar(4000) NULL,
    [drvPayType] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvAdjustedServiceDate] datetime NULL,
    [drvScheduledMinutesperWeek] varchar(30) NULL,
    [drvAcutalHoursWorkedin12Mo] varchar(30) NULL,
    [drvScheduledMinutesSunday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeMonday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeTuesday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeWednesday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeThursday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeFriday] varchar(1) NOT NULL,
    [drvScheduledWorkTimeSaturday] varchar(1) NOT NULL,
    [drvVariableScheduleFlag] varchar(1) NOT NULL,
    [drvJobDescription] varchar(1) NOT NULL,
    [drvJobClassification] varchar(1) NOT NULL,
    [drvDepartment] varchar(25) NULL,
    [drvCostCenter] varchar(1) NOT NULL,
    [drvScheduleEffectiveDate] varchar(1) NOT NULL,
    [drvEmployerReferenceCode] varchar(4) NOT NULL,
    [drvEmptyColumn3] varchar(1) NOT NULL,
    [drvPayScheduleName] varchar(1) NOT NULL,
    [drvStartDayoftheWeek] varchar(1) NOT NULL,
    [drvAverageWeeklyMinutes] varchar(30) NULL,
    [drvWorkCounty] varchar(1) NOT NULL,
    [drvResidenceCounty] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvEmptyColumn4] varchar(1) NOT NULL,
    [drvFTEPercentage] varchar(1) NOT NULL,
    [drvTotalHoursPilstmonth] varchar(30) NULL
);

-----------
-- Create table U_EQUODEMEXP_EEList
-----------

IF OBJECT_ID('U_EQUODEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQUODEMEXP_File
-----------

IF OBJECT_ID('U_EQUODEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EQUODEMEXP_PDedHist
-----------

IF OBJECT_ID('U_EQUODEMEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_PDedHist] (
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
-- Create table U_EQUODEMEXP_PEarHist
-----------

IF OBJECT_ID('U_EQUODEMEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EQUODEMEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurHrsAll] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQUODEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quorum Federal Credit Union

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 12/19/2021
Service Request Number: TekP-2021-10-04-0008

Purpose: One Digital Employee Export

Revision History
----------------
Update By           Date           Request Num           Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQUODEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQUODEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQUODEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQUODEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQUODEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUODEMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUODEMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUODEMEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUODEMEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQUODEMEXP', 'SCH_EQUODE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQUODEMEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQUODEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EQUODEMEXP';

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
    DELETE FROM dbo.U_EQUODEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQUODEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    Delete from dbo.U_EQUODEMEXP_EEList where xeeid not in (Select eeceeid from EmpComp where eeceetype ='REG');
    
    --Exclude terms before specified start date 
    DELETE EE 
    FROM dbo.U_EQUODEMEXP_EEList AS EE
    JOIN dbo.Empcomp WITH (NOLOCK) 
      ON EecEEID = xEEID 
     AND EecCOID = xCOID
    WHERE ISNULL(EecDateOfTermination, @StartDate) < @StartDate
    
    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EQUODEMEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQUODEMEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQUODEMEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EQUODEMEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQUODEMEXP_PDedHist;
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
    INTO dbo.U_EQUODEMEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EQUODEMEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EQUODEMEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQUODEMEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl>=  @Last52WeekPerControl and PehPerControl <= @StartPerControl And PehEarnCode IN ('REG', 'REGSL', 'OT', 'OTCOM') THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsAll           = SUM(CASE WHEN PehPerControl>=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  THEN PehCurHrs ELSE 0.00 END)

        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EQUODEMEXP_PEarHist
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
    -- DETAIL RECORD - U_EQUODEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EQUODEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EQUODEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'E'
        ,drvEmployeeNumber = eecEmpNo
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = EepNameMiddle
        ,drvJobTitle = JbcLongDesc
        ,drvJobLocation = LocDesc
        ,drvWorkState = LocAddressState
        ,drvEmptyColumn = ''
        ,drvEmployeePhoneHome = FORMAT(CAST(EepPhoneHomeNumber as numeric),'###-###-####')
        ,drvEmployeePhoneWork = FORMAT(CAST( CASE WHEN ISNULL(EecPhoneBusinessNumber,'') <> '' THEN  EecPhoneBusinessNumber END as numeric),'###-###-####')
        ,drvEmployeePhoneMobile = FORMAT( cast( (Select top 1 efoPhoneNumber from EmpMPhon where efoeeid =  xeeid and efoPhoneType = 'CEL') as numeric),'###-###-####')
        ,drvEmployeePhoneAlt = ''
        ,drvEmployeeEmail = EepAddressEMail
        ,drvEmployeeAltEmail = eepAddressEMailAlternate
        ,drvMailingAddress = EepAddressLine1
        ,drvMailingAddress2 = EepAddressLine2
        ,drvMailingCity = EepAddressCity
        ,drvMailingStateProvince = EepAddressState
        ,drvMailingPostalCode = EepAddressZipCode
        ,drvMailingCountry = EepAddressCountry --EepAddressCountry (Send the 2 character ISO code - ULTIPRO_SYSTEM.dbo.CountryISOCode)
        ,drvPTFTStatus = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1'
                              WHEN EecFullTimeOrPartTime = 'P' THEN '2'
                         END
        ,drvManagerEmployeeNumber = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'EmpNo')    
        ,drvManagerLastName = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'NameLast')
        ,drvManagerFirstName = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'NameFirst')
        ,drvManagerPhone = CASE WHEN  dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'BusinessPhoneNumber') <> '' THEN FORMAT(CAST(dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'BusinessPhoneNumber') as numeric),'###-###-####')  END
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('', xEEID, 'AddressEMail') 
        ,drvHRContactEmployeeNumber = 'General'
        ,drvHRContactLastName = 'HR'
        ,drvHRContactFirstName = 'Contact'
        ,drvHRContactPhone = '999-999-9999'
        ,drvHRContactemail = 'hr@quorumfcu.org'
        ,drvEmptyColumn2 = ''
        ,drvDefaultto111920 = '1/1/1920'
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvExemptionStatus = CASE WHEN EJH.EjhFLSACategory = 'E' THEN 'E' ELSE 'N' END  --if EjhFLSACategory = E send E Else send N
        ,drvMeets50in75 = ''
        ,drvKeyEmployee = ''
        ,drvMilitaryStatus = ''
        ,drvEmploymentStatus = CASE WHEN eecEmplStatus = 'A' THEN 'A'
                                    WHEN eecEmplStatus = 'L' THEN 'L'
                                    ELSE 'T'
                               END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPayRate = FORMAT(CAST(CASE WHEN eecSalaryOrHourly = 'S' THEN EecHourlyPayRate ELSE EecAnnSalary END AS decimal(10,2)),'0.00')
        ,drvPayType = CASE WHEN eecSalaryOrHourly = 'S' THEN '1' ELSE '2' END
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvAdjustedServiceDate = EecDateOfOriginalHire
        ,drvScheduledMinutesperWeek = CAST ( CONVERT(DECIMAL(10,2),(Case  WHEN EecPayPeriod = 'W' THEN EecScheduledWorkHrs * 60
                                            WHEN EecPayPeriod = 'B' then (EecScheduledWorkHrs / 2) * 60
                                            WHEN EecPayPeriod = 'S' then ((EecScheduledWorkHrs * 24) / 52) * 60
                                            WHEN EecPayPeriod = 'M' then ((EecScheduledWorkHrs * 12) / 52) * 60
                                      END)) as varchar)

        ,drvAcutalHoursWorkedin12Mo = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar)
        ,drvScheduledMinutesSunday = ''
        ,drvScheduledWorkTimeMonday = ''
        ,drvScheduledWorkTimeTuesday = ''
        ,drvScheduledWorkTimeWednesday = ''
        ,drvScheduledWorkTimeThursday = ''
        ,drvScheduledWorkTimeFriday = ''
        ,drvScheduledWorkTimeSaturday = ''
        ,drvVariableScheduleFlag = ''
        ,drvJobDescription = ''
        ,drvJobClassification = ''
        ,drvDepartment = (Select top 1 OrgDesc from OrgLevel where OrgCode = EecOrglvl1)
        ,drvCostCenter = ''
        ,drvScheduleEffectiveDate = ''
        ,drvEmployerReferenceCode = 'QFCU'
        ,drvEmptyColumn3 = ''
        ,drvPayScheduleName = ''
        ,drvStartDayoftheWeek = '1'
        ,drvAverageWeeklyMinutes = CAST( CONVERT( DECIMAL(10,2),( (PehCurHrs / 52) * 60)) as varchar)
        ,drvWorkCounty = ''
        ,drvResidenceCounty = ''
        ,drvWorkCity = ''
        ,drvEmptyColumn4 = ''
        ,drvFTEPercentage = ''
        ,drvTotalHoursPilstmonth = CAST( CONVERT( DECIMAL(10,2),PehCurHrsAll) as varchar)
    INTO dbo.U_EQUODEMEXP_drvTbl
    FROM dbo.U_EQUODEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.Location WITH (NOLOCK)
        on LocCode = EecLocation
    LEFT JOIN dbo.U_EQUODEMEXP_PEarHist  WITH (NOLOCK)
        on PehEEID = XEEID
     LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
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
ALTER VIEW dbo.dsi_vwEQUODEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQUODEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EQUODEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112121'
       ,expStartPerControl     = '202112121'
       ,expLastEndPerControl   = '202112199'
       ,expEndPerControl       = '202112199'
WHERE expFormatCode = 'EQUODEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQUODEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQUODEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQUODEMEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQUODEMEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQUODEMEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQUODEMEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQUODEMEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQUODEMEXP', 'UseFileName', 'V', 'Y'


-- End ripout