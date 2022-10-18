/**********************************************************************************

EMCPTELEXP: CirrusMD Telehealth Export

FormatCode:     EMCPTELEXP
Project:        CirrusMD Telehealth Export
Client ID:      MOU1003
Date/time:      2022-10-13 15:59:04.013
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPMCPL
Web Filename:   MOU1003_6O5TG_EEHISTORY_EMCPTELEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMCPTELEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMCPTELEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMCPTELEXP'


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
WHERE FormatCode = 'EMCPTELEXP'
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
WHERE ExpFormatCode = 'EMCPTELEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMCPTELEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMCPTELEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMCPTELEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMCPTELEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMCPTELEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMCPTELEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMCPTELEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMCPTELEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMCPTELEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMCPTELEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMCPTELEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMCPTELEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMCPTELEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPTELEXP];
GO
IF OBJECT_ID('U_EMCPTELEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_Header];
GO
IF OBJECT_ID('U_EMCPTELEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_File];
GO
IF OBJECT_ID('U_EMCPTELEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_EEList];
GO
IF OBJECT_ID('U_EMCPTELEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_drvTbl];
GO
IF OBJECT_ID('U_EMCPTELEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_DedList];
GO
IF OBJECT_ID('U_EMCPTELEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_AuditFields];
GO
IF OBJECT_ID('U_EMCPTELEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMCPTELEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMCPTELEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMCPTELEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMCPTELEXP','CirrusMD Telehealth Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EMCPTELEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPTELEXPZ0','50','H','01','1',NULL,'External Id',NULL,NULL,'"External Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPTELEXPZ0','50','H','01','2',NULL,'Member Id',NULL,NULL,'"Member Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPTELEXPZ0','50','H','01','3',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPTELEXPZ0','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPTELEXPZ0','50','H','01','5',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPTELEXPZ0','50','H','01','6',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPTELEXPZ0','50','H','01','7',NULL,'Effective Date',NULL,NULL,'"Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPTELEXPZ0','50','H','01','8',NULL,'Expiry Date',NULL,NULL,'"Expiry Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPTELEXPZ0','50','H','01','9',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMCPTELEXPZ0','50','H','01','10',NULL,'Primary Phone',NULL,NULL,'"Primary Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMCPTELEXPZ0','50','H','01','11',NULL,'Street Address',NULL,NULL,'"Street Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMCPTELEXPZ0','50','H','01','12',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMCPTELEXPZ0','50','H','01','13',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMCPTELEXPZ0','50','H','01','14',NULL,'Subscriber DOB',NULL,NULL,'"Subscriber DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMCPTELEXPZ0','50','H','01','15',NULL,'Subscriber First Name',NULL,NULL,'"Subscriber First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMCPTELEXPZ0','50','H','01','16',NULL,'Subscriber Last Name',NULL,NULL,'"Subscriber Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMCPTELEXPZ0','50','H','01','17',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMCPTELEXPZ0','50','H','01','25',NULL,'LOB',NULL,NULL,'"LOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMCPTELEXPZ0','50','H','01','33',NULL,'Subscriber Relationship',NULL,NULL,'"Subscriber Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMCPTELEXPZ0','50','H','01','34',NULL,'Relationship Code',NULL,NULL,'"Relationship Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMCPTELEXPZ0','50','H','01','35',NULL,'Ethnicity Code',NULL,NULL,'"Ethnicity Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMCPTELEXPZ0','50','H','01','38',NULL,'Medical Enrollment',NULL,NULL,'"Medical Enrollment"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMCPTELEXPZ0','50','H','01','39',NULL,'Medical Eligibility',NULL,NULL,'"Medical Eligibility"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMCPTELEXPZ0','50','H','01','43',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMCPTELEXPZ0','50','H','01','44',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPTELEXPZ0','50','D','10','1',NULL,'External Id',NULL,NULL,'"drvExternalId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPTELEXPZ0','50','D','10','2',NULL,'Member Id',NULL,NULL,'"drvMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPTELEXPZ0','50','D','10','3',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPTELEXPZ0','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPTELEXPZ0','50','D','10','5',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPTELEXPZ0','50','D','10','6',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPTELEXPZ0','51','D','10','7',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPTELEXPZ0','52','D','10','8',NULL,'Expiry Date',NULL,NULL,'"drvExpiryDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPTELEXPZ0','53','D','10','9',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMCPTELEXPZ0','54','D','10','10',NULL,'Primary Phone',NULL,NULL,'"drvPrimaryPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMCPTELEXPZ0','55','D','10','11',NULL,'Street Address',NULL,NULL,'"drvStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMCPTELEXPZ0','56','D','10','12',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMCPTELEXPZ0','57','D','10','13',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMCPTELEXPZ0','58','D','10','14',NULL,'Subscriber DOB',NULL,NULL,'"drvSubscriberDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMCPTELEXPZ0','59','D','10','15',NULL,'Subscriber First Name',NULL,NULL,'"drvSubscriberFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMCPTELEXPZ0','60','D','10','16',NULL,'Subscriber Last Name',NULL,NULL,'"drvSubscriberLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMCPTELEXPZ0','61','D','10','17',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMCPTELEXPZ0','69','D','10','25',NULL,'LOB',NULL,NULL,'"drvLOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMCPTELEXPZ0','77','D','10','33',NULL,'Subscriber Relationship',NULL,NULL,'"drvSubscriberRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMCPTELEXPZ0','78','D','10','34',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMCPTELEXPZ0','79','D','10','35',NULL,'Ethnicity Code',NULL,NULL,'"drvEthnicityCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMCPTELEXPZ0','82','D','10','38',NULL,'Medical Enrollment',NULL,NULL,'"drvMedicalEnrollment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMCPTELEXPZ0','83','D','10','39',NULL,'Medical Eligibility',NULL,NULL,'"drvMedicalEligibility"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMCPTELEXPZ0','87','D','10','43',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMCPTELEXPZ0','88','D','10','44',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMCPTELEXP_20221013.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CirrusMD Telehealth Export','202210139','EMPEXPORT','ONDEM_XOE',NULL,'EMCPTELEXP',NULL,NULL,NULL,'202210139','Sep 22 2022 12:04PM','Sep 22 2022 12:04PM','202201151',NULL,'','','202201151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',QUD2P',NULL,NULL,NULL,'CirrusMD Telehlth Sch','202210139','EMPEXPORT','SCH_EMCPTE',NULL,'EMCPTELEXP',NULL,NULL,NULL,'202210139','Sep 22 2022 12:04PM','Sep 22 2022 12:04PM','202201151',NULL,'','','202201151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',QUD2P',NULL,NULL,NULL,'CirrusMD Telehealth Expo-Test','202210139','EMPEXPORT','TEST_XOE','Oct 13 2022  3:51PM','EMCPTELEXP',NULL,NULL,NULL,'202210139','Oct 13 2022 12:00AM','Dec 30 1899 12:00AM','202210061','352','','','202210061',dbo.fn_GetTimedKey(),NULL,'us3kEpMOU1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPTELEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPTELEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPTELEXP','D10','dbo.U_EMCPTELEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMCPTELEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EMCPTELEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMCPTELEXP] (
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
-- Create table U_EMCPTELEXP_Audit
-----------

IF OBJECT_ID('U_EMCPTELEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_Audit] (
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
-- Create table U_EMCPTELEXP_AuditFields
-----------

IF OBJECT_ID('U_EMCPTELEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMCPTELEXP_DedList
-----------

IF OBJECT_ID('U_EMCPTELEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMCPTELEXP_drvTbl
-----------

IF OBJECT_ID('U_EMCPTELEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvExternalId] varchar(1) NOT NULL,
    [drvMemberId] varchar(1) NOT NULL,
    [drvNameFirst] varchar(102) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvDateofBirth] nvarchar(4000) NULL,
    [drvGender] varchar(9) NOT NULL,
    [drvEffectiveDate] nvarchar(4000) NULL,
    [drvExpiryDate] nvarchar(4000) NULL,
    [drvAddressZipCode] varchar(52) NULL,
    [drvPrimaryPhone] varchar(52) NULL,
    [drvStreetAddress] varchar(513) NULL,
    [drvAddressCity] varchar(257) NULL,
    [drvAddressState] varchar(257) NULL,
    [drvSubscriberDOB] nvarchar(4000) NULL,
    [drvSubscriberFirstName] varchar(102) NULL,
    [drvSubscriberLastName] varchar(102) NULL,
    [drvEmail] varchar(52) NULL,
    [drvLOB] varchar(12) NULL,
    [drvSubscriberRelationship] varchar(11) NOT NULL,
    [drvRelationshipCode] varchar(24) NOT NULL,
    [drvEthnicityCode] varchar(64) NULL,
    [drvMedicalEnrollment] varchar(7) NOT NULL,
    [drvMedicalEligibility] varchar(7) NOT NULL,
    [drvEmployeeID] varchar(11) NULL,
    [drvEmployeeType] varchar(11) NULL
);

-----------
-- Create table U_EMCPTELEXP_EEList
-----------

IF OBJECT_ID('U_EMCPTELEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMCPTELEXP_File
-----------

IF OBJECT_ID('U_EMCPTELEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EMCPTELEXP_Header
-----------

IF OBJECT_ID('U_EMCPTELEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EMCPTELEXP_Header] (
    [drvPersonaRepExternalID] varchar(35) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPTELEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mountain Capital Partners

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 09/22/2022
Service Request Number: TekP-2022-08-11-01

Purpose: CirrusMD Telehealth Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMCPTELEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMCPTELEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMCPTELEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMCPTELEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMCPTELEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPTELEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPTELEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPTELEXP', 'SCH_EMCPTE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMCPTELEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMCPTELEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMCPTELEXP';

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
    DELETE FROM dbo.U_EMCPTELEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMCPTELEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMCPTELEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPTELEXP_AuditFields;
    CREATE TABLE dbo.U_EMCPTELEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

     INSERT INTO dbo.U_EMCPTELEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMCPTELEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPTELEXP_Audit;
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
    INTO dbo.U_EMCPTELEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMCPTELEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMCPTELEXP_Audit ON dbo.U_EMCPTELEXP_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EMCPTELEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMCPTELEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HLTH,HDHP';

    IF OBJECT_ID('U_EMCPTELEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPTELEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMCPTELEXP_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMCPTELEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMCPTELEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPTELEXP_drvTbl;
        
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubsort = CASE WHEN  BdmRecType = 'EMP'  THEN '1' 
                           when  BdmRecType = 'DEP' and  conrelationship = 'SPS' THEN  '2' 
                                    WHEN BdmRecType = 'DEP' and conrelationship IN ('SPS', 'CHL', 'STC', 'DCH', 'DPC') theN '3'
                                    ELSE '4'
                                    END
        -- standard fields above and additional driver fields below
        ,drvExternalId = ''--'"' + Ltrim(rtrim(EecEmpNo)) +'-'+Ltrim(rtrim(EepNameFirst)) +'-'+EepAddressZipCode +'-'+ Format(EepDateOfBirth, 'yyyy-MM-dd') + '"'
        ,drvMemberId = ''--'"' + Ltrim(rtrim(EecEmpNo)) +'-'+Ltrim(rtrim(EepNameFirst))+'-'+EepAddressZipCode +'-'+ Format(EepDateOfBirth, 'yyyy-MM-dd') + '"'
        ,drvNameFirst = CASE WHEN bdmRecType = 'DEP' THEN '"' + ConNameFirst + '"' ELSE '"' + EepNameFirst + '"'  END
        ,drvNameLast = CASE WHEN bdmRecType = 'DEP' THEN '"' + ConNameLast + '"'  ELSE '"' + EepNameLast + '"'  END
        ,drvDateofBirth = CASE WHEN BdmRecType = 'DEP' THEN  '"' + FORMAT(ConDateOfBirth, 'yyyy-MM-dd') + '"' ELSE '"' + FOrmat(EepDateOfBirth, 'yyyy-MM-dd') + '"'  END
        ,drvGender = CASE WHEN BdmRecType <> 'DEP'  and  eepgender = 'F'  THEN  '"Female"'
                          WHEN BdmRecType <> 'DEP' and  eepgender = 'M'  THEN  '"Male"'
                          WHEN BdmRecType = 'DEP'  and  ConGender = 'F'  THEN  '"Female"'
                          WHEN BdmRecType = 'DEP'  and  ConGender = 'M'  THEN  '"Male"'
                        Else '"Unknown"'
                    END
        ,drvEffectiveDate = CASE WHEN isnull(FORMAT(dateadd(d, 14, BdmBenstartdate ), 'yyyy-MM-dd'), '') <> '' 
                                     THEN '"' + FORMAT(dateadd(d, 14, BdmBenstartdate ), 'yyyy-MM-dd') + '"' 
                                    ELSE '"' + FORMAT(dateadd(d, 14,EecDateofLastHire), 'yyyy-MM-dd') + '"'  
                                END 
        
        ,drvExpiryDate =  CASE     WHEN EecEmplStatus = 'T' THEN '"' + FORMAT(EecDateOfTermination, 'yyyy-MM-dd') + '"' 
                                ELSE '"2099-12-31"' END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'DEP' THEN '"' + ConAddressZipCode + '"'  ELSE  '"' + EepAddressZipCode + '"' END
        ,drvPrimaryPhone = CASE WHEN EfoPhoneNumber IS NOT NULL THEN '"' + EfoPhoneNumber + '"' ELSE '"' + eepPhoneHomeNumber + '"' END
        ,drvStreetAddress = CASE WHEN BdmRecType = 'DEP' THEN '"' + ltrim(rtrim(conAddressLine1)) + '' + ltrim(rtrim(isnull(conAddressLine2, ''))) + '"' 
                                ELSE  '"' + ltrim(rtrim(eepAddressLine1)) + '' + isnull(Ltrim(rtrim(eepAddressLine2)),'') + '"' 
                                END
        ,drvAddressCity = CASE WHEN  BdmRecType = 'DEP ' THEN '"' + Ltrim(rtrim(ConAddressCity)) + '"'  else '"' + ltrim(rtrim(EepAddressCity)) + '"' END
        ,drvAddressState = CASE WHEN BdmRecType =  'DEP' THEN  '"' + ltrim(rtrim(conAddressState)) + '"' else  '"' + ltrim(rtrim(EepAddressState)) + '"'END 
        ,drvSubscriberDOB =  '"' + FORMAT(EepDateOfBirth, 'yyyy-MM-dd') + '"'
        ,drvSubscriberFirstName = '"' + EepNameFirst + '"'
        ,drvSubscriberLastName = '"' + EepNameLast + '"'
        ,drvEmail = CASE WHEN BdmRecType <> 'DEP' and ISNULL(EepAddressEmailAlternate, '')  NOT LIke '%.ski' and ISNULL(EepAddressEmailAlternate, '') <> ''  THEN '"' + EepAddressEmailAlternate + '"' ELSE CASE WHEn Isnull(EepAddressEmail, '') <> '' AND  EepAddressEmail NOT LIke '%.ski' THEN '"' + EepAddressEmail + '"' END END
        ,drvLOB = '"' + rtrim(EecOrglvl3) + '"'
        ,drvSubscriberRelationship = CASE WHEN  BdmRecType = 'DEP' and conrelationship IN ('SPS', 'CHL', 'STC', 'DCH', 'DPC') THEN '"Dependent"' 
                                        ELSE '"Primary"' END 
        ,drvRelationshipCode = CASE WHEN  BdmRecType = 'DEP' AND conrelationship = 'SPS' and congender = 'M' THEN '"Husband"' 
                                    WHEN  BdmRecType = 'DEP' AND conrelationship = 'SPS' and congender = 'F' THEN '"WIFE"'
                                    WHEN  BdmRecType = 'DEP' AND conrelationship IN ('SPS', 'CHL', 'STC', 'DCH', 'DPC') and congender = 'M' THEN '"SPONSORED MALE CHILD"'
                                    WHEN  BdmRecType = 'DEP' AND conrelationship IN ('SPS', 'CHL', 'STC', 'DCH', 'DPC') and congender = 'F' THEN '"SPONSORED FEMALE CHILD"'
                                    ELSE '"Primary"'
                                 END
                            
        ,drvEthnicityCode = CASE WHEN coddesc = 'White' THEN '"White alone, non-Hispanic"'      --'"' + coddesc + '"'
                                 WHEN coddesc in ('Hispanic or Latino' ) THEN '"Hispanic"'
                                 WHEN coddesc IN ('Black or African American') THEN '"Black or African American alone, non-Hispanic"'
                                 WHEN coddesc IN ('American Indian/Alaskan Native', 'Alaskan Native','American Indian')  THEN 'Some Other Race alone, non-Hispanic' 
                                 WHEN coddesc  = 'Asian' THEN '"Asian alone, non-Hispanic"'
                                 WHEN coddesc IN ( 'Native Hawaiian', 'Other Pacific Islander') THEN '"Native Hawaiian and Other Pacific Islander alone, non-Hispanic"'
                                 WHEN coddesc = 'Two or more races' THEN '"Multiracial, non-Hispanic"'
                                 WHEN (coddesc = 'Not specified' or isnull(coddesc ,'') = '')  THEN '' 
                                END 
        ,drvMedicalEnrollment = CASE WHEN  bdmDedCode IN ('HDHP', 'HLTH')  and bdmBenstatus = 'A' THEN '"True"' ELSE  '"False"' END
        ,drvMedicalEligibility = CASE WHEN Deductionbenefitgroup IN ('YR', 'SSHCB') THEN '"True"' ELSE  '"False"' END
        ,drvEmployeeID = '"' + rtrim(EecEmpNo) + '"'
        ,drvEmployeeType = CASE WHEN eeceetype IN ('Y10', 'YR') THEN '"' +'Full Time' +'"'  --'"' + EMPTYPEDESC  + '"'
                                WHEN eeceetype IN ('HC', 'HF', 'H10', 'HCM', 'PEK', 'SS') THEN '"' + 'Seasonal'+ '"' END 

        
    INTO dbo.U_EMCPTELEXP_drvTbl
    FROM dbo.U_EMCPTELEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
   LEFT  JOIN dbo.U_dsi_BDM_EMCPTELEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    LEFT JOIN  dbo.codes  WITH (NOLOCK)
         on codcode = eepEthnicID
     and codtable = 'ETHNICCODE'
    LEFT JOIN  (Select Distinct coddesc AS EMPTYPEDESC , Eeceetype AS EETYPE  
                FROM dbo.vw_int_EmpComp
                Join dbo.codes 
                on codcode = Eeceetype
                and codtable = 'EMPTYPE'
                and Eeceetype IN ('Y10', 'YR') ) Etype ON EETYPE = Eeceetype
    LEFT JOIN ( Select EEID AS BGEEID, COID AS BGCOID, Deductionbenefitgroup 
                from ACAAutoPopulation2Summary
                Where Deductionbenefitgroup IN ('YR', 'SSHCB'))BG ON BGEEID = xEEID and BGCOID = XCOID
    LEFT JOIN ( SELECT  AudEEID,  AudCOID, audDateTime AS AudTermDate
                    FROM dbo.U_EMCPTELEXP_Audit WITH (NOLOCK) 
                    WHERE audTableName = 'EmpComp' 
                    AND audFieldName = 'EecEmplStatus'
                    AND AudOldValue = 'A' 
                    AND AudNewValue = 'T'
        ) AS AudTermDate
         ON AudEEID = xEEID
        AND AudCOID = xCOID
        WHERE EecEmpNo NOT IN ('4564', '4568', '4570', '3504', '3505')
        AND (EecEmplStatus <>  'T' or (EecEmplStatus = 'T' AND AudTermDate < = DATEADD(DAY, -14, @EndDate)))

    ;
    -----------------------------------
    ---- HEADER RECORD
    -----------------------------------
    --IF OBJECT_ID('U_EMCPTELEXP_Header','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMCPTELEXP_Header;
    --SELECT DISTINCT
    --     drvPersonaRepExternalID = 'Personal Representative External Id'
    --INTO dbo.U_EMCPTELEXP_Header
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
ALTER VIEW dbo.dsi_vwEMCPTELEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMCPTELEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMCPTELEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201151'
       ,expStartPerControl     = '202201151'
       ,expLastEndPerControl   = '202210139'
       ,expEndPerControl       = '202210139'
WHERE expFormatCode = 'EMCPTELEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMCPTELEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMCPTELEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMCPTELEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMCPTELEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMCPTELEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPTELEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMCPTELEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPTELEXP', 'UseFileName', 'V', 'Y'


-- End ripout