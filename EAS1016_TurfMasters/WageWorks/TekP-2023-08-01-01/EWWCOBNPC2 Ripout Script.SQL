/**********************************************************************************

EWWCOBNPC2: WageWorks COBRA NPM Export V2

FormatCode:     EWWCOBNPC2
Project:        WageWorks COBRA NPM Export V2
Client ID:      EAS1016
Date/time:      2023-08-09 14:33:39.337
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB04
Database:       ULTIPRO_WPEURF
Web Filename:   EAS1016_MY9A2_EEHISTORY_EWWCOBNPC2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWWCOBNPC2_SavePath') IS NOT NULL DROP TABLE dbo.U_EWWCOBNPC2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWWCOBNPC2'


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
WHERE FormatCode = 'EWWCOBNPC2'
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
WHERE ExpFormatCode = 'EWWCOBNPC2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWWCOBNPC2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWWCOBNPC2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWWCOBNPC2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWWCOBNPC2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWWCOBNPC2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWWCOBNPC2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWWCOBNPC2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWWCOBNPC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWWCOBNPC2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWWCOBNPC2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWWCOBNPC2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWWCOBNPC2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWWCOBNPC2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBNPC2];
GO
IF OBJECT_ID('U_EWWCOBNPC2_File') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBNPC2_File];
GO
IF OBJECT_ID('U_EWWCOBNPC2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBNPC2_EEList];
GO
IF OBJECT_ID('U_EWWCOBNPC2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBNPC2_drvTbl];
GO
IF OBJECT_ID('U_EWWCOBNPC2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBNPC2_AuditFields];
GO
IF OBJECT_ID('U_EWWCOBNPC2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBNPC2_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EWWCOBNPC2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWWCOBNPC2];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EWWCOBNPC2','WageWorks COBRA NPM Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1477','S','N','EXF4XZ000050','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXF4XZ000050','20','D','10','1',NULL,'EMPLOYER_EIN',NULL,NULL,'"drvEmployerEIN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXF4XZ000050','2','D','10','21',NULL,'ACTION_CODE',NULL,NULL,'"drvActionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXF4XZ000050','20','D','10','23',NULL,'LAST_NAME',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXF4XZ000050','20','D','10','43',NULL,'FIRST_NAME',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXF4XZ000050','1','D','10','63',NULL,'MIDDLE_INITIAL',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXF4XZ000050','11','D','10','64',NULL,'EMPLOYEE_SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXF4XZ000050','11','D','10','75',NULL,'DEPENDENT_SSN',NULL,NULL,'"drvDependentSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXF4XZ000050','20','D','10','86',NULL,'EMPLOYEE_NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXF4XZ000050','50','D','10','106',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXF4XZ000050','25','D','10','156',NULL,'EMPLOYEE_CLASS',NULL,NULL,'"drvEmployeeClass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXF4XZ000050','1','D','10','181',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXF4XZ000050','1','D','10','182',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXF4XZ000050','10','D','10','183',NULL,'HIRE_DATE',NULL,NULL,'"drvHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXF4XZ000050','10','D','10','193',NULL,'BIRTH_DATE',NULL,NULL,'"drvBirthDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXF4XZ000050','50','D','10','203',NULL,'ADDRESS_1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXF4XZ000050','50','D','10','253',NULL,'ADDRESS_2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXF4XZ000050','20','D','10','303',NULL,'CITY',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EXF4XZ000050','2','D','10','323',NULL,'STATE',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EXF4XZ000050','10','D','10','325',NULL,'ZIP',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EXF4XZ000050','10','D','10','335',NULL,'COUNTRY',NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EXF4XZ000050','1','D','10','345',NULL,'FILLER_1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EXF4XZ000050','1','D','10','346',NULL,'COBRA_ELIGIBLE',NULL,NULL,'"drvCobraEligible"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EXF4XZ000050','2','D','10','347',NULL,'PREFERRED_LANGUAGE',NULL,NULL,'"drvPreferredLanguage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EXF4XZ000050','12','D','10','349',NULL,'PHONE_NUMBER',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EXF4XZ000050','100','D','10','361',NULL,'E_MAIL_ADDRESS',NULL,NULL,'"drvAddressEMail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EXF4XZ000050','1','D','10','461',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL,'"drvInitialNotificationCOBRA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EXF4XZ000050','1','D','10','462',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL,'"C"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EXF4XZ000050','10','D','10','463',NULL,'WAITING_START_DATE',NULL,NULL,'"drvWaitingStartDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EXF4XZ000050','10','D','10','473',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL,'"drvCoverageBeginDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EXF4XZ000050','50','D','10','483',NULL,'FILLER_2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EXF4XZ000050','10','D','10','533',NULL,'QUALIFYING_EVENT_DATE',NULL,NULL,'"drvQualifyingEventDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EXF4XZ000050','10','D','10','543',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL,'"drvLastPreCobraCovered"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EXF4XZ000050','2','D','10','553',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL,'"drvQualifyingEventType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EXF4XZ000050','10','D','10','555',NULL,'ELIGIBILITY_END_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EXF4XZ000050','10','D','10','565',NULL,'SEVERANCE_THROUGH',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EXF4XZ000050','3','D','10','575',NULL,'SEVERANCE_PERCENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EXF4XZ000050','10','D','10','578',NULL,'SEVERANCE_MONTHLY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EXF4XZ000050','10','D','10','588',NULL,'SEVERANCE_CREDIT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EXF4XZ000050','10','D','10','598',NULL,'BILLING_START_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EXF4XZ000050','10','D','10','608',NULL,'ELECTION_NOTICE_MAILED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EXF4XZ000050','10','D','10','618',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EXF4XZ000050','10','D','10','628',NULL,'ELECTION_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EXF4XZ000050','50','D','10','638',NULL,'FILLER_3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EXF4XZ000050','50','D','10','688',NULL,'PLAN_NAME1(MED)C1',NULL,NULL,'"drvPlanName1C1Med"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EXF4XZ000050','2','D','10','738',NULL,'PLAN_COV_CODE1',NULL,NULL,'"drvPlanCovCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EXF4XZ000050','10','D','10','740',NULL,'PLAN_COV_START1',NULL,NULL,'"drvPlanCovStart1"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EXF4XZ000050','10','D','10','750',NULL,'PLAN_COV_END1',NULL,NULL,'"drvPlanCovEnd1"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EXF4XZ000050','10','D','10','760',NULL,'PLAN_RATE1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EXF4XZ000050','8','D','10','770',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EXF4XZ000050','14','D','10','778',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL,'"drvCarrierEmpID1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EXF4XZ000050','16','D','10','792',NULL,'PLAN_FILLER1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EXF4XZ000050','50','D','10','808',NULL,'PLAN_NAME2(DEN)C8',NULL,NULL,'"drvPlanName2C8Den"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EXF4XZ000050','2','D','10','858',NULL,'PLAN_COV_CODE2',NULL,NULL,'"drvPlanCovCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EXF4XZ000050','10','D','10','860',NULL,'PLAN_COV_START2',NULL,NULL,'"drvPlanCovStart2"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EXF4XZ000050','10','D','10','870',NULL,'PLAN_COV_END2',NULL,NULL,'"drvPlanCovEnd2"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EXF4XZ000050','10','D','10','880',NULL,'PLAN_RATE2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EXF4XZ000050','8','D','10','890',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EXF4XZ000050','14','D','10','898',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL,'"drvCarrierEmpID2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EXF4XZ000050','16','D','10','912',NULL,'PLAN_FILLER2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EXF4XZ000050','50','D','10','928',NULL,'PLAN_NAME3(VIS)C15',NULL,NULL,'"drvPlanName3C15Vis"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EXF4XZ000050','2','D','10','978',NULL,'PLAN_COV_CODE3',NULL,NULL,'"drvPlanCovCode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EXF4XZ000050','10','D','10','980',NULL,'PLAN_COV_START3',NULL,NULL,'"drvPlanCovStart3"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EXF4XZ000050','10','D','10','990',NULL,'PLAN_COV_END3',NULL,NULL,'"drvPlanCovEnd3"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EXF4XZ000050','10','D','10','1000',NULL,'PLAN_RATE3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EXF4XZ000050','8','D','10','1010',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EXF4XZ000050','14','D','10','1018',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL,'"drvCarrierEmpID3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EXF4XZ000050','16','D','10','1032',NULL,'PLAN_FILLER3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EXF4XZ000050','50','D','10','1048',NULL,'PLAN_NAME4(FSAMed)',NULL,NULL,'"drvPlanName4FSAMed"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EXF4XZ000050','2','D','10','1098',NULL,'PLAN_COV_CODE4',NULL,NULL,'"drvPlanCovCode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EXF4XZ000050','10','D','10','1100',NULL,'PLAN_COV_START4',NULL,NULL,'"drvPlanCovStart4"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EXF4XZ000050','10','D','10','1110',NULL,'PLAN_COV_END4',NULL,NULL,'"drvPlanCovEnd4"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EXF4XZ000050','10','D','10','1120',NULL,'PLAN_RATE4',NULL,NULL,'"drvPlanRate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EXF4XZ000050','8','D','10','1130',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EXF4XZ000050','14','D','10','1138',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL,'"drvCarrierEmpID4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EXF4XZ000050','16','D','10','1152',NULL,'PLAN_FILLER4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EXF4XZ000050','50','D','10','1168',NULL,'PLAN_NAME5(FSA-LimitedPurpose)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EXF4XZ000050','2','D','10','1218',NULL,'PLAN_COV_CODE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EXF4XZ000050','10','D','10','1220',NULL,'PLAN_COV_START5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EXF4XZ000050','10','D','10','1230',NULL,'PLAN_COV_END5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EXF4XZ000050','10','D','10','1240',NULL,'PLAN_RATE5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EXF4XZ000050','8','D','10','1250',NULL,'EMPLOYER_ANNUAL_CONTRIBUTION5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EXF4XZ000050','14','D','10','1258',NULL,'CARRIER_EMPLOYEE_ID5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EXF4XZ000050','16','D','10','1272',NULL,'PLAN_FILLER5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EXF4XZ000050','10','D','10','1288',NULL,'PLAN_YEAR_START',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EXF4XZ000050','10','D','10','1298',NULL,'ENROLLMENT_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EXF4XZ000050','10','D','10','1308',NULL,'PAY_RUN_DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EXF4XZ000050','25','D','10','1318',NULL,'PAY_SCHEDULE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EXF4XZ000050','1','D','10','1343',NULL,'PAYMENT_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EXF4XZ000050','1','D','10','1344',NULL,'ENROLLMENT_TYPE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EXF4XZ000050','27','D','10','1345',NULL,'FSA_FILLER1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EXF4XZ000050','1','D','10','1372',NULL,'COMMUTER_ELGIBLE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EXF4XZ000050','1','D','10','1373',NULL,'OPT_IN_OPT_OUT',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWWCOBNPC2_20230809.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks COBRA NPM-OnDem','202205011','EMPEXPORT','ONDEM_XOE','May  9 2022 12:00AM','EWWCOBNPC2',NULL,NULL,NULL,'202205011','May  1 2022 12:00AM','Dec 30 1899 12:00AM','202201011',NULL,NULL,NULL,'202201011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEURF',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks COBRA NPM Full-OnDem','202205011','EMPEXPORT','ONDEMF_XOE','May  9 2022 12:00AM','EWWCOBNPC2',NULL,NULL,NULL,'202205011','May  1 2022 12:00AM','Dec 30 1899 12:00AM','202201011',NULL,NULL,NULL,'202201011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEURF',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks COBRA NPM-Sched','202205011','EMPEXPORT','SCH_EWWCOB','May  9 2022 12:00AM','EWWCOBNPC2',NULL,NULL,NULL,'202308089','May  1 2022 12:00AM','Dec 30 1899 12:00AM','202308011',NULL,NULL,NULL,'202201011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPEURF',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'WageWorks COBRA NPM-Test','202308091','EMPEXPORT','TEST_XOE','Aug  9 2023 12:00AM','EWWCOBNPC2',NULL,NULL,NULL,'202308091','Aug  1 2023 12:00AM','Dec 30 1899 12:00AM','202308011',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'us3mWaEAS1016',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBNPC2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBNPC2','D10','dbo.U_EWWCOBNPC2_drvTbl WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWWCOBNPC2
-----------

IF OBJECT_ID('U_dsi_BDM_EWWCOBNPC2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWWCOBNPC2] (
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
-- Create table U_EWWCOBNPC2_Audit
-----------

IF OBJECT_ID('U_EWWCOBNPC2_Audit') IS NULL
CREATE TABLE [dbo].[U_EWWCOBNPC2_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(1) NOT NULL,
    [audKey1] varchar(255) NOT NULL,
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
-- Create table U_EWWCOBNPC2_AuditFields
-----------

IF OBJECT_ID('U_EWWCOBNPC2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EWWCOBNPC2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EWWCOBNPC2_drvTbl
-----------

IF OBJECT_ID('U_EWWCOBNPC2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBNPC2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecType] varchar(3) NOT NULL,
    [drvEmployerEIN] varchar(20) NULL,
    [drvActionCode] varchar(2) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvEmployeeSSN] varchar(13) NULL,
    [drvDependentSSN] varchar(13) NULL,
    [drvEmployeeNumber] char(20) NULL,
    [drvDivision] varchar(50) NULL,
    [drvEmployeeClass] varchar(25) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(51) NULL,
    [drvCountry] varchar(10) NULL,
    [drvCobraEligible] char(1) NULL,
    [drvPreferredLanguage] varchar(2) NULL,
    [drvPhoneNumber] varchar(52) NULL,
    [drvAddressEMail] varchar(255) NULL,
    [drvInitialNotificationCOBRA] char(1) NULL,
    [drvWaitingStartDate] datetime NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvQualifyingEventDate] datetime NULL,
    [drvLastPreCobraCovered] datetime NULL,
    [drvQualifyingEventType] varchar(2) NULL,
    [drvPlanName1C1Med] varchar(50) NULL,
    [drvPlanCovCode1] varchar(2) NULL,
    [drvPlanCovStart1] datetime NULL,
    [drvPlanCovEnd1] datetime NULL,
    [drvCarrierEmpID1] varchar(14) NULL,
    [drvPlanName2C8Den] varchar(50) NULL,
    [drvPlanCovCode2] varchar(2) NULL,
    [drvPlanCovStart2] datetime NULL,
    [drvPlanCovEnd2] datetime NULL,
    [drvCarrierEmpID2] varchar(14) NULL,
    [drvPlanName3C15Vis] varchar(50) NULL,
    [drvPlanCovCode3] varchar(2) NULL,
    [drvPlanCovStart3] datetime NULL,
    [drvPlanCovEnd3] datetime NULL,
    [drvCarrierEmpID3] varchar(14) NULL,
    [drvPlanName4FSAMed] varchar(50) NULL,
    [drvPlanCovCode4] varchar(2) NULL,
    [drvPlanCovStart4] datetime NULL,
    [drvPlanCovEnd4] datetime NULL,
    [drvPlanRate4] varchar(30) NULL,
    [drvCarrierEmpID4] varchar(14) NULL,
    [drvInitialSort] varchar(23) NULL
);

-----------
-- Create table U_EWWCOBNPC2_EEList
-----------

IF OBJECT_ID('U_EWWCOBNPC2_EEList') IS NULL
CREATE TABLE [dbo].[U_EWWCOBNPC2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWWCOBNPC2_File
-----------

IF OBJECT_ID('U_EWWCOBNPC2_File') IS NULL
CREATE TABLE [dbo].[U_EWWCOBNPC2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1477) NULL
);
GO
CREATE   PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBNPC2]  
    @SystemID char(12)  
AS  
/**********************************************************************************  
Client Name: BOKF, NA  
  
Created By: Shairil Narang  
Business Analyst: Lauren Brown-Underwood   
Create Date: 04/18/2022  
Service Request Number: SR-2022-00353565  
  
  
Purpose: WageWorks COBRA NPM Export V2  
  
Revision History  
----------------  
Update By           Date        Request Num         Desc  

Marie Waters        08/09/2023  TekP-2023-08-01-01  Added division mapping and added specific dedcodes TMDBU,TMDEN,TMHSA,TMPP5,TMPPE,TMVIS
XXXXXXXXXXXX        XX/XX/20XX  SR-20XX-00XXXXXX    XXXXX  
  
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWWCOBNPC2';  
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWWCOBNPC2';  
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWWCOBNPC2';  
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EWWCOBNPC2';  
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWWCOBNPC2' ORDER BY RunID DESC;  
  
Execute Export  
--------------  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBNPC2', 'ONDEMF_XOE';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBNPC2', 'ONDEM_XOE';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBNPC2', 'TEST_XOE';  
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBNPC2', 'SCH_EWWCOB';  
  
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWWCOBNPC2';  
**********************************************************************************/  
BEGIN  
    --==========================================  
    -- Declare variables  
    --==========================================  
    DECLARE  @FormatCode varchar(12)  
            ,@ExportCode varchar(12)  
            ,@StartDate  datetime  
            ,@EndDate    datetime  
            ,@EETypeList varchar(100);  
  
    -- Initialize @FormatCode  
    SET @FormatCode = 'EWWCOBNPC2';  
  
    -- Declare dates from Parameter file  
    SELECT  
         @StartDate  = LEFT(StartPerControl,8)  
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))  
        ,@ExportCode = ExportCode  
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)  
    WHERE FormatCode = @FormatCode;  
  
    --==========================================  
    -- Clean EE List  
    --==========================================  
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company  
    DELETE FROM dbo.U_EWWCOBNPC2_EEList  
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)  
      AND xEEID IN (SELECT xEEID FROM dbo.U_EWWCOBNPC2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);  
  
    --==========================================  
    -- Audit to find new hires  
    --==========================================  
  
    -- Get data from audit fields table.  Add fields here if auditing select * from U_EWWCOBNPC2_Audit  
    IF OBJECT_ID('U_EWWCOBNPC2_AuditFields','U') IS NOT NULL  
        DROP TABLE dbo.U_EWWCOBNPC2_AuditFields;  
    CREATE TABLE dbo.U_EWWCOBNPC2_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));  
    -- Employee Information  
    INSERT INTO dbo.U_EWWCOBNPC2_AuditFields VALUES ('EmpComp','EecEmplStatus');  
  
    -- Create audit table based on fields defined above  
    IF OBJECT_ID('U_EWWCOBNPC2_Audit','U') IS NOT NULL  
        DROP TABLE dbo.U_EWWCOBNPC2_Audit;  
    SELECT audEEID = xEEID  
        ,audCOID = xCOID  
        ,audConSystemID = ''  
        ,audKey1 = audKey1Value  
        ,audKey2 = audKey2Value  
        ,audKey3 = audKey3Value  
        ,audTableName  
        ,audFieldName  
        ,audAction  
        ,audDateTime  
        ,audOldValue  
        ,audNewValue  
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)  
    INTO dbo.U_EWWCOBNPC2_Audit  
    FROM dbo.U_EWWCOBNPC2_EEList WITH (NOLOCK)  
    JOIN dbo.vw_AuditData WITH (NOLOCK)  
        ON xEEID = audKey1Value  
    JOIN dbo.U_EWWCOBNPC2_AuditFields WITH (NOLOCK)  
        ON aTableName = audTableName  
        AND aFieldName = audFieldName  
    WHERE audDateTime BETWEEN @StartDate AND @EndDate  
    AND ISNULL(audNewValue, '') = 'A'  
    AND ISNULL(audOldValue, '') IN ('','T');  
  
 --==============  
 -- Clean EELIST for Changes ONLY files  
 --==============  
 IF @ExportCode IN ('ONDEMAND','SCH_EWWCOB','TEST')  
 BEGIN  
    
   DELETE FROM dbo.U_EWWCOBNPC2_EEList  
   WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EWWCOBNPC2_Audit WHERE audEEID = xEEID);  
   
 END ;  
  
    --==========================================  
    -- BDM Section - COBRA RUN  
    --==========================================  
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;  
  
    -- Required parameters  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');  
  
    -- COBRA parameters  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','N');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A'); -- DedIsCobraCovered = 'Y'  
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', 'TMDBU,TMDEN,TMHSA,TMPP5,TMPPE,TMVIS');  
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'NewEnrolleeType', '1');  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','LEVNT3,LEVNT4'); -- Valid dependent PQB reasons  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','210'); -- Invalidate employee when Cobra Reason is "Death"  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','DP,SPS');  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,DPC');  
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');  
  
    -- Run BDM for QB  
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable_v2 @FormatCode;  
  
    --============================================  
    -- Build Employee Data and the driver tables   
 --select * from U_EWWCOBNPC2_drvTbl  
    --============================================  
    IF OBJECT_ID('U_EWWCOBNPC2_drvTbl') IS NOT NULL  
        DROP TABLE dbo.U_EWWCOBNPC2_drvTbl;  
    CREATE TABLE dbo.U_EWWCOBNPC2_drvTbl(  
        drvEEID char(12) NULL,  
        drvCoID char(5) NULL,  
        drvDepRecID char(12) NULL,  
        drvRecType varchar(3) NOT NULL,  
        drvEmployerEIN varchar(20) NULL,  
        drvActionCode varchar(2) NULL,  
        drvLastName varchar(100) NULL,  
        drvFirstName varchar(100) NULL,  
        drvMiddleInitial varchar(1) NULL,  
        drvEmployeeSSN varchar(13) NULL,  
        drvDependentSSN varchar(13) NULL,  
        drvEmployeeNumber char(20) NULL,  
        drvDivision varchar(50) NULL,  
        drvEmployeeClass varchar(25) NULL,  
        drvRelationship varchar(1) NULL,  
        drvGender char(1) NULL,  
        drvHireDate datetime NULL,  
        drvBirthDate datetime NULL,  
        drvAddress1 varchar(255) NULL,  
        drvAddress2 varchar(255) NULL,  
        drvCity varchar(255) NULL,  
        drvState varchar(255) NULL,  
        drvZip varchar(51) NULL,  
        drvCountry varchar(10) NULL,  
        drvCobraEligible char(1) NULL,  
        drvPreferredLanguage varchar(2) NULL,  
        drvPhoneNumber varchar(52) NULL,  
        drvAddressEMail varchar(255) NULL,  
        drvInitialNotificationCOBRA char(1) NULL,  
        drvWaitingStartDate datetime NULL,  
        drvCoverageBeginDate datetime NULL,  
        drvQualifyingEventDate datetime NULL,  
        drvLastPreCobraCovered datetime NULL,  
        drvQualifyingEventType varchar(2) NULL,  
        drvPlanName1C1Med varchar(50) NULL,  
        drvPlanCovCode1 varchar(2) NULL,  
        drvPlanCovStart1 datetime NULL,  
        drvPlanCovEnd1 datetime NULL,  
        drvCarrierEmpID1 varchar(14) NULL,  
        drvPlanName2C8Den varchar(50) NULL,  
        drvPlanCovCode2 varchar(2) NULL,  
        drvPlanCovStart2 datetime NULL,  
        drvPlanCovEnd2 datetime NULL,  
        drvCarrierEmpID2 varchar(14) NULL,  
        drvPlanName3C15Vis varchar(50) NULL,  
        drvPlanCovCode3 varchar(2) NULL,  
        drvPlanCovStart3 datetime NULL,  
        drvPlanCovEnd3 datetime NULL,  
        drvCarrierEmpID3 varchar(14) NULL,  
        drvPlanName4FSAMed varchar(50) NULL,  
        drvPlanCovCode4 varchar(2) NULL,  
        drvPlanCovStart4 datetime NULL,  
        drvPlanCovEnd4 datetime NULL,  
        drvPlanRate4 varchar(30) NULL,  
        drvCarrierEmpID4 varchar(14) NULL,  
        drvInitialSort varchar(23) NULL  
    );  
  
    ------------------  
    -- Load Employee Action Code = '01'  
        -- Employees who are NPM or employees when dependent only losing coverage (dependent is PQB)  
    ------------------  
    INSERT INTO dbo.U_EWWCOBNPC2_drvTbl(  
        drvEEID, drvCoID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName, drvFirstName, drvMiddleInitial,  
        drvEmployeeSSN, drvEmployeeNumber, drvDivision, drvRelationship, drvGender, drvHireDate, drvBirthDate,  
        drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry, drvCobraEligible, drvPreferredLanguage,  
        drvPhoneNumber, drvAddressEMail, drvInitialNotificationCOBRA, drvWaitingStartDate, drvCoverageBeginDate,  drvInitialSort)  
    SELECT DISTINCT  
         drvEEID                     = xEEID  
        ,drvCoID                     = xCoID  
        ,drvRecType                  = 'EMP'  
        ,drvEmployerEIN              = '84-2153183'  
        ,drvActionCode               = '01'  
        ,drvLastName                 = EepNameLast  
        ,drvFirstName                = EepNameFirst  
        ,drvMiddleInitial            = LEFT(EepNameMiddle,1)  
        ,drvEmployeeSSN              = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')  
        ,drvEmployeeNumber           = EecEmpNo  
        ,drvDivision                 = Case when CmpCompanyCode = 'ALLTF' then 'ALLTF001'  --MW updated from being a empty field
                                            when CmpCompanyCode = 'GREEN' then 'GREEN001'
                                            when CmpCompanyCode = 'TMLC' then 'TMLC001'
                                        END
  
        ,drvRelationship             = 'E'  
        ,drvGender                   = CASE WHEN EepGender NOT IN ('M','F') THEN 'X' ELSE EepGender END  
        ,drvHireDate                 = EecDateOfLastHire  
        ,drvBirthDate                = EepDateOfBirth  
        ,drvAddress1                 = EepAddressLine1  
        ,drvAddress2                 = EepAddressLine2  
        ,drvCity                     = EepAddressCity  
        ,drvState                    = EepAddressState  
        ,drvZip                      = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')  
                                            ELSE EepAddressZipCode  
                                       END  
        ,drvCountry                  = EepAddressCountry  
        ,drvCobraEligible            = 'Y'  
        ,drvPreferredLanguage        = ''  
        ,drvPhoneNumber              = ''--STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')  
        ,drvAddressEMail             = EepAddressEMail  
        ,drvInitialNotificationCOBRA = 'C'  
        ,drvWaitingStartDate = BdmBenStartDate  
        ,drvCoverageBeginDate = BdmBenStartDate  
        ,drvInitialSort              = RTRIM(EepSSN) + '01'  
    FROM dbo.U_EWWCOBNPC2_EEList WITH (NOLOCK)  
    JOIN dbo.EmpComp WITH (NOLOCK)  
        ON EecEEID = xEEID  
       AND EecCoID = xCoID  
    JOIN dbo.EmpPers WITH (NOLOCK)  
        ON eepEEID = xEEID  
 JOIN (select BdmEEID,BdmCOID,max(BdmBenStartDate) BdmBenStartDate from dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK) group by BdmEEID,BdmCOID) bdm  
       ON bdm.BdmEEID = xEEID  
       AND bdm.BdmCoID = xCoID  
 JOIN dbo.Company WITH (NOLOCK)  
        ON CmpCoID = XCOID 
    --AND BdmRunID = 'NPM'  
    --JOIN dbo.U_EWWCOBNPC2_Audit WITH (NOLOCK)  
    --    ON audEEID = xEEID  
    --    AND AudCOID = xCOID  
    WHERE eecjobchangereason NOT in ('TRO','TRI','TRB') -- Not a transfer  
  --  UNION ALL  
  --  SELECT DISTINCT  
  --       drvEEID                     = xEEID  
  --      ,drvCoID                     = xCoID  
  --      ,drvRecType                  = 'EMP'  
  --      ,drvEmployerEIN              = '84-2153183'  
  --      ,drvActionCode               = '01'  
  --      ,drvLastName                 = EepNameLast  
  --      ,drvFirstName                = EepNameFirst  
  --      ,drvMiddleInitial            = LEFT(EepNameMiddle,1)  
  --      ,drvEmployeeSSN              = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')  
  --      ,drvEmployeeNumber           = EecEmpNo  
  --      ,drvDivision                 = ''  
  --      ,drvRelationship             = 'E'  
  --      ,drvGender                   = CASE WHEN EepGender NOT IN ('M','F') THEN 'X' ELSE EepGender END  
  --      ,drvHireDate                 = EecDateOfLastHire  
  --      ,drvBirthDate                = EepDateOfBirth  
  --      ,drvAddress1                 = EepAddressLine1  
  --      ,drvAddress2                 = EepAddressLine2  
  --      ,drvCity                     = EepAddressCity  
  --      ,drvState                    = EepAddressState  
  --      ,drvZip                      = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')  
  --                                          ELSE EepAddressZipCode  
  --                                     END  
  --      ,drvCountry                  = EepAddressCountry  
  --      ,drvCobraEligible            = CASE WHEN BdmRunID = 'QB' THEN 'N' ELSE 'Y' END -- dependent QE  
  --      ,drvPreferredLanguage        = ''  
  --      ,drvPhoneNumber              = ''--STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')  
  --      ,drvAddressEMail             = EepAddressEMail  
  --      ,drvInitialNotificationCOBRA = CASE WHEN BdmRunID = 'NPM' THEN 'C'  
  --                                     END  
  --,drvWaitingStartDate = BdmBenStartDate  
  --,drvCoverageBeginDate = BdmBenStartDate  
  --      ,drvInitialSort              = RTRIM(EepSSN) + '01'  
  --  FROM dbo.U_EWWCOBNPC2_EEList WITH (NOLOCK)  
  --  JOIN dbo.EmpComp WITH (NOLOCK)  
  --      ON EecEEID = xEEID  
  --     AND EecCoID = xCoID  
  --  JOIN dbo.EmpPers WITH (NOLOCK)  
  --      ON eepEEID = xEEID  
  --  JOIN (SELECT DISTINCT BdmEEID, BdmCoID, BdmRunID, BdmBenStartDate  
  --        FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
  --        WHERE (BdmRunID = 'QB' AND BdmRecType = 'DEP' AND BdmIsPQB = 'Y')) BDM  
  --      ON BdmEEID = xEEID  
  --     AND BdmCoID = xCoID;  
  
    ------------------  
    -- Load Employee Action Codes 03 and 06  
    -- 03 - Employee is PQB (non-death)  
    -- 06 - Dependent is PQB  
    ------------------  
    --INSERT INTO dbo.U_EWWCOBNPC2_drvTbl  
    --SELECT DISTINCT  
    --     drvEEID                     = xEEID  
    --    ,drvCoID                     = xCoID  
    --    ,drvDepRecID                 = ConSystemID  
    --    ,drvRecType                  = BdmRecType  
    --    ,drvEmployerEIN              = '73-0780382'  
    --    ,drvActionCode               = CASE WHEN BdmRecType = 'EMP' THEN '03'  
    --                                        WHEN BdmRecType = 'DEP' THEN '06'  
    --                                   END  
    --    ,drvLastName                 = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast  
    --                            WHEN BdmRecType = 'DEP' THEN ConNameLast  
    --                                   END  
    --    ,drvFirstName                = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst  
    --                                        WHEN BdmRecType = 'DEP' THEN ConNameFirst  
    --                                   END  
    --    ,drvMiddleInitial            = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)  
    --                                        WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)  
    --                                   END  
    --    ,drvEmployeeSSN              = STUFF(STUFF(EepSSN,4,0,'-'),7,0,'-')  
    --    ,drvDependentSSN             = STUFF(STUFF(ConSSN,4,0,'-'),7,0,'-')  
    --    ,drvEmployeeNumber           = EecEmpNo  
    --    ,drvDivision                 = ''  
    --    ,drvEmployeeClass            = NULL  
    --    ,drvRelationship             = CASE WHEN BdmRecType = 'EMP' THEN 'E'  
    --                                        WHEN BdmRecType = 'DEP' THEN  
    --                                             CASE WHEN ConRelationship IN ('SPC','SPS','DP') THEN 'S'  
    --                                                  WHEN ConRelationship IN ('CST','STC','DCH','STU','CHL','CDP') THEN 'C'  
    --                                                  --WHEN ConRelationship IN ('CDP','STC') THEN 'Q'  
    --                                                  --WHEN ConRelationship IN ('DP') THEN 'W'  
    --                                                  ELSE 'O'  
    --                                             END  
    --                                   END  
    --    ,drvGender                   = CASE WHEN BdmRecType = 'EMP' THEN EepGender  
    --                                        WHEN BdmRecType = 'DEP' THEN ConGender  
    --                                   END  
    --    ,drvHireDate                 = EecDateOfLastHire  
    --    ,drvBirthDate                = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth  
    --                                        WHEN BdmRecType = 'DEP' THEN ConDateOfBirth  
    --                                   END  
    --    ,drvAddress1                 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1  
    --                                        WHEN BdmRecType = 'DEP' THEN ConAddressLine1  
    --                                   END  
    --    ,drvAddress2                 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2  
    --                                        WHEN BdmRecType = 'DEP' THEN ConAddressLine2  
    --                                   END  
    --    ,drvCity                     = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity  
    --                                        WHEN BdmRecType = 'DEP' THEN ConAddressCity  
    --                                   END  
    --    ,drvState                    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState  
    --                                        WHEN BdmRecType = 'DEP' THEN ConAddressState  
    --                                   END  
    --    ,drvZip                      = CASE WHEN BdmRecType = 'EMP' THEN  
    --                                             CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')  
    --                                                  ELSE EepAddressZipCode  
    --                                             END  
    --                                        WHEN BdmRecType = 'DEP' THEN  
    --                                             CASE WHEN LEN(ConAddressZipCode) > 5 THEN STUFF(ConAddressZipCode,6,0,'-')  
    --                                                  ELSE ConAddressZipCode  
    --                                             END  
    --                                   END  
    --    ,drvCountry                  = CASE WHEN BdmRecType = 'EMP' THEN NULLIF(EepAddressCountry,'USA')  
    --                                        WHEN BdmRecType = 'DEP' THEN NULLIF(ConAddressCountry,'USA')  
    --                                   END  
    --    ,drvCobraEligible            = 'Y'  
    --    ,drvPreferredLanguage        = 'EN'  
    --    ,drvPhoneNumber              = CASE WHEN BdmRecType = 'EMP' THEN STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')  
    --                                        WHEN BdmRecType = 'DEP' THEN STUFF(STUFF(ConPhoneHomeNumber,7,0,'-'),4,0,'-')  
    --                                   END  
    --    ,drvAddressEMail             = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail  
    --                                   END  
    --    ,drvInitialNotificationCOBRA = NULL  
    --    ,drvWaitingStartDate         = EecDateOfLastHire  
    --    ,drvCoverageBeginDate        = BdmStartDate  
    --    ,drvQualifyingEventDate      = BdmLastStopDate  
    --    ,drvLastPreCobraCovered      = BdmBenStopDate--BdmStopDateBdmStopDate JDE 03/10/2020 SF16844163   
    --    ,drvQualifyingEventType      = CASE WHEN BdmRecType = 'EMP' THEN  
    --                                             CASE WHEN BdmCobraReason = '208' THEN '01'  
    --                                                  WHEN EecTermReason IN ('101','112','198','199','202') THEN '01'  
    --                                                  WHEN BdmCobraReason IN ('202','203','CHGRP') THEN '04'  
    --                                                  WHEN BdmCobraReason = '209' THEN '03'  
    --                                                  WHEN BdmCobraReason = '207' THEN '07'  
    --                                                  WHEN EecTermReason IN ('100','102','103','104','105','106','107','108','110','111','120','130','140','150','160','170','180','201','203','204','207','251','253') THEN '03'  
    --                                                  WHEN EecTermReason IN ('200','208','209','210','211','216','218','220','223','225','230','235','240','245','255','260','265','270','300','C2H','FLEX','LIEU') THEN 'NS'  
    --                                                  ELSE '03'  
    --                                             END  
    --                                        WHEN BdmRecType = 'DEP' THEN  
    --                                             CASE WHEN BdmCobraReason = '210' OR EecTermReason = '203' THEN '14'  
    --                                                  WHEN BdmCobraReason = '204' THEN '11'  
    --                                                  WHEN BdmCobraReason = '201' THEN '12'  
    --                                                  WHEN BdmCobraReason = 'LEVNT3' THEN '17'  
    --                                                  WHEN BdmCobraReason = 'LEVNT4' THEN '11'  
    --                                                  WHEN BdmCobraReason = '205' THEN '13'  
    --                                             END  
    --                                   END  
    --    ,drvPlanName1C1Med           = CASE WHEN MedEEID IS NOT NULL THEN   
    --                                        CASE WHEN MedDedCode IN ('CDHPA','CDHPB','CDHPC','CDHPD','CDHPE') THEN 'BCBS Consumer Driven Health'  
    --                                             WHEN MedDedCode IN ('PPOA','PPOB','PPOC','PPOD','PPOE') THEN 'BCBS PPO'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovCode1             = CASE WHEN MedEEID IS NOT NULL THEN  
    --                                           CASE WHEN MedBenOption = 'EE' THEN '01'  
    --                                             WHEN MedBenOption = 'EECH' THEN '59'  
    --                                             WHEN MedBenOption IN ('EESP','EEDP') THEN '06'  
    --                                             WHEN MedBenOption IN ('FAM','FDP') THEN '04'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovStart1            = MedStartDate  
    --    ,drvPlanCovEnd1              = MedStopDate  
    --    ,drvCarrierEmpID1        = CASE WHEN MedEEID IS NOT NULL THEN EecEmpNo  
    --                                   END  
    --    ,drvPlanName2C8Den           = CASE WHEN DenEEID IS NOT NULL THEN  
    --                                        CASE WHEN DenDedCode IN ('DENT') THEN 'Delta Dental Core'  
    --                                             WHEN DenDedCode IN ('DENTP') THEN 'Delta Dental Premium'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovCode2             = CASE WHEN DenEEID IS NOT NULL THEN  
    --                                        CASE WHEN DenBenOption = 'EE' THEN '01'  
    --                                             WHEN DenBenOption = 'EECH' THEN '59'  
    --                                             WHEN DenBenOption IN ('EESP','EEDP') THEN '06'  
    --                                             WHEN DenBenOption IN ('FAM','FDP') THEN '04'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovStart2            = DenStartDate  
    --    ,drvPlanCovEnd2              = DenStopDate  
    --    ,drvCarrierEmpID2            = CASE WHEN DenEEID IS NOT NULL THEN EecEmpNo  
    --                                   END  
    --    ,drvPlanName3C15Vis          = CASE WHEN VisEEID IS NOT NULL THEN  
    --                                        CASE WHEN VisDedCode IN ('VIS') THEN 'VSP'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovCode3             = CASE WHEN VisEEID IS NOT NULL THEN  
    --                                        CASE WHEN VisBenOption = 'EE' THEN '01'  
    --                                             WHEN VisBenOption = 'EECH' THEN '59'  
    --                                             WHEN VisBenOption IN ('EESP','EEDP') THEN '06'  
    --                                             WHEN VisBenOption IN ('FAM','FDP') THEN '04'  
    --                                        END  
    --                                   END  
    --    ,drvPlanCovStart3            = VisStartDate  
    --    ,drvPlanCovEnd3              = VisStopDate  
    --    ,drvCarrierEmpID3            = CASE WHEN VisEEID IS NOT NULL THEN EecEmpNo  
    --                                   END  
    --    ,drvPlanName4FSAMed          = CASE WHEN FsaEEID IS NOT NULL THEN 'WW19' END   
    --    ,drvPlanCovCode4             = CASE WHEN FsaEEID IS NOT NULL THEN '98' END  
    --    ,drvPlanCovStart4            = FsaStartDate  
    --    ,drvPlanCovEnd4              = FsaStopDate  
    --    ,drvPlanRate4                = CASE WHEN FsaEEID IS NOT NULL THEN  
    --                                             CASE WHEN EecPayPeriod = 'B' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * 26 / 12))  
    --                                                  WHEN EecPayPeriod = 'S' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * 24 / 12))  
    --                                                  WHEN EecPayPeriod = 'M' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt))  
    --                                                  WHEN EecPayPeriod = 'W' THEN CONVERT(varchar(30),CONVERT(decimal(10,2), FsaEEAmt * 52 / 12))  
    --                                             END  
    --                                   END  
    --    ,drvCarrierEmpID4            = CASE WHEN FsaEEID IS NOT NULL THEN EecEmpNo END  
    --    ,drvInitialSort              = RTRIM(EepSSN)  
    --                                    + CASE WHEN BdmRecType = 'EMP' THEN '03'  
    --                                           ELSE '06'  
    --                                      END  
    --                                    + CASE WHEN ConRelationship IN ('SPC','SPS','DP') THEN '1'  
    --                                           WHEN ConRelationship IN ('CST','STC','DCH','STU','CHL','CDP') THEN '2'  
    --                                           ELSE ''  
   --                                      END + ISNULL(ConSSN,'')  
    --FROM dbo.U_EWWCOBNPC2_EEList WITH (NOLOCK)  
    --JOIN (SELECT  
    --           BdmEEID, BdmCoID, BdmDepRecID, BdmRecType, BdmCobraReason, BdmRelationship,  
    --           MIN(BdmBenStartDate) BdmStartDate, MIN(BdmStopDate) BdmStopDate, MIN(BdmBenStopDate) BdmBenStopDate,MAX(BdmDateOfCOBRAEvent) BdmLastStopDate --JDE 03/10/2020 MIN(BdmBenStopDate) BdmBenStopDate SF16844163   
    --      FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
    --      WHERE BdmRunID = 'QB'  
    --        AND BdmIsPQB = 'Y'  
    --      GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType, BdmCobraReason, BdmRelationship) BDM  
    --    ON BdmEEID = xEEID  
    --   AND BdmCoID = xCoID  
    --JOIN dbo.EmpComp WITH (NOLOCK)  
    --    ON EecEEID = BdmEEID  
    --   AND EecCoID = BdmCoID  
    --JOIN dbo.EmpPers WITH (NOLOCK)  
    --    ON eepEEID = BdmEEID  
    --JOIN dbo.Company WITH (NOLOCK)  
    --    ON CmpCoID = BdmCoID  
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)  
    --    ON ConEEID = BdmEEID  
    --   AND ConSystemID = BdmDepRecID  
    --LEFT JOIN (SELECT  
    --                MedEEID        = BdmEEID  
    --               ,MedCoID        = BdmCoID  
    --               ,MedDepRecID    = BdmDepRecID  
    --               ,MedDedCode     = BdmDedCode  
    --               ,MedBenOption   = BdmBenOption  
    --               ,MedNumSpouses  = BdmNumSpouses  
    --               ,MedNumChildren = BdmNumChildren  
    --               ,MedStartDate   = BdmBenStartDate  
    --               ,MedStopDate    = BdmBenStopDate --BdmDateOfCOBRAEvent  
    --           FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
    --           WHERE BdmRunID = 'QB'  
    --             AND BdmDedType = 'MED') MED  
    --    ON MedEEID = BdmEEID  
    --   AND MedCoID = BdmCoID  
    --   AND ISNULL(MedDepRecID,'') = ISNULL(BdmDepRecID,'')  
    --LEFT JOIN (SELECT  
    --                DenEEID        = BdmEEID  
    --               ,DenCoID        = BdmCoID  
    --               ,DenDepRecID    = BdmDepRecID  
    --               ,DenDedCode     = BdmDedCode  
    --               ,DenBenOption   = BdmBenOption  
    --               ,DenNumSpouses  = BdmNumSpouses  
    --               ,DenNumChildren = BdmNumChildren  
    --               ,DenStartDate   = BdmBenStartDate  
    --               ,DenStopDate    = BdmBenStopDate --BdmDateOfCOBRAEvent  
    --           FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
    --           WHERE BdmRunID = 'QB'  
    --             AND BdmDedType = 'DEN') DEN  
    --    ON DenEEID = BdmEEID  
    --   AND DenCoID = BdmCoID  
    --   AND ISNULL(DenDepRecID,'') = ISNULL(BdmDepRecID,'')  
    --LEFT JOIN (SELECT  
    --                VisEEID        = BdmEEID  
    --               ,VisCoID        = BdmCoID  
    --               ,VisDepRecID    = BdmDepRecID  
    --               ,VisDedCode     = BdmDedCode  
    --               ,VisBenOption   = BdmBenOption  
    --               ,VisNumSpouses  = BdmNumSpouses  
    --               ,VisNumChildren = BdmNumChildren  
    --               ,VisStartDate   = BdmBenStartDate  
    --               ,VisStopDate    = BdmBenStopDate --BdmDateOfCOBRAEvent  
    --           FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
    --           WHERE BdmRunID = 'QB'  
    --             AND BdmDedType = 'VIS') VIS  
    --    ON VisEEID = BdmEEID  
    --   AND VisCoID = BdmCoID  
    --   AND ISNULL(VisDepRecID,'') = ISNULL(BdmDepRecID,'')  
    --LEFT JOIN (SELECT  
    --                FsaEEID      = BdmEEID  
    --               ,FsaCoID      = BdmCoID  
    --               ,FsaDepRecID  = BdmDepRecID  
    --               ,FsaDedCode   = BdmDedCode  
    --               ,FsaEEAmt     = BdmEEAmt  
    --               ,FsaStartDate = BdmBenStartDate  
    --               ,FsaStopDate  = BdmBenStopDate --BdmDateOfCOBRAEvent  
    --           FROM dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
    --           WHERE BdmRunID = 'QB'  
    --             AND BdmDedType = 'FSA') FSA  
    --    ON FsaEEID = BdmEEID  
    --   AND FsaCoID = BdmCoID  
    --   AND ISNULL(FsaDepRecID,'') = ISNULL(BdmDepRecID,'')  
    -- ;  
  
    ------------------  
    -- Load Dependent Action Code 02  
    -- 02 - Dependent for Action Codes 01, 03, or 06  
    ------------------  
    INSERT INTO dbo.U_EWWCOBNPC2_drvTbl(  
        drvEEID, drvCoID, drvDepRecID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName,  
        drvFirstName, drvMiddleInitial, drvEmployeeSSN, drvDependentSSN, drvEmployeeNumber,drvRelationship, drvGender,  
        drvBirthDate, drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry,drvCobraEligible, drvPreferredLanguage,drvInitialNotificationCOBRA,drvWaitingStartDate,drvCoverageBeginDate, drvInitialSort)  
    SELECT DISTINCT  
        drvEEID           = drvEEID  
        ,drvCoID          = drvCoID  
        ,drvDepRecID      = ConSystemID  
        ,drvRecType       = 'DEP'  
        ,drvEmployerEIN   = drvEmployerEIN  
        ,drvActionCode    = '02'  
        ,drvLastName      = ConNameLast  
        ,drvFirstName     = ConNameFirst  
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)  
        ,drvEmployeeSSN   = STUFF(STUFF(ConSSN,4,0,'-'), 7,0,'-')  
        ,drvDependentSSN  = STUFF(STUFF(ConSSN,4,0,'-'), 7,0,'-')  
  ,drvEmployeeNumber = drvEmployeeNumber  
        ,drvRelationship  = CASE WHEN ConRelationship IN ('SPS') THEN 'S'  
                                 WHEN ConRelationship IN ('CHL') THEN  
         CASE WHEN ConIsDisabled = 'Y' then 'D'   
           WHEN ConIsStudent  = 'Y' then 'T'  
           ELSE 'C'  
         END  
                                 WHEN ConRelationship IN ('STC') THEN 'Q'  
                                 WHEN ConRelationship IN ('DP') THEN 'W'  
                                 ELSE 'O'  
                            END  
        ,drvGender        = CASE WHEN ConGender not in ('M','F') then 'X'  
        Else ConGender  
       END  
        ,drvBirthDate     = ConDateOfBirth  
        ,drvAddress1      = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine1 Else drvAddress1  
                            END  
        ,drvAddress2      = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine2 Else drvAddress2  
                            END  
        ,drvCity          = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity Else drvCity  
                            END  
        ,drvState         = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressState Else drvState  
                            END  
        ,drvZip           = CASE WHEN ConAddressIsDifferent = 'Y' THEN  
                                      CASE WHEN LEN(ConAddressZipCode) > 5 THEN STUFF(ConAddressZipCode,6,0,'-')  
                                           ELSE ConAddressZipCode  
                                      END  
        Else drvZip  
                                     
                            END  
        ,drvCountry       = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCountry Else drvCountry  
                            END  
        ,drvCobraEligible            = 'Y'   
        ,drvPreferredLanguage        = ''  
  ,drvInitialNotificationCOBRA = 'C'  
                                         
  ,drvWaitingStartDate = BdmBenStartDate  
  ,drvCoverageBeginDate = BdmBenStartDate  
        ,drvInitialSort   = RTRIM(REPLACE(drvEmployeeSSN,'-','')) + '02'  
                                + CASE WHEN ConRelationship IN ('SPC','SPS','DP') THEN '1'  
                                       ELSE '2'  
                                  END + ISNULL(ConSSN,'')  
    FROM dbo.U_EWWCOBNPC2_drvTbl WITH (NOLOCK)  
    JOIN dbo.Contacts WITH (NOLOCK)  
        ON ConEEID = drvEEID  
    JOIN(select BdmEEID,BdmCOID,BdmDepRecID,max(BdmBenStartDate) BdmBenStartDate from dbo.U_dsi_BDM_EWWCOBNPC2 WITH (NOLOCK)  
   where BdmRecType = 'DEP'  
                   AND (BdmRunID = 'NPM'  
                        OR (BdmRunID = 'QB' ))  
    group by BdmEEID,BdmCOID,BdmDepRecID) bdm  
           ON BdmEEID = drvEEID  
                   AND BdmCoID = drvCoID  
                   AND BdmDepRecID = ConSystemID  
                   ;  
  
    ------------------  
    -- Load Dependent Action Code 04  
    -- 04 - Death of Covered Employee  
    ------------------  
    --INSERT INTO dbo.U_EWWCOBNPC2_drvTbl(  
    --    drvEEID, drvCoID, drvRecType, drvEmployerEIN, drvActionCode, drvLastName, drvFirstName, drvMiddleInitial,  
    --    drvEmployeeSSN, drvEmployeeNumber, drvDivision, drvRelationship, drvGender, drvHireDate, drvBirthDate,  
    --    drvAddress1, drvAddress2, drvCity, drvState, drvZip, drvCountry, drvPreferredLanguage, drvPhoneNumber,  
    --    drvAddressEMail, drvWaitingStartDate, drvQualifyingEventDate, drvQualifyingEventType, drvInitialSort)  
    --SELECT DISTINCT  
    --     drvEEID                = drvEEID  
    --    ,drvCoID                = drvCoID  
    --    ,drvRecType             = 'EMP'  
    --    ,drvEmployerEIN         = drvEmployerEIN  
    --    ,drvActionCode          = '04'  
    --    ,drvLastName            = EepNameLast  
    --    ,drvFirstName           = EepNameFirst  
    --    ,drvMiddleInitial       = LEFT(EepNameMiddle,1)  
    --    ,drvEmployeeSSN         = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')  
    --    ,drvEmployeeNumber      = drvEmployeeNumber  
    --    ,drvDivision            = drvDivision  
    --    ,drvRelationship        = 'E'  
    --    ,drvGender              = EepGender  
    --    ,drvHireDate            = drvHireDate  
    --    ,drvBirthDate           = EepDateOfBirth  
    --    ,drvAddress1            = EepAddressLine1  
    --    ,drvAddress2            = EepAddressLine2  
    --    ,drvCity                = EepAddressCity  
    --    ,drvState               = EepAddressState  
    --    ,drvZip                 = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')  
    --                                   ELSE EepAddressZipCode  
    --                              END  
    --    ,drvCountry             = NULLIF(EepAddressCountry,'USA')  
    --    ,drvPreferredLanguage   = 'EN'  
    --    ,drvPhoneNumber         = STUFF(STUFF(EepPhoneHomeNumber,7,0,'-'),4,0,'-')  
    --    ,drvAddressEMail        = EepAddressEMail  
    --    ,drvWaitingStartDate    = drvWaitingStartDate  
    --    ,drvQualifyingEventDate = drvQualifyingEventDate  
    --    ,drvQualifyingEventType = '21'  
    --    ,drvInitialSort         = RTRIM(EepSSN) + '04'  
    --FROM dbo.U_EWWCOBNPC2_drvTbl WITH (NOLOCK)  
    --JOIN dbo.EmpPers WITH (NOLOCK)  
    --    ON eepEEID = drvEEID  
    --WHERE drvActionCode = '06'  
    --  AND drvQualifyingEventType = '14';  
  
    --==========================================  
    -- Set FileName  
    --==========================================  
 IF (dbo.dsi_fnVariable('EWWCOBNPC2','UseFileName') = 'N')  
    UPDATE dbo.U_dsi_Parameters  
    SET ExportFile = 'COB_Complink43_99748_CXT_' + CONVERT(char(8),GETDATE(),112) + '_'  
                     + CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR @ExportCode = 'TEST' THEN 'TST_'  
                            ELSE ''  
                       END  
                     + 'NOT.txt'  
    WHERE FormatCode = @FormatCode;  
  
END  
/*  
--Alter the View  
ALTER VIEW dbo.dsi_vwEWWCOBNPC2_Export AS  
    SELECT TOP 200000000 Data  
    FROM dbo.U_EWWCOBNPC2_File WITH (NOLOCK)  
    ORDER BY InitialSort;  
  
--Check out AscDefF  
SELECT * FROM dbo.AscDefF  
WHERE AdfHeaderSystemID LIKE 'EWWCOBNPC2%'  
ORDER BY AdfSetNumber, AdfFieldNumber;  
  
--Update Dates  
UPDATE dbo.AscExp  
SET expLastStartPerControl = '202308011'  
   ,expStartPerControl     = '202308011'  
   ,expLastEndPerControl   = '202308091'  
   ,expEndPerControl       = '202308091'  
WHERE expFormatCode = 'EWWCOBNPC2'  
  AND expExportCode = 'TEST_XOE';  
*/  
GO
CREATE VIEW dbo.dsi_vwEWWCOBNPC2_Export AS
    SELECT TOP 200000000 Data
    FROM dbo.U_EWWCOBNPC2_File WITH (NOLOCK)
    ORDER BY InitialSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWWCOBNPC2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWWCOBNPC2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWWCOBNPC2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBNPC2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBNPC2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBNPC2', 'UseFileName', 'V', 'Y'


-- End ripout