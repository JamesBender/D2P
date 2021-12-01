/**********************************************************************************

EMOOSVAEXP: MoO STD VolL ADD Export

FormatCode:     EMOOSVAEXP
Project:        MoO STD VolL ADD Export
Client ID:      PCR1000
Date/time:      2021-12-01 05:39:30.093
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP6DB02
Database:       ULTIPRO_WPPCRK
Web Filename:   PCR1000_VG436_EEHISTORY_EMOOSVAEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMOOSVAEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMOOSVAEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMOOSVAEXP'


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
WHERE FormatCode = 'EMOOSVAEXP'
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
WHERE ExpFormatCode = 'EMOOSVAEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMOOSVAEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMOOSVAEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMOOSVAEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMOOSVAEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMOOSVAEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMOOSVAEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMOOSVAEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMOOSVAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMOOSVAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMOOSVAEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMOOSVAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMOOSVAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMOOSVAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOOSVAEXP];
GO
IF OBJECT_ID('U_EMOOSVAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_PEarHist];
GO
IF OBJECT_ID('U_EMOOSVAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_PDedHist];
GO
IF OBJECT_ID('U_EMOOSVAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_File];
GO
IF OBJECT_ID('U_EMOOSVAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_EEList];
GO
IF OBJECT_ID('U_EMOOSVAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_drvTbl];
GO
IF OBJECT_ID('U_EMOOSVAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMOOSVAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMOOSVAEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMOOSVAEXP','MoO STD VolL ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1381','S','N','EMOOSVAEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMOOSVAEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL,'"drvTransDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMOOSVAEXPZ0','8','D','10','9',NULL,'Group ID',NULL,NULL,'"G000BW7J"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMOOSVAEXPZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMOOSVAEXPZ0','10','D','10','18',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMOOSVAEXPZ0','35','D','10','28',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMOOSVAEXPZ0','26','D','10','63',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMOOSVAEXPZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMOOSVAEXPZ0','19','D','10','90',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMOOSVAEXPZ0','40','D','10','109',NULL,'Address Line 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMOOSVAEXPZ0','80','D','10','149',NULL,'Address Line 2',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMOOSVAEXPZ0','19','D','10','229',NULL,'City',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMOOSVAEXPZ0','2','D','10','248',NULL,'State',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMOOSVAEXPZ0','59','D','10','250',NULL,'Zip Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMOOSVAEXPZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateOfHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMOOSVAEXPZ0','76','D','10','317',NULL,'Employee Effective Date',NULL,NULL,'"drvEmployeeEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMOOSVAEXPZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMOOSVAEXPZ0','74','D','10','401',NULL,'Bill Group ID',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMOOSVAEXPZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMOOSVAEXPZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL,'"drvBasicSalaryMode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMOOSVAEXPZ0','16','D','10','484',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMOOSVAEXPZ0','8','D','10','500',NULL,'1st Additional Compensation Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMOOSVAEXPZ0','1','D','10','508',NULL,'1st Additional Compensation Mode',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMOOSVAEXPZ0','2','D','10','509',NULL,'1st Additional Compensation Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMOOSVAEXPZ0','97','D','10','511',NULL,'1st Additional Compensation Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMOOSVAEXPZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMOOSVAEXPZ0','414','D','10','616',NULL,'Class ID',NULL,NULL,'"A001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMOOSVAEXPZ0','1','D','10','1030',NULL,'Product Category',NULL,NULL,'"drvTermEEProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMOOSVAEXPZ0','8','D','10','1031',NULL,'Effective Date',NULL,NULL,'"drvTermEEEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMOOSVAEXPZ0','2','D','10','1039',NULL,'Eligibility Event',NULL,NULL,'"drvTermEEEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMOOSVAEXPZ0','10','D','10','1041',NULL,'Plan ID',NULL,NULL,'"drvTermEEPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMOOSVAEXPZ0','5','D','10','1051',NULL,'Family Coverage Indicator',NULL,NULL,'"drvTermEEFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMOOSVAEXPZ0','8','D','10','1056',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvTermEEApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMOOSVAEXPZ0','21','D','10','1064',NULL,'Approved Amount',NULL,NULL,'"drvTermEEApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMOOSVAEXPZ0','1','D','10','1085',NULL,'Product Category',NULL,NULL,'"drvTermSPSProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMOOSVAEXPZ0','8','D','10','1086',NULL,'Effective Date',NULL,NULL,'"drvTermSPSEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMOOSVAEXPZ0','2','D','10','1094',NULL,'Eligibility Event',NULL,NULL,'"drvTermSPSEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMOOSVAEXPZ0','10','D','10','1096',NULL,'Plan ID',NULL,NULL,'"drvTermSPSPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMOOSVAEXPZ0','5','D','10','1106',NULL,'Family Coverage Indicator',NULL,NULL,'"drvTermSPSFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMOOSVAEXPZ0','8','D','10','1111',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvTermSPSApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMOOSVAEXPZ0','21','D','10','1119',NULL,'Approved Amount',NULL,NULL,'"drvTermSPSApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMOOSVAEXPZ0','1','D','10','1140',NULL,'Product Category',NULL,NULL,'"drvTermDepProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMOOSVAEXPZ0','8','D','10','1141',NULL,'Effective Date',NULL,NULL,'"drvTermDepEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMOOSVAEXPZ0','2','D','10','1149',NULL,'Eligibility Event',NULL,NULL,'"drvTermDepEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMOOSVAEXPZ0','10','D','10','1151',NULL,'Plan ID',NULL,NULL,'"drvTermDepPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMOOSVAEXPZ0','5','D','10','1161',NULL,'Family Coverage Indicator',NULL,NULL,'"drvTermDepFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMOOSVAEXPZ0','8','D','10','1166',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvTermDepApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMOOSVAEXPZ0','21','D','10','1174',NULL,'Approved Amount',NULL,NULL,'"drvTermDepApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMOOSVAEXPZ0','1','D','10','1195',NULL,'Product Category',NULL,NULL,'"drvAddEEProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMOOSVAEXPZ0','8','D','10','1196',NULL,'Effective Date',NULL,NULL,'"drvAddEEEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMOOSVAEXPZ0','2','D','10','1204',NULL,'Eligibility Event',NULL,NULL,'"drvAddEEEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMOOSVAEXPZ0','10','D','10','1206',NULL,'Plan ID',NULL,NULL,'"drvAddEEPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMOOSVAEXPZ0','5','D','10','1216',NULL,'Family Coverage Indicator',NULL,NULL,'"drvAddEEFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMOOSVAEXPZ0','8','D','10','1221',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvAddEEApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMOOSVAEXPZ0','21','D','10','1229',NULL,'Approved Amount',NULL,NULL,'"drvAddEEApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMOOSVAEXPZ0','1','D','10','1250',NULL,'Product Category',NULL,NULL,'"drvAddSPSProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMOOSVAEXPZ0','8','D','10','1251',NULL,'Effective Date',NULL,NULL,'"drvAddSPSEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMOOSVAEXPZ0','2','D','10','1259',NULL,'Eligibility Event',NULL,NULL,'"drvAddSPSEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMOOSVAEXPZ0','10','D','10','1261',NULL,'Plan ID',NULL,NULL,'"drvAddSPSPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMOOSVAEXPZ0','5','D','10','1271',NULL,'Family Coverage Indicator',NULL,NULL,'"drvAddSPSFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMOOSVAEXPZ0','8','D','10','1276',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvAddSPSApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMOOSVAEXPZ0','21','D','10','1284',NULL,'Approved Amount',NULL,NULL,'"drvAddSPSApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMOOSVAEXPZ0','1','D','10','1305',NULL,'Product Category',NULL,NULL,'"drvAddDepProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMOOSVAEXPZ0','8','D','10','1306',NULL,'Effective Date',NULL,NULL,'"drvAddDepEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EMOOSVAEXPZ0','2','D','10','1314',NULL,'Eligibility Event',NULL,NULL,'"drvAddDepEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EMOOSVAEXPZ0','10','D','10','1316',NULL,'Plan ID',NULL,NULL,'"drvAddDepPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EMOOSVAEXPZ0','5','D','10','1326',NULL,'Family Coverage Indicator',NULL,NULL,'"drvAddDepFamCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EMOOSVAEXPZ0','8','D','10','1331',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvAddDepApprovedAmtEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EMOOSVAEXPZ0','21','D','10','1339',NULL,'Approved Amount',NULL,NULL,'"drvAddDepApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EMOOSVAEXPZ0','1','D','10','1360',NULL,'Product Category',NULL,NULL,'"drvVolSTDProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EMOOSVAEXPZ0','8','D','10','1361',NULL,'Effective Date',NULL,NULL,'"drvVolSTDEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EMOOSVAEXPZ0','2','D','10','1369',NULL,'Eligibility Event',NULL,NULL,'"drvVolSTDEligibilityEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EMOOSVAEXPZ0','10','D','10','1371',NULL,'Plan ID',NULL,NULL,'"drvVolSTDPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EMOOSVAEXPZ0','1','D','10','1381',NULL,'Family Coverage Indicator',NULL,NULL,'"drvVolSTDFamCoverageInd"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMOOSVAEXP_20211201.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202108279','EMPEXPORT','OEACTIVE','Sep  1 2021  5:22AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','0','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202108279','EMPEXPORT','OEPASSIVE','Sep  1 2021  5:22AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','225','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export','202108279','EMPEXPORT','ONDEM_XOE','Sep  1 2021  5:23AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','220','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export-Sched','202108279','EMPEXPORT','SCH_EMOOSV','Sep  1 2021  5:24AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','220','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export-Test','202111171','EMPEXPORT','TEST_XOE','Nov 17 2021 10:54PM','EMOOSVAEXP',NULL,NULL,NULL,'202111171','Nov 17 2021 12:00AM','Dec 30 1899 12:00AM','202111101','323','','','202111101',dbo.fn_GetTimedKey(),NULL,'us3cPePCR1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOOSVAEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOOSVAEXP','D10','dbo.U_EMOOSVAEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMOOSVAEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EMOOSVAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMOOSVAEXP] (
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
-- Create table U_EMOOSVAEXP_DedList
-----------

IF OBJECT_ID('U_EMOOSVAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMOOSVAEXP_drvTbl
-----------

IF OBJECT_ID('U_EMOOSVAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvTransDate] datetime NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvGenderCode] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeEffectiveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryMode] varchar(1) NOT NULL,
    [drvBasicSalaryAmount] nvarchar(4000) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvTermEEProductCategory] varchar(1) NULL,
    [drvTermEEEffectiveDate] datetime NULL,
    [drvTermEEEligibilityEvent] varchar(2) NULL,
    [drvTermEEPlanID] varchar(10) NULL,
    [drvTermEEFamCoverageInd] varchar(1) NULL,
    [drvTermEEApprovedAmtEffDate] datetime NULL,
    [drvTermEEApprovedAmt] nvarchar(4000) NULL,
    [drvTermSPSProductCategory] varchar(1) NULL,
    [drvTermSPSEffectiveDate] datetime NULL,
    [drvTermSPSEligibilityEvent] varchar(2) NULL,
    [drvTermSPSPlanID] varchar(10) NULL,
    [drvTermSPSFamCoverageInd] varchar(1) NULL,
    [drvTermSPSApprovedAmtEffDate] datetime NULL,
    [drvTermSPSApprovedAmt] nvarchar(4000) NULL,
    [drvTermDepProductCategory] varchar(1) NULL,
    [drvTermDepEffectiveDate] datetime NULL,
    [drvTermDepEligibilityEvent] varchar(2) NULL,
    [drvTermDepPlanID] varchar(10) NULL,
    [drvTermDepFamCoverageInd] varchar(1) NULL,
    [drvTermDepApprovedAmtEffDate] datetime NULL,
    [drvTermDepApprovedAmt] varchar(10) NULL,
    [drvAddEEProductCategory] varchar(1) NULL,
    [drvAddEEEffectiveDate] datetime NULL,
    [drvAddEEEligibilityEvent] varchar(2) NULL,
    [drvAddEEPlanID] varchar(10) NULL,
    [drvAddEEFamCoverageInd] varchar(1) NULL,
    [drvAddEEApprovedAmtEffDate] datetime NULL,
    [drvAddEEApprovedAmt] nvarchar(4000) NULL,
    [drvAddSPSProductCategory] varchar(1) NULL,
    [drvAddSPSEffectiveDate] datetime NULL,
    [drvAddSPSEligibilityEvent] varchar(2) NULL,
    [drvAddSPSPlanID] varchar(10) NULL,
    [drvAddSPSFamCoverageInd] varchar(1) NULL,
    [drvAddSPSApprovedAmtEffDate] datetime NULL,
    [drvAddSPSApprovedAmt] nvarchar(4000) NULL,
    [drvAddDepProductCategory] varchar(1) NULL,
    [drvAddDepEffectiveDate] datetime NULL,
    [drvAddDepEligibilityEvent] varchar(2) NULL,
    [drvAddDepPlanID] varchar(10) NULL,
    [drvAddDepFamCoverageInd] varchar(1) NULL,
    [drvAddDepApprovedAmtEffDate] datetime NULL,
    [drvAddDepApprovedAmt] varchar(10) NULL,
    [drvVolSTDProductCategory] varchar(1) NULL,
    [drvVolSTDEffectiveDate] datetime NULL,
    [drvVolSTDEligibilityEvent] varchar(2) NULL,
    [drvVolSTDPlanID] varchar(10) NULL,
    [drvVolSTDFamCoverageInd] varchar(1) NULL
);

-----------
-- Create table U_EMOOSVAEXP_EEList
-----------

IF OBJECT_ID('U_EMOOSVAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMOOSVAEXP_File
-----------

IF OBJECT_ID('U_EMOOSVAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1381) NULL
);

-----------
-- Create table U_EMOOSVAEXP_PDedHist
-----------

IF OBJECT_ID('U_EMOOSVAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_PDedHist] (
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
-- Create table U_EMOOSVAEXP_PEarHist
-----------

IF OBJECT_ID('U_EMOOSVAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOOSVAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 08/27/2021
Service Request Number: TekP-2021-07-04-0004

Purpose: MoO STD VolL ADD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMOOSVAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMOOSVAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'SCH_EMOOSV';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMOOSVAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMOOSVAEXP', @AllObjects = 'Y', @IsWeb = 'Y'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMOOSVAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMOOSVAEXP';

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
    /*DELETE FROM dbo.U_EMOOSVAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMOOSVAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);*/

    DELETE FROM dbo.U_EMOOSVAEXP_EEList WHERE xEEID IN (
        SELECT EepEEID FROM dbo.EmpPers WHERE LEFT(EepSSN, 3) = '999'
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'VLIFE,VLFES,VLFEF,VLFEC,STD';

    IF OBJECT_ID('U_EMOOSVAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMOOSVAEXP_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMOOSVAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_PDedHist;
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
    INTO dbo.U_EMOOSVAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMOOSVAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMOOSVAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_PEarHist;
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
    INTO dbo.U_EMOOSVAEXP_PEarHist
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
    -- DETAIL RECORD - U_EMOOSVAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMOOSVAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvRelationshipCode = CASE WHEN ConRelationship IN ('SPS','SPX','DMP','DP') AND ConGender = 'F' THEN 'W'
                                    WHEN ConRelationship IN ('SPS','SPX','DMP','DP') AND ConGender = 'M' THEN 'H'
                                    WHEN ConRelationship IN ('SPS','SPX','DMP','DP') AND ConGender NOT IN ('M','F') THEN 'H'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'F' THEN 'D'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'M' THEN 'S'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender NOT IN  ('M','F') THEN 'S'
                                    ELSE 'M'
                                END
        ,drvEmployeeID = EepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                        ELSE 
                            CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                        END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmployeeEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END
        ,drvBillGroupEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END
        ,drvBasicSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate(xEEID, xCOID, eecDateOfLastHire)
                                        --dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '4/1/2021', eecDateOfLastHire)
        ,drvBasicSalaryMode = CASE WHEN EecSalaryOrHourly = 'S' THEN 'A' ELSE 'H' END
        ,drvBasicSalaryAmount =    CASE WHEN EecSalaryOrHourly = 'S' THEN FORMAT(EecAnnSalary*100, REPLICATE('0',16))
                                    ELSE FORMAT(EecHourlyPayRate*100, REPLICATE('0',16))
                                END
        ,drvClassEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END


        ,drvTermEEProductCategory = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '3' END
        ,drvTermEEEffectiveDate =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN
                                        CASE WHEN VLIFE_DedCode IS NOT NULL AND VLIFE_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStopDate, '4/1/2021') 
                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') 
                                        END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEF_DedCode IS NOT NULL AND VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') 
                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') 
                                        END                                        
                                    END
        ,drvTermEEEligibilityEvent =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLIFE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermEEPlanID = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'ETL0CEEVAL' END
        ,drvTermEEFamCoverageInd = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvTermEEApprovedAmtEffDate =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') 
                                            WHEN VLFEF_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') 
                                        END
        ,drvTermEEApprovedAmt =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN FORMAT(VLIFE_BenAmt, REPLICATE('0',10)) 
                                    WHEN VLFEF_DedCode IS NOT NULL THEN FORMAT(VLFEF_BenAmt, REPLICATE('0',10)) 
                                END



        ,drvTermSPSProductCategory = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '4' END
        ,drvTermSPSEffectiveDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvTermSPSEligibilityEvent =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermSPSPlanID = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'ETL0CSPVAL' END
        ,drvTermSPSFamCoverageInd = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvTermSPSApprovedAmtEffDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvTermSPSApprovedAmt =    CASE WHEN VLFES_DedCode IS NOT NULL THEN FORMAT(VLFES_BenAmt, REPLICATE('0',10))
                                        WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                    END


        ,drvTermDepProductCategory = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '5' END
        ,drvTermDepEffectiveDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvTermDepEligibilityEvent =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermDepPlanID = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'ETL0CDPVAL' END
        ,drvTermDepFamCoverageInd = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvTermDepApprovedAmtEffDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvTermDepApprovedAmt = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '0000010000' END
                                    /*CASE WHEN VLFEC_DedCode IS NOT NULL THEN FORMAT(VLFEC_BenAmt, REPLICATE('0',10))
                                        WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                    END*/


        ,drvAddEEProductCategory = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'c' END
        ,drvAddEEEffectiveDate =    CASE WHEN VLIFE_DedCode IS NOT NULL  THEN 
                                        CASE WHEN VLIFE_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL  THEN 
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddEEEligibilityEvent =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLIFE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    END
        ,drvAddEEPlanID = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'BTA0CEEVAL' END
        ,drvAddEEFamCoverageInd = CASE WHEN VLIFE_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvAddEEApprovedAmtEffDate =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') 
                                            WHEN VLFEF_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') 
                                        END
        ,drvAddEEApprovedAmt =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN FORMAT(VLIFE_BenAmt, REPLICATE('0',10)) 
                                    WHEN VLFEF_DedCode IS NOT NULL THEN FORMAT(VLFEF_BenAmt, REPLICATE('0',10)) 
                                END



        ,drvAddSPSProductCategory = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'e' END
        ,drvAddSPSEffectiveDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddSPSEligibilityEvent =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvAddSPSPlanID = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'BTA0CSPVAL' END
        ,drvAddSPSFamCoverageInd = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvAddSPSApprovedAmtEffDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvAddSPSApprovedAmt =    CASE WHEN VLFES_DedCode IS NOT NULL THEN FORMAT(VLFES_BenAmt, REPLICATE('0',10))
                                    WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                END


        ,drvAddDepProductCategory = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'd' END
        ,drvAddDepEffectiveDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddDepEligibilityEvent =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvAddDepPlanID = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'BTA0CDPVAL' END
        ,drvAddDepFamCoverageInd = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvAddDepApprovedAmtEffDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvAddDepApprovedAmt = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '0000010000' END
                                /*CASE WHEN VLFEC_DedCode IS NOT NULL THEN FORMAT(VLFEC_BenAmt, REPLICATE('0',10))
                                    WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                END*/


        ,drvVolSTDProductCategory = CASE WHEN STD_DedCode IS NOT NULL THEN 'Q' END
        ,drvVolSTDEffectiveDate = CASE WHEN STD_DedCode IS NOT NULL THEN 
                                        CASE WHEN STD_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, '4/1/2021') END
                                    END
        ,drvVolSTDEligibilityEvent =    CASE WHEN STD_DedCode IS NOT NULL THEN 
                                            CASE WHEN STD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvVolSTDPlanID = CASE WHEN STD_DedCode IS NOT NULL THEN 'YTS000CSAL' END
        ,drvVolSTDFamCoverageInd = CASE WHEN STD_DedCode IS NOT NULL THEN 'C' END

    INTO dbo.U_EMOOSVAEXP_drvTbl
    FROM dbo.U_EMOOSVAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmDedCode END) AS VLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStatus END) AS VLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStartDate END) AS VLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END) AS VLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN EedBenAmt END) AS VLIFE_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmDedCode END) AS VLFES_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStatus END) AS VLFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStartDate END) AS VLFES_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStopDate END) AS VLFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN EedBenAmt END) AS VLFES_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmDedCode END) AS VLFEF_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStatus END) AS VLFEF_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStartDate END) AS VLFEF_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStopDate END) AS VLFEF_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN EedBenAmt END) AS VLFEF_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmDedCode END) AS VLFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStatus END) AS VLFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStartDate END) AS VLFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStopDate END) AS VLFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN EedBenAmt END) AS VLFEC_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate

            FROM dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK)
            JOIN dbo.EmpDed WITH (NOLOCK)
                ON BdmEEID = EedEEID
                AND BdmDedCode = EedDedCode
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID ) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
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
ALTER VIEW dbo.dsi_vwEMOOSVAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMOOSVAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMOOSVAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108201'
       ,expStartPerControl     = '202108201'
       ,expLastEndPerControl   = '202108279'
       ,expEndPerControl       = '202108279'
WHERE expFormatCode = 'EMOOSVAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMOOSVAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMOOSVAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMOOSVAEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMOOSVAEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMOOSVAEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMOOSVAEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMOOSVAEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMOOSVAEXP', 'UseFileName', 'V', 'Y'


-- End ripout