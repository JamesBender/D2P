/**********************************************************************************

EIHRELDLEX: Reliance Disability and Life Export

FormatCode:     EIHRELDLEX
Project:        Reliance Disability and Life Export
Client ID:      ITH1000
Date/time:      2022-11-21 11:09:35.453
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB01
Database:       ULTIPRO_WPITHAK
Web Filename:   ITH1000_29229_EEHISTORY_EIHRELDLEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIHRELDLEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EIHRELDLEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIHRELDLEX'


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
WHERE FormatCode = 'EIHRELDLEX'
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
WHERE ExpFormatCode = 'EIHRELDLEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIHRELDLEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIHRELDLEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIHRELDLEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIHRELDLEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIHRELDLEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIHRELDLEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIHRELDLEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIHRELDLEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIHRELDLEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIHRELDLEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIHRELDLEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIHRELDLEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIHRELDLEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIHRELDLEX];
GO
IF OBJECT_ID('U_EIHRELDLEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_PEarHist];
GO
IF OBJECT_ID('U_EIHRELDLEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_PDedHist];
GO
IF OBJECT_ID('U_EIHRELDLEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_Header];
GO
IF OBJECT_ID('U_EIHRELDLEX_File') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_File];
GO
IF OBJECT_ID('U_EIHRELDLEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_EEList];
GO
IF OBJECT_ID('U_EIHRELDLEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_drvTbl];
GO
IF OBJECT_ID('U_EIHRELDLEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_DedList];
GO
IF OBJECT_ID('U_EIHRELDLEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_AuditFields];
GO
IF OBJECT_ID('U_EIHRELDLEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIHRELDLEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIHRELDLEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIHRELDLEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIHRELDLEX','Reliance Disability and Life Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EIHRELDLEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIHRELDLEXZ0','50','H','01','1',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIHRELDLEXZ0','50','H','01','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"Date of Hire Most Recent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIHRELDLEXZ0','50','H','01','3',NULL,'Date of Hire Original',NULL,NULL,'"Date of Hire Original"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIHRELDLEXZ0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIHRELDLEXZ0','50','H','01','5',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIHRELDLEXZ0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIHRELDLEXZ0','50','H','01','7',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIHRELDLEXZ0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIHRELDLEXZ0','50','H','01','9',NULL,'Home Address 1',NULL,NULL,'"Home Address 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIHRELDLEXZ0','50','H','01','10',NULL,'Home Address 2',NULL,NULL,'"Home Address 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIHRELDLEXZ0','50','H','01','11',NULL,'Home City',NULL,NULL,'"Home City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIHRELDLEXZ0','50','H','01','12',NULL,'Home State',NULL,NULL,'"Home State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIHRELDLEXZ0','50','H','01','13',NULL,'Home Zip',NULL,NULL,'"Home Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIHRELDLEXZ0','50','H','01','14',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIHRELDLEXZ0','50','H','01','15',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIHRELDLEXZ0','50','H','01','16',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIHRELDLEXZ0','50','H','01','17',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIHRELDLEXZ0','50','H','01','18',NULL,'Position',NULL,NULL,'"Position"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIHRELDLEXZ0','50','H','01','19',NULL,'Is Active',NULL,NULL,'"Is Active"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIHRELDLEXZ0','50','H','01','20',NULL,'Is Fulltime',NULL,NULL,'"Is Fulltime"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIHRELDLEXZ0','50','H','01','21',NULL,'Is Exempt',NULL,NULL,'"Is Exempt"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIHRELDLEXZ0','50','H','01','22',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIHRELDLEXZ0','50','H','01','23',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIHRELDLEXZ0','50','H','01','24',NULL,'Sub Group A',NULL,NULL,'"Sub Group A"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIHRELDLEXZ0','50','H','01','25',NULL,'Sub Group B',NULL,NULL,'"Sub Group B"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIHRELDLEXZ0','50','H','01','26',NULL,'Sub Group C',NULL,NULL,'"Sub Group C"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIHRELDLEXZ0','50','H','01','27',NULL,'Sub Group D',NULL,NULL,'"Sub Group D"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIHRELDLEXZ0','50','H','01','28',NULL,'Sub Group E',NULL,NULL,'"Sub Group E"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIHRELDLEXZ0','50','H','01','29',NULL,'Sub Group F',NULL,NULL,'"Sub Group F"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIHRELDLEXZ0','50','H','01','30',NULL,'Is STD Eligible',NULL,NULL,'"Is STD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIHRELDLEXZ0','50','H','01','31',NULL,'Std Plan Effective',NULL,NULL,'"Std Plan Effective"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIHRELDLEXZ0','50','H','01','32',NULL,'Is LTD Eligible',NULL,NULL,'"Is LTD Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIHRELDLEXZ0','50','H','01','33',NULL,'LTD Effective Date',NULL,NULL,'"LTD Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIHRELDLEXZ0','50','H','01','34',NULL,'Hours Worked',NULL,NULL,'"Hours Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIHRELDLEXZ0','50','H','01','35',NULL,'Key Employee Indicator',NULL,NULL,'"Key Employee Indicator"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EIHRELDLEXZ0','50','H','01','36',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'"drvEmployees50in75MileInd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EIHRELDLEXZ0','50','H','01','37',NULL,'Add Data 01',NULL,NULL,'"Add Data 01"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EIHRELDLEXZ0','50','H','01','38',NULL,'Add Data 02',NULL,NULL,'"Add Data 02"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EIHRELDLEXZ0','50','H','01','39',NULL,'Add Data 03',NULL,NULL,'"Add Data 03"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EIHRELDLEXZ0','50','H','01','40',NULL,'Contact 1 Email Address',NULL,NULL,'"Contact 1 Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EIHRELDLEXZ0','50','H','01','41',NULL,'Contact 2 Email Address',NULL,NULL,'"Contact 2 Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EIHRELDLEXZ0','50','H','01','42',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EIHRELDLEXZ0','50','H','01','43',NULL,'Home/Mobile Phone',NULL,NULL,'"Home/Mobile Phone"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIHRELDLEXZ0','50','D','10','1',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIHRELDLEXZ0','50','D','10','2',NULL,'Date of Hire Most Recent',NULL,NULL,'"drvDateofHireMostRecent"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIHRELDLEXZ0','50','D','10','3',NULL,'Date of Hire Original',NULL,NULL,'"drvDateofHireOriginal"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIHRELDLEXZ0','50','D','10','4',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIHRELDLEXZ0','50','D','10','5',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIHRELDLEXZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIHRELDLEXZ0','50','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIHRELDLEXZ0','51','D','10','8',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIHRELDLEXZ0','52','D','10','9',NULL,'Home Address 1',NULL,NULL,'"drvHomeAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIHRELDLEXZ0','53','D','10','10',NULL,'Home Address 2',NULL,NULL,'"drvHomeAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIHRELDLEXZ0','54','D','10','11',NULL,'Home City',NULL,NULL,'"drvHomeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIHRELDLEXZ0','55','D','10','12',NULL,'Home State',NULL,NULL,'"drvHomeState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIHRELDLEXZ0','56','D','10','13',NULL,'Home Zip',NULL,NULL,'"drvHomeZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIHRELDLEXZ0','57','D','10','14',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIHRELDLEXZ0','58','D','10','15',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIHRELDLEXZ0','59','D','10','16',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIHRELDLEXZ0','60','D','10','17',NULL,'Department Name',NULL,NULL,'"DepartmentName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIHRELDLEXZ0','61','D','10','18',NULL,'Position',NULL,NULL,'"drvPosition"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIHRELDLEXZ0','62','D','10','19',NULL,'Is Active',NULL,NULL,'"drvIsActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIHRELDLEXZ0','63','D','10','20',NULL,'Is Fulltime',NULL,NULL,'"drvIsFulltime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIHRELDLEXZ0','64','D','10','21',NULL,'Is Exempt',NULL,NULL,'"drvIsExempt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIHRELDLEXZ0','65','D','10','22',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIHRELDLEXZ0','66','D','10','23',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIHRELDLEXZ0','67','D','10','24',NULL,'Sub Group A',NULL,NULL,'"drvSubGroupA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIHRELDLEXZ0','68','D','10','25',NULL,'Sub Group B',NULL,NULL,'"drvSubGroupB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIHRELDLEXZ0','69','D','10','26',NULL,'Sub Group C',NULL,NULL,'"drvSubGroupC"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIHRELDLEXZ0','70','D','10','27',NULL,'Sub Group D',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIHRELDLEXZ0','71','D','10','28',NULL,'Sub Group E',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIHRELDLEXZ0','72','D','10','29',NULL,'Sub Group F',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIHRELDLEXZ0','73','D','10','30',NULL,'Is STD Eligible',NULL,NULL,'"drvIsSTDEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIHRELDLEXZ0','74','D','10','31',NULL,'Std Plan Effective',NULL,NULL,'"drvStdPlanEffective"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIHRELDLEXZ0','75','D','10','32',NULL,'Is LTD Eligible',NULL,NULL,'"drvIsLTDEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIHRELDLEXZ0','76','D','10','33',NULL,'LTD Effective Date',NULL,NULL,'"drvLTDEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIHRELDLEXZ0','77','D','10','34',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIHRELDLEXZ0','78','D','10','35',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EIHRELDLEXZ0','79','D','10','36',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EIHRELDLEXZ0','80','D','10','37',NULL,'Add Data 01',NULL,NULL,'"drvAddData01"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EIHRELDLEXZ0','81','D','10','38',NULL,'Add Data 02',NULL,NULL,'"drvAddData02"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EIHRELDLEXZ0','82','D','10','39',NULL,'Add Data 03',NULL,NULL,'"drvAddData03"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EIHRELDLEXZ0','83','D','10','40',NULL,'Contact 1 Email Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EIHRELDLEXZ0','84','D','10','41',NULL,'Contact 2 Email Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EIHRELDLEXZ0','85','D','10','42',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EIHRELDLEXZ0','86','D','10','43',NULL,'Home/Mobile Phone',NULL,NULL,'"drvHomeMobilePhone"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIHRELDLEX_20221121.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210059','EMPEXPORT','OEACTIVE',NULL,'EIHRELDLEX',NULL,NULL,NULL,'202210059','Oct  5 2022  9:50AM','Oct  5 2022  9:50AM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210059','EMPEXPORT','OEPASSIVE',NULL,'EIHRELDLEX',NULL,NULL,NULL,'202210059','Oct  5 2022  9:50AM','Oct  5 2022  9:50AM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',XQ8NM',NULL,NULL,NULL,'RELIANCE DISB ONDEMAND','202210059','EMPEXPORT','ONDEM_XOE',NULL,'EIHRELDLEX',NULL,NULL,NULL,'202210059','Oct  5 2022  9:50AM','Oct  5 2022  9:50AM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',XQ8NM',NULL,NULL,NULL,'RELIANCE DISB SCH','202210059','EMPEXPORT','SCH_EIHREL',NULL,'EIHRELDLEX',NULL,NULL,NULL,'202210059','Oct  5 2022  9:50AM','Oct  5 2022  9:50AM','202209011',NULL,'','','202209011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XQ8NM',NULL,NULL,NULL,'RELIANCE DISB TEST','202211219','EMPEXPORT','TEST_XOE','Nov 21 2022 12:00AM','EIHRELDLEX',NULL,NULL,NULL,'202211219','Nov 21 2022 12:00AM','Dec 30 1899 12:00AM','202211211',NULL,'','','202211211',dbo.fn_GetTimedKey(),NULL,'US3KEPITH1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIHRELDLEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIHRELDLEX','H01','dbo.U_EIHRELDLEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIHRELDLEX','D10','dbo.U_EIHRELDLEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIHRELDLEX
-----------

IF OBJECT_ID('U_dsi_BDM_EIHRELDLEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIHRELDLEX] (
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
-- Create table U_EIHRELDLEX_Audit
-----------

IF OBJECT_ID('U_EIHRELDLEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_Audit] (
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
-- Create table U_EIHRELDLEX_AuditFields
-----------

IF OBJECT_ID('U_EIHRELDLEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIHRELDLEX_DedList
-----------

IF OBJECT_ID('U_EIHRELDLEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIHRELDLEX_drvTbl
-----------

IF OBJECT_ID('U_EIHRELDLEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvDateofHireMostRecent] varchar(30) NULL,
    [drvDateofHireOriginal] varchar(30) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmployeeID] varchar(9) NULL,
    [drvFirstName] varchar(40) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(40) NULL,
    [drvHomeAddress1] varchar(50) NULL,
    [drvHomeAddress2] varchar(50) NULL,
    [drvHomeCity] varchar(35) NULL,
    [drvHomeState] varchar(2) NULL,
    [drvHomeZipCode] varchar(10) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvWorkState] varchar(2) NULL,
    [DepartmentName] varchar(25) NULL,
    [drvPosition] varchar(50) NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvIsFulltime] varchar(1) NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvAnnualSalary] nvarchar(16) NULL,
    [drvHourlyRate] nvarchar(16) NULL,
    [drvSubGroupA] varchar(2) NULL,
    [drvSubGroupB] varchar(20) NULL,
    [drvSubGroupC] varchar(20) NULL,
    [drvIsSTDEligible] varchar(1) NOT NULL,
    [drvStdPlanEffective] varchar(30) NULL,
    [drvIsLTDEligible] varchar(1) NOT NULL,
    [drvLTDEffectiveDate] varchar(30) NULL,
    [drvHoursWorked] nvarchar(25) NULL,
    [drvAddData01] varchar(1) NOT NULL,
    [drvAddData02] varchar(7) NULL,
    [drvAddData03] varchar(7) NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvHomeMobilePhone] varchar(25) NULL
);

-----------
-- Create table U_EIHRELDLEX_EEList
-----------

IF OBJECT_ID('U_EIHRELDLEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIHRELDLEX_File
-----------

IF OBJECT_ID('U_EIHRELDLEX_File') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EIHRELDLEX_Header
-----------

IF OBJECT_ID('U_EIHRELDLEX_Header') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_Header] (
    [drvEmployees50in75MileInd] varchar(33) NOT NULL
);

-----------
-- Create table U_EIHRELDLEX_PDedHist
-----------

IF OBJECT_ID('U_EIHRELDLEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_PDedHist] (
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
-- Create table U_EIHRELDLEX_PEarHist
-----------

IF OBJECT_ID('U_EIHRELDLEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIHRELDLEX_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIHRELDLEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ithaka Harbors 

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 10/05/2022
Service Request Number: TekP-2022-07-14-06 

Purpose: Reliance Disability and Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIHRELDLEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIHRELDLEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIHRELDLEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIHRELDLEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIHRELDLEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIHRELDLEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIHRELDLEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIHRELDLEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIHRELDLEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIHRELDLEX', 'SCH_EIHREL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIHRELDLEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIHRELDLEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIHRELDLEX';

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
    DELETE FROM dbo.U_EIHRELDLEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIHRELDLEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIHRELDLEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_AuditFields;
    CREATE TABLE dbo.U_EIHRELDLEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EIHRELDLEX_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EIHRELDLEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EIHRELDLEX_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EIHRELDLEX_AuditFields VALUES ('EmpDed', 'EedDedCode');
   -- INSERT INTO dbo.U_EIHRELDLEX_AuditFields VALUES ('EmpDed', 'EedBenStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIHRELDLEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_Audit;
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
    INTO dbo.U_EIHRELDLEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIHRELDLEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DateAdd(d, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIHRELDLEX_Audit ON dbo.U_EIHRELDLEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EIHRELDLEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIHRELDLEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD,LTDEE,SLTD,STD,STDEE';--,NYDBL,NYPFL,NJTDB

    IF OBJECT_ID('U_EIHRELDLEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIHRELDLEX_DedList
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
    IF OBJECT_ID('U_EIHRELDLEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_PDedHist;
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
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('LTD') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('LTDEE') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('SLTD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('STD') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('STDEE') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('NYDBL') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('NYPFL') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('NJTDB') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EIHRELDLEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIHRELDLEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    and DedCode in ('LTD','LTDEE','SLTD','STD','STDEE','NYDBL','NYPFL','NJTDB')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EIHRELDLEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_PEarHist;
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
    INTO dbo.U_EIHRELDLEX_PEarHist
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
    -- DETAIL RECORD - U_EIHRELDLEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIHRELDLEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
       ,drvDateofBirth = CONVERT(VARCHAR,EepDateOfBirth,101)
        ,drvDateofHireMostRecent = CONVERT(VARCHAR,EecDateOfLastHire,101)
        ,drvDateofHireOriginal = CONVERT(VARCHAR,eecDateOfOriginalHire,101)
        ,drvSSN = ltrim(rtrim(eepSSN))
        ,drvEmployeeID = Left(ltrim(rtrim(EecEmpNo)), 20)
        ,drvFirstName = Left(ltrim(rtrim(EepNameFirst)), 40)
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = Left(ltrim(rtrim(EepNameLast)), 40)
        ,drvHomeAddress1 = Left(ltrim(rtrim(EepAddressLine1)), 50)
        ,drvHomeAddress2 = Left(ltrim(rtrim(EepAddressLine2)), 50)
        ,drvHomeCity = Left(ltrim(rtrim(EepAddressCity)), 35)
        ,drvHomeState = Left(ltrim(rtrim(EepAddressState)), 2)
        ,drvHomeZipCode = Left(ltrim(rtrim(EepAddressZipCode)), 10)
        ,drvMaritalStatus = Left(ltrim(rtrim(eepMaritalStatus)), 10)
        ,drvGender = Left(ltrim(rtrim(EepGender)), 8)
        ,drvWorkState = LEFT(EecSITResidentStateCode,2) 
        ,DepartmentName = Left(ltrim(rtrim(OrgDesc13)), 40)--EecOrgLvl3 -- Description  
        ,drvPosition = Left(ltrim(rtrim(jbcLongDesc)), 50) -- EecJobTitle 
        ,drvIsActive = CASE WHEN EecEmplStatus IN ('A', 'L') THEN 'Y' ELSE 'N' END
        ,drvIsFulltime = CASE WHEN EecFulltimeorPartTime = 'F' THEN 'Y' 
                              WHEN EecFulltimeorPartTime = 'P' THEN 'N' 
                             END
        ,drvIsExempt =  CASE WHEN  EjhFLSACategory = 'E' THEN 'Y' ELSE 'N' END                 --JbcFLSAType-- where JbcJobCode = EecJobCode               --JbcFLSAType-- where JbcJobCode = EecJobCode
        ,drvAnnualSalary = Left(ltrim(rtrim(FORMAT(isnull(EecAnnSalary,'0.00'), '#0.00'))), 16)
        ,drvHourlyRate = CASE WHEN isnull(EjhHourlyPayRate,'0.00') <> '0.00' THEN Left(ltrim(rtrim(FORMAT(isnull(EjhHourlyPayRate,'0.00'), '#0.00'))), 16) END
        ,drvSubGroupA = LEFT(replace(EecStateSUI, ' ' ,''),2) 
        ,drvSubGroupB = Left(Ltrim(Rtrim(REPLACE(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast'),' ' ,'')  +  REPLACE(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst'), ' ','') )), 20) --Supervisor Name - EepNameLast + EepNameFirst where EecSupervisorID = EjhEEID truncate after last name without spaces
        ,drvSubGroupC = Left(Replace(Ltrim(Rtrim(OrgDesc12)),' ' ,''), 20)
        ,drvIsSTDEligible = CASE WHEN STDCOMBINED_Status is not null  AND STDCOMBINED_Status = 'A'  THEN 'Y'  
                                 --WHEn bdmdedcode IN ('NYDBL', 'NYPFL') AND EepAddressState = 'NY' AND bdmbenstatus = 'A'  THEN 'Y' 
                                 --WHEn bdmdedcode IN ('NJTDB') AND EepAddressState = 'NJ' AND bdmbenstatus = 'A'  THEN 'Y'
                                 Else 'N' END
        ,drvStdPlanEffective = CONVERT(VARCHAR,CASE WHEN  STDCOMBINED_Status is not null AND EecEmplStatus <> 'T' AND ISNull(STDCOMBINED_StartDate, '') <> '' THEN STDCOMBINED_StartDate ELSE NULL END,101)---CASE WHEN bdmdedcode IN ('STD', 'STDEE') AND ISNull(bdmBenStartDate, '') <> '' THEN bdmBenStartDate ELSE NULL END
        ,drvIsLTDEligible = CASE WHEN LTDCOMBINED_Status is not null  and LTDCOMBINED_Status = 'A' THEN 'Y' ELSE 'N' END
        ,drvLTDEffectiveDate = CONVERT(VARCHAR,CASE WHEN LTDCOMBINED_Status is not null AND EecEmplStatus <> 'T' AND ISNull(LTDCOMBINED_StartDate, '') <> '' THEN LTDCOMBINED_StartDate ELSE NULL END,101)
        ,drvHoursWorked = CASE WHEN isnull(PehInclInDefCompHrsYTD,'0.00')<> ' 0.000' THEN Left(Ltrim(Rtrim(FORMAT(isnull(PehInclInDefCompHrsYTD,'0.00'), '#0.00'))),25) ELSE NULL END--total hours worked in last 12 months sum(PehCurHrs) where ErnIsRegularPayCode = Y where ErnEarnCode = PehEarnCode for per controls for last 12 months
        ,drvAddData01 = CASE WHEN SLTD_DedCode IN ( 'SLTD' )  THEn 'Y' ELSE 'N' END
        ,drvAddData02 = CASE WHEN STD_DedCode IN ( 'STD' )  THEN 'Class 1'
                             WHEN STDEE_DedCode  = 'STDEE' THEN 'Class 2' ELSE NULL END

        ,drvAddData03 = CASE WHEN LTD_DedCode = 'LTD'  THEN 'Class 1'
                             WHEN LTDEE_DedCode  = 'LTDEE' THEN 'Class 2' ELSE NULL END
        ,drvTerminationDate = CONVERT(VARCHAR,CASE WHEN MaxBenStopDate >=  DATEADD(DAY, -30, MaxBenStopDate) THEN MaxBenStopDate  END,101)-- EedBenStopDate Pass termination date and drop from file after 30 days
        ,drvHomeMobilePhone = Left(Ltrim(Rtrim(CASE WHEN ISNULL(efoPhoneNumber, '') <> '' THEN efoPhoneNumber ELSE NULL END)), 25)
    INTO dbo.U_EIHRELDLEX_drvTbl
    FROM dbo.U_EIHRELDLEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
      LEFT JOIN (SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'SLTD' THEN BdmDedCode END) AS SLTD_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'LTDEE' THEN BdmDedCode END) AS LTDEE_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode 
                    ,MAX(CASE WHEN BdmDedCode = 'STDEE' THEN BdmDedCode END) AS STDEE_DedCode 
                    ,MAX(CASE WHEN BdmDedCode IN ('STD','STDEE') THEN BdmDedCode END) AS STDCOMBINED_DedCode 
                    ,MAX(CASE WHEN BdmDedCode  IN ('SLTD','LTD','LTDEE') THEN BdmDedCode END) AS LTDCOMBINED_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('STD','STDEE') THEN bdmbenstatus END) AS STDCOMBINED_Status 

                    ,MAX(CASE WHEN BdmDedCode  IN ('SLTD','LTD','LTDEE') THEN bdmbenstatus END) AS LTDCOMBINED_Status
                   
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'SLTD' THEN BdmBenStartDate END) AS SLTD_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDEE' THEN BdmBenStartDate END) AS LTDEE_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDEE' THEN BdmBenStartDate END) AS STDEE_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('STD','STDEE') THEN BdmBenStartDate END) AS STDCOMBINED_StartDate
                    ,MAX(CASE WHEN BdmDedCode  IN ('SLTD','LTD','LTDEE') THEN BdmBenStartDate  END) AS LTDCOMBINED_StartDate
                   
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'SLTD' THEN BdmBenStopDate END) AS SLTD_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDEE' THEN BdmBenStopDate END) AS LTDEE_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'STDEE' THEN BdmBenStopDate END) AS STDEE_StopDate
                   
                    ,MAX(CASE WHEN BdmDedCode IN ('STD','STDEE') THEN BdmBenStopDate END) AS STDCOMBINED_STopDate
                    ,MAX(CASE WHEN BdmDedCode  IN ('SLTD','LTD','LTDEE') THEN BdmBenStopDate  END) AS LTDCOMBINED_StopDate
                    ,MAX( BdmBenStopDate ) AS MaxBenStopDate
                FROM dbo.U_dsi_BDM_EIHRELDLEX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId) BDMCombined
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
      LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    LEFT JOIN dbo.U_EIHRELDLEX_PEarHist WITH(NOLOCK)
            ON PehEEID = xEEID
        LEFT JOIN  dbo.U_EIHRELDLEX_Audit WITH (NOLOCK)
        ON xEEID = audEEID
 LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours ,EjhHourlyPayRate
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhHourlyPayRate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
    JOIN (
            SELECT DISTINCT OrgCode as OrgCode13, OrgDesc AS OrgDesc13
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 3
            ) AS Org3
        ON OrgCode13 = EecOrgLvl3
    JOIN (
            SELECT DISTINCT OrgCode as OrgCode12 , OrgDesc AS OrgDesc12
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
         ON OrgCode12 = EecOrgLvl2
    Where EecEEType <> 'TES' AND  BdmRecType = 'EMP' 
         AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audFieldName = 'EecDateOfTermination' AND AudDateTime BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIHRELDLEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EIHRELDLEX_Header;
    SELECT DISTINCT
          drvEmployees50in75MileInd = 'Employees 50 in 75 Mile Indicator'
    INTO dbo.U_EIHRELDLEX_Header
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
ALTER VIEW dbo.dsi_vwEIHRELDLEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIHRELDLEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIHRELDLEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209011'
       ,expStartPerControl     = '202209011'
       ,expLastEndPerControl   = '202210059'
       ,expEndPerControl       = '202210059'
WHERE expFormatCode = 'EIHRELDLEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIHRELDLEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIHRELDLEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIHRELDLEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIHRELDLEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIHRELDLEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIHRELDLEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIHRELDLEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIHRELDLEX', 'UseFileName', 'V', 'Y'


-- End ripout