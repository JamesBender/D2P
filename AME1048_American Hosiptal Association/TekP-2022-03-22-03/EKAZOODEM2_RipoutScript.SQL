/**********************************************************************************

EKAZOODEM2: Kazoo Demographic File Export

FormatCode:     EKAZOODEM2
Project:        Kazoo Demographic File Export
Client ID:      AME1048
Date/time:      2022-05-10 10:57:27.243
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP2DB01
Database:       ULTIPRO_WPAHA
Web Filename:   AME1048_72359_EEHISTORY_EKAZOODEM2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EKAZOODEM2_SavePath') IS NOT NULL DROP TABLE dbo.U_EKAZOODEM2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EKAZOODEM2'


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
WHERE FormatCode = 'EKAZOODEM2'
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
WHERE ExpFormatCode = 'EKAZOODEM2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EKAZOODEM2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EKAZOODEM2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EKAZOODEM2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EKAZOODEM2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EKAZOODEM2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EKAZOODEM2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EKAZOODEM2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EKAZOODEM2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EKAZOODEM2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EKAZOODEM2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEKAZOODEM2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEKAZOODEM2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EKAZOODEM2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EKAZOODEM2];
GO
IF OBJECT_ID('U_EKAZOODEM2_File') IS NOT NULL DROP TABLE [dbo].[U_EKAZOODEM2_File];
GO
IF OBJECT_ID('U_EKAZOODEM2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EKAZOODEM2_EEList];
GO
IF OBJECT_ID('U_EKAZOODEM2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EKAZOODEM2_drvTbl];
GO
IF OBJECT_ID('U_EKAZOODEM2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EKAZOODEM2_AuditFields];
GO
IF OBJECT_ID('U_EKAZOODEM2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EKAZOODEM2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EKAZOODEM2','Kazoo Demographic File Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EKAZOODEM2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAZOODEM2Z0','50','H','01','1',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAZOODEM2Z0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAZOODEM2Z0','50','H','01','3',NULL,'Preferred Name',NULL,NULL,'"Preferred Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAZOODEM2Z0','50','H','01','4',NULL,'User Status',NULL,NULL,'"User Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAZOODEM2Z0','50','H','01','5',NULL,'Start Date',NULL,NULL,'"Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAZOODEM2Z0','50','H','01','6',NULL,'Offboard Date',NULL,NULL,'"Offboard Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAZOODEM2Z0','50','H','01','7',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAZOODEM2Z0','50','H','01','8',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAZOODEM2Z0','50','H','01','9',NULL,'Username',NULL,NULL,'"Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EKAZOODEM2Z0','50','H','01','10',NULL,'Login Email',NULL,NULL,'"Login Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EKAZOODEM2Z0','50','H','01','11',NULL,'Notification Email',NULL,NULL,'"Notification Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EKAZOODEM2Z0','50','H','01','12',NULL,'Title/Position',NULL,NULL,'"Title/Position"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EKAZOODEM2Z0','50','H','01','13',NULL,'YEI User Role',NULL,NULL,'"YEI User Role"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EKAZOODEM2Z0','50','H','01','14',NULL,'HG User Role',NULL,NULL,'"HG User Role"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EKAZOODEM2Z0','50','H','01','15',NULL,'Group',NULL,NULL,'"Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EKAZOODEM2Z0','50','H','01','16',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EKAZOODEM2Z0','50','H','01','17',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EKAZOODEM2Z0','50','H','01','18',NULL,'Assigned Manager',NULL,NULL,'"Assigned Manager"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EKAZOODEM2Z0','50','H','01','19',NULL,'Birthdate',NULL,NULL,'"Birthdate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EKAZOODEM2Z0','50','H','01','20',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EKAZOODEM2Z0','50','H','01','21',NULL,'Custom Point Rule',NULL,NULL,'"Custom Point Rule"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EKAZOODEM2Z0','50','H','01','22',NULL,'Points to Redeem',NULL,NULL,'"Points to Redeem"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EKAZOODEM2Z0','50','H','01','23',NULL,'Points to Send',NULL,NULL,'"Points to Send"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EKAZOODEM2Z0','50','H','01','24',NULL,'Hide Anniversary',NULL,NULL,'"Hide Anniversary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EKAZOODEM2Z0','50','H','01','25',NULL,'Hide Birthday',NULL,NULL,'"Hide Birthday"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EKAZOODEM2Z0','50','H','01','26',NULL,'Profile Image',NULL,NULL,'"Profile Image"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EKAZOODEM2Z0','50','H','01','27',NULL,'Locale setting',NULL,NULL,'"Locale setting"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EKAZOODEM2Z0','50','H','01','28',NULL,'Group',NULL,NULL,'"Group"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAZOODEM2Z0','50','D','10','1',NULL,'First Name',NULL,NULL,'"drvNameFirst "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAZOODEM2Z0','50','D','10','2',NULL,'Last Name',NULL,NULL,'"drvNameLast "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAZOODEM2Z0','50','D','10','3',NULL,'Preferred Name',NULL,NULL,'"drvNamePreferred"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAZOODEM2Z0','50','D','10','4',NULL,'User Status',NULL,NULL,'"drvUserStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAZOODEM2Z0','50','D','10','5',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAZOODEM2Z0','50','D','10','6',NULL,'Offboard Date',NULL,NULL,'"drvOffboardDate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAZOODEM2Z0','50','D','10','7',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAZOODEM2Z0','50','D','10','8',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAZOODEM2Z0','50','D','10','9',NULL,'Username',NULL,NULL,'"drvUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EKAZOODEM2Z0','50','D','10','10',NULL,'Login Email',NULL,NULL,'"drvLoginEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EKAZOODEM2Z0','50','D','10','11',NULL,'Notification Email',NULL,NULL,'"drvNotificationEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EKAZOODEM2Z0','50','D','10','12',NULL,'Title/Position',NULL,NULL,'"drvTitlePosition"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EKAZOODEM2Z0','50','D','10','13',NULL,'YEI User Role',NULL,NULL,'"drvYEIUserRole"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EKAZOODEM2Z0','50','D','10','14',NULL,'HG User Role',NULL,NULL,'"drvHGUserRole"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EKAZOODEM2Z0','50','D','10','15',NULL,'Group',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EKAZOODEM2Z0','50','D','10','16',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EKAZOODEM2Z0','50','D','10','17',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EKAZOODEM2Z0','50','D','10','18',NULL,'Assigned Manager',NULL,NULL,'"drvAssignedManager"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EKAZOODEM2Z0','50','D','10','19',NULL,'Birthdate',NULL,NULL,'"drvBirthdate"','(''UD23''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EKAZOODEM2Z0','50','D','10','20',NULL,'Country',NULL,NULL,'"USA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EKAZOODEM2Z0','50','D','10','21',NULL,'Custom Point Rule',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EKAZOODEM2Z0','50','D','10','22',NULL,'Points to Redeem',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EKAZOODEM2Z0','51','D','10','23',NULL,'Points to Send',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EKAZOODEM2Z0','52','D','10','24',NULL,'Hide Anniversary',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EKAZOODEM2Z0','53','D','10','25',NULL,'Hide Birthday',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EKAZOODEM2Z0','54','D','10','26',NULL,'Profile Image',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EKAZOODEM2Z0','55','D','10','27',NULL,'Locale setting',NULL,NULL,'"en-us"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EKAZOODEM2Z0','56','D','10','28',NULL,'Group',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EKAZOODEM2_20220510.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kazoo Demographic File Export','202205099','EMPEXPORT','ONDEM_XOE',NULL,'EKAZOODEM2',NULL,NULL,NULL,'202205099','May  9 2022  4:08PM','May  9 2022  4:08PM','202205091',NULL,'','','202205091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kazoo Demographic File E-Sched','202205099','EMPEXPORT','SCH_EKAZOO',NULL,'EKAZOODEM2',NULL,NULL,NULL,'202205099','May  9 2022  4:08PM','May  9 2022  4:08PM','202205091',NULL,'','','202205091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Kazoo Demographic File E-Test','202205099','EMPEXPORT','TEST_XOE','May  9 2022 12:00AM','EKAZOODEM2',NULL,NULL,NULL,'202205099','May  9 2022 12:00AM','Dec 30 1899 12:00AM','202205021',NULL,'','','202205021',dbo.fn_GetTimedKey(),NULL,'us3mWaAME1048',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAZOODEM2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAZOODEM2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAZOODEM2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAZOODEM2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAZOODEM2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAZOODEM2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAZOODEM2','D10','dbo.U_EKAZOODEM2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EKAZOODEM2_Audit
-----------

IF OBJECT_ID('U_EKAZOODEM2_Audit') IS NULL
CREATE TABLE [dbo].[U_EKAZOODEM2_Audit] (
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
-- Create table U_EKAZOODEM2_AuditFields
-----------

IF OBJECT_ID('U_EKAZOODEM2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EKAZOODEM2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EKAZOODEM2_drvTbl
-----------

IF OBJECT_ID('U_EKAZOODEM2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EKAZOODEM2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNamePreferred] varchar(100) NULL,
    [drvUserStatus] varchar(10) NOT NULL,
    [drvStartDate] datetime NULL,
    [drvOffboardDate] datetime NULL,
    [drvEmployeeType] varchar(20) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvUsername] varchar(50) NULL,
    [drvLoginEmail] varchar(50) NULL,
    [drvNotificationEmail] varchar(50) NULL,
    [drvTitlePosition] varchar(25) NOT NULL,
    [drvYEIUserRole] varchar(8) NOT NULL,
    [drvHGUserRole] varchar(8) NOT NULL,
    [drvDepartment] varchar(25) NULL,
    [drvLocation] varchar(25) NULL,
    [drvAssignedManager] varchar(256) NULL,
    [drvBirthdate] datetime NULL
);

-----------
-- Create table U_EKAZOODEM2_EEList
-----------

IF OBJECT_ID('U_EKAZOODEM2_EEList') IS NULL
CREATE TABLE [dbo].[U_EKAZOODEM2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EKAZOODEM2_File
-----------

IF OBJECT_ID('U_EKAZOODEM2_File') IS NULL
CREATE TABLE [dbo].[U_EKAZOODEM2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EKAZOODEM2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Hospital Association

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 05/09/2022
Service Request Number: TekP-2022-03-22-03

Purpose: Kazoo Demographic File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EKAZOODEM2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EKAZOODEM2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EKAZOODEM2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EKAZOODEM2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EKAZOODEM2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAZOODEM2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAZOODEM2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAZOODEM2', 'SCH_EKAZOO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EKAZOODEM2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EKAZOODEM2';

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
    DELETE FROM dbo.U_EKAZOODEM2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EKAZOODEM2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EKAZOODEM2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EKAZOODEM2_AuditFields;
    CREATE TABLE dbo.U_EKAZOODEM2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EKAZOODEM2_AuditFields VALUES ('Empcomp','EecEmplstatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EKAZOODEM2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EKAZOODEM2_Audit;
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
    INTO dbo.U_EKAZOODEM2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EKAZOODEM2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EKAZOODEM2_Audit ON dbo.U_EKAZOODEM2_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EKAZOODEM2_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EKAZOODEM2_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EKAZOODEM2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EKAZOODEM2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EKAZOODEM2_drvTbl;
    SELECT DISTINCT
         drvEEID                    = xEEID
        ,drvCoID                    = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvNameFirst               = EepNameFirst
        ,drvNameLast                = EepNameLast
        ,drvNamePreferred           = EepNamePreferred
        ,drvUserStatus              = CASE WHEN  EecEmplStatus = 'T' THEN 'Archived' Else 'Active' END ---CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' Else 'Active' END
        ,drvStartDate               = EecDateOfLastHire
        ,drvOffboardDate            = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmployeeType            = CASE 
                                            WHEN EecEEType = 'PTN' THEN 'PART TIME NO BENEFIT'
                                            WHEN EecEEType = 'RFT' THEN 'REGULAR FULL TIME'
                                            WHEN EecEEType = 'RPT' THEN 'REGULAR PART TIME'
                                            ELSE '' 
                                        END
        ,drvEmployeeID               = EecEmpNo
        ,drvUsername                 = EepAddressEMail
        ,drvLoginEmail               = EepAddressEMail
        ,drvNotificationEmail        = EepAddressEMail
        ,drvTitlePosition            = JbcDesc
        ,drvYEIUserRole              = CASE 
                                            WHEN RolnameMGR   = 'MGR' and ISNULL(RolnameAdm, '')   = '' THEN 'Manager'
                                            WHEN RolnameAdm   = 'PERFADMIN' THEN 'Admin'
                                            ELSE 'Employee'
                                        END
        ,drvHGUserRole               = CASE
                                            WHEN  RolnameMGR   = 'MGR' and ISNULL(RolnameAdm, '')   = '' THEN 'Manager'
                                            WHEN RolnameAdm   = 'PERFADMIN' THEN 'Admin'
                                            ELSE 'Employee'
                                        END
        ,drvDepartment              = OrgDesc
        ,drvLocation                = LocDesc
        ,drvAssignedManager         = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'empno')   
        ,drvBirthdate               = EepDateOfBirth
    INTO dbo.U_EKAZOODEM2_drvTbl
    FROM dbo.U_EKAZOODEM2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID AND EecEEType <> 'TES'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Orglevel WITH (NOLOCK)
        ON orgcode = EecOrgLvl2 and OrgLvl = 2
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode 
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
            SELECT RurEEID,RolnameMGR = max(case when RolName IN ('MGR') THEN RolName END) 
            ,RolnameAdm = max(case when RolName IN ('PERFADMIN') THEN RolName END) 
                  ,rolid = max(case when RolName IN ('MGR','PERFADMIN') THEN RolId END) 
             from dbo.RbsROles     
             JOIN dbo.RbsUserRoles WITH (NOLOCK)
                ON  RurroleID = RolID
                group by RurEEID
            ) Roles
        ON Roles.RurEEID = xEEID
    LEFT JOIN dbo.U_EKAZOODEM2_Audit WITH(NOLOCK)
        ON audEEID = xEEID and audKey2 = xCOID
     WHERE (EecEmplStatus IN ('A','L')
           OR (EecEmplStatus = 'T' AND  eecTermReason <> 'TRO'  AND audEEID IS NOT NULL))
           AND EecEEType IN ( 'PRN', 'RFT', 'RPT')

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
ALTER VIEW dbo.dsi_vwEKAZOODEM2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EKAZOODEM2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EKAZOODEM2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202205021'
       ,expStartPerControl     = '202205021'
       ,expLastEndPerControl   = '202205099'
       ,expEndPerControl       = '202205099'
WHERE expFormatCode = 'EKAZOODEM2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEKAZOODEM2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EKAZOODEM2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EKAZOODEM2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EKAZOODEM2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EKAZOODEM2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EKAZOODEM2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EKAZOODEM2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EKAZOODEM2', 'UseFileName', 'V', 'Y'


-- End ripout