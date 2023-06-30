/**********************************************************************************

ECHIRELDEM: Relias Demograhic

FormatCode:     ECHIRELDEM
Project:        Relias Demograhic
Client ID:      CHI1033
Date/time:      2023-06-30 16:26:59.590
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP6DB02
Database:       ULTIPRO_WPCLDI
Web Filename:   CHI1033_3CQHE_EEHISTORY_ECHIRELDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECHIRELDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_ECHIRELDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECHIRELDEM'


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
WHERE FormatCode = 'ECHIRELDEM'
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
WHERE ExpFormatCode = 'ECHIRELDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECHIRELDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECHIRELDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECHIRELDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECHIRELDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECHIRELDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECHIRELDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECHIRELDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECHIRELDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECHIRELDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECHIRELDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECHIRELDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECHIRELDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECHIRELDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECHIRELDEM];
GO
IF OBJECT_ID('U_ECHIRELDEM_File') IS NOT NULL DROP TABLE [dbo].[U_ECHIRELDEM_File];
GO
IF OBJECT_ID('U_ECHIRELDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECHIRELDEM_EEList];
GO
IF OBJECT_ID('U_ECHIRELDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECHIRELDEM_drvTbl];
GO
IF OBJECT_ID('U_ECHIRELDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECHIRELDEM_AuditFields];
GO
IF OBJECT_ID('U_ECHIRELDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECHIRELDEM_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECHIRELDEM','Relias Demograhic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECHIRELDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECHIRELDEMZ0','50','D','10','1',NULL,'Entry type ',NULL,NULL,'"drvEntryType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECHIRELDEMZ0','50','D','10','2',NULL,'OrgID ',NULL,NULL,'"drvOrgID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECHIRELDEMZ0','50','D','10','3',NULL,'OrgCode ',NULL,NULL,'"drvOrgCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECHIRELDEMZ0','50','D','10','4',NULL,'Last Name ',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECHIRELDEMZ0','50','D','10','5',NULL,'First Name ',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECHIRELDEMZ0','50','D','10','6',NULL,'User Name ',NULL,NULL,'"drvUserName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECHIRELDEMZ0','50','D','10','7',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECHIRELDEMZ0','50','D','10','8',NULL,'GUID ',NULL,NULL,'"drvGUID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECHIRELDEMZ0','50','D','10','9',NULL,'Employee ID ',NULL,NULL,'"drvEmployeeId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECHIRELDEMZ0','50','D','10','10',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECHIRELDEMZ0','50','D','10','11',NULL,'Termination Date ',NULL,NULL,'"drvTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECHIRELDEMZ0','50','D','10','12',NULL,'Email ',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECHIRELDEMZ0','50','D','10','13',NULL,'Job Title ',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECHIRELDEMZ0','50','D','10','14',NULL,'Department ',NULL,NULL,'"drvDepartment"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECHIRELDEMZ0','50','D','10','15',NULL,'Organization ',NULL,NULL,'"drvOrganization"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECHIRELDEMZ0','50','D','10','16',NULL,'Location ',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECHIRELDEMZ0','50','D','10','17',NULL,'Work Phone ',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECHIRELDEMZ0','50','D','10','18',NULL,'Credentials ',NULL,NULL,'"drvCredentials"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECHIRELDEMZ0','50','D','10','19',NULL,'Fax ',NULL,NULL,'"drvFax"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECHIRELDEMZ0','50','D','10','20',NULL,'Address ',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECHIRELDEMZ0','50','D','10','21',NULL,'Address2 ',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECHIRELDEMZ0','50','D','10','22',NULL,'City ',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECHIRELDEMZ0','50','D','10','23',NULL,'State ',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECHIRELDEMZ0','50','D','10','24',NULL,'Country ',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECHIRELDEMZ0','50','D','10','25',NULL,'Postal Code ',NULL,NULL,'"drvPostalCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECHIRELDEMZ0','50','D','10','26',NULL,'Active ',NULL,NULL,'"drvActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECHIRELDEMZ0','50','D','10','27',NULL,'HierarchyID ',NULL,NULL,'"drvHierarchyID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECHIRELDEMZ0','50','D','10','28',NULL,'UDF1 ',NULL,NULL,'"drvUDF1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECHIRELDEMZ0','50','D','10','29',NULL,'UDF2 ',NULL,NULL,'"drvUDF2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECHIRELDEMZ0','50','D','10','30',NULL,'UDF3 ',NULL,NULL,'"drvUDF3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECHIRELDEMZ0','50','D','10','31',NULL,'Restricted ',NULL,NULL,'"drvRestricted"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECHIRELDEMZ0','50','D','10','32',NULL,'User Categories ',NULL,NULL,'"drvUserCategories"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECHIRELDEMZ0','50','D','10','33',NULL,'Hide From Master ',NULL,NULL,'"drvHideFromMaster"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECHIRELDEMZ0','50','D','10','34',NULL,'CanElect ',NULL,NULL,'"drvCanElect"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECHIRELDEMZ0','50','D','10','35',NULL,'Self-Completion Mode',NULL,NULL,'"drvSelfCompletionMode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECHIRELDEMZ0','50','D','10','36',NULL,'External Request Mode ',NULL,NULL,'"drvExternalRequestMode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECHIRELDEMZ0','50','D','10','37',NULL,'Gender ',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECHIRELDEMZ0','50','D','10','38',NULL,'Ethnicity ',NULL,NULL,'"drvEthnicity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECHIRELDEMZ0','50','D','10','39',NULL,'Employment Types ',NULL,NULL,'"drvEmploymentTypes"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECHIRELDEMZ0','50','D','10','40',NULL,'Date of Birth ',NULL,NULL,'"drvDOB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECHIRELDEMZ0','50','D','10','41',NULL,'Middle Name ',NULL,NULL,'"drvMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECHIRELDEMZ0','50','D','10','42',NULL,'Administrator ',NULL,NULL,'"drvAdministrator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECHIRELDEMZ0','50','D','10','43',NULL,'Instructor ',NULL,NULL,'"drvInstructor"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECHIRELDEMZ0','50','D','10','44',NULL,'Supervisor ',NULL,NULL,'"drvSupervisor"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECHIRELDEMZ0','50','D','10','45',NULL,'Observer ',NULL,NULL,'"drvObserver"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECHIRELDEMZ0','50','D','10','46',NULL,'Performance Optimizer Reporter ',NULL,NULL,'"drvPerformanceOptReporter"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECHIRELDEMZ0','50','D','10','47',NULL,'Require ',NULL,NULL,'"drvRequire"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECHIRELDEMZ0','50','D','10','48',NULL,'Password Change on Next Login',NULL,NULL,'"drvPasswordChangeNextLogin"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECHIRELDEMZ0','50','D','10','49',NULL,'Exempt Status',NULL,NULL,'"drvExemptStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECHIRELDEMZ0','50','D','10','50',NULL,'Additional Hierarchy ID''s',NULL,NULL,'"drvAdditionalHierarchyID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECHIRELDEMZ0','51','D','10','51',NULL,'Comparison Group',NULL,NULL,'"drvComparisonGroup"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECHIRELDEM_20230630.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Relias Demograhic','202306309','EMPEXPORT','ONDEM_XOE',NULL,'ECHIRELDEM',NULL,NULL,NULL,'202306309','Jun 30 2023  3:41PM','Jun 30 2023  3:41PM','202306301',NULL,'','','202306301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Relias Demograhic-Sched','202306309','EMPEXPORT','SCH_ECHIRE',NULL,'ECHIRELDEM',NULL,NULL,NULL,'202306309','Jun 30 2023  3:41PM','Jun 30 2023  3:41PM','202306301',NULL,'','','202306301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Relias Demograhic-Test','202306309','EMPEXPORT','TEST_XOE',NULL,'ECHIRELDEM',NULL,NULL,NULL,'202306309','Jun 30 2023  3:41PM','Jun 30 2023  3:41PM','202306301',NULL,'','','202306301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECHIRELDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECHIRELDEM','D10','dbo.U_ECHIRELDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECHIRELDEM_Audit
-----------

IF OBJECT_ID('U_ECHIRELDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_ECHIRELDEM_Audit] (
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
-- Create table U_ECHIRELDEM_AuditFields
-----------

IF OBJECT_ID('U_ECHIRELDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECHIRELDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECHIRELDEM_drvTbl
-----------

IF OBJECT_ID('U_ECHIRELDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECHIRELDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEntryType] varchar(4) NOT NULL,
    [drvOrgID] varchar(4) NOT NULL,
    [drvOrgCode] varchar(7) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvUserName] char(9) NULL,
    [drvPassword] varchar(9) NOT NULL,
    [drvGUID] varchar(50) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvEmail] varchar(50) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvOrganization] varchar(1) NOT NULL,
    [drvLocation] varchar(25) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvCredentials] varchar(1) NOT NULL,
    [drvFax] varchar(1) NOT NULL,
    [drvAddress1] varchar(1) NOT NULL,
    [drvAddress2] varchar(1) NOT NULL,
    [drvCity] varchar(1) NOT NULL,
    [drvState] varchar(1) NOT NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvPostalCode] varchar(1) NOT NULL,
    [drvActive] varchar(1) NULL,
    [drvHierarchyID] varchar(1) NOT NULL,
    [drvUDF1] varchar(1) NOT NULL,
    [drvUDF2] varchar(1) NOT NULL,
    [drvUDF3] varchar(1) NOT NULL,
    [drvRestricted] varchar(1) NOT NULL,
    [drvUserCategories] varchar(1) NOT NULL,
    [drvHideFromMaster] varchar(1) NOT NULL,
    [drvCanElect] varchar(1) NOT NULL,
    [drvSelfCompletionMode] varchar(1) NOT NULL,
    [drvExternalRequestMode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvEthnicity] varchar(1) NOT NULL,
    [drvEmploymentTypes] char(3) NULL,
    [drvDOB] varchar(1) NOT NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvAdministrator] varchar(1) NOT NULL,
    [drvInstructor] varchar(1) NOT NULL,
    [drvSupervisor] varchar(1) NOT NULL,
    [drvObserver] varchar(1) NOT NULL,
    [drvPerformanceOptReporter] varchar(1) NOT NULL,
    [drvRequire] varchar(1) NOT NULL,
    [drvPasswordChangeNextLogin] varchar(1) NOT NULL,
    [drvExemptStatus] varchar(1) NOT NULL,
    [drvAdditionalHierarchyID] varchar(1) NOT NULL,
    [drvComparisonGroup] varchar(1) NOT NULL
);

-----------
-- Create table U_ECHIRELDEM_EEList
-----------

IF OBJECT_ID('U_ECHIRELDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_ECHIRELDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECHIRELDEM_File
-----------

IF OBJECT_ID('U_ECHIRELDEM_File') IS NULL
CREATE TABLE [dbo].[U_ECHIRELDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECHIRELDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CHILDREN'S INSTITUTE, INC.

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 06/30/2023
Service Request Number: SR-2023-00409526

Purpose: Relias Demograhic

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECHIRELDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECHIRELDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECHIRELDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECHIRELDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECHIRELDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECHIRELDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECHIRELDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECHIRELDEM', 'SCH_ECHIRE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECHIRELDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECHIRELDEM';

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
    DELETE FROM dbo.U_ECHIRELDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECHIRELDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECHIRELDEM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECHIRELDEM_AuditFields;
    CREATE TABLE dbo.U_ECHIRELDEM_AuditFields (aTableName varchar(30),aFieldName varchar(30));
      INSERT INTO dbo.U_ECHIRELDEM_AuditFields VALUES ('EmpComp','EecDateofTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECHIRELDEM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECHIRELDEM_Audit;
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
    INTO dbo.U_ECHIRELDEM_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECHIRELDEM_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(dd,-14,@StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECHIRELDEM_Audit ON dbo.U_ECHIRELDEM_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECHIRELDEM_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECHIRELDEM_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECHIRELDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECHIRELDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECHIRELDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEntryType = 'USER'
        ,drvOrgID = '8234'
        ,drvOrgCode = 'ASD8234'
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvUserName = EecEmpNo
        ,drvPassword = 'Temporary'
        ,drvGUID = eepAddressEMail
        ,drvEmployeeId = EecEmpNo
        ,drvHireDate = Convert(varchar(10), EecDateOfLastHire,126)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN Convert(varchar(10), EecDateOfTermination,126) END
        ,drvEmail = EepAddressEMail
        ,drvJobTitle = EecJobTitle 
        ,drvDepartment = OrgDesc
        ,drvOrganization = ''
        ,drvLocation = LocDesc
        ,drvWorkPhone = ''
        ,drvCredentials = ''
        ,drvFax = ''
        ,drvAddress1 = ''
        ,drvAddress2 = ''
        ,drvCity = ''
        ,drvState = ''
        ,drvCountry = ''
        ,drvPostalCode = ''
        ,drvActive = Case when EecEmplStatus = 'T' then '0'
                          when EecEmplStatus = 'A' then '1'
                          when EecEmplStatus in ('L', 'S', 'O') then '2'
                      END


        ,drvHierarchyID = ''
        ,drvUDF1 = ''
        ,drvUDF2 = ''
        ,drvUDF3 = ''
        ,drvRestricted = '1'
        ,drvUserCategories = ''
        ,drvHideFromMaster = ''
        ,drvCanElect = '1'
        ,drvSelfCompletionMode = ''
        ,drvExternalRequestMode = ''
        ,drvGender = ''
        ,drvEthnicity = ''
        ,drvEmploymentTypes = EecEEType
        ,drvDOB = ''
        ,drvMiddleName = EepNameMiddle
        ,drvAdministrator = ''
        ,drvInstructor = ''
        ,drvSupervisor = ''
        ,drvObserver = ''
        ,drvPerformanceOptReporter = ''
        ,drvRequire = ''
        ,drvPasswordChangeNextLogin = ''
        ,drvExemptStatus = ''
        ,drvAdditionalHierarchyID = ''
        ,drvComparisonGroup = ''
    INTO dbo.U_ECHIRELDEM_drvTbl
    FROM dbo.U_ECHIRELDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.LOCATION WITH (NOLOCK)
      ON LOCcode = EecLocation
    left join vw_int_OrgLevel o3 with (nolock) on eecorglvl3 = o3.orgcode and o3.orglvl = '3'
    WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_ECHIRELDEM_Audit where audEEID = xeeid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
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
ALTER VIEW dbo.dsi_vwECHIRELDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECHIRELDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECHIRELDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202306231'
       ,expStartPerControl     = '202306231'
       ,expLastEndPerControl   = '202306309'
       ,expEndPerControl       = '202306309'
WHERE expFormatCode = 'ECHIRELDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECHIRELDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECHIRELDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECHIRELDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECHIRELDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECHIRELDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECHIRELDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECHIRELDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECHIRELDEM', 'UseFileName', 'V', 'Y'


-- End ripout