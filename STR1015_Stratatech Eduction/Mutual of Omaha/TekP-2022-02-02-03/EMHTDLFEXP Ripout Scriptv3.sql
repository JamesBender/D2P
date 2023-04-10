/**********************************************************************************

EMHTDLFEXP: MoO S/LTD Basic/Vol Life Export

FormatCode:     EMHTDLFEXP
Project:        MoO S/LTD Basic/Vol Life Export
Client ID:      STR1015
Date/time:      2023-04-10 08:29:31.797
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPSTRA
Web Filename:   STR1015_6Z8OI_EEHISTORY_EMHTDLFEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMHTDLFEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMHTDLFEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMHTDLFEXP'


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
WHERE FormatCode = 'EMHTDLFEXP'
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
WHERE ExpFormatCode = 'EMHTDLFEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMHTDLFEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMHTDLFEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMHTDLFEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMHTDLFEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMHTDLFEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMHTDLFEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMHTDLFEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMHTDLFEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMHTDLFEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMHTDLFEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMHTDLFEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMHTDLFEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMHTDLFEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMHTDLFEXP];
GO
IF OBJECT_ID('U_EMHTDLFEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMHTDLFEXP_PDedHist];
GO
IF OBJECT_ID('U_EMHTDLFEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMHTDLFEXP_File];
GO
IF OBJECT_ID('U_EMHTDLFEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMHTDLFEXP_EEList];
GO
IF OBJECT_ID('U_EMHTDLFEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMHTDLFEXP_drvTbl];
GO
IF OBJECT_ID('U_EMHTDLFEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMHTDLFEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMHTDLFEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMHTDLFEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMHTDLFEXP','MoO S/LTD Basic/Vol Life Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMHTDLFEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMHTDLFEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL,'"drvTransDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMHTDLFEXPZ0','8','D','10','9',NULL,'Group ID',NULL,NULL,'"G000BYQK"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMHTDLFEXPZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMHTDLFEXPZ0','10','D','10','18',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMHTDLFEXPZ0','35','D','10','28',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMHTDLFEXPZ0','26','D','10','63',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMHTDLFEXPZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMHTDLFEXPZ0','8','D','10','90',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMHTDLFEXPZ0','211','D','10','98',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMHTDLFEXPZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateOfHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMHTDLFEXPZ0','8','D','10','317',NULL,'Employee Effective Date',NULL,NULL,'"drvEEEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMHTDLFEXPZ0','68','D','10','325',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMHTDLFEXPZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMHTDLFEXPZ0','4','D','10','401',NULL,'Bill Group ID',NULL,NULL,'"drvBillGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMHTDLFEXPZ0','70','D','10','405',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMHTDLFEXPZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMHTDLFEXPZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMHTDLFEXPZ0','16','D','10','484',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMHTDLFEXPZ0','108','D','10','500',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMHTDLFEXPZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMHTDLFEXPZ0','4','D','10','616',NULL,'Class ID',NULL,NULL,'"drvClassID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMHTDLFEXPZ0','190','D','10','620',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMHTDLFEXPZ0','1','D','10','810',NULL,'Product Category Basic Life',NULL,NULL,'"drvProductCategoryBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMHTDLFEXPZ0','8','D','10','811',NULL,'Effective Date Basic Life',NULL,NULL,'"drvEffectiveDateBasicLife"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMHTDLFEXPZ0','2','D','10','819',NULL,'Eligibility Event Basic Life',NULL,NULL,'"drvElligbilityEventBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMHTDLFEXPZ0','10','D','10','821',NULL,'Plan ID Basic Life',NULL,NULL,'"drvPlanIDBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMHTDLFEXPZ0','1','D','10','831',NULL,'Family Coverage Indicator Basic Life',NULL,NULL,'"drvFamilyCoverageIndBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMHTDLFEXPZ0','33','D','10','832',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMHTDLFEXPZ0','1','D','10','865',NULL,'Product Category Basic AD&D',NULL,NULL,'"drvProductCategoryBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMHTDLFEXPZ0','8','D','10','866',NULL,'Effective Date Basic AD&D',NULL,NULL,'"drvEffectiveDateBasicADD"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMHTDLFEXPZ0','2','D','10','874',NULL,'Eligibility Event Basic AD&D',NULL,NULL,'"drvElligbilityEventBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMHTDLFEXPZ0','10','D','10','876',NULL,'Plan ID Basic AD&D',NULL,NULL,'"drvPlanIDBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMHTDLFEXPZ0','1','D','10','886',NULL,'Family Coverage Indicator Basic AD&D',NULL,NULL,'"drvFamilyCoverageIndBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMHTDLFEXPZ0','33','D','10','887',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMHTDLFEXPZ0','1','D','10','920',NULL,'Product Category Basic STD',NULL,NULL,'"drvProductCategoryBasicSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMHTDLFEXPZ0','8','D','10','921',NULL,'Effective Date Basic STD',NULL,NULL,'"drvEffectiveDateBasicSTD"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMHTDLFEXPZ0','2','D','10','929',NULL,'Eligibility Event Basic STD',NULL,NULL,'"drvElligbilityEventBasicSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMHTDLFEXPZ0','10','D','10','931',NULL,'Plan ID Basic STD',NULL,NULL,'"drvPlanIDBasicSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMHTDLFEXPZ0','1','D','10','941',NULL,'Family Coverage Indicator Basic STD',NULL,NULL,'"drvFamilyCoverageIndBasicSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMHTDLFEXPZ0','33','D','10','942',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMHTDLFEXPZ0','1','D','10','975',NULL,'Product Category Basic LTD',NULL,NULL,'"drvProductCategoryBasicLTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMHTDLFEXPZ0','8','D','10','976',NULL,'Effective Date Basic LTD',NULL,NULL,'"drvEffectiveDateBasicLTD"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMHTDLFEXPZ0','2','D','10','984',NULL,'Eligibility Event Basic LTD',NULL,NULL,'"drvElligbilityEventBasicLTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMHTDLFEXPZ0','10','D','10','986',NULL,'Plan ID Basic LTD',NULL,NULL,'"drvPlanIDBasicLTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMHTDLFEXPZ0','1','D','10','996',NULL,'Family Coverage Indicator Basic LTD',NULL,NULL,'"drvFamilyCoverageIndBasicLTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMHTDLFEXPZ0','33','D','10','997',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMHTDLFEXPZ0','1','D','10','1030',NULL,'Product Category Vol Life EE',NULL,NULL,'"drvProductCategoryVolLifeEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMHTDLFEXPZ0','8','D','10','1031',NULL,'Effective Date Vol Life EE',NULL,NULL,'"drvEffectiveDateVolLifeEE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMHTDLFEXPZ0','2','D','10','1039',NULL,'Eligibility Event Vol Life EE',NULL,NULL,'"drvEligibilityEventVolLifeEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMHTDLFEXPZ0','10','D','10','1041',NULL,'Plan ID Vol Life EE',NULL,NULL,'"drvPlanIDVolLifeEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMHTDLFEXPZ0','5','D','10','1051',NULL,'Family Coverage Indicator Vol Life EE',NULL,NULL,'"drvFamilyCoverageIndVolLIfeEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMHTDLFEXPZ0','8','D','10','1056',NULL,'Approved Amount Effective Date Vol Life EE',NULL,NULL,'"drvApprovedAmtEffDteVolLIfeEE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMHTDLFEXPZ0','10','D','10','1064',NULL,'Approved Amount Vol Life EE',NULL,NULL,'"drvApprovedAmountVolLIfeEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMHTDLFEXPZ0','11','D','10','1065',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMHTDLFEXPZ0','1','D','10','1085',NULL,'Product Category Vol Life Spouse',NULL,NULL,'"drvProductCategoryVolLifeSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMHTDLFEXPZ0','8','D','10','1086',NULL,'Effective Date Vol Life Spouse',NULL,NULL,'"drvEffectiveDateVolLifeSps"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMHTDLFEXPZ0','2','D','10','1094',NULL,'Eligibility Event Vol Life Spouse',NULL,NULL,'"drvEligibilityEventVolLifeSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMHTDLFEXPZ0','10','D','10','1096',NULL,'Plan ID Vol Life Spouse',NULL,NULL,'"drvPlanIDVolLifeSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMHTDLFEXPZ0','5','D','10','1106',NULL,'Family Coverage Indicator Vol Life Spouse',NULL,NULL,'"drvFamCoverageIndVolLIfeSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMHTDLFEXPZ0','8','D','10','1111',NULL,'Approved Amount Effective Date Vol Life Spouse',NULL,NULL,'"drvApprovedAmtEffDteVolLfeSps"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMHTDLFEXPZ0','10','D','10','1119',NULL,'Approved Amount Vol Life Spouse',NULL,NULL,'"drvApprovedAmountVolLIfeSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMHTDLFEXPZ0','11','D','10','1129',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMHTDLFEXPZ0','1','D','10','1140',NULL,'Product Category Vol Life Dep',NULL,NULL,'"drvProductCategoryVolLifeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EMHTDLFEXPZ0','8','D','10','1141',NULL,'Effective Date Vol Life Dep',NULL,NULL,'"drvEffectiveDateVolLifeDep"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EMHTDLFEXPZ0','2','D','10','1149',NULL,'Eligibility Event Vol Life Dep',NULL,NULL,'"drvEligibilityEventVolLifeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EMHTDLFEXPZ0','10','D','10','1151',NULL,'Plan ID Vol Life Dep',NULL,NULL,'"drvPlanIDVolLifeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EMHTDLFEXPZ0','5','D','10','1161',NULL,'Family Coverage Indicator Vol Life Dep',NULL,NULL,'"drvFamCoverageIndVolLIfeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EMHTDLFEXPZ0','8','D','10','1166',NULL,'Approved Amount Effective Date Vol Life Dep',NULL,NULL,'"drvApprovedAmtEffDteVolLfeDep"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EMHTDLFEXPZ0','10','D','10','1174',NULL,'Approved Amount Vol Life Dep',NULL,NULL,'"drvApprovedAmountVolLIfeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EMHTDLFEXPZ0','11','D','10','1184',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EMHTDLFEXPZ0','1','D','10','1195',NULL,'Product Category Vol ADD EE',NULL,NULL,'"drvProductCategoryVolAddEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EMHTDLFEXPZ0','8','D','10','1196',NULL,'Effective Date Vol Life Vol ADD EE',NULL,NULL,'"drvEffectiveDateVolLifeAddEE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EMHTDLFEXPZ0','2','D','10','1204',NULL,'Eligibility Event Vol Life Vol ADD EE',NULL,NULL,'"drvEligibilityEvtVolLifeAddEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EMHTDLFEXPZ0','10','D','10','1206',NULL,'Plan ID Vol Life Vol ADD EE',NULL,NULL,'"drvPlanIDVolAddEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EMHTDLFEXPZ0','5','D','10','1216',NULL,'Family Coverage Indicator Vol Life Vol ADD EE',NULL,NULL,'"drvFamilyCoverageIndVolAddEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EMHTDLFEXPZ0','8','D','10','1221',NULL,'Approved Amount Effective Date Vol Life Vol ADD EE',NULL,NULL,'"drvApprovedAmtEffDteVolAddEE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EMHTDLFEXPZ0','10','D','10','1229',NULL,'Approved Amount Vol Life Vol ADD EE',NULL,NULL,'"drvApprovedAmountVolAddEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EMHTDLFEXPZ0','11','D','10','1239',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EMHTDLFEXPZ0','1','D','10','1250',NULL,'Product Category Vol ADD Spouse',NULL,NULL,'"drvProductCategoryVolAddSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EMHTDLFEXPZ0','8','D','10','1251',NULL,'Effective Date Vol Life Vol ADD Spouse',NULL,NULL,'"drvEffectiveDateVolLifeAddSps"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EMHTDLFEXPZ0','2','D','10','1259',NULL,'Eligibility Event Vol Life Vol ADD Spouse',NULL,NULL,'"drvEligibilityEvtVolLfeAddSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EMHTDLFEXPZ0','10','D','10','1261',NULL,'Plan ID Vol Life Vol ADD Spouse',NULL,NULL,'"drvPlanIDVolAddSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EMHTDLFEXPZ0','5','D','10','1271',NULL,'Family Coverage Indicator Vol Life Vol ADD Spouse',NULL,NULL,'"drvFamilyCoverageIndVolAddSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EMHTDLFEXPZ0','8','D','10','1276',NULL,'Approved Amount Effective Date Vol Life Vol ADD Sp',NULL,NULL,'"drvApprovedAmtEffDteVolAddSps"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EMHTDLFEXPZ0','10','D','10','1284',NULL,'Approved Amount Vol Life Vol ADD Spouse',NULL,NULL,'"drvApprovedAmountVolAddSps"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EMHTDLFEXPZ0','11','D','10','1294',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EMHTDLFEXPZ0','1','D','10','1305',NULL,'Product Category Vol ADD Dep',NULL,NULL,'"drvProductCategoryVolAddDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EMHTDLFEXPZ0','8','D','10','1306',NULL,'Effective Date Vol Life Vol ADD Dep',NULL,NULL,'"drvEffectiveDateVolLifeAddDep"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EMHTDLFEXPZ0','2','D','10','1314',NULL,'Eligibility Event Vol Life Vol ADD Dep',NULL,NULL,'"drvEligibilityEvtVolLfeAddDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EMHTDLFEXPZ0','10','D','10','1316',NULL,'Plan ID Vol Life Vol ADD Dep',NULL,NULL,'"drvPlanIDVolAddDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EMHTDLFEXPZ0','5','D','10','1326',NULL,'Family Coverage Indicator Vol Life Vol ADD Dep',NULL,NULL,'"drvFamilyCoverageIndVolAddDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EMHTDLFEXPZ0','8','D','10','1331',NULL,'Approved Amount Effective Date Vol Life Vol ADD De',NULL,NULL,'"drvApprovedAmtEffDteVolAddDep"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EMHTDLFEXPZ0','10','D','10','1339',NULL,'Approved Amount Vol Life Vol ADD Dep',NULL,NULL,'"drvApprovedAmountVolAddDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EMHTDLFEXPZ0','286','D','10','1349',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EMHTDLFEXPZ0','1','D','10','1360',NULL,'Product Category Voluntary STD',NULL,NULL,'"drvProductCategoryVolSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EMHTDLFEXPZ0','8','D','10','1361',NULL,'Effective Date Voluntary STD',NULL,NULL,'"drvEffectiveDateVolSTD"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EMHTDLFEXPZ0','2','D','10','1369',NULL,'Eligibility Event Voluntary STD',NULL,NULL,'"drvElligbilityEventVolSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EMHTDLFEXPZ0','10','D','10','1371',NULL,'Plan ID Voluntary STD',NULL,NULL,'"drvPlanIDVolSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EMHTDLFEXPZ0','1','D','10','1372',NULL,'Family Coverage Indicator Voluntary STD',NULL,NULL,'"drvFamilyCoverageIndVolSTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EMHTDLFEXPZ0','33','D','10','1373',NULL,'Filler',NULL,NULL,'" "','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EMHTDLFEXPZ0','1','D','10','1636',NULL,'Product Category Basic Dep Life',NULL,NULL,'"drvProductCategoryBasicDepLfe"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EMHTDLFEXPZ0','8','D','10','1637',NULL,'Effective Date Basic Dep Life',NULL,NULL,'"drvEffectiveDateBasicDepLife"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EMHTDLFEXPZ0','2','D','10','1644',NULL,'Eligibility Event Basic Dep Life',NULL,NULL,'"drvElligbilityEvtBasicDepLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EMHTDLFEXPZ0','10','D','10','1646',NULL,'Plan ID Basic Dep Life',NULL,NULL,'"drvPlanIDBasicDepLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EMHTDLFEXPZ0','1','D','10','1656',NULL,'Family Coverage Indicator Basic Dep Life',NULL,NULL,'"drvFamilyCoveIndBasicDepLife"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMHTDLFEXP_20230410.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202207149','EMPEXPORT','OEACTIVE','Jul 19 2022  8:47AM','EMHTDLFEXP',NULL,NULL,NULL,'202207149','Jul 14 2022 11:39AM','Jul 14 2022 11:39AM','202207141','13','','','202207141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202207149','EMPEXPORT','OEPASSIVE','Jul 19 2022  8:47AM','EMHTDLFEXP',NULL,NULL,NULL,'202207149','Jul 14 2022 11:39AM','Jul 14 2022 11:39AM','202207141','572','','','202207141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'MoO S/LTD B/V Life Export','202207149','EMPEXPORT','ONDEM_XOE','Jul 19 2022  8:47AM','EMHTDLFEXP',NULL,NULL,NULL,'202207149','Jul 14 2022 11:39AM','Jul 14 2022 11:39AM','202207141','569','','','202207141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'MoO S/LTD B/V Life Expor-Sched','202207149','EMPEXPORT','SCH_EMHTDL','Jul 19 2022  8:48AM','EMHTDLFEXP',NULL,NULL,NULL,'202207149','Jul 14 2022 11:39AM','Jul 14 2022 11:39AM','202207141','569','','','202207141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','4I21S,4HYM8,FETK8,4I1Q0,4HYZM,4HX8S',NULL,NULL,NULL,'MoO S/LTD B/V Life Expor-Test','202304079','EMPEXPORT','TEST_XOE','Apr  7 2023 12:00AM','EMHTDLFEXP',NULL,NULL,NULL,'202304079','Apr  7 2023 12:00AM','Dec 30 1899 12:00AM','202303241','569','','','202303241',dbo.fn_GetTimedKey(),NULL,'us3kEpSTR1015',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMHTDLFEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMHTDLFEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMHTDLFEXP','D10','dbo.U_EMHTDLFEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMHTDLFEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EMHTDLFEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMHTDLFEXP] (
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
-- Create table U_EMHTDLFEXP_DedList
-----------

IF OBJECT_ID('U_EMHTDLFEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMHTDLFEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMHTDLFEXP_drvTbl
-----------

IF OBJECT_ID('U_EMHTDLFEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMHTDLFEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvTransDate] datetime NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvEEEffectiveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBillGroupID] varchar(4) NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryAmount] nvarchar(4000) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvClassID] varchar(4) NULL,
    [drvProductCategoryBasicLife] varchar(1) NULL,
    [drvEffectiveDateBasicLife] datetime NULL,
    [drvElligbilityEventBasicLife] varchar(2) NULL,
    [drvPlanIDBasicLife] varchar(10) NULL,
    [drvFamilyCoverageIndBasicLife] varchar(1) NULL,
    [drvProductCategoryBasicADD] varchar(1) NULL,
    [drvEffectiveDateBasicADD] datetime NULL,
    [drvElligbilityEventBasicADD] varchar(2) NULL,
    [drvPlanIDBasicADD] varchar(10) NULL,
    [drvFamilyCoverageIndBasicADD] varchar(1) NULL,
    [drvProductCategoryBasicSTD] varchar(1) NULL,
    [drvEffectiveDateBasicSTD] datetime NULL,
    [drvElligbilityEventBasicSTD] varchar(2) NULL,
    [drvPlanIDBasicSTD] varchar(10) NULL,
    [drvFamilyCoverageIndBasicSTD] varchar(1) NULL,
    [drvProductCategoryBasicLTD] varchar(1) NULL,
    [drvEffectiveDateBasicLTD] datetime NULL,
    [drvElligbilityEventBasicLTD] varchar(2) NULL,
    [drvPlanIDBasicLTD] varchar(10) NULL,
    [drvFamilyCoverageIndBasicLTD] varchar(1) NULL,
    [drvProductCategoryVolLifeEE] varchar(1) NULL,
    [drvEffectiveDateVolLifeEE] datetime NULL,
    [drvEligibilityEventVolLifeEE] varchar(2) NULL,
    [drvPlanIDVolLifeEE] varchar(10) NULL,
    [drvFamilyCoverageIndVolLIfeEE] varchar(1) NULL,
    [drvApprovedAmtEffDteVolLIfeEE] datetime NULL,
    [drvApprovedAmountVolLIfeEE] nvarchar(4000) NULL,
    [drvProductCategoryVolLifeSps] varchar(1) NULL,
    [drvEffectiveDateVolLifeSps] datetime NULL,
    [drvEligibilityEventVolLifeSps] varchar(2) NULL,
    [drvPlanIDVolLifeSps] varchar(10) NULL,
    [drvFamCoverageIndVolLIfeSps] varchar(1) NULL,
    [drvApprovedAmtEffDteVolLfeSps] datetime NULL,
    [drvApprovedAmountVolLIfeSps] nvarchar(4000) NULL,
    [drvProductCategoryVolLifeDep] varchar(1) NULL,
    [drvEffectiveDateVolLifeDep] datetime NULL,
    [drvEligibilityEventVolLifeDep] varchar(2) NULL,
    [drvPlanIDVolLifeDep] varchar(10) NULL,
    [drvFamCoverageIndVolLIfeDep] varchar(1) NULL,
    [drvApprovedAmtEffDteVolLfeDep] datetime NULL,
    [drvApprovedAmountVolLIfeDep] nvarchar(4000) NULL,
    [drvProductCategoryVolAddEE] varchar(1) NULL,
    [drvEffectiveDateVolLifeAddEE] datetime NULL,
    [drvEligibilityEvtVolLifeAddEE] varchar(2) NULL,
    [drvPlanIDVolAddEE] varchar(10) NULL,
    [drvFamilyCoverageIndVolAddEE] varchar(1) NULL,
    [drvApprovedAmtEffDteVolAddEE] datetime NULL,
    [drvApprovedAmountVolAddEE] nvarchar(4000) NULL,
    [drvProductCategoryVolAddSps] varchar(1) NULL,
    [drvEffectiveDateVolLifeAddSps] datetime NULL,
    [drvEligibilityEvtVolLfeAddSps] varchar(2) NULL,
    [drvPlanIDVolAddSps] varchar(10) NULL,
    [drvFamilyCoverageIndVolAddSps] varchar(1) NULL,
    [drvApprovedAmtEffDteVolAddSps] datetime NULL,
    [drvApprovedAmountVolAddSps] nvarchar(4000) NULL,
    [drvProductCategoryVolAddDep] varchar(1) NULL,
    [drvEffectiveDateVolLifeAddDep] datetime NULL,
    [drvEligibilityEvtVolLfeAddDep] varchar(2) NULL,
    [drvPlanIDVolAddDep] varchar(10) NULL,
    [drvFamilyCoverageIndVolAddDep] varchar(1) NULL,
    [drvApprovedAmtEffDteVolAddDep] datetime NULL,
    [drvApprovedAmountVolAddDep] nvarchar(4000) NULL,
    [drvProductCategoryVolSTD] varchar(1) NULL,
    [drvEffectiveDateVolSTD] datetime NULL,
    [drvElligbilityEventVolSTD] varchar(2) NULL,
    [drvPlanIDVolSTD] varchar(10) NULL,
    [drvFamilyCoverageIndVolSTD] varchar(1) NULL,
    [drvProductCategoryBasicDepLfe] varchar(1) NULL,
    [drvEffectiveDateBasicDepLife] datetime NULL,
    [drvElligbilityEvtBasicDepLife] varchar(2) NULL,
    [drvPlanIDBasicDepLife] varchar(10) NULL,
    [drvFamilyCoveIndBasicDepLife] varchar(1) NULL
);

-----------
-- Create table U_EMHTDLFEXP_EEList
-----------

IF OBJECT_ID('U_EMHTDLFEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMHTDLFEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMHTDLFEXP_File
-----------

IF OBJECT_ID('U_EMHTDLFEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMHTDLFEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);

-----------
-- Create table U_EMHTDLFEXP_PDedHist
-----------

IF OBJECT_ID('U_EMHTDLFEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMHTDLFEXP_PDedHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMHTDLFEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Stratatech Eduction

Created By: James Bender
Business Analyst: Jule Reardon
Create Date: 07/14/2022
Service Request Number: TekP-2022-02-02-03

Purpose: MoO S/LTD Basic/Vol Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters       02/02023     TekP-2022-02-02-03   Updated Code for LIFES , LIFEC ,GLIFC. Fixed format was missing starting positions and creating a T at the end of some rows.
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMHTDLFEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMHTDLFEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMHTDLFEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMHTDLFEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMHTDLFEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMHTDLFEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMHTDLFEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMHTDLFEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMHTDLFEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMHTDLFEXP', 'SCH_EMHTDL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMHTDLFEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMHTDLFEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMHTDLFEXP';

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
    DELETE FROM dbo.U_EMHTDLFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMHTDLFEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADD,GLIFE,GLFEX,GLIFS,GLIFC,LIFEC,LIFEE,LIFES,LTD,STD,VSTD';     --Added new Voluntary STD to file feed (VSTD)

    IF OBJECT_ID('U_EMHTDLFEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMHTDLFEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMHTDLFEXP_DedList
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
    IF OBJECT_ID('U_EMHTDLFEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMHTDLFEXP_PDedHist;
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
    INTO dbo.U_EMHTDLFEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMHTDLFEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMHTDLFEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMHTDLFEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMHTDLFEXP_drvTbl;
        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' -- CAST(LIFEE_AMT AS VARCHAR(10))
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvRelationshipCode =    CASE WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'F' THEN 'W'
                                WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'M' THEN 'H'
                                WHEN ConRelationship IN ('CHL','DPC','GRC','STC') AND ConGender = 'F' AND ConIsDisabled = 'N' THEN 'D' --'CHL','DPC','STC'
                                WHEN ConRelationship IN ('CHL','DPC','GRC','STC') AND ConGender = 'M' AND ConIsDisabled = 'N' THEN 'S' --'CHL','DPC','STC'
                                WHEN ConRelationship IN ('CHL','DPC','GRC','STC') AND ConGender = 'F' AND ConIsDisabled = 'Y' THEN 'I' --'CHL','DPC','STC'
                                WHEN ConRelationship IN ('CHL','DPC','GRC','STC') AND ConGender = 'M' AND ConIsDisabled = 'Y' THEN 'I' --'CHL','DPC','STC'
                                ELSE 'M'
                                END
        ,drvEmployeeID = eepssn  --EecEmpNo
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEEEffectiveDate = CASE WHEN EecDateOfOriginalHire > '11/1/2021' THEN EecDateOfLastHire ELSE '11/1/2021' END
        ,drvBillGroupEffectiveDate = CASE WHEN EecDateOfOriginalHire > '11/1/2021' THEN EecDateOfLastHire ELSE '11/1/2021' END
        ,drvBillGroupID =    CASE WHEN EecCOID = '4HX8S' THEN '0001'
                            WHEN EecCOID = '4I1Q0' THEN '0002'
                            WHEN EecCOID = '4HYZM' THEN '0003'
                            WHEN EecCOID = '4I21S' THEN '0004'
                            WHEN EecCOID = '4HYM8' THEN '0005'
                            WHEN EecCOID = 'FETK8' THEN '0006'
                            END
        ,drvBasicSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
        ,drvBasicSalaryAmount = FORMAT(EecAnnSalary * 100, '0000000000000000')
        ,drvClassEffectiveDate = CASE WHEN EecDateOfOriginalHire > '11/1/2021' THEN EecDateOfLastHire ELSE '11/1/2021' END
        ,drvClassID =    CASE WHEN GLFEX_DedCode IS NOT NULL THEN 'A001'
                        WHEN GLIFE_DedCode IS NOT NULL THEN 'A002'
                        END
        -- 810 Basic Life
        ,drvProductCategoryBasicLife = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLFEX_DedCode IS NOT NULL THEN '1' END
        ,drvEffectiveDateBasicLife =    CASE WHEN GLIFE_DedCode IS NOT NULL AND GLIFE_BenStatus = 'T' THEN GLIFE_BenStopDate
                                        WHEN GLIFE_DedCode IS NOT NULL AND GLIFE_BenStatus <> 'T' THEN GLIFE_BenStartDate
                                        WHEN GLFEX_DedCode IS NOT NULL AND GLFEX_BenStatus = 'T' THEN GLFEX_BenStopDate
                                        WHEN GLFEX_DedCode IS NOT NULL AND GLFEX_BenStatus <> 'T' THEN GLFEX_BenStartDate
                                        END
        ,drvElligbilityEventBasicLife =    CASE WHEN GLIFE_DedCode IS NOT NULL AND GLIFE_BenStatus = 'T' THEN 'TM'
                                        WHEN GLIFE_DedCode IS NOT NULL AND GLIFE_BenStatus <> 'T' THEN 'EN'
                                        WHEN GLFEX_DedCode IS NOT NULL AND GLFEX_BenStatus = 'T' THEN 'TM'
                                        WHEN GLFEX_DedCode IS NOT NULL AND GLFEX_BenStatus <> 'T' THEN 'EN'
                                        END
        ,drvPlanIDBasicLife = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLFEX_DedCode IS NOT NULL THEN 'LTL00NCSAL' END
        ,drvFamilyCoverageIndBasicLife = CASE WHEN GLIFE_DedCode IS NOT NULL OR GLFEX_DedCode IS NOT NULL THEN 'C' END

        -- 865 Basi AD&D
        ,drvProductCategoryBasicADD = CASE WHEN ADD_DedCode IS NOT NULL THEN 'a' END
        ,drvEffectiveDateBasicADD =    CASE WHEN ADD_DedCode IS NOT NULL AND ADD_BenStatus = 'T' THEN ADD_BenStopDate
                                            WHEN ADD_DedCode IS NOT NULL AND ADD_BenStatus <> 'T' THEN ADD_BenStartDate
                                          END
        ,drvElligbilityEventBasicADD =    CASE WHEN ADD_DedCode IS NOT NULL AND ADD_BenStatus = 'T' THEN 'TM'
                                               WHEN ADD_DedCode IS NOT NULL AND ADD_BenStatus <> 'T' THEN 'EN'
                                            END
        ,drvPlanIDBasicADD = CASE WHEN ADD_DedCode IS NOT NULL THEN 'ATA00NCSAL' END
        ,drvFamilyCoverageIndBasicADD = CASE WHEN ADD_DedCode IS NOT NULL THEN 'C' END

        -- 920 Basic STD
        ,drvProductCategoryBasicSTD = CASE WHEN STD_DedCode IS NOT NULL THEN 'S' END
        ,drvEffectiveDateBasicSTD = CASE WHEN STD_DedCode IS NOT NULL AND STD_BenStatus = 'T' THEN STD_BenStopDate
                                         WHEN STD_DedCode IS NOT NULL AND STD_BenStatus <> 'T' THEN STD_BenStartDate
                                     END
        ,drvElligbilityEventBasicSTD =    CASE WHEN STD_DedCode IS NOT NULL AND STD_BenStatus = 'T' THEN 'TM'
                                                WHEN STD_DedCode IS NOT NULL AND STD_BenStatus <> 'T' THEN 'EN'
                                            END
        ,drvPlanIDBasicSTD = CASE WHEN STD_DedCode IS NOT NULL THEN 'STS00NCSAL' END
        ,drvFamilyCoverageIndBasicSTD = CASE WHEN STD_DedCode IS NOT NULL THEN 'C' END

        -- 975 Basic LTD
        ,drvProductCategoryBasicLTD = CASE WHEN LTD_DedCode IS NOT NULL THEN 'T' END
        ,drvEffectiveDateBasicLTD = CASE WHEN LTD_DedCode IS NOT NULL AND LTD_BenStatus = 'T' THEN LTD_BenStopDate
                                         WHEN LTD_DedCode IS NOT NULL AND LTD_BenStatus <> 'T' THEN LTD_BenStartDate
                                    END
        ,drvElligbilityEventBasicLTD =    CASE WHEN LTD_DedCode IS NOT NULL AND LTD_BenStatus = 'T' THEN 'TM'
                                               WHEN LTD_DedCode IS NOT NULL AND LTD_BenStatus <> 'T' THEN 'EN'
                                        END
        ,drvPlanIDBasicLTD = CASE WHEN LTD_DedCode IS NOT NULL THEN 'TTT00NCSAL' END
        ,drvFamilyCoverageIndBasicLTD = CASE WHEN LTD_DedCode IS NOT NULL THEN 'C' END
        
          -- 1030 Voluntary Term Life Coverage Employee
        ,drvProductCategoryVolLifeEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null  THEN '3' END
        ,drvEffectiveDateVolLifeEE =    CASE WHEN LIFEE_DedCode IS NOT NULL AND LIFEE_BenStatus = 'T' and LIFEE_AMT is not null  THEN LIFEE_BenStopDate
                                             WHEN LIFEE_DedCode IS NOT NULL AND LIFEE_BenStatus <> 'T' and LIFEE_AMT is not null  THEN LIFEE_BenStartDate
                                        END
        ,drvEligibilityEventVolLifeEE =    CASE WHEN LIFEE_DedCode IS NOT NULL AND LIFEE_BenStatus = 'T' and LIFEE_AMT is not null  THEN 'TM'
                                                WHEN LIFEE_DedCode IS NOT NULL AND LIFEE_BenStatus <> 'T' and LIFEE_AMT is not null  THEN 'EN'
                                          END
        ,drvPlanIDVolLifeEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null  THEN 'ETL0CEEVAL' END
        ,drvFamilyCoverageIndVolLIfeEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null  THEN 'C' END
        ,drvApprovedAmtEffDteVolLIfeEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null  THEN LIFEE_BenStartDate END
        ,drvApprovedAmountVolLIfeEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null  THEN FORMAT(LIFEE_AMT, '0000000000') END
        
        -- 1085 - Voluntary Term LifeCoverage Spouse
        ,drvProductCategoryVolLifeSps = CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP')  and LIFES_AMT is not null THEN '4' END
        ,drvEffectiveDateVolLifeSps =    CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null AND LIFES_BenStatus = 'T'   THEN LIFES_BenStopDate
                                        WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') AND LIFES_AMT is not null and  LIFES_BenStatus <> 'T' THEN LIFES_BenStartDate
                                        END
        ,drvEligibilityEventVolLifeSps =    CASE WHEN LIFES_DedCode IS NOT NULL AND LIFES_BenStatus = 'T' AND ConRelationship IN ('SPS' ,'DP') THEN 'TM'
                                                 WHEN LIFES_DedCode IS NOT NULL AND LIFES_BenStatus <> 'T' AND ConRelationship IN ('SPS' ,'DP') THEN 'EN'
                                            END
        ,drvPlanIDVolLifeSps = CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'ETL0CSPVAL' END
        ,drvFamCoverageIndVolLIfeSps = CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP')  and LIFES_AMT is not null THEN 'C' END
        ,drvApprovedAmtEffDteVolLfeSps = CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP')  and LIFES_AMT is not null THEN LIFES_BenStartDate END
        ,drvApprovedAmountVolLIfeSps = CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP')  and LIFES_AMT is not null THEN FORMAT(LIFES_AMT, '0000000000') END
        
        -- 1140 - Voluntary Term Life Coverage Dependent
        ,drvProductCategoryVolLifeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN '5' END
        ,drvEffectiveDateVolLifeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus = 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStopDate
                                           WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus <> 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStartDate
                                        END
        ,drvEligibilityEventVolLifeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus = 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'TM'
                                              WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus <> 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'EN'
                                             END
        ,drvPlanIDVolLifeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'ETL0CDPVAL' END
        ,drvFamCoverageIndVolLIfeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'C' END
        ,drvApprovedAmtEffDteVolLfeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStartDate END
        ,drvApprovedAmountVolLIfeDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN FORMAT(LIFEC_AMT, '0000000000') END

         -- 1195 Voluntary AD&D Coverage Employee
        ,drvProductCategoryVolAddEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null THEN 'c' END
        ,drvEffectiveDateVolLifeAddEE =  CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null AND LIFEE_BenStatus = 'T' THEN LIFEE_BenStopDate
                                              WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null AND LIFEE_BenStatus <> 'T' THEN LIFEE_BenStartDate
                                           END
        ,drvEligibilityEvtVolLifeAddEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null AND LIFEE_BenStatus = 'T' THEN 'TM'
                                              WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null AND LIFEE_BenStatus <> 'T' THEN 'EN'
                                            END
        ,drvPlanIDVolAddEE =            CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null THEN 'BTA0CEEVAL' END 
        ,drvFamilyCoverageIndVolAddEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null THEN 'C' END
        ,drvApprovedAmtEffDteVolAddEE = CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null THEN LIFEE_BenStartDate END
        ,drvApprovedAmountVolAddEE =    CASE WHEN LIFEE_DedCode IS NOT NULL and LIFEE_AMT is not null THEN FORMAT(LIFEE_AMT, '0000000000') END

        -- 1250 Voluntary AD&D Coverage Spouse
        ,drvProductCategoryVolAddSps =     CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'e' END
        ,drvEffectiveDateVolLifeAddSps =   CASE WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null AND LIFES_BenStatus  = 'T' THEN LIFES_BenStopDate
                                                WHEN LIFES_DedCode IS NOT NULL AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null AND LIFES_BenStatus <> 'T'  THEN LIFES_BenStartDate
                                           END
        ,drvEligibilityEvtVolLfeAddSps = CASE WHEN LIFES_DedCode IS NOT NULL AND LIFES_BenStatus = 'T'  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'TM'
                                              WHEN LIFES_DedCode IS NOT NULL AND LIFES_BenStatus <> 'T'  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'EN'
                                            END
        ,drvPlanIDVolAddSps =            CASE WHEN LIFES_DedCode IS NOT NULL  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'BTA0CSPVAL' END
        ,drvFamilyCoverageIndVolAddSps = CASE WHEN LIFES_DedCode IS NOT NULL  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN 'C' END
        ,drvApprovedAmtEffDteVolAddSps = CASE WHEN LIFES_DedCode IS NOT NULL  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null  THEN LIFES_BenStartDate END
        ,drvApprovedAmountVolAddSps = CASE WHEN LIFES_DedCode IS NOT NULL  AND ConRelationship IN ('SPS' ,'DP') and LIFES_AMT is not null THEN FORMAT(LIFES_AMT, '0000000000') END

        -- 1305 Voluntary AD&D Coverage Dependent
        ,drvProductCategoryVolAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL  AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null THEN 'd' END
        ,drvEffectiveDateVolLifeAddDep =  CASE WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus = 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStopDate
                                               WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus <> 'T'AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStartDate
                                            END
        ,drvEligibilityEvtVolLfeAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus = 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC')and LIFEC_AMT is not null   THEN 'TM'
                                              WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_BenStatus <> 'T' AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'EN'
                                            END
        ,drvPlanIDVolAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'BTA0CDPVAL' END
        ,drvFamilyCoverageIndVolAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN 'C' END
        ,drvApprovedAmtEffDteVolAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN LIFEC_BenStartDate END
        ,drvApprovedAmountVolAddDep = CASE WHEN LIFEC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') and LIFEC_AMT is not null  THEN FORMAT(LIFEC_AMT, '0000000000') END

         -- 1360 - Voluntary STD
        ,drvProductCategoryVolSTD = CASE WHEN VSTD_DedCode IS NOT NULL  THEN 'Q' END                                    --Added new Voluntary STD to file feed (VSTD)
        ,drvEffectiveDateVolSTD = CASE WHEN VSTD_DedCode IS NOT NULL AND VSTD_BenStatus = 'T' THEN VSTD_BenStopDate
                                         WHEN VSTD_DedCode IS NOT NULL AND VSTD_BenStatus <> 'T' THEN VSTD_BenStartDate
                                     END
        ,drvElligbilityEventVolSTD =    CASE WHEN VSTD_DedCode IS NOT NULL AND VSTD_BenStatus = 'T' THEN 'TM'
                                                WHEN VSTD_DedCode IS NOT NULL AND VSTD_BenStatus <> 'T' THEN 'EN'
                                            END
        ,drvPlanIDVolSTD = CASE WHEN VSTD_DedCode IS NOT NULL THEN 'YTS000CSAL' END
        ,drvFamilyCoverageIndVolSTD = CASE WHEN VSTD_DedCode IS NOT NULL THEN 'C' END


        -- 1635 - Basic Dependent Life
        
        ,drvProductCategoryBasicDepLfe = CASE WHEN   (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC')) or ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP')) THEN '6' END
        ,drvEffectiveDateBasicDepLife = CASE WHEN   (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') AND GLIFC_BenStatus = 'T' ) THEN GLIFC_BenStopDate
                                             WHEN ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP') AND GLIFS_BenStatus = 'T') THEN GLIFS_BenStopDate
                                             WHEN (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') AND GLIFC_BenStatus <> 'T')  THEN GLIFC_BenStartDate
                                             WHEN  ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP') and GLIFS_BenStatus <> 'T') THEN GLIFS_BenStartDate
                                        END
        ,drvElligbilityEvtBasicDepLife = CASE WHEN  (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') AND GLIFC_BenStatus = 'T' ) or ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP') AND GLIFS_BenStatus = 'T') THEN 'TM'
                                        WHEN  (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC') AND GLIFC_BenStatus <> 'T') or ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP')and GLIFS_BenStatus <> 'T') THEN 'EN'
                                        END
        ,drvPlanIDBasicDepLife = CASE WHEN    (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC')) or ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP'))  THEN 'LTL00NCDEP' END
        ,drvFamilyCoveIndBasicDepLife = CASE WHEN   (GLIFC_DedCode IS NOT NULL AND ConRelationship IN ('CHL','DPC','GRC','STC')) or ( GLIFS_DedCode IS NOT NULL  AND ConRelationship IN ('SPS', 'DP')) THEN 'C' END

   INTO dbo.U_EMHTDLFEXP_drvTbl
    FROM dbo.U_EMHTDLFEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EMHTDLFEXP WITH (NOLOCK)
    JOIN (
            SELECT BdmRecType, BdmCOID, BdmEEID, BdmDepRecID
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmDedCode END) AS ADD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLFEX' THEN BdmDedCode END) AS GLFEX_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLIFS' THEN BdmDedCode END) AS GLIFS_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLIFC' THEN BdmDedCode END) AS GLIFC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VSTD' THEN BdmDedCode END) AS VSTD_DedCode                        --Added new Voluntary STD to file feed (VSTD)
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStatus END) AS GLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmBenStatus END) AS ADD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLFEX' THEN BdmBenStatus END) AS GLFEX_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLIFS' THEN BdmBenStatus END) AS GLIFS_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLIFC' THEN BdmBenStatus END) AS GLIFC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStatus END) AS LIFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStatus END) AS LIFEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStatus END) AS LIFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStatus END) AS LTD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VSTD' THEN BdmBenStatus END) AS VSTD_BenStatus                    --Added new Voluntary STD to file feed (VSTD)
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmBenStartDate END) AS ADD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLFEX' THEN BdmBenStartDate END) AS GLFEX_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFS' THEN BdmBenStartDate END) AS GLIFS_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFC' THEN BdmBenStartDate END) AS GLIFC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VSTD' THEN BdmBenStartDate END) AS VSTD_BenStartDate            --Added new Voluntary STD to file feed (VSTD)
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmStopDate END) AS GLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmStopDate END) AS ADD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLFEX' THEN BdmbenStopDate END) AS GLFEX_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFS' THEN BdmbenStopDate END) AS GLIFS_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFC' THEN BdmBenStopDate END) AS GLIFC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmbenStopDate END) AS LIFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmbenStopDate END) AS LIFEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmStopDate END) AS LTD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmStopDate END) AS STD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VSTD' THEN BdmStopDate END) AS VSTD_BenStopDate                --Added new Voluntary STD to file feed (VSTD)
            FROM dbo.U_dsi_BDM_EMHTDLFEXP WITH (NOLOCK)

            GROUP BY BdmRecType, BdmCOID, BdmEEID, BdmDepRecID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EedEEID, EedCOID
                    ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedBenAmt  END) AS LIFEE_AMT
                    ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedBenAmt  END) AS LIFES_AMT
                    ,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN EedBenAmt  END) AS LIFEC_AMT
                FROM dbo.EmpDed WITH (NOLOCK)
                Where EedBenAmt > 0
                GROUP BY EedEEID, EedCOID) AS Amounts
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON xEEID = ConEEID
        AND BdmDepRecId = ConSystemId
        WHERE EecfullTimeOrPartTime = 'F' 
        AND EecEEType = 'REG'

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
ALTER VIEW dbo.dsi_vwEMHTDLFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMHTDLFEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMHTDLFEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202207071'
       ,expStartPerControl     = '202207071'
       ,expLastEndPerControl   = '202207149'
       ,expEndPerControl       = '202207149'
WHERE expFormatCode = 'EMHTDLFEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMHTDLFEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMHTDLFEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMHTDLFEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMHTDLFEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMHTDLFEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMHTDLFEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMHTDLFEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMHTDLFEXP', 'UseFileName', 'V', 'Y'


-- End ripout