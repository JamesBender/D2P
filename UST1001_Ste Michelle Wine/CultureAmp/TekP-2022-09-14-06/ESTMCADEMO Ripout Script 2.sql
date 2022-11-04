/**********************************************************************************

ESTMCADEMO: CultureAmp Demographics Export

FormatCode:     ESTMCADEMO
Project:        CultureAmp Demographics Export
Client ID:      USG1000
Date/time:      2022-10-28 11:52:19.127
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_ESTMCADEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESTMCADEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_ESTMCADEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESTMCADEMO'


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
WHERE FormatCode = 'ESTMCADEMO'
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
WHERE ExpFormatCode = 'ESTMCADEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESTMCADEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESTMCADEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESTMCADEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESTMCADEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESTMCADEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESTMCADEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESTMCADEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESTMCADEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESTMCADEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESTMCADEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTMCADEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTMCADEMO];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTMCADEMO','CultureAmp Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESTMCADEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTMCADEMOZ0','50','H','01','1',NULL,'Name',NULL,NULL,'"Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTMCADEMOZ0','50','H','01','2',NULL,'Preferred Name',NULL,NULL,'"Preferred Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTMCADEMOZ0','50','H','01','3',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTMCADEMOZ0','50','H','01','4',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTMCADEMOZ0','50','H','01','5',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTMCADEMOZ0','50','H','01','6',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTMCADEMOZ0','50','H','01','7',NULL,'End Date',NULL,NULL,'"End Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTMCADEMOZ0','50','H','01','8',NULL,'Language',NULL,NULL,'"Language"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTMCADEMOZ0','50','H','01','9',NULL,'Manager Email',NULL,NULL,'"Manager Email"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTMCADEMOZ0','50','H','01','10',NULL,'Manager Name',NULL,NULL,'"Manager Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTMCADEMOZ0','50','H','01','11',NULL,'Performance Rating',NULL,NULL,'"Performance Rating"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTMCADEMOZ0','50','H','01','12',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTMCADEMOZ0','50','H','01','13',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTMCADEMOZ0','50','H','01','14',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTMCADEMOZ0','50','H','01','15',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTMCADEMOZ0','50','H','01','16',NULL,'Company Code',NULL,NULL,'"Company Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTMCADEMOZ0','50','H','01','17',NULL,'Employment',NULL,NULL,'"Employment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTMCADEMOZ0','50','H','01','18',NULL,'Hourly Salaried',NULL,NULL,'"Hourly Salaried"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTMCADEMOZ0','50','H','01','19',NULL,'Grade',NULL,NULL,'"Grade"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTMCADEMOZ0','50','H','01','20',NULL,'People Manager?',NULL,NULL,'"People Manager?"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTMCADEMOZ0','50','H','01','21',NULL,'Union',NULL,NULL,'"Union"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTMCADEMOZ0','50','H','01','22',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTMCADEMOZ0','50','H','01','23',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTMCADEMOZ0','50','H','01','24',NULL,'Military',NULL,NULL,'"Military"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTMCADEMOZ0','50','H','01','25',NULL,'Disability Code',NULL,NULL,'"Disability Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTMCADEMOZ0','50','H','01','26',NULL,'Org 2 Code',NULL,NULL,'"Org 2 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTMCADEMOZ0','50','H','01','27',NULL,'Org 2',NULL,NULL,'"Org 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTMCADEMOZ0','50','H','01','28',NULL,'Org 3 Code',NULL,NULL,'"Org 3 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTMCADEMOZ0','50','H','01','29',NULL,'Org 3',NULL,NULL,'"Org 3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTMCADEMOZ0','50','H','01','30',NULL,'Org 4 Code',NULL,NULL,'"Org 4 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTMCADEMOZ0','50','H','01','31',NULL,'Org 4',NULL,NULL,'"Org 4"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTMCADEMOZ0','50','D','10','1',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTMCADEMOZ0','50','D','10','2',NULL,'Preferred Name',NULL,NULL,'"drvPreferredName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTMCADEMOZ0','50','D','10','3',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTMCADEMOZ0','50','D','10','4',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTMCADEMOZ0','50','D','10','5',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTMCADEMOZ0','50','D','10','6',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTMCADEMOZ0','50','D','10','7',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTMCADEMOZ0','50','D','10','8',NULL,'Language',NULL,NULL,'"drvLanguage"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTMCADEMOZ0','50','D','10','9',NULL,'Manager Email',NULL,NULL,'"drvManagerEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTMCADEMOZ0','50','D','10','10',NULL,'Manager Name',NULL,NULL,'"drvManagerName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTMCADEMOZ0','50','D','10','11',NULL,'Performance Rating',NULL,NULL,'"drvPerformanceRating"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTMCADEMOZ0','50','D','10','12',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTMCADEMOZ0','50','D','10','13',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTMCADEMOZ0','50','D','10','14',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTMCADEMOZ0','50','D','10','15',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTMCADEMOZ0','50','D','10','16',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTMCADEMOZ0','50','D','10','17',NULL,'Employment',NULL,NULL,'"drvEmployment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTMCADEMOZ0','50','D','10','18',NULL,'Hourly Salaried',NULL,NULL,'"drvHourlySalaried"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTMCADEMOZ0','50','D','10','19',NULL,'Grade',NULL,NULL,'"drvGrade"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTMCADEMOZ0','50','D','10','20',NULL,'People Manager?',NULL,NULL,'"drvPeopleManager"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTMCADEMOZ0','50','D','10','21',NULL,'Union',NULL,NULL,'"drvUnion"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTMCADEMOZ0','50','D','10','22',NULL,'Work State',NULL,NULL,'"DrvWorkState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTMCADEMOZ0','50','D','10','23',NULL,'Ethnicity',NULL,NULL,'"drvEnthnecity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTMCADEMOZ0','50','D','10','24',NULL,'Military',NULL,NULL,'"drvMilitary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTMCADEMOZ0','50','D','10','25',NULL,'Disability Code',NULL,NULL,'"drvDisabilityCodfe"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTMCADEMOZ0','50','D','10','26',NULL,'Org 2 Code',NULL,NULL,'"drvOrg2Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTMCADEMOZ0','50','D','10','27',NULL,'Org 2',NULL,NULL,'"drvOrg2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTMCADEMOZ0','50','D','10','28',NULL,'Org 3 Code',NULL,NULL,'"drvOrg3Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTMCADEMOZ0','50','D','10','29',NULL,'Org 3',NULL,NULL,'"drvOrg3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTMCADEMOZ0','50','D','10','30',NULL,'Org 4 Code',NULL,NULL,'"drvOrg4Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTMCADEMOZ0','50','D','10','31',NULL,'Org 4',NULL,NULL,'"drvOrg4"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESTMCADEMO_20221028.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CultureAmp Demographics Export','202210289','EMPEXPORT','ONDEM_XOE',NULL,'ESTMCADEMO',NULL,NULL,NULL,'202210289','Oct 28 2022 11:51AM','Oct 28 2022 11:51AM','202210281',NULL,'','','202210281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CultureAmp Demographics -Sched','202210289','EMPEXPORT','SCH_ESTMCA',NULL,'ESTMCADEMO',NULL,NULL,NULL,'202210289','Oct 28 2022 11:51AM','Oct 28 2022 11:51AM','202210281',NULL,'','','202210281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CultureAmp Demographics -Test','202210289','EMPEXPORT','TEST_XOE',NULL,'ESTMCADEMO',NULL,NULL,NULL,'202210289','Oct 28 2022 11:51AM','Oct 28 2022 11:51AM','202210281',NULL,'','','202210281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTMCADEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTMCADEMO','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTMCADEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTMCADEMO','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTMCADEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTMCADEMO','D10','dbo.U_ESTMCADEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------

GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTMCADEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: 

Created By: Roger Bynum
Business Analyst: Katherine Ricca
Create Date: 10/28/2022
Service Request Number: TekP-2022-09-14-06

Purpose: CultureAmp Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTMCADEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTMCADEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTMCADEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTMCADEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTMCADEMO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTMCADEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTMCADEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTMCADEMO', 'SCH_ESTMCA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESTMCADEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTMCADEMO';

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
    DELETE FROM dbo.U_ESTMCADEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTMCADEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	DELETE FROM dbo.U_ESTMCADEMO_EEList WHERE xEEID IN (
    SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecEEType NOT IN ('001','002','003'))
    
	DELETE FROM dbo.U_ESTMCADEMO_EEList WHERE xEEID IN (SELECT EecEEID FROM dbo.EmpComp WITH (NOLOCK) 
	WHERE EecEmplStatus = 'T' AND EecDateOfTermination NOT BETWEEN @StartDate AND @EndDate)
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESTMCADEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTMCADEMO_PEarHist;
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
    INTO dbo.U_ESTMCADEMO_PEarHist
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
    -- DETAIL RECORD - U_ESTMCADEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTMCADEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTMCADEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvName = dbo.dsi_fnRemoveChars('.,/-', TRIM(EepNameFirst) + ' ' + TRIM(ISNULL(EepNameMiddle, ''))  + ' ' + TRIM(eepNameLast) + ' ' 
			+ CASE WHEN ISNULL(EepNameSuffix, 'Z') <> 'Z' THEN  TRIM(ISNULL(EepNameSuffix, '')) ELSE '' END)
        ,drvPreferredName = TRIM(EepNamePreferred)
        ,drvEmployeeID = RIGHT(EecEmpNo, 5)
        ,drvEmail = EepAddressEMail
        ,drvDateOfBirth = CONVERT(VARCHAR, EepDateOfBirth, 23)
        ,drvStartDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN CONVERT(VARCHAR(10), EecDateOfLastHire, 23) ELSE '' END
        ,drvEndDate = CASE WHEN  EecEmplStatus = 'T' AND EjhReason <> 'TRO' THEN CONVERT(VARCHAR(10), eecdateoftermination, 23) 
						   WHEN  EecEmplStatus = 'T' AND EjhReason IS NULL THEN ''
						   ELSE '' END
        ,drvLanguage = EecLanguageCode
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')
        ,drvManagerName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFML')  + '' + ISNULL(dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Suffix'),'')
        ,drvPerformanceRating = CASE WHEN ISNULL(EecReviewPerfRating, 'Z') <> 'Z' THEN EecReviewPerfRating ELSE '' END
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvLocation = (SELECT LocDesc FROM dbo.Location WITH (NOLOCK) WHERE LocCode = EecLocation)
        ,drvDepartment = OL4.OrgDesc
        ,drvJobTitle = (SELECT Jbcdesc FROM dbo.JobCode WITH (NOLOCK) WHERE JbcJobCode = EecJobCode)
        ,drvCompanyCode = CmpCompanyCode
        ,drvEmployment = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time' WHEN EecFullTimeOrPartTime = 'P' THEN 'Part Time' END
        ,drvHourlySalaried = CASE WHEN  EecSalaryOrHourly = 'S' THEN 'Salaried' WHEN  EecSalaryOrHourly = 'H' THEN 'Hourly' END
        ,drvGrade = (SELECT TOP 1 EjhSalaryGrade FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC)
        ,drvPeopleManager = dbo.dsi_fnlib_IsSupervisor(xEEID)
        ,drvUnion = CASE WHEN (SELECT TOP 1 EJHUnionLocal FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) in ('TEAM', 'UFW') THEN 'Union' ELSE 'Non-Union' END
        ,DrvWorkState = LEFT(EecStateSUI,2)
        ,drvEnthnecity = Eth.CodDesc
        ,drvMilitary = CASE WHEN eepMilitary = 'Y' THEN 'Yes' ELSE 'No' END
        ,drvDisabilityCodfe = EepIsDisabled
        ,drvOrg2Code = EecOrgLvl2
        ,drvOrg2 = OL2.OrgDesc
        ,drvOrg3Code = EecOrgLvl3
        ,drvOrg3 = OL3.OrgDesc
        ,drvOrg4Code = EecOrgLvl4
        ,drvOrg4 = OL4.OrgDesc
    INTO dbo.U_ESTMCADEMO_drvTbl
    FROM dbo.U_ESTMCADEMO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
	LEFT JOIN (
            SELECT EjhEEID 
                ,MAX(EjhReason) AS EjhReason
                ,MAX(EjhJobEffDate) AS EjhJobEffDate 
            FROM dbo.EmpHJob WITH (NOLOCK)
            WHERE EjhReason IN ('TRI','500') 
            GROUP BY EjhEEID) AS Ejh
    ON EjhEEID = xEEID
	LEFT JOIN dbo.OrgLevel OL2 WITH (NOLOCK)
        ON OL2.OrgLvl = 2
        AND OL2.OrgCode = EecOrgLvl2
	LEFT JOIN dbo.OrgLevel OL3 WITH (NOLOCK)
        ON OL3.OrgLvl = 3
        AND OL3.OrgCode = EecOrgLvl3
	LEFT JOIN dbo.OrgLevel OL4 WITH (NOLOCK)
        ON OL4.OrgLvl = 4
        AND OL4.OrgCode = EecOrgLvl4
	LEFT JOIN (SELECT CodCode,CodDesc from dbo.Codes WITH (NOLOCK) WHERE CodTable = 'ETHNICCODE') Eth
        ON Eth.CodCode =  eepEthnicID
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
ALTER VIEW dbo.dsi_vwESTMCADEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTMCADEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESTMCADEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202210211'
       ,expStartPerControl     = '202210211'
       ,expLastEndPerControl   = '202210289'
       ,expEndPerControl       = '202210289'
WHERE expFormatCode = 'ESTMCADEMO';

**********************************************************************************/

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESTMCADEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESTMCADEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESTMCADEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTMCADEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESTMCADEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTMCADEMO', 'UseFileName', 'V', 'Y'


-- End ripout