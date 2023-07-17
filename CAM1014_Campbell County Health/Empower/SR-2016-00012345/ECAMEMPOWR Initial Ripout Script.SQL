/**********************************************************************************

ECAMEMPOWR: Empower 457 Combined

FormatCode:     ECAMEMPOWR
Project:        Empower 457 Combined
Client ID:      USG1000
Date/time:      2023-07-14 11:47:17.170
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ECAMEMPOWR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECAMEMPOWR_SavePath') IS NOT NULL DROP TABLE dbo.U_ECAMEMPOWR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECAMEMPOWR'


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
WHERE FormatCode = 'ECAMEMPOWR'
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
WHERE ExpFormatCode = 'ECAMEMPOWR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECAMEMPOWR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECAMEMPOWR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECAMEMPOWR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECAMEMPOWR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECAMEMPOWR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECAMEMPOWR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECAMEMPOWR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECAMEMPOWR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECAMEMPOWR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECAMEMPOWR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECAMEMPOWR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECAMEMPOWR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECAMEMPOWR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAMEMPOWR];
GO
IF OBJECT_ID('U_ECAMEMPOWR_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_PEarHist];
GO
IF OBJECT_ID('U_ECAMEMPOWR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_PDedHist];
GO
IF OBJECT_ID('U_ECAMEMPOWR_File') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_File];
GO
IF OBJECT_ID('U_ECAMEMPOWR_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_EEList];
GO
IF OBJECT_ID('U_ECAMEMPOWR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_drvTbl];
GO
IF OBJECT_ID('U_ECAMEMPOWR_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_DedList];
GO
IF OBJECT_ID('U_ECAMEMPOWR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_AuditFields];
GO
IF OBJECT_ID('U_ECAMEMPOWR_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECAMEMPOWR_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECAMEMPOWR') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECAMEMPOWR];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECAMEMPOWR','Empower 457 Combined','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECAMEMPOWRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAMEMPOWRZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAMEMPOWRZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAMEMPOWRZ0','20','D','10','25',NULL,'Division number',NULL,NULL,'"drvDivisionnumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAMEMPOWRZ0','35','D','10','45',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAMEMPOWRZ0','20','D','10','80',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAMEMPOWRZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAMEMPOWRZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAMEMPOWRZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAMEMPOWRZ0','1','D','10','145',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECAMEMPOWRZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECAMEMPOWRZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECAMEMPOWRZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECAMEMPOWRZ0','20','D','10','217',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECAMEMPOWRZ0','2','D','10','237',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECAMEMPOWRZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECAMEMPOWRZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECAMEMPOWRZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL,'"drvWorkPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECAMEMPOWRZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL,'"drvWorkPhoneExt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECAMEMPOWRZ0','2','D','10','273',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECAMEMPOWRZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECAMEMPOWRZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECAMEMPOWRZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL,'"drvReHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECAMEMPOWRZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL,'"drvCheckdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECAMEMPOWRZ0','10','D','10','315',NULL,'Pretax',NULL,NULL,'"drvPretax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECAMEMPOWRZ0','10','D','10','325',NULL,'Roth',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECAMEMPOWRZ0','10','D','10','335',NULL,'Contribution Amount 3',NULL,NULL,'"drvContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECAMEMPOWRZ0','10','D','10','345',NULL,'Contribution Amount 4',NULL,NULL,'"drvContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECAMEMPOWRZ0','10','D','10','355',NULL,'Contribution Amount 5',NULL,NULL,'"drvContributionAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECAMEMPOWRZ0','10','D','10','365',NULL,'Contribution Amount 6',NULL,NULL,'"drvContributionAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECAMEMPOWRZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL,'"drvContributionAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECAMEMPOWRZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL,'"drvContributionAmount8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECAMEMPOWRZ0','5','D','10','395',NULL,'Hours Worked',NULL,NULL,'"drvHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECAMEMPOWRZ0','11','D','10','400',NULL,'YTD Total Compensation - Includes Bonus',NULL,NULL,'"drvYTDTotalCompnIncludesBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECAMEMPOWRZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL,'"drvYTDPlanCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECAMEMPOWRZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL,'"drvPreEntryComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECAMEMPOWRZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL,'"drvHighlyCompEmployeeploy"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECAMEMPOWRZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL,'"drvPercentofOwnership"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECAMEMPOWRZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL,'"drvOfficerDetermination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECAMEMPOWRZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL,'"drvParticipationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECAMEMPOWRZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL,'"drvEligibilityCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECAMEMPOWRZ0','1','D','10','452',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECAMEMPOWRZ0','1','D','10','453',NULL,'LOA Reason Code',NULL,NULL,'"drvLOAReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECAMEMPOWRZ0','10','D','10','454',NULL,'LOA Start Date',NULL,NULL,'"drvLOAStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECAMEMPOWRZ0','10','D','10','464',NULL,'LOA End Date',NULL,NULL,'"drvLOAEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECAMEMPOWRZ0','80','D','10','474',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECAMEMPOWRZ0','17','D','10','554',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECAMEMPOWRZ0','2','D','10','571',NULL,'Salary Amount Qualifier',NULL,NULL,'"drvSalaryAmountQualifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECAMEMPOWRZ0','20','D','10','573',NULL,'Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECAMEMPOWRZ0','1','D','10','593',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL,'"drvSarbanesOxleyReportingploy"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECAMEMPOWRZ0','6','D','10','594',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECAMEMPOWRZ0','2','D','10','600',NULL,'Federal Exemptions',NULL,NULL,'"drvFederalExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECAMEMPOWRZ0','10','D','10','602',NULL,'Employer Assigned ID',NULL,NULL,'"drvEmployerAssignedID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECAMEMPOWRZ0','6','D','10','612',NULL,'Compliance Status Code/ excluded class code',NULL,NULL,'"drvYTDStatusCompnclasscode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECAMEMPOWRZ0','80','D','10','618',NULL,'Personal Email Address',NULL,NULL,'"drvPersonalEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECAMEMPOWRZ0','10','D','10','698',NULL,'Mobile Phone',NULL,NULL,'"drvMobilePhone"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECAMEMPOWR_20230714.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 457 Combined','202307149','EMPEXPORT','ONDEM_XOE',NULL,'ECAMEMPOWR',NULL,NULL,NULL,'202307149','Jul 14 2023 11:44AM','Jul 14 2023 11:44AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 457 Combined-Sched','202307149','EMPEXPORT','SCH_ECAMEM',NULL,'ECAMEMPOWR',NULL,NULL,NULL,'202307149','Jul 14 2023 11:44AM','Jul 14 2023 11:44AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 457 Combined-Test','202307149','EMPEXPORT','TEST_XOE',NULL,'ECAMEMPOWR',NULL,NULL,NULL,'202307149','Jul 14 2023 11:44AM','Jul 14 2023 11:44AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAMEMPOWR','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAMEMPOWR','D10','dbo.U_ECAMEMPOWR_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECAMEMPOWR
-----------

IF OBJECT_ID('U_dsi_BDM_ECAMEMPOWR') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECAMEMPOWR] (
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
-- Create table U_ECAMEMPOWR_Audit
-----------

IF OBJECT_ID('U_ECAMEMPOWR_Audit') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_Audit] (
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
-- Create table U_ECAMEMPOWR_AuditFields
-----------

IF OBJECT_ID('U_ECAMEMPOWR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECAMEMPOWR_DedList
-----------

IF OBJECT_ID('U_ECAMEMPOWR_DedList') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECAMEMPOWR_drvTbl
-----------

IF OBJECT_ID('U_ECAMEMPOWR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanNumber] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvDivisionnumber] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(50) NULL,
    [drvCountryCode] char(3) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckdate] varchar(1) NOT NULL,
    [drvPretax] varchar(1) NOT NULL,
    [drvRoth] varchar(1) NOT NULL,
    [drvContributionAmount3] varchar(1) NOT NULL,
    [drvContributionAmount4] varchar(1) NOT NULL,
    [drvContributionAmount5] varchar(1) NOT NULL,
    [drvContributionAmount6] varchar(1) NOT NULL,
    [drvContributionAmount7] varchar(1) NOT NULL,
    [drvContributionAmount8] varchar(1) NOT NULL,
    [drvHoursWorked] varchar(1) NOT NULL,
    [drvYTDTotalCompnIncludesBonus] varchar(1) NOT NULL,
    [drvYTDPlanCompensation] varchar(1) NOT NULL,
    [drvPreEntryComp] varchar(1) NOT NULL,
    [drvHighlyCompEmployeeploy] char(1) NULL,
    [drvPercentofOwnership] varchar(1) NOT NULL,
    [drvOfficerDetermination] varchar(1) NOT NULL,
    [drvParticipationDate] varchar(1) NOT NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvLOAReasonCode] varchar(1) NOT NULL,
    [drvLOAStartDate] varchar(1) NOT NULL,
    [drvLOAEndDate] varchar(1) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] varchar(1) NOT NULL,
    [drvSalaryAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] char(6) NULL,
    [drvSarbanesOxleyReportingploy] varchar(1) NOT NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvEmployerAssignedID] varchar(1) NOT NULL,
    [drvYTDStatusCompnclasscode] varchar(1) NOT NULL,
    [drvPersonalEmailAddress] varchar(50) NULL,
    [drvMobilePhone] varchar(1) NOT NULL
);

-----------
-- Create table U_ECAMEMPOWR_EEList
-----------

IF OBJECT_ID('U_ECAMEMPOWR_EEList') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECAMEMPOWR_File
-----------

IF OBJECT_ID('U_ECAMEMPOWR_File') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ECAMEMPOWR_PDedHist
-----------

IF OBJECT_ID('U_ECAMEMPOWR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_PDedHist] (
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
-- Create table U_ECAMEMPOWR_PEarHist
-----------

IF OBJECT_ID('U_ECAMEMPOWR_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECAMEMPOWR_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAMEMPOWR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Campbell County Health

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 07/14/2023
Service Request Number: SR-2016-00012345

Purpose: Empower 457 Combined

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECAMEMPOWR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECAMEMPOWR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECAMEMPOWR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECAMEMPOWR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECAMEMPOWR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAMEMPOWR', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAMEMPOWR', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECAMEMPOWR', 'SCH_ECAMEM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECAMEMPOWR';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECAMEMPOWR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECAMEMPOWR';

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
    DELETE FROM dbo.U_ECAMEMPOWR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECAMEMPOWR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECAMEMPOWR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_AuditFields;
    CREATE TABLE dbo.U_ECAMEMPOWR_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECAMEMPOWR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_Audit;
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
    INTO dbo.U_ECAMEMPOWR_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECAMEMPOWR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECAMEMPOWR_Audit ON dbo.U_ECAMEMPOWR_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECAMEMPOWR_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECAMEMPOWR_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '457BF,457RO';

    IF OBJECT_ID('U_ECAMEMPOWR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECAMEMPOWR_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECAMEMPOWR_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_PDedHist;
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
    INTO dbo.U_ECAMEMPOWR_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECAMEMPOWR_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECAMEMPOWR_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_PEarHist;
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
    INTO dbo.U_ECAMEMPOWR_PEarHist
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
    -- DETAIL RECORD - U_ECAMEMPOWR_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECAMEMPOWR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECAMEMPOWR_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = ''
        ,drvEmployeeSSN = eepSSN
        ,drvDivisionnumber = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = EecPhoneBusinessNumber
        ,drvCountryCode = EepAddressCountry
        ,drvHireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvReHireDate = EecDateOfLastHire
        ,drvCheckdate = ''
        ,drvPretax = ''
        ,drvRoth = ''
        ,drvContributionAmount3 = ''
        ,drvContributionAmount4 = ''
        ,drvContributionAmount5 = ''
        ,drvContributionAmount6 = ''
        ,drvContributionAmount7 = ''
        ,drvContributionAmount8 = ''
        ,drvHoursWorked = ''
        ,drvYTDTotalCompnIncludesBonus = ''
        ,drvYTDPlanCompensation = ''
        ,drvPreEntryComp = ''
        ,drvHighlyCompEmployeeploy = EecIsHighlyComp
        ,drvPercentofOwnership = ''
        ,drvOfficerDetermination = ''
        ,drvParticipationDate = ''
        ,drvEligibilityCode = ''
        ,drvLOAReasonCode = ''
        ,drvLOAStartDate = ''
        ,drvLOAEndDate = ''
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvSalaryAmount = ''
        ,drvSalaryAmountQualifier = ''
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvSarbanesOxleyReportingploy = ''
        ,drvFederalExemptions = ''
        ,drvEmployerAssignedID = ''
        ,drvYTDStatusCompnclasscode = ''
        ,drvPersonalEmailAddress = EepAddressEMail
        ,drvMobilePhone = ''
    INTO dbo.U_ECAMEMPOWR_drvTbl
    FROM dbo.U_ECAMEMPOWR_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECAMEMPOWR WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwECAMEMPOWR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECAMEMPOWR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECAMEMPOWR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307071'
       ,expStartPerControl     = '202307071'
       ,expLastEndPerControl   = '202307149'
       ,expEndPerControl       = '202307149'
WHERE expFormatCode = 'ECAMEMPOWR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECAMEMPOWR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECAMEMPOWR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECAMEMPOWR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECAMEMPOWR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECAMEMPOWR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECAMEMPOWR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECAMEMPOWR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECAMEMPOWR', 'UseFileName', 'V', 'Y'


-- End ripout