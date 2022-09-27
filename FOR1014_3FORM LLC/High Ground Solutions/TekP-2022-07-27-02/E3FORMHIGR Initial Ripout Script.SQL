/**********************************************************************************

E3FORMHIGR: High Ground Solutions Demo Export

FormatCode:     E3FORMHIGR
Project:        High Ground Solutions Demo Export
Client ID:      USG1000
Date/time:      2022-09-20 13:16:29.383
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_E3FORMHIGR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_E3FORMHIGR_SavePath') IS NOT NULL DROP TABLE dbo.U_E3FORMHIGR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'E3FORMHIGR'


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
WHERE FormatCode = 'E3FORMHIGR'
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
WHERE ExpFormatCode = 'E3FORMHIGR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'E3FORMHIGR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'E3FORMHIGR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'E3FORMHIGR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'E3FORMHIGR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'E3FORMHIGR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'E3FORMHIGR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'E3FORMHIGR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'E3FORMHIGR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'E3FORMHIGR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'E3FORMHIGR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwE3FORMHiGR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwE3FORMHiGR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_E3FORMHiGR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E3FORMHiGR];
GO
IF OBJECT_ID('U_E3FORMHiGR_File') IS NOT NULL DROP TABLE [dbo].[U_E3FORMHiGR_File];
GO
IF OBJECT_ID('U_E3FORMHiGR_EEList') IS NOT NULL DROP TABLE [dbo].[U_E3FORMHiGR_EEList];
GO
IF OBJECT_ID('U_E3FORMHiGR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_E3FORMHiGR_drvTbl];
GO
IF OBJECT_ID('U_E3FORMHiGR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_E3FORMHiGR_AuditFields];
GO
IF OBJECT_ID('U_E3FORMHiGR_Audit') IS NOT NULL DROP TABLE [dbo].[U_E3FORMHiGR_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','E3FORMHiGR','High Ground Solutions Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','E3FORMHiGRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3FORMHiGRZ0','50','H','01','1',NULL,'Employee number',NULL,NULL,'"Employee number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3FORMHiGRZ0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3FORMHiGRZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3FORMHiGRZ0','50','H','01','4',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3FORMHiGRZ0','50','H','01','5',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3FORMHiGRZ0','50','H','01','6',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3FORMHiGRZ0','50','H','01','7',NULL,'Cell Phone 1',NULL,NULL,'"Cell Phone 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3FORMHiGRZ0','50','H','01','8',NULL,'Cell Phone 2',NULL,NULL,'"Cell Phone 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3FORMHiGRZ0','50','H','01','9',NULL,'Work Phone 1',NULL,NULL,'"Work Phone 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3FORMHiGRZ0','50','H','01','10',NULL,'Primary Email',NULL,NULL,'"Primary Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3FORMHiGRZ0','50','H','01','11',NULL,'Email 2',NULL,NULL,'"Email 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3FORMHiGRZ0','50','H','01','12',NULL,'Group 1 State',NULL,NULL,'"Group 1 State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3FORMHiGRZ0','50','H','01','13',NULL,'Group 2 Department',NULL,NULL,'"Group 2 Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E3FORMHiGRZ0','50','H','01','14',NULL,'Group 3 Manager',NULL,NULL,'"Group 3 Manager"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E3FORMHiGRZ0','50','H','01','15',NULL,'Group 4 Location',NULL,NULL,'"Group 4 Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E3FORMHiGRZ0','50','H','01','16',NULL,'Group 5 Country',NULL,NULL,'"Group 5 Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E3FORMHiGRZ0','50','H','01','17',NULL,'Group 6 Job Title',NULL,NULL,'"Group 6 Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E3FORMHiGRZ0','50','H','01','18',NULL,'Group 7 Shift Number',NULL,NULL,'"Group 7 Shift Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E3FORMHiGRZ0','50','H','01','19',NULL,'Group 8 Pay Category',NULL,NULL,'"Group 8 Pay Category"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E3FORMHiGRZ0','50','H','01','20',NULL,'Group 9 Pay Type',NULL,NULL,'"Group 9 Pay Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E3FORMHiGRZ0','50','H','01','21',NULL,'Group 10 Hourly/Salaried',NULL,NULL,'"Group 10 Hourly/Salaried"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E3FORMHiGRZ0','50','H','01','22',NULL,'Group 11 Supervisor Email',NULL,NULL,'"Group 11 Supervisor Email"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3FORMHiGRZ0','50','D','10','1',NULL,'Employee number',NULL,NULL,'"drvEmployeenumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3FORMHiGRZ0','50','D','10','2',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3FORMHiGRZ0','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3FORMHiGRZ0','50','D','10','4',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3FORMHiGRZ0','50','D','10','5',NULL,'State',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3FORMHiGRZ0','50','D','10','6',NULL,'Zip',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3FORMHiGRZ0','50','D','10','7',NULL,'Cell Phone 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3FORMHiGRZ0','50','D','10','8',NULL,'Cell Phone 2',NULL,NULL,'"drvCellPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3FORMHiGRZ0','50','D','10','9',NULL,'Work Phone 1',NULL,NULL,'"drvWorkPhone1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3FORMHiGRZ0','50','D','10','10',NULL,'Primary Email',NULL,NULL,'"drvPrimaryEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3FORMHiGRZ0','50','D','10','11',NULL,'Email 2',NULL,NULL,'"drvEmail2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3FORMHiGRZ0','50','D','10','12',NULL,'Group 1 State',NULL,NULL,'"drvGroup1State"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3FORMHiGRZ0','50','D','10','13',NULL,'Group 2 Department',NULL,NULL,'"drvGroup2Department"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E3FORMHiGRZ0','50','D','10','14',NULL,'Group 3 Manager',NULL,NULL,'"drvGroup3Manager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E3FORMHiGRZ0','50','D','10','15',NULL,'Group 4 Location',NULL,NULL,'"drvGroup4Location"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E3FORMHiGRZ0','50','D','10','16',NULL,'Group 5 Country',NULL,NULL,'"drvGroup5Country"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E3FORMHiGRZ0','50','D','10','17',NULL,'Group 6 Job Title',NULL,NULL,'"drvGroup6JobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E3FORMHiGRZ0','50','D','10','18',NULL,'Group 7 Shift Number',NULL,NULL,'"drvGroup7ShiftNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E3FORMHiGRZ0','50','D','10','19',NULL,'Group 8 Pay Category',NULL,NULL,'"drvGroup8PayCategory"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E3FORMHiGRZ0','50','D','10','20',NULL,'Group 9 Pay Type',NULL,NULL,'"drvGroup9PayType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E3FORMHiGRZ0','50','D','10','21',NULL,'Group 10 Hourly/Salaried',NULL,NULL,'"drvGroup10HourlySalaried"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E3FORMHiGRZ0','50','D','10','22',NULL,'Group 11 Supervisor Email',NULL,NULL,'"drvGroup11SupervisorEmail"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'E3FORMHIGR_20220920.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'High Ground Solutions Demo Exp','202209199','EMPEXPORT','ONDEM_XOE',NULL,'E3FORMHiGR',NULL,NULL,NULL,'202209199','Sep 19 2022  2:34PM','Sep 19 2022  2:34PM','202209191',NULL,'','','202209191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'High Ground Solutions De-Sched','202209199','EMPEXPORT','SCH_E3FORM',NULL,'E3FORMHiGR',NULL,NULL,NULL,'202209199','Sep 19 2022  2:34PM','Sep 19 2022  2:34PM','202209191',NULL,'','','202209191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'High Ground Solutions De-Test','202209199','EMPEXPORT','TEST_XOE',NULL,'E3FORMHiGR',NULL,NULL,NULL,'202209199','Sep 19 2022  2:34PM','Sep 19 2022  2:34PM','202209191',NULL,'','','202209191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHiGR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHIGR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHiGR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHiGR','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHiGR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHIGR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E3FORMHIGR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E3FORMHiGR','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E3FORMHiGR','D10','dbo.U_E3FORMHiGR_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_E3FORMHiGR_Audit
-----------

IF OBJECT_ID('U_E3FORMHiGR_Audit') IS NULL
CREATE TABLE [dbo].[U_E3FORMHiGR_Audit] (
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
-- Create table U_E3FORMHiGR_AuditFields
-----------

IF OBJECT_ID('U_E3FORMHiGR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_E3FORMHiGR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_E3FORMHiGR_drvTbl
-----------

IF OBJECT_ID('U_E3FORMHiGR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_E3FORMHiGR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvEmployeenumber] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvCellPhone2] varchar(50) NULL,
    [drvWorkPhone1] varchar(50) NULL,
    [drvPrimaryEmail] varchar(50) NULL,
    [drvEmail2] varchar(50) NULL,
    [drvGroup1State] varchar(2) NULL,
    [drvGroup2Department] varchar(36) NULL,
    [drvGroup3Manager] varchar(514) NULL,
    [drvGroup4Location] varchar(32) NULL,
    [drvGroup5Country] char(3) NULL,
    [drvGroup6JobTitle] varchar(150) NULL,
    [drvGroup7ShiftNumber] varchar(1) NOT NULL,
    [drvGroup8PayCategory] varchar(9) NULL,
    [drvGroup9PayType] varchar(10) NULL,
    [drvGroup10HourlySalaried] varchar(6) NULL,
    [drvGroup11SupervisorEmail] varchar(256) NULL
);

-----------
-- Create table U_E3FORMHiGR_EEList
-----------

IF OBJECT_ID('U_E3FORMHiGR_EEList') IS NULL
CREATE TABLE [dbo].[U_E3FORMHiGR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_E3FORMHiGR_File
-----------

IF OBJECT_ID('U_E3FORMHiGR_File') IS NULL
CREATE TABLE [dbo].[U_E3FORMHiGR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E3FORMHiGR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: 3Form

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 09/19/2022
Service Request Number: TekP-2022-07-27-02 

Purpose: High Ground Solutions Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'E3FORMHiGR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'E3FORMHiGR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'E3FORMHiGR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'E3FORMHiGR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'E3FORMHiGR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E3FORMHiGR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E3FORMHiGR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E3FORMHiGR', 'SCH_E3FORM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'E3FORMHiGR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'E3FORMHiGR';

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
    DELETE FROM dbo.U_E3FORMHiGR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_E3FORMHiGR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_E3FORMHiGR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_E3FORMHiGR_AuditFields;
    CREATE TABLE dbo.U_E3FORMHiGR_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_E3FORMHiGR_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_E3FORMHiGR_AuditFields VALUES ('EmpComp','EecEmplStatus');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_E3FORMHiGR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_E3FORMHiGR_Audit;
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
    INTO dbo.U_E3FORMHiGR_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_E3FORMHiGR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_E3FORMHiGR_Audit ON dbo.U_E3FORMHiGR_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_E3FORMHiGR_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_E3FORMHiGR_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_E3FORMHiGR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_E3FORMHiGR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_E3FORMHiGR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeenumber = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvCellPhone2 = CASE WHEN eepPhoneHomeNumber is not null then eepPhoneHomeNumber ELSE efoPhoneNumber END
        ,drvWorkPhone1 = CASE WHEN eepPhoneHomeNumber is not null then eepPhoneHomeNumber ELSE efoPhoneNumber END
        ,drvPrimaryEmail = EepAddressEMail
        ,drvEmail2 = EepAddressEmailAlternate
        ,drvGroup1State = left(EepAddressState,2)
        ,drvGroup2Department =  Ltrim(rtrim(orgcode))+'-'+ orgdesc
        ,drvGroup3Manager = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast') + ', ' + dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'Namefirst')
        ,drvGroup4Location = locCode+'-'+locDesc
        ,drvGroup5Country = EepAddressCountry
        ,drvGroup6JobTitle = JbclongDesc 
        ,drvGroup7ShiftNumber = '' -- shift number from Time Management
        ,drvGroup8PayCategory = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time'  
                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'Part Time'
                                     END
        ,drvGroup9PayType = CASE WHEN JbcFLSAType= 'E' THEN 'Exempt' 
                                 WHEN JbcFLSAType= 'N' THEN 'Non Exempt' 
                                 END
        ,drvGroup10HourlySalaried = CASE WHEN EecSalaryOrHourly = 'S'  THEN 'Salary' 
                                         WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
                                        END
        ,drvGroup11SupervisorEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, ' AddressEMail')
    INTO dbo.U_E3FORMHiGR_drvTbl
    FROM dbo.U_E3FORMHiGR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.Orglevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
     LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
        Where EecEmplStatus in ('A')
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
ALTER VIEW dbo.dsi_vwE3FORMHiGR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_E3FORMHiGR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'E3FORMHiGR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209121'
       ,expStartPerControl     = '202209121'
       ,expLastEndPerControl   = '202209199'
       ,expEndPerControl       = '202209199'
WHERE expFormatCode = 'E3FORMHiGR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwE3FORMHiGR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_E3FORMHiGR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'E3FORMHIGR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'E3FORMHIGR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'E3FORMHIGR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E3FORMHIGR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'E3FORMHIGR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E3FORMHIGR', 'UseFileName', 'V', 'Y'


-- End ripout