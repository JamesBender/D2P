/**********************************************************************************

ECUTRAMPEX: Culture Amp Demographic Export

FormatCode:     ECUTRAMPEX
Project:        Culture Amp Demographic Export
Client ID:      CLI1003
Date/time:      2021-12-09 15:29:33.530
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP2DB03
Database:       ULTIPRO_WPCLIF
Web Filename:   CLI1003_EAE8A_EEHISTORY_ECUTRAMPEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECUTRAMPEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ECUTRAMPEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECUTRAMPEX'


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
WHERE FormatCode = 'ECUTRAMPEX'
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
WHERE ExpFormatCode = 'ECUTRAMPEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECUTRAMPEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECUTRAMPEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECUTRAMPEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECUTRAMPEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECUTRAMPEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECUTRAMPEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECUTRAMPEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECUTRAMPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECUTRAMPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECUTRAMPEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECUTRAMPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUTRAMPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUTRAMPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUTRAMPEX];
GO
IF OBJECT_ID('U_ECUTRAMPEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_PEarHist];
GO
IF OBJECT_ID('U_ECUTRAMPEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_File];
GO
IF OBJECT_ID('U_ECUTRAMPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_EEList];
GO
IF OBJECT_ID('U_ECUTRAMPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_drvTbl];
GO
IF OBJECT_ID('U_ECUTRAMPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_AuditFields];
GO
IF OBJECT_ID('U_ECUTRAMPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECUTRAMPEX','Culture Amp Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECUTRAMPEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUTRAMPEXZ0','50','H','01','1',NULL,'Name',NULL,NULL,'"Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUTRAMPEXZ0','50','H','01','2',NULL,'Preferred Name',NULL,NULL,'"Preferred Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUTRAMPEXZ0','50','H','01','3',NULL,'Employee Id',NULL,NULL,'"Employee Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUTRAMPEXZ0','50','H','01','4',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUTRAMPEXZ0','50','H','01','5',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUTRAMPEXZ0','50','H','01','6',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUTRAMPEXZ0','50','H','01','7',NULL,'End Date',NULL,NULL,'"End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUTRAMPEXZ0','50','H','01','8',NULL,'Language',NULL,NULL,'"Language"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUTRAMPEXZ0','50','H','01','9',NULL,'Performance Rating',NULL,NULL,'"Performance Rating"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUTRAMPEXZ0','50','H','01','10',NULL,'Manager',NULL,NULL,'"Manager"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUTRAMPEXZ0','50','H','01','11',NULL,'Manager Email',NULL,NULL,'"Manager Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUTRAMPEXZ0','50','H','01','12',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUTRAMPEXZ0','50','H','01','13',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUTRAMPEXZ0','50','H','01','13',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUTRAMPEXZ0','50','H','01','15',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUTRAMPEXZ0','50','H','01','16',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUTRAMPEXZ0','50','H','01','17',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUTRAMPEXZ0','50','H','01','18',NULL,'Org Level 1 Manager',NULL,NULL,'"ALT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUTRAMPEXZ0','50','H','01','19',NULL,'Org Level 3 Description',NULL,NULL,'"Job Level"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUTRAMPEXZ0','50','H','01','20',NULL,'Age',NULL,NULL,'"Age"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUTRAMPEXZ0','50','H','01','21',NULL,'Time in Role',NULL,NULL,'"Time in Role"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUTRAMPEXZ0','50','H','01','22',NULL,'Race/Ethnicity',NULL,NULL,'"Race/Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUTRAMPEXZ0','50','H','01','23',NULL,'Org Level 2 Description',NULL,NULL,'"State/Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECUTRAMPEXZ0','50','H','01','24',NULL,'FLSA Type',NULL,NULL,'"FLSA Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECUTRAMPEXZ0','50','H','01','25',NULL,'Company',NULL,NULL,'"Company"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECUTRAMPEXZ0','50','H','01','26',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECUTRAMPEXZ0','50','H','01','27',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECUTRAMPEXZ0','50','H','01','28',NULL,'Manager EEID',NULL,NULL,'"Employee Number (Supervisor)"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECUTRAMPEXZ0','50','D','10','1',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECUTRAMPEXZ0','50','D','10','2',NULL,'Preferred Name',NULL,NULL,'"drvPrefferedName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECUTRAMPEXZ0','50','D','10','3',NULL,'Employee Id',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECUTRAMPEXZ0','50','D','10','4',NULL,'Email',NULL,NULL,'"drvAddressEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECUTRAMPEXZ0','50','D','10','5',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECUTRAMPEXZ0','50','D','10','6',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECUTRAMPEXZ0','50','D','10','7',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECUTRAMPEXZ0','50','D','10','8',NULL,'Language',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECUTRAMPEXZ0','50','D','10','9',NULL,'Performance Rating',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECUTRAMPEXZ0','50','D','10','10',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECUTRAMPEXZ0','50','D','10','11',NULL,'Manager Email',NULL,NULL,'"drvManagerEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECUTRAMPEXZ0','50','D','10','12',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECUTRAMPEXZ0','50','D','10','13',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECUTRAMPEXZ0','50','D','10','14',NULL,'Business Unit',NULL,NULL,'"drvBusinessUnit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECUTRAMPEXZ0','50','D','10','15',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECUTRAMPEXZ0','50','D','10','16',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECUTRAMPEXZ0','50','D','10','17',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECUTRAMPEXZ0','50','D','10','18',NULL,'Org Level 1 Manager',NULL,NULL,'"drvOrgLvl1Manager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECUTRAMPEXZ0','50','D','10','19',NULL,'Org Level 3 Description',NULL,NULL,'"drvOrgLvl3Description"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECUTRAMPEXZ0','50','D','10','20',NULL,'Age',NULL,NULL,'"drvAge"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECUTRAMPEXZ0','50','D','10','21',NULL,'Time in Role',NULL,NULL,'"drvTimeInRole"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECUTRAMPEXZ0','50','D','10','22',NULL,'Race/Ethnicity',NULL,NULL,'"drvRateEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECUTRAMPEXZ0','50','D','10','23',NULL,'Org Level 2 Description',NULL,NULL,'"drvOrvLvl2Description"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECUTRAMPEXZ0','50','D','10','24',NULL,'FLSA Type',NULL,NULL,'"drvFSLAType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECUTRAMPEXZ0','50','D','10','25',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECUTRAMPEXZ0','50','D','10','26',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECUTRAMPEXZ0','50','D','10','27',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECUTRAMPEXZ0','50','D','10','28',NULL,'Manager EEID',NULL,NULL,'"drvManagerEEID"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECUTRAMPEX_20211209.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG,Y5USD,XI0GS,HG0SP,VLYMR,368IV,B57L5',NULL,NULL,NULL,'Culture Amp Demographic Export','202109079','EMPEXPORT','ONDEM_XOE','Sep 21 2021  2:39PM','ECUTRAMPEX',NULL,NULL,NULL,'202110129','Sep  7 2021 12:00AM','Dec 30 1899 12:00AM','202110111','29','','','202109071',dbo.fn_GetTimedKey(),NULL,'us3rVaCLI1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','IAGFG,Y5USD,XI0GS,HG0SP,VLYMR,368IV,B57L5',NULL,NULL,NULL,'Culture Amp Demographic -Sched','202104229','EMPEXPORT','SCH_ECUTRA','Apr 22 2021 12:46PM','ECUTRAMPEX',NULL,NULL,NULL,'202112099','Apr 22 2021 12:00AM','Dec 30 1899 12:00AM','202112081','124','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3rVaCLI1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Culture Amp Demographic -Test','202109161','EMPEXPORT','TEST_XOE','Sep 21 2021  2:58PM','ECUTRAMPEX',NULL,NULL,NULL,'202109161','Sep 16 2021 12:00AM','Dec 30 1899 12:00AM','202109161','17','','','202109161',dbo.fn_GetTimedKey(),NULL,'us3rVaCLI1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUTRAMPEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUTRAMPEX','D10','dbo.U_ECUTRAMPEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECUTRAMPEX_Audit
-----------

IF OBJECT_ID('U_ECUTRAMPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);

-----------
-- Create table U_ECUTRAMPEX_AuditFields
-----------

IF OBJECT_ID('U_ECUTRAMPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECUTRAMPEX_drvTbl
-----------

IF OBJECT_ID('U_ECUTRAMPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvName] varchar(201) NULL,
    [drvPrefferedName] varchar(100) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] datetime NULL,
    [drvManager] varchar(201) NULL,
    [drvManagerEmail] varchar(50) NULL,
    [drvGender] varchar(10) NOT NULL,
    [drvLocation] varchar(25) NULL,
    [drvBusinessUnit] varchar(25) NULL,
    [drvDepartment] varchar(45) NULL,
    [drvEmploymentType] varchar(9) NOT NULL,
    [drvJobTitle] varchar(152) NULL,
    [drvOrgLvl1Manager] varchar(201) NOT NULL,
    [drvOrgLvl3Description] varchar(25) NULL,
    [drvAge] int NULL,
    [drvTimeInRole] int NULL,
    [drvRateEthnicity] varchar(45) NULL,
    [drvOrvLvl2Description] varchar(255) NULL,
    [drvFSLAType] varchar(10) NOT NULL,
    [drvCompany] varchar(40) NULL,
    [drvEmploymentStatus] varchar(16) NOT NULL,
    [drvCountry] varchar(45) NULL,
    [drvManagerEEID] char(9) NULL
);

-----------
-- Create table U_ECUTRAMPEX_EEList
-----------

IF OBJECT_ID('U_ECUTRAMPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECUTRAMPEX_File
-----------

IF OBJECT_ID('U_ECUTRAMPEX_File') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECUTRAMPEX_PEarHist
-----------

IF OBJECT_ID('U_ECUTRAMPEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUTRAMPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CBC

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 10/12/2020
Service Request Number: TekP-2020-09-04-0001

Purpose: Culture Amp Demographic Export

Revision History
----------------
12/09/2021 by AP:
	- Cleaned up name field to replace é with e.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECUTRAMPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECUTRAMPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'SCH_ECUTRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECUTRAMPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECUTRAMPEX';

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
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ECUTRAMPEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_AuditFields;
    CREATE TABLE dbo.U_ECUTRAMPEX_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNamePreferred');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepEthnicID');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecSupervisorId');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl3');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecJobCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Dependent Information
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressCountry');

    -- PlatformConfigFields
    --INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('SEmployment','_BCultureAmpDepartment'); -- took this out and added the table/field to the where clause because this was taking FOREVER to run.
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECUTRAMPEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_ECUTRAMPEX_Audit
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    --INNER JOIN dbo.vw_dsi_CfgAuditData WITH (NOLOCK) ON xEEID = CfgAudKey1Value
    JOIN dbo.U_ECUTRAMPEX_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
   ;


   INSERT INTO dbo.U_ECUTRAMPEX_Audit
   SELECT xEEID
    ,xCOID
    ,NULL
    ,xEEID 
    ,xCOID
    ,''
    ,CfgAudClass
    ,CfgAudFieldName
    ,CfgAudAction
    ,CfgAudDateTime
    ,CfgAudOldValue
    ,CfgAudNewValue
    ,CfgAudEffDate
    ,ROW_NUMBER() OVER (PARTITION BY xEEID, xCOID, CfgAudFieldName ORDER BY cfgAudDateTime DESC), 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_dsi_CfgAuditData XX WITH (NOLOCK) ON xEEID = CfgAudKey1Value
    WHERE CfgAudDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(CfgAudNewValue, '') <> ''
    --AND xEEID = 'A5M38E0010K0'
    AND CfgAudClass = 'SEmployment'
    AND CfgAudFieldName = '_BCultureAmpDepartment'

    --================
    -- Changes Only
    --================

    -- Remove Employees with No Changes in Audit
    DELETE FROM dbo.U_ECUTRAMPEX_EELIST
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECUTRAMPEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);












    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECUTRAMPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECUTRAMPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECUTRAMPEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECUTRAMPEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_PEarHist;
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
    INTO dbo.U_ECUTRAMPEX_PEarHist
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
    -- DETAIL RECORD - U_ECUTRAMPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECUTRAMPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EC.EecEmpNo -- E.EepDateOfBirth
        -- standard fields above and additional driver fields below
        ,drvName = REPLACE(E.EepNameFirst + ' ' + E.EepNameLast, 'é', 'e')
        ,drvPrefferedName = CASE WHEN E.EepNamePreferred IS NOT NULL THEN E.EepNamePreferred ELSE E.EepNameFirst END
        ,drvEmployeeID = EC.EecEmpNo
        ,drvAddressEmail = E.EepAddressEMail
        ,drvDateOfBirth = E.EepDateOfBirth
        ,drvStartDate = EC.EecDateOfLastHire
        ,drvEndDate = EC.EecDateOfTermination
        ,drvManager = SUP.EepNameFirst + ' ' + SUP.EepNameLast
        ,drvManagerEmail = SUP.EepAddressEMail
        ,drvGender = CASE E.EepGender
                        WHEN 'M' THEN 'Male'
                        WHEN 'F' THEN 'Female'
                        ELSE 'Non-Binary'
                    END
        ,drvLocation = OrgDesc2 
        ,drvBusinessUnit = OrgDesc1
        ,drvDepartment = CodDesc -- CustomFields.Employment_CultureAmpDepartment -- OrgDesc1
        ,drvEmploymentType = CASE WHEN EC.EecFulltimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvJobTitle = '"' + EecJobTitle + '"'
        ,drvOrgLvl1Manager = OrgMangerName
        ,drvOrgLvl3Description = OrgDesc3
        ,drvAge = DATEDIFF(hour,E.EepDateOfBirth,GETDATE())/8766
        ,drvTimeInRole = EjhMonthsInJobCode
        ,drvRateEthnicity = EDesc -- E.EepEthnicID
        ,drvOrvLvl2Description = LocAddressState
        ,drvFSLAType = CASE WHEN EjhFLSACategory = 'E' THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvCompany =    CASE WHEN CmpCompanyCode = 'CBC' THEN 'Clif Bar & Company'
                            WHEN CmpCompanyCode = 'CBCCD' THEN 'Clif Bar & Company Canada'
                            WHEN CmpCompanyCode = 'CIN' THEN 'Clif Bar Baking Company of Indianapolis'
                            WHEN CmpCompanyCode = 'CTF' THEN 'Clif Bar Baking Company of Twin Falls LL'
                            WHEN CmpCompanyCode = 'CBENL' THEN 'Clif Bar Europe B.V. NL'
                            WHEN CmpCompanyCode = 'CBEUK' THEN 'Clif Bar Europe B.V. UK'
                            WHEN CmpCompanyCode = 'CBEDE' THEN 'Clif Bar Europe Germany'
                        END
        ,drvEmploymentStatus =    CASE EC.EecEmplStatus
                                    WHEN 'A' THEN 'Active'
                                    WHEN 'L' THEN 'Leave of Absence'
                                    ELSE 'Terminated'
                                END
        ,drvCountry = CNCdesc-- E.EepAddressCountry
        ,drvManagerEEID = (SELECT TOP 1 SUP.EecEmpNo FROM dbo.EmpComp SUP WITH (NOLOCK) WHERE SUP.EecEEID = EC.EecSupervisorId)
    INTO dbo.U_ECUTRAMPEX_drvTbl
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EC WITH (NOLOCK)
        ON EC.EecEEID = xEEID 
        AND EC.EecCoID = xCoID
    JOIN dbo.EmpPers E WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EC.EecJobCode
    JOIN dbo.EmpPers SUP WITH (NOLOCK)
        ON Sup.EepEEID = EC.EecSupervisorId
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EC.EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    --JOIN dbo.U_ECUTRAMPEX_PEarHist WITH (NOLOCK)
       -- ON PehEEID = xEEID
    JOIN (
            SELECT EjhEEID, EjhCOID, EjhJobCode, DATEDIFF(MONTH, MIN(EjhJobEffDate), GETDATE()) AS EjhMonthsInJobCode, MAX(EjhFLSACategory) AS EjhFLSACategory
            FROM dbo.vw_int_EmpHJob WITH (NOLOCK)
            GROUP BY EjhEEID, EjhCOID, EjhJobCode ) AS JobMonths
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EC.EecJobCode
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode1, OrgDesc AS OrgDesc1, OrgManagerId AS OrgManagerId1, ISNULL(EepNameFirst, '') + ' ' + ISNULL(EepNameLast, '') As OrgMangerName
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            LEFT JOIN dbo.EmpPers WITH (NOLOCK)
                ON OrgManagerId = EepEEID
            WHERE OrgLvl = 1
            ) AS Org1
        ON OrgCode1 = EC.EecOrgLvl1
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode3, OrgDesc AS OrgDesc3, OrgManagerId AS OrgManagerId3
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 3
            ) AS Org3
        ON OrgCode3 = EC.EecOrgLvl3
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode2, OrgDesc AS OrgDesc2, OrgManagerId AS OrgManagerId2
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
        ON OrgCode2 = EC.EecOrgLvl2
    LEFT JOIN (
            SELECT CodCode AS ECode, CodDesc AS EDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'ETHNICCODE'
            ) AS EStatus
        ON E.EepEthnicID = ECode
    JOIN (select * from [dbo].[fn_MP_CustomFields_EmpComp_Export] (null, null, null, null)) AS CustomFields
        ON EC.EecEEID = CustomFields.EecEEID
        AND EC.EecCOID = CustomFields.EecCOID
    LEFT JOIN dbo.Codes WITH (NOLOCK)
        ON CustomFields.Employment_CultureAmpDepartment = CodCode
        AND CodTable = 'CO_CULTUREAMPDEP'
    JOIN (
            SELECT CodCode AS CNCode, CodDesc AS CNCdesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'COUNTRY'
            ) AS Countries
        ON E.EepAddressCountry = CnCode
    WHERE --PehCurAmtYTD > 0
        --AND 
        CmpCompanyCode IN ('CBC','CBCCD','CIN','CTF','CBENL','CBEUK','CBEDE')
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
ALTER VIEW dbo.dsi_vwECUTRAMPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECUTRAMPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECUTRAMPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009051'
       ,expStartPerControl     = '202009051'
       ,expLastEndPerControl   = '202010129'
       ,expEndPerControl       = '202010129'
WHERE expFormatCode = 'ECUTRAMPEX';

**********************************************************************************/

-- ??
GO
CREATE VIEW dbo.dsi_vwECUTRAMPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECUTRAMPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECUTRAMPEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECUTRAMPEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECUTRAMPEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUTRAMPEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECUTRAMPEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECUTRAMPEX', 'UseFileName', 'V', 'Y'


-- End ripout