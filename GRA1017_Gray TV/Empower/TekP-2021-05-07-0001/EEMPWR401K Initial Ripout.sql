/**********************************************************************************

EEMPWR401K: Empower 401K Export

FormatCode:     EEMPWR401K
Project:        Empower 401K Export
Client ID:      GRA1017
Date/time:      2022-01-24 12:53:51.370
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_GRYT
Web Filename:   GRA1017_6Q6LQ_EEHISTORY_EEMPWR401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EEMPWR401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EEMPWR401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EEMPWR401K'


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
WHERE FormatCode = 'EEMPWR401K'
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
WHERE ExpFormatCode = 'EEMPWR401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EEMPWR401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EEMPWR401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EEMPWR401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EEMPWR401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EEMPWR401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EEMPWR401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EEMPWR401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EEMPWR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EEMPWR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EEMPWR401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEEMPWR401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMPWR401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMPWR401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPWR401K];
GO
IF OBJECT_ID('U_EEMPWR401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_PEarHist];
GO
IF OBJECT_ID('U_EEMPWR401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_PDedHist];
GO
IF OBJECT_ID('U_EEMPWR401K_File') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_File];
GO
IF OBJECT_ID('U_EEMPWR401K_EmpHJob') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_EmpHJob];
GO
IF OBJECT_ID('U_EEMPWR401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_EEList];
GO
IF OBJECT_ID('U_EEMPWR401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_drvTbl];
GO
IF OBJECT_ID('U_EEMPWR401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_DedList];
GO
IF OBJECT_ID('U_EEMPWR401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_AuditFields];
GO
IF OBJECT_ID('U_EEMPWR401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEMPWR401K_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMPWR401K','Empower 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','708','S','N','EEMPWR401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMPWR401KZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL,'"455269-01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMPWR401KZ0','11','D','10','0',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMPWR401KZ0','20','D','10','0',NULL,'Division number',NULL,NULL,'"drvDivisionnumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMPWR401KZ0','35','D','10','0',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMPWR401KZ0','20','D','10','0',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMPWR401KZ0','20','D','10','0',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMPWR401KZ0','15','D','10','0',NULL,'Name Suffix',NULL,NULL,'"drvNameSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMPWR401KZ0','10','D','10','0',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMPWR401KZ0','1','D','10','0',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMPWR401KZ0','1','D','10','0',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMPWR401KZ0','35','D','10','0',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMPWR401KZ0','35','D','10','0',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMPWR401KZ0','20','D','10','0',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMPWR401KZ0','2','D','10','0',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMPWR401KZ0','10','D','10','0',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMPWR401KZ0','10','D','10','0',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMPWR401KZ0','10','D','10','0',NULL,'Work Phone Number',NULL,NULL,'"drvWorkPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMPWR401KZ0','4','D','10','0',NULL,'Work Phone Ext.',NULL,NULL,'"drvWorkPhoneExt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMPWR401KZ0','2','D','10','0',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMPWR401KZ0','10','D','10','0',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMPWR401KZ0','10','D','10','0',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMPWR401KZ0','10','D','10','0',NULL,'Re-Hire Date',NULL,NULL,'"drvReHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMPWR401KZ0','10','D','10','0',NULL,'Checkdate',NULL,NULL,'"drvCheckdate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 1',NULL,NULL,'"drvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 3',NULL,NULL,'"drvContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 4',NULL,NULL,'"drvContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 5',NULL,NULL,'"drvContributionAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 6',NULL,NULL,'"drvContributionAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 7',NULL,NULL,'"drvContributionAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMPWR401KZ0','10','D','10','0',NULL,'Contribution Amount 8',NULL,NULL,'"drvContributionAmount8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMPWR401KZ0','5','D','10','0',NULL,'YTD Hours Worked',NULL,NULL,'"drvYTDHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDTotalCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Plan Compensation',NULL,NULL,'"drvYTDPlanCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMPWR401KZ0','11','D','10','0',NULL,'YTD Pre Entry Compensation',NULL,NULL,'"drvYTDPreEntryCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMPWR401KZ0','1','D','10','0',NULL,'Highly Comp Employee Code',NULL,NULL,'"drvHighlyCompEmployeeCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMPWR401KZ0','6','D','10','0',NULL,'Percent of Ownership',NULL,NULL,'"drvPercentofOwnership"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMPWR401KZ0','1','D','10','0',NULL,'Officer Determination',NULL,NULL,'"drvOfficerDetermination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMPWR401KZ0','10','D','10','0',NULL,'Participation Date (ACQUISITION DATE)',NULL,NULL,'"drvParticipationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMPWR401KZ0','1','D','10','0',NULL,'Eligibility Code',NULL,NULL,'"drvEligibilityCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMPWR401KZ0','2','D','10','0',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMPWR401KZ0','1','D','10','0',NULL,'LOA Reason Code',NULL,NULL,'"drvLOAReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMPWR401KZ0','10','D','10','0',NULL,'LOA Start Date',NULL,NULL,'"drvLOAStartDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMPWR401KZ0','10','D','10','0',NULL,'LOA End Date',NULL,NULL,'"drvLOAEndDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMPWR401KZ0','80','D','10','0',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMPWR401KZ0','17','D','10','0',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMPWR401KZ0','2','D','10','0',NULL,'Salary Amount Qualifier',NULL,NULL,'"drvSalaryAmountQualifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMPWR401KZ0','20','D','10','0',NULL,'Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMPWR401KZ0','1','D','10','0',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL,'"drvSarbanesOxleyReporting"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMPWR401KZ0','6','D','10','0',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMPWR401KZ0','2','D','10','0',NULL,'Federal Exemptions',NULL,NULL,'"drvFederalExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMPWR401KZ0','10','D','10','0',NULL,'Employer Assigned ID',NULL,NULL,'"drvEmployerAssignedID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMPWR401KZ0','6','D','10','0',NULL,'Compliance Status Code',NULL,NULL,'"drvComplianceStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EEMPWR401KZ0','80','D','10','0',NULL,'Personal Email Address',NULL,NULL,'"drvPersonalEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EEMPWR401KZ0','10','D','10','0',NULL,'Mobile Phone',NULL,NULL,'"drvMobilePhone"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EEMPWR401K_20220124.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',RW4WR,S92VK,S92SH,WSGTJ,S92PR,90P54,S92N5,K2WNB,14CGB',NULL,NULL,NULL,'Empower 401K Export Send','202002069','EMPEXPORT','EEMPKOE','Oct 18 2021 12:00AM','EEMPWR401K',NULL,NULL,NULL,'202002069','Feb  6 2020 12:00AM','Dec 30 1899 12:00AM','202002061',NULL,'','','202002061',dbo.fn_GetTimedKey(),NULL,'MBUTTIMER01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',RW4WR,S92VK,S92SH,WSGTJ,S92PR,90P54,S92N5,K2WNB,14CGB',NULL,NULL,NULL,'Empower 401K Export','202107161','EMPEXPORT','ONDEMAND','Jul 22 2021  4:25PM','EEMPWR401K',NULL,NULL,NULL,'202107161','Jul 16 2021 12:00AM','Jul 11 2021 12:00AM','202107161','81','eecPaygroup','CORPA1','202107161',dbo.fn_GetTimedKey(),NULL,'ULTI_GRYT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911279','EMPEXPORT','SCHEDULED',NULL,'EEMPWR401K',NULL,NULL,NULL,'201911279','Nov 27 2019 11:24AM','Nov 27 2019 11:24AM','201911271',NULL,'','','201911271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202201142','EMPEXPORT','TEST','Jan 19 2022 11:13AM','EEMPWR401K',NULL,NULL,NULL,'202201142','Jan 14 2022 12:00AM','Jan  9 2022 12:00AM','202201142','8811','','','202201142',dbo.fn_GetTimedKey(),NULL,'us3rVaGRA1017',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMPWR401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPWR401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMPWR401K','D10','dbo.U_EEMPWR401K_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EEMPWR401K_Audit
-----------

IF OBJECT_ID('U_EEMPWR401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_Audit] (
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
-- Create table U_EEMPWR401K_AuditFields
-----------

IF OBJECT_ID('U_EEMPWR401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EEMPWR401K_DedList
-----------

IF OBJECT_ID('U_EEMPWR401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EEMPWR401K_drvTbl
-----------

IF OBJECT_ID('U_EEMPWR401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvDivisionnumber] char(5) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckdate] varchar(10) NULL,
    [drvContributionAmount1] varchar(10) NULL,
    [drvContributionAmount2] varchar(10) NULL,
    [drvContributionAmount3] varchar(10) NULL,
    [drvContributionAmount4] varchar(10) NULL,
    [drvContributionAmount5] varchar(10) NULL,
    [drvContributionAmount6] varchar(10) NULL,
    [drvContributionAmount7] varchar(1) NOT NULL,
    [drvContributionAmount8] varchar(1) NOT NULL,
    [drvYTDHoursWorked] varchar(5) NULL,
    [drvYTDTotalCompensation] varchar(11) NULL,
    [drvYTDPlanCompensation] varchar(11) NULL,
    [drvYTDPreEntryCompensation] varchar(11) NULL,
    [drvHighlyCompEmployeeCode] char(1) NULL,
    [drvPercentofOwnership] varchar(1) NOT NULL,
    [drvOfficerDetermination] char(1) NULL,
    [drvParticipationDate] datetime NULL,
    [drvEligibilityCode] varchar(1) NOT NULL,
    [drvLOAReasonCode] varchar(1) NOT NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] varchar(17) NULL,
    [drvSalaryAmountQualifier] varchar(1) NOT NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvSarbanesOxleyReporting] varchar(1) NOT NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvEmployerAssignedID] char(9) NULL,
    [drvComplianceStatusCode] varchar(1) NOT NULL,
    [drvPersonalEmailAddress] varchar(50) NULL,
    [drvMobilePhone] varchar(50) NULL
);

-----------
-- Create table U_EEMPWR401K_EEList
-----------

IF OBJECT_ID('U_EEMPWR401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEMPWR401K_EmpHJob
-----------

IF OBJECT_ID('U_EEMPWR401K_EmpHJob') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_EmpHJob] (
    [EjhEEID] char(12) NOT NULL,
    [EjhCOID] char(5) NOT NULL,
    [EjhHireReHireDate] datetime NULL
);

-----------
-- Create table U_EEMPWR401K_File
-----------

IF OBJECT_ID('U_EEMPWR401K_File') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(708) NULL
);

-----------
-- Create table U_EEMPWR401K_PDedHist
-----------

IF OBJECT_ID('U_EEMPWR401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_PDedHist] (
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
    [PdhSource6] numeric NULL
);

-----------
-- Create table U_EEMPWR401K_PEarHist
-----------

IF OBJECT_ID('U_EEMPWR401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMPWR401K_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMPWR401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gray Television

Created By: Sean Farrell
Business Analyst: Karen Formicone
Create Date: 11/27/2019
Service Request Number: SR-2019-00244787

Purpose: Empower 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Nicci Blady            10/20/2020        NoSR-PartnerDirect    Update to send amounts > 0.00, add new ded codes, update contribution buckets

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPWR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, ExpDesc, * FROM dbo.AscExp WHERE expFormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPWR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'EEMPKOE';


EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EEMPWR401K', @AllObjects = 'Y', @IsWeb = 'Y';

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
    SELECT @FormatCode = 'EEMPWR401K';

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
    -- Max PayDate
    --==========================================

    DECLARE @CheckDate VARCHAR(10);

    SELECT

    @CheckDate = CONVERT(VARCHAR,MAX(PrgPayDate),101)
    FROM dbo.PayReg WITH (NOLOCK)
    WHERE LEFT(PrgPerControl,4) = LEFT(@EndPerControl,4)
    AND PrgPerControl <= @EndPerControl;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EEMPWR401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMPWR401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEMPWR401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_AuditFields;
    CREATE TABLE dbo.U_EEMPWR401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEMPWR401K_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEMPWR401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EEMPWR401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEMPWR401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(d,-14,@EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEMPWR401K_Audit ON dbo.U_EEMPWR401K_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EEMPWR401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EEMPWR401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'K401K,K2CU,KLN1,KLN2,K4CU,KERM,KRTHK,KAFTX';            --10/20/2020 Added KERM (Combined ER Match),KRTHK (Roth regular),KAFTX (Roth After Tax) ded codes - NB

    IF OBJECT_ID('U_EEMPWR401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMPWR401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EEMPWR401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('K401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('K4CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('K401K','KERM') THEN PdhERCurAmt ELSE 0.00 END)            --10/20/2020 Added KERM (Combined ER Match) ded code - NB
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('KLN1','KLN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('KRTHK') THEN PdhEECurAmt ELSE 0.00 END)                    --10/20/2020 Added KRTHK (Roth regular) ded code - NB
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('KAFTX') THEN PdhEECurAmt ELSE 0.00 END)                    --10/20/2020 Added KAFTX (Roth After Tax) ded code - NB
    INTO dbo.U_EEMPWR401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEMPWR401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl    -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) > 0.00            --11/18/2020 Updated per client request - NB
        OR SUM(PdhERCurAmt) > 0.00)
    ;


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EEMPWR401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_PEarHist;
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
    INTO dbo.U_EEMPWR401K_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEMPWR401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMPWR401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMPWR401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvDivisionnumber = CmpCompanyCode
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvBirthDate = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE eepMaritalStatus WHEN 'M' THEN 'M' WHEN 'D' THEN 'D' WHEN 'W' THEN 'W' ELSE 'S' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvWorkPhoneNumber = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = ''
        ,drvCountryCode = 'US'
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                   WHEN EecEMplStatus = 'A' AND EecDateOfLastHire <> EecdateOfOriginalHire AND Exists (SELECT Top 1 * FROM dbo.EmpHStat WITH (NOLOCK) WHERE EshEEID = xEEID AND EshCOID = xCOID AND ESHEmplStatus = 'T' ORDER BY EshStatusStartDate DESC)
                                    THEN (SELECT DATEADD(d,-1,MAX(EshStatusStartDate)) FROM dbo.EmpHStat WITH (NOLOCK) WHERE EshEEID = xEEID AND EshCOID = xCOID AND ESHEmplStatus = 'T')
                                    ELSE NULL
                              END
        ,drvReHireDate = CASE WHEN EecDateOFLastHire <> EecDateofOriginalHire THEN EecdateOfLastHire ELSE NULL END
        ,drvCheckdate = @CheckDate
        ,drvContributionAmount1 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource1)),'0.00'),10)
        ,drvContributionAmount2 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource2)),'0.00'),10)
        ,drvContributionAmount3 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource3)),'0.00'),10)
        ,drvContributionAmount4 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource4)),'0.00'),10)
        ,drvContributionAmount5 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource5)),'0.00'),10)        --''--'0.00'        --10/20/2020 Added KRTHK (Roth regular) contributions - NB
        ,drvContributionAmount6 = RIGHT(SPACE(10) + ISNULL(CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PdhSource6)),'0.00'),10)        --''--'0.00'        --10/20/2020 Added KAFTX (Roth After Tax) contributions - NB
        ,drvContributionAmount7 = ''--'''0.00'
        ,drvContributionAmount8 = ''--'0.00'
        ,drvYTDHoursWorked = RIGHT(SPACE(5) + CONVERT(VARCHAR,CONVERT(NUMERIC(10),PehCurHrsYTD)),5)
        ,drvYTDTotalCompensation = RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11)
        ,drvYTDPlanCompensation = RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11)
        ,drvYTDPreEntryCompensation = CASE WHEN dbo.dsi_fnlib_TrueWeeklyandMonthlyDATEDIFF('Monthly',EecDateOfOriginalhire,@EndDate) < 6 THEN RIGHT(SPACE(11) + CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),PehInclInDefCompYTD)),11) ELSE '' END
        ,drvHighlyCompEmployeeCode = EecUDFIELD22
        ,drvPercentofOwnership = ''
        ,drvOfficerDetermination = EecUDFIELD21
        ,drvParticipationDate = EecDateInJob
        ,drvEligibilityCode = 'Y'
        ,drvLOAReasonCode = CASE WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN 'M' ELSE '' END
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN EecEmplStatusStartDate ELSE NULL END
        ,drvLOAEndDate = CASE WHEN EecLeaveReason = '300' AND audOLdValue = 'L' AND audNewValue <> 'L' THEN audDateTime ELSE NULL END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvSalaryAmount = RIGHT(SPACE(17) + CASE EecSalaryOrHourly WHEN 'H' THEN CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),EecHourlyPayRate)) ELSE CONVERT(VARCHAR,CONVERT(NUMERIC(20,2),EecPeriodPayRate)) END,17)
        ,drvSalaryAmountQualifier = CASE EecSalaryOrHourly WHEN 'H' THEN 'H' ELSE 'B' END
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN 
                                                CASE EecTermReason 
                                                        WHEN '203' THEN 'DE'
                                                        WHEN '300' THEN 'LA'
                                                        WHEN '202' THEN 'R'
                                                        ELSE 'S'
                                                END
                                   END
        ,drvSarbanesOxleyReporting = ''
        ,drvFederalExemptions = ''
        ,drvEmployerAssignedID = EecEmpno
        ,drvComplianceStatusCode = ''
        ,drvPersonalEmailAddress = EepAddressEMailAlternate
        ,drvMobilePhone = EfoPhoneNumber
    INTO dbo.U_EEMPWR401K_drvTbl
    FROM dbo.U_EEMPWR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EEMPWR401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EEMPWR401K_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EEMPWR401K_Audit WITH (NOLOCK)
        ON audEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
        AND EfoIsPrivate = 'N'
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    WHERE EecEmplStatus IN ('A','L')
    OR (EecEMplStatus = 'T' AND (DATEDIFF(d,@EndDate,EecDateOfTermination) BETWEEN 0 AND 30 
                OR PehCurAmt > 0.00))
                
                /* (PdhSource1 > 0.00
                OR PdhSource2 > 0.00
                OR PdhSource3 > 0.00
                OR PdhSource4 > 0.00)))*/
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMPWR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl, ExpDesc, * FROM dbo.AscExp WHERE expFormatCode = 'EEMPWR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMPWR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMPWR401K', 'EEMPKOE';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EEMPWR401K', @AllObjects = 'Y', @IsWeb = 'Y';

--Alter the View
ALTER VIEW dbo.dsi_vwEEMPWR401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMPWR401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEMPWR401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911201'
       ,expStartPerControl     = '201911201'
       ,expLastEndPerControl   = '201911279'
       ,expEndPerControl       = '201911279'
WHERE expFormatCode = 'EEMPWR401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMPWR401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMPWR401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EEMPWR401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EEMPWR401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EEMPWR401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPWR401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EEMPWR401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMPWR401K', 'UseFileName', 'V', 'Y'


-- End ripout