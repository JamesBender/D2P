/**********************************************************************************

EARCCONDEM: Convergence Demographic Export

FormatCode:     EARCCONDEM
Project:        Convergence Demographic Export
Client ID:      ARC1020
Date/time:      2023-07-13 12:21:40.407
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB02
Database:       ULTIPRO_WPARCAB
Web Filename:   ARC1020_KH7LJ_EEHISTORY_EARCCONDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EARCCONDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_EARCCONDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EARCCONDEM'


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
WHERE FormatCode = 'EARCCONDEM'
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
WHERE ExpFormatCode = 'EARCCONDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EARCCONDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EARCCONDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EARCCONDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EARCCONDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EARCCONDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EARCCONDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EARCCONDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EARCCONDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EARCCONDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EARCCONDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEARCCONDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEARCCONDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EARCCONDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARCCONDEM];
GO
IF OBJECT_ID('U_EARCCONDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EARCCONDEM_File];
GO
IF OBJECT_ID('U_EARCCONDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EARCCONDEM_EEList];
GO
IF OBJECT_ID('U_EARCCONDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EARCCONDEM_drvTbl];
GO
IF OBJECT_ID('U_EARCCONDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EARCCONDEM_AuditFields];
GO
IF OBJECT_ID('U_EARCCONDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_EARCCONDEM_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EARCCONDEM','Convergence Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EARCCONDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARCCONDEMZ0','50','H','01','1',NULL,'Import User?',NULL,NULL,'"Import User?"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARCCONDEMZ0','50','H','01','2',NULL,'Is Active?',NULL,NULL,'"Is Active?"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARCCONDEMZ0','50','H','01','3',NULL,'Organization Name',NULL,NULL,'"Organization Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARCCONDEMZ0','50','H','01','4',NULL,'Region ID',NULL,NULL,'"Region ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARCCONDEMZ0','50','H','01','5',NULL,'Region Name',NULL,NULL,'"Region Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARCCONDEMZ0','50','H','01','6',NULL,'Site ID',NULL,NULL,'"Site ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARCCONDEMZ0','50','H','01','7',NULL,'Site Name',NULL,NULL,'"Site Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARCCONDEMZ0','50','H','01','8',NULL,'Department ID',NULL,NULL,'"Department ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARCCONDEMZ0','50','H','01','9',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARCCONDEMZ0','50','H','01','10',NULL,'Team ID',NULL,NULL,'"Team ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARCCONDEMZ0','50','H','01','11',NULL,'Team Name',NULL,NULL,'"Team Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARCCONDEMZ0','50','H','01','12',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARCCONDEMZ0','50','H','01','13',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARCCONDEMZ0','50','H','01','14',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARCCONDEMZ0','50','H','01','15',NULL,'Username',NULL,NULL,'"Username"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARCCONDEMZ0','50','H','01','16',NULL,'Password',NULL,NULL,'"Password"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARCCONDEMZ0','50','H','01','17',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARCCONDEMZ0','50','H','01','18',NULL,'Phone',NULL,NULL,'"Phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARCCONDEMZ0','50','H','01','19',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARCCONDEMZ0','50','H','01','20',NULL,'External ID',NULL,NULL,'"External ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARCCONDEMZ0','50','H','01','21',NULL,'Supervisor',NULL,NULL,'"Supervisor"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARCCONDEMZ0','50','H','01','22',NULL,'Custom Field 1',NULL,NULL,'"Custom Field 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARCCONDEMZ0','50','H','01','23',NULL,'Custom Field 2',NULL,NULL,'"Custom Field 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARCCONDEMZ0','50','H','01','24',NULL,'Custom Field 3',NULL,NULL,'"Custom Field 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARCCONDEMZ0','50','H','01','25',NULL,'Custom Field 4',NULL,NULL,'"Custom Field 4"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EARCCONDEMZ0','50','D','10','1',NULL,'Import User?',NULL,NULL,'"drvImportUser"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EARCCONDEMZ0','50','D','10','2',NULL,'Is Active?',NULL,NULL,'"drvIsActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EARCCONDEMZ0','50','D','10','3',NULL,'Organization Name',NULL,NULL,'"drvOrganizationName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EARCCONDEMZ0','50','D','10','4',NULL,'Region ID',NULL,NULL,'"drvRegionID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EARCCONDEMZ0','50','D','10','5',NULL,'Region Name',NULL,NULL,'"drvRegionName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EARCCONDEMZ0','50','D','10','6',NULL,'Site ID',NULL,NULL,'"drvSiteID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EARCCONDEMZ0','50','D','10','7',NULL,'Site Name',NULL,NULL,'"drvSiteName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EARCCONDEMZ0','50','D','10','8',NULL,'Department ID',NULL,NULL,'"drvDepartmentID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EARCCONDEMZ0','50','D','10','9',NULL,'Department Name',NULL,NULL,'"drvDepartmentName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EARCCONDEMZ0','50','D','10','10',NULL,'Team ID',NULL,NULL,'"drvTeamID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EARCCONDEMZ0','50','D','10','11',NULL,'Team Name',NULL,NULL,'"drvTeamName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EARCCONDEMZ0','50','D','10','12',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EARCCONDEMZ0','50','D','10','13',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EARCCONDEMZ0','50','D','10','14',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EARCCONDEMZ0','50','D','10','15',NULL,'Username',NULL,NULL,'"drvUsername"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EARCCONDEMZ0','50','D','10','16',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EARCCONDEMZ0','50','D','10','17',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EARCCONDEMZ0','50','D','10','18',NULL,'Phone',NULL,NULL,'"drvPhonePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EARCCONDEMZ0','50','D','10','19',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EARCCONDEMZ0','50','D','10','20',NULL,'External ID',NULL,NULL,'"drvExternalID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EARCCONDEMZ0','50','D','10','21',NULL,'Supervisor',NULL,NULL,'"drvSupervisor"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EARCCONDEMZ0','50','D','10','22',NULL,'Custom Field 1',NULL,NULL,'"drvCustomField1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EARCCONDEMZ0','50','D','10','23',NULL,'Custom Field 2',NULL,NULL,'"drvCustomField2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EARCCONDEMZ0','50','D','10','24',NULL,'Custom Field 3',NULL,NULL,'"drvCustomField3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EARCCONDEMZ0','50','D','10','25',NULL,'Custom Field 4',NULL,NULL,'"drvCustomField4"','(''UA''=''T|'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EARCCONDEM_20230713.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Convergence Demographic Export','202307109','EMPEXPORT','ONDEM_XOE',NULL,'EARCCONDEM',NULL,NULL,NULL,'202307109','Jul 10 2023  4:09PM','Jul 10 2023  4:09PM','202307101',NULL,'','','202307101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Convergence Demographic -Sched','202307109','EMPEXPORT','SCH_EARCCO',NULL,'EARCCONDEM',NULL,NULL,NULL,'202307109','Jul 10 2023  4:09PM','Jul 10 2023  4:09PM','202307101',NULL,'','','202307101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Convergence Demographic -Test','202307109','EMPEXPORT','TEST_XOE',NULL,'EARCCONDEM',NULL,NULL,NULL,'202307109','Jul 10 2023  4:09PM','Jul 10 2023  4:09PM','202307101',NULL,'','','202307101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EARCCONDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARCCONDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EARCCONDEM','D10','dbo.U_EARCCONDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EARCCONDEM_Audit
-----------

IF OBJECT_ID('U_EARCCONDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_EARCCONDEM_Audit] (
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
-- Create table U_EARCCONDEM_AuditFields
-----------

IF OBJECT_ID('U_EARCCONDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EARCCONDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EARCCONDEM_drvTbl
-----------

IF OBJECT_ID('U_EARCCONDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EARCCONDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvImportUser] varchar(5) NOT NULL,
    [drvIsActive] varchar(5) NOT NULL,
    [drvOrganizationName] varchar(13) NOT NULL,
    [drvRegionID] varchar(1) NOT NULL,
    [drvRegionName] varchar(255) NULL,
    [drvSiteID] varchar(1) NOT NULL,
    [drvSiteName] varchar(25) NULL,
    [drvDepartmentID] varchar(1) NOT NULL,
    [drvDepartmentName] varchar(37) NOT NULL,
    [drvTeamID] varchar(1) NOT NULL,
    [drvTeamName] varchar(25) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvUsername] char(9) NULL,
    [drvPassword] varchar(103) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhonePhone] varchar(1) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvExternalID] char(9) NULL,
    [drvSupervisor] varchar(256) NULL,
    [drvCustomField1] varchar(1) NOT NULL,
    [drvCustomField2] varchar(1) NOT NULL,
    [drvCustomField3] varchar(1) NOT NULL,
    [drvCustomField4] varchar(1) NOT NULL
);

-----------
-- Create table U_EARCCONDEM_EEList
-----------

IF OBJECT_ID('U_EARCCONDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EARCCONDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EARCCONDEM_File
-----------

IF OBJECT_ID('U_EARCCONDEM_File') IS NULL
CREATE TABLE [dbo].[U_EARCCONDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EARCCONDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Arcade Beauty

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 07/10/2023
Service Request Number: TekP-2023-06-14-03

Purpose: Convergence Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EARCCONDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EARCCONDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EARCCONDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EARCCONDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EARCCONDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCCONDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCCONDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EARCCONDEM', 'SCH_EARCCO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EARCCONDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EARCCONDEM';

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
    DELETE FROM dbo.U_EARCCONDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EARCCONDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EARCCONDEM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EARCCONDEM_AuditFields;
    CREATE TABLE dbo.U_EARCCONDEM_AuditFields (aTableName varchar(30),aFieldName varchar(30));

     INSERT INTO dbo.U_EARCCONDEM_AuditFields VALUES ('Empcomp','EecDateOfTermination')
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EARCCONDEM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EARCCONDEM_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EARCCONDEM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EARCCONDEM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EARCCONDEM_Audit ON dbo.U_EARCCONDEM_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EARCCONDEM_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EARCCONDEM_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EARCCONDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EARCCONDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EARCCONDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpno
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvImportUser = Case when EecHireSource = 'Y' OR EecEmplStatus IN ('A','L') THEN 'True' Else 'False' END
        ,drvIsActive = Case when EecHireSource = 'Y' OR EecEmplStatus IN ('A','L') THEN 'True' Else 'False' END
        ,drvOrganizationName = 'Arcade Beauty'
        ,drvRegionID = ''
        ,drvRegionName = locaddressstate
        ,drvSiteID = ''
        ,drvSiteName = O1.OrgDesc -- EecOrglvl2--?? EecOrgCode
        ,drvDepartmentID = ''
        ,drvDepartmentName =  Concat(EecOrglvl2, '  ',O2.OrgDesc)
        ,drvTeamID = ''
        ,drvTeamName = JbcDesc
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvUsername = EecEmpNo
        ,drvPassword = Case when EecHireSource = 'Y' THEN Concat(EepNameFirst,'@01')END
        ,drvEmailAddress = EepAddressEMail
        ,drvPhonePhone = ''
        ,drvJobTitle = JbcDesc
        ,drvExternalID = EecEmpno
        ,drvSupervisor = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'EmpNo')
        ,drvCustomField1 = ''
        ,drvCustomField2 = ''
        ,drvCustomField3 = ''
        ,drvCustomField4 = ''
    INTO dbo.U_EARCCONDEM_drvTbl
    FROM dbo.U_EARCCONDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
        JOIN OrgLevel O1 WITH (NOLOCK) 
        ON O1.orgCode = EecOrglvl1
        AND O1.OrgLvl = '1'  
     JOIN OrgLevel O2 WITH (NOLOCK) 
        ON O2.orgCode = eecOrglvl2
        AND O2.OrgLvl = '2'    
    JOIN dbo.Location WITH (NOLOCK)
       ON LocCode = EecLocation
    LEFT JOIN dbo.U_EARCCONDEM_Audit WITH (NOLOCK)
       ON audeeid = Xeeid
       and AudCoid = Xcoid
      Where EecEEType = 'REG'        
        AND (EecEmplStatus <> 'T'  
           OR ( EecEmplStatus <> 'T' and EecTermReason <> 'TRO' AND audDateTime between @StartDate and @enddate))
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
ALTER VIEW dbo.dsi_vwEARCCONDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EARCCONDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EARCCONDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307031'
       ,expStartPerControl     = '202307031'
       ,expLastEndPerControl   = '202307109'
       ,expEndPerControl       = '202307109'
WHERE expFormatCode = 'EARCCONDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEARCCONDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EARCCONDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EARCCONDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EARCCONDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EARCCONDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARCCONDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EARCCONDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EARCCONDEM', 'UseFileName', 'V', 'Y'


-- End ripout