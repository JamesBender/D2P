/**********************************************************************************

ESANMOOEXP: Mutual of Omaha Life Disability Export

FormatCode:     ESANMOOEXP
Project:        Mutual of Omaha Life Disability Export
Client ID:      USG1000
Date/time:      2023-04-11 11:40:16.590
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ESANMOOEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESANMOOEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESANMOOEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESANMOOEXP'


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
WHERE FormatCode = 'ESANMOOEXP'
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
WHERE ExpFormatCode = 'ESANMOOEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESANMOOEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESANMOOEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESANMOOEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESANMOOEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESANMOOEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESANMOOEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESANMOOEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESANMOOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESANMOOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESANMOOEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_sp_BuildDriverTables_ESANMOOEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESANMOOEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESANMOOEXP','Mutual of Omaha Life Disability Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESANMOOEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESANMOOEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL,'"drvTransDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESANMOOEXPZ0','8','D','10','2',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESANMOOEXPZ0','1','D','10','3',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESANMOOEXPZ0','9','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESANMOOEXPZ0','35','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESANMOOEXPZ0','15','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESANMOOEXPZ0','1','D','10','7',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESANMOOEXPZ0','8','D','10','8',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESANMOOEXPZ0','30','D','10','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESANMOOEXPZ0','30','D','10','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESANMOOEXPZ0','19','D','10','11',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESANMOOEXPZ0','2','D','10','12',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESANMOOEXPZ0','11','D','10','13',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESANMOOEXPZ0','8','D','10','14',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateofHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESANMOOEXPZ0','8','D','10','15',NULL,'Employee Effective Date',NULL,NULL,'"drvEmployeeEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESANMOOEXPZ0','8','D','10','16',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESANMOOEXPZ0','4','D','10','17',NULL,'Bill Group ID',NULL,NULL,'"drvBillGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESANMOOEXPZ0','8','D','10','18',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESANMOOEXPZ0','1','D','10','19',NULL,'Basic Salary Mode',NULL,NULL,'"drvBasicSalaryMode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESANMOOEXPZ0','16','D','10','20',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESANMOOEXPZ0','8','D','10','21',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESANMOOEXPZ0','4','D','10','22',NULL,'Class ID',NULL,NULL,'"drvClassID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESANMOOEXPZ0','1','D','10','23',NULL,'Product Category',NULL,NULL,'"drvProductCategory1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESANMOOEXPZ0','8','D','10','24',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESANMOOEXPZ0','2','D','10','25',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESANMOOEXPZ0','10','D','10','26',NULL,'Plan ID',NULL,NULL,'"drvPlanID1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESANMOOEXPZ0','1','D','10','27',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESANMOOEXPZ0','1','D','10','28',NULL,'Product Category',NULL,NULL,'"drvProductCategory2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESANMOOEXPZ0','8','D','10','29',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESANMOOEXPZ0','2','D','10','30',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESANMOOEXPZ0','10','D','10','31',NULL,'Plan ID',NULL,NULL,'"drvPlanID2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESANMOOEXPZ0','1','D','10','32',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESANMOOEXPZ0','1','D','10','33',NULL,'Product Category',NULL,NULL,'"drvProductCategory3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESANMOOEXPZ0','8','D','10','34',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESANMOOEXPZ0','2','D','10','35',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESANMOOEXPZ0','10','D','10','36',NULL,'Plan ID',NULL,NULL,'"drvPlanID3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESANMOOEXPZ0','1','D','10','37',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESANMOOEXPZ0','1','D','10','38',NULL,'Product Category',NULL,NULL,'"drvProductCategory4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESANMOOEXPZ0','8','D','10','39',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESANMOOEXPZ0','2','D','10','40',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESANMOOEXPZ0','10','D','10','41',NULL,'Plan ID',NULL,NULL,'"drvPlanID4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESANMOOEXPZ0','1','D','10','42',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESANMOOEXPZ0','8','D','10','43',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESANMOOEXPZ0','10','D','10','44',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESANMOOEXPZ0','1','D','10','45',NULL,'Product Category',NULL,NULL,'"drvProductCategory5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESANMOOEXPZ0','8','D','10','46',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESANMOOEXPZ0','2','D','10','47',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESANMOOEXPZ0','10','D','10','48',NULL,'Plan ID',NULL,NULL,'"drvPlanID5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESANMOOEXPZ0','1','D','10','49',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESANMOOEXPZ0','8','D','10','50',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESANMOOEXPZ0','10','D','10','51',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESANMOOEXPZ0','1','D','10','52',NULL,'Product Category',NULL,NULL,'"drvProductCategory6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESANMOOEXPZ0','8','D','10','53',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESANMOOEXPZ0','2','D','10','54',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESANMOOEXPZ0','10','D','10','55',NULL,'Plan ID',NULL,NULL,'"drvPlanID6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESANMOOEXPZ0','1','D','10','56',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESANMOOEXPZ0','8','D','10','57',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESANMOOEXPZ0','10','D','10','58',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESANMOOEXPZ0','1','D','10','59',NULL,'Product Category',NULL,NULL,'"drvProductCategory7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESANMOOEXPZ0','8','D','10','60',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESANMOOEXPZ0','2','D','10','61',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESANMOOEXPZ0','10','D','10','62',NULL,'Plan ID',NULL,NULL,'"drvPlanID7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESANMOOEXPZ0','1','D','10','63',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESANMOOEXPZ0','8','D','10','64',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESANMOOEXPZ0','10','D','10','65',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESANMOOEXPZ0','1','D','10','66',NULL,'Product Category',NULL,NULL,'"drvProductCategory8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESANMOOEXPZ0','8','D','10','67',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESANMOOEXPZ0','2','D','10','68',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESANMOOEXPZ0','10','D','10','69',NULL,'Plan ID',NULL,NULL,'"drvPlanID8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESANMOOEXPZ0','1','D','10','70',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESANMOOEXPZ0','8','D','10','71',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESANMOOEXPZ0','10','D','10','72',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESANMOOEXPZ0','1','D','10','73',NULL,'Product Category',NULL,NULL,'"drvProductCategory9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESANMOOEXPZ0','8','D','10','74',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESANMOOEXPZ0','2','D','10','75',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESANMOOEXPZ0','10','D','10','76',NULL,'Plan ID',NULL,NULL,'"drvPlanID9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESANMOOEXPZ0','1','D','10','77',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESANMOOEXPZ0','8','D','10','78',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESANMOOEXPZ0','10','D','10','79',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESANMOOEXPZ0','1','D','10','80',NULL,'Product Category',NULL,NULL,'"drvProductCategory10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESANMOOEXPZ0','8','D','10','81',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESANMOOEXPZ0','2','D','10','82',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESANMOOEXPZ0','10','D','10','83',NULL,'Plan ID',NULL,NULL,'"drvPlanID10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESANMOOEXPZ0','1','D','10','84',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator10"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESANMOOEXP_20230411.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202304119','EMPEXPORT','OEACTIVE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202304119','Apr 11 2023  9:02AM','Apr 11 2023  9:02AM','202304111',NULL,'','','202304111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202304119','EMPEXPORT','OEPASSIVE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202304119','Apr 11 2023  9:02AM','Apr 11 2023  9:02AM','202304111',NULL,'','','202304111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Disabilit','202304119','EMPEXPORT','ONDEM_XOE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202304119','Apr 11 2023  9:02AM','Apr 11 2023  9:02AM','202304111',NULL,'','','202304111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Sched','202304119','EMPEXPORT','SCH_ESANMO',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202304119','Apr 11 2023  9:02AM','Apr 11 2023  9:02AM','202304111',NULL,'','','202304111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Test','202304119','EMPEXPORT','TEST_XOE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202304119','Apr 11 2023  9:02AM','Apr 11 2023  9:02AM','202304111',NULL,'','','202304111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESANMOOEXP','D10','dbo.U_ESANMOOEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------

GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESANMOOEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: San Diego Convention Center

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 04/11/2023
Service Request Number: TekP-2023-01-12-05

Purpose: Mutual of Omaha Life Disability Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESANMOOEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESANMOOEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESANMOOEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESANMOOEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESANMOOEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESANMOOEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESANMOOEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESANMOOEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESANMOOEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESANMOOEXP', 'SCH_ESANMO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESANMOOEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESANMOOEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@RunDate           VARCHAR(8)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ESANMOOEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@FileMinCovDate  = '03/01/2022'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESANMOOEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESANMOOEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESANMOOEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESANMOOEXP_AuditFields;
    CREATE TABLE dbo.U_ESANMOOEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESANMOOEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESANMOOEXP_Audit;
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
    INTO dbo.U_ESANMOOEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESANMOOEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESANMOOEXP_Audit ON dbo.U_ESANMOOEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ESANMOOEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESANMOOEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTLER,DEPER,LTDER,LTDEX,GVLEE,GVLSP,GVLCH,ADDEM,ADDSP,ADDCH';

    IF OBJECT_ID('U_ESANMOOEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESANMOOEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESANMOOEXP_DedList
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

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESANMOOEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESANMOOEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESANMOOEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransDate = @Rundate
        ,drvGroupID = 'G000AZNK'
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN 'M' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ISNULL(ConGender,'') IN ( 'M', '')THEN 'H' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ConGender = 'F' THEN 'W' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ISNULL(ConGender, '') IN ( 'M', '') THEN 'S'
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConGender = 'F' THEN 'D' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConIsDisabled ='Y' AND (SELECT FLOOR(DATEDIFF(DAY, GetDate() , ConDateofbirth) / 365.25)) >=  26 THEN 'Y'
                                    ELSE 'I' 
                                END
        ,drvEmployeeID = EepSSN
        ,drvLastName = CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END)) AS VARCHAR(50))
        ,drvFirstName = CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END)) AS VARCHAR(50))
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateofBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOFBirth END
        ,drvAddressLine = ''
        ,drvAddressLine = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDateofHire = EecDateofLastHire
        ,drvEmployeeEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', All_BenStartDate , @FileMinCovDate)                         
        ,drvBillGroupEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', All_BenStartDate , @FileMinCovDate)
        ,drvBillGroupID = '0001'
        ,drvBasicSalaryEffectiveDate =  dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @FileMinCovDate, eecDateOfLastHire)
        ,drvBasicSalaryMode = 'A'
        ,drvBasicSalaryAmount = Format(EecAnnSalary, '0000000000000000')
        ,drvClassEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', ALL_BenStartDate , @FileMinCovDate)
        ,drvClassID = 'A001'
        ,drvProductCategory1 = CASE WHEN GTLER_DedCode Is not null THEN '1' END
        ,drvEffectiveDate1 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GTLER_BenStatus = 'T' THEN DATEADD(DAY, +1, GTLER_BenStopDate) ELSE GTLER_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent1 = CASE WHEN GTLER_DedCode Is not null and GTLER_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID1 = CASE WHEN GTLER_DedCode Is not null THEN 'LTL00NCSAL' END
        ,drvFamilyCoverageIndicator1 = CASE WHEN GTLER_DedCode Is not null THEN 'C' END
        ,drvProductCategory2 = CASE WHEN ADDEM_DedCode Is not null THEN 'a' END
        ,drvEffectiveDate2 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDEM_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDEM_BenStopDate) ELSE ADDEM_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent2 = CASE WHEN ADDEM_DedCode Is not null and ADDEM_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID2 = CASE WHEN ADDEM_DedCode Is not null THEN 'ATA00NCSAL' END
        ,drvFamilyCoverageIndicator2 = CASE WHEN ADDEM_DedCode Is not null THEN 'C' END
        ,drvProductCategory3 = CASE WHEN LTD_DedCode Is not null  THEN 'T' END
        ,drvEffectiveDate3 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LTD_BenStatus = 'T' THEN DATEADD(DAY, +1, LTD_BenStopDate) ELSE LTD_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent3 =  CASE WHEN LTD_DedCode Is not null and LTD_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID3 = CASE WHEN LTD_DedCode Is not null THEN 'TTT00NCSAL' END
        ,drvFamilyCoverageIndicator3 = CASE WHEN LTD_DedCode Is not null THEN 'C' END
        ,drvProductCategory4 = CASE WHEN GVLEE_DedCode Is not null THEN '3' END
        ,drvEffectiveDate4 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLEE_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLEE_BenStopDate) ELSE GVLEE_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent4 = CASE WHEN GVLEE_DedCode Is not null and GVLEE_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID4 = CASE WHEN GVLEE_DedCode Is not null THEN 'ETL0CEEVAL' END
        ,drvFamilyCoverageIndicator4 = CASE WHEN GVLEE_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate4 = CASE WHEN GVLEE_DedCode Is not null THEN dbo.dsi_fnGetMinMaxDates('MAX',  GVLEE_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount4 = CASE WHEN GVLEE_DedCode Is not null THEN FORMAT(GVLEE_BenAmt, '0000000000') END
        ,drvProductCategory5 = CASE WHEN GVLSP_DedCode Is not null THEN '4' END
        ,drvEffectiveDate5 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLSP_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLSP_BenStopDate) ELSE GVLSP_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent5 = CASE WHEN GVLSP_DedCode Is not null and GVLSP_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID5 = CASE WHEN GVLSP_DedCode Is not null THEN 'ETL0CSPVAL' END
        ,drvFamilyCoverageIndicator5 = CASE WHEN GVLSP_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate5 = CASE WHEN GVLSP_DedCode Is not null THEN dbo.dsi_fnGetMinMaxDates('MAX',  GVLSP_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount5 =  CASE WHEN GVLSP_DedCode Is not null THEN FORMAT(GVLSP_BenAmt, '0000000000') END
        ,drvProductCategory6 =CASE WHEN GVLCH_DedCode Is not null THEN  '5' END
        ,drvEffectiveDate6 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLCH_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLCH_BenStopDate) ELSE GVLCH_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent6 = CASE WHEN GVLCH_DedCode Is not null and GVLCH_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID6 = CASE WHEN GVLCH_DedCode Is not null THEN 'ETL0CDPVAL' END
        ,drvFamilyCoverageIndicator6 = CASE WHEN GVLCH_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate6 = CASE WHEN GVLCH_DedCode Is not null THEN dbo.dsi_fnGetMinMaxDates('MAX',  GVLCH_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount6 = CASE WHEN GVLCH_DedCode Is not null THEN FORMAT(GVLCH_BenAmt, '0000000000') END
        ,drvProductCategory7 = CASE WHEN ADDEE_BenStatus is not null THEN 'c'END
        ,drvEffectiveDate7 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDEE_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDEE_BenStopDate) ELSE ADDEE_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent7 = CASE WHEN ADDEE_DedCode Is not null and ADDEE_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID7 = CASE WHEN ADDEE_DedCode Is not null THEN 'ETL0CEEVAL' END
        ,drvFamilyCoverageIndicator7 =CASE WHEN ADDEE_DedCode Is not null THEN  'C' END
        ,drvApprovedAmtEffectiveDate7 =  CASE WHEN ADDEE_DedCode Is not null THEN dbo.dsi_fnGetMinMaxDates('MAX',  ADDEE_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount7 = CASE WHEN ADDEE_DedCode Is not null THEN FORMAT(ADDEE_BenAmt, '0000000000') END
        ,drvProductCategory8 =  CASE WHEN ADDSP_DedCode Is not null THEN 'e' END
        ,drvEffectiveDate8 = dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDSP_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDSP_BenStopDate) ELSE ADDSP_BenStartDate END, @FileMinCovDate)
        ,drvEligibilityEvent8 = CASE WHEN ADDSP_DedCode Is not null and ADDSP_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID8 = CASE WHEN ADDSP_DedCode Is not null THEN 'ETL0CSPVAL' END
        ,drvFamilyCoverageIndicator8 = CASE WHEN ADDSP_DedCode Is not null  THEN 'C' END
        ,drvApprovedAmtEffectiveDate8 = CASE WHEN ADDSP_DedCode Is not null  THEN  dbo.dsi_fnGetMinMaxDates('MAX',  ADDSP_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount8 = CASE WHEN ADDSP_DedCode Is not null  THEN FORMAT(ADDSP_BenAmt, '0000000000') END
        ,drvProductCategory9 =  CASE WHEN ADDCH_DedCode Is not null THEN 'd' END
        ,drvEffectiveDate9 =CASE WHEN ADDCH_DedCode Is not null  THEN dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDCH_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDCH_BenStopDate) ELSE ADDCH_BenStartDate END, @FileMinCovDate) END
        ,drvEligibilityEvent9 = CASE WHEN ADDCH_DedCode Is not null and ADDCH_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID9 = CASE WHEN ADDCH_DedCode Is not null THEN 'ETL0CDPVAL' END
        ,drvFamilyCoverageIndicator9 = CASE WHEN ADDCH_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate9 = CASE WHEN ADDCH_DedCode Is not null THEN  dbo.dsi_fnGetMinMaxDates('MAX',  ADDCH_BenStartDate , @FileMinCovDate) END
        ,drvApprovedAmount9 = CASE WHEN ADDCH_DedCode Is not null  THEN FORMAT(ADDCH_BenAmt, '0000000000') END
        ,drvProductCategory10 = CASE WHEN DEPER_DedCode is not null THEN '6' END
        ,drvEffectiveDate10 = CASE WHEN DEPER_DedCode Is not null  THEN dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN DEPER_BenStatus = 'T' THEN DATEADD(DAY, +1, DEPER_BenStopDate) ELSE DEPER_BenStartDate END, @FileMinCovDate) END
        ,drvEligibilityEvent10 = CASE WHEN DEPER_DedCode Is not null  and DEPER_BenStatus IN ('C','T') THEN 'TM' ELSE 'EN' END
        ,drvPlanID10 = CASE WHEN DEPER_DedCode Is not null  THEN  'LTL00NCDEP' END
        ,drvFamilyCoverageIndicator10 =  CASE WHEN DEPER_DedCode Is not null  THEN 'C' END 
    INTO dbo.U_ESANMOOEXP_drvTbl
    FROM dbo.U_ESANMOOEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
      JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
                
                ,MAX(CASE WHEN BdmDedCode = 'GTLER' THEN BdmDedCode END) AS GTLER_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'DEPER' THEN BdmDedCode END) AS DEPER_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('LTDER','LTDEX') THEN BdmDedCode END) AS LTD_DedCode
               -- ,MAX(CASE WHEN BdmDedCode = 'LTDEX' THEN BdmDedCode END) AS LTDEX_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GVLEE' THEN BdmDedCode END) AS GVLEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GVLSP' THEN BdmDedCode END) AS GVLSP_DedCode    
                ,MAX(CASE WHEN BdmDedCode = 'GVLCH' THEN BdmDedCode END) AS GVLCH_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTLER' THEN BdmBenStatus END) AS GTLER_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DEPER' THEN BdmBenStatus END) AS DEPER_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('LTDER','LTDEX') THEN BdmBenStatus END) AS LTD_BenStatus
               -- ,MAX(CASE WHEN BdmDedCode = 'LTDEX' THEN BdmBenStatus END) AS LTDEX_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GVLEE' THEN BdmBenStatus END) AS GVLEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GVLSP' THEN BdmBenStatus END) AS GVLSP_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GVLCH' THEN BdmBenStatus END) AS GVLCH_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GTLER' THEN BdmBenStartDate END) AS GTLER_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'DEPER' THEN BdmBenStartDate END) AS DEPER_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('LTDER','LTDEX') THEN BdmBenStartDate END) AS LTD_BenStartDate
                --,MAX(CASE WHEN BdmDedCode = 'LTDEX' THEN BdmBenStartDate END) AS LTDEX_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLEE' THEN BdmBenStartDate END) AS GVLEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLSP' THEN BdmBenStartDate END) AS GVLSP_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLCH' THEN BdmBenStartDate END) AS GVLCH_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GTLER' THEN BdmBenStopDate END) AS GTLER_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'DEPER' THEN BdmBenStopDate END) AS DEPER_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('LTDER','LTDEX') THEN BdmBenStopDate END) AS LTD_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'LTDEX' THEN BdmBenStopDate END) AS LTDEX_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLEE' THEN BdmBenStopDate END) AS GVLEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLSP' THEN BdmBenStopDate END) AS GVLSP_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GVLCH' THEN BdmBenStopDate END) AS GVLCH_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmDedCode END) AS ADDEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmDedCode END) AS ADDEM_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmDedCode END) AS ADDSP_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmDedCode END) AS ADDCH_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmDedCode END) AS ALL_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStatus END) AS ADDEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStatus END) AS ADDEM_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStatus END) AS ADDSP_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStatus END) AS ADDCH_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmBenStatus END) AS ALL_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStartDate END) AS ADDEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStartDate END) AS ADDEM_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStartDate END) AS ADDSP_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStartDate END) AS ADDCH_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmBenStartDate END) AS ALL_BenStartDate
       
                ,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStopDate END) AS ADDEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStopDate END) AS ADDEM_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStopDate END) AS ADDSP_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStopDate END) AS ADDCH_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH','ADDEE') THEN BdmBenStopDate END) AS ALL_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmEEAmt END) AS ADDEE_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmEEAmt END) AS ADDSP_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmEEAmt END) AS ADDCH_BenAmt
            FROM dbo.U_dsi_BDM_ESANMOOEXP WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.Contacts
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID
                    ,MAX(CASE WHEN EdhDedCode = 'GVLEE' THEN EdhEEBenAmt END) AS GVLEE_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'GVLSP' THEN EdhEEBenAmt END) AS GVLSP_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'GVLCH' THEN EdhEEBenAmt END) AS GVLCH_BenAmt
                    --,MAX(CASE WHEN EdhDedCode = 'ADDEE' THEN EdhEEBenAmt END) AS ADDEE_BenAmt
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt
                        FROM (
                                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDate DESC) AS RN
                                FROM dbo.EmpHDed WITH (NOLOCK) 
                                WHERE EdhDedCode IN ('GVLEE', 'GVLSP', 'GVLCH') 
                                    AND EdhBenStatus = 'A') AS T
                WHERE RN = 1) AS Y
                GROUP BY EdhEEID, EdhCOID
            ) AS BenAmount
        ON EdhEEID = xEEID
        AND EdhCOID = XCOID
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
ALTER VIEW dbo.dsi_vwESANMOOEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESANMOOEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESANMOOEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304041'
       ,expStartPerControl     = '202304041'
       ,expLastEndPerControl   = '202304119'
       ,expEndPerControl       = '202304119'
WHERE expFormatCode = 'ESANMOOEXP';

**********************************************************************************/

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESANMOOEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESANMOOEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESANMOOEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESANMOOEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESANMOOEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESANMOOEXP', 'UseFileName', 'V', 'Y'


-- End ripout