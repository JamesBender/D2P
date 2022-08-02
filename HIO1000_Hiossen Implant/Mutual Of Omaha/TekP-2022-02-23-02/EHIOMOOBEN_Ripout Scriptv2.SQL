/**********************************************************************************

EHIOMOOBEN: Mutual Of Omaha AD&D/Life/Vol Life/LTD/STD

FormatCode:     EHIOMOOBEN
Project:        Mutual Of Omaha AD&D/Life/Vol Life/LTD/STD
Client ID:      HIO1000
Date/time:      2022-08-01 16:34:21.213
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP5DB02
Database:       ULTIPRO_WPHIOSE
Web Filename:   HIO1000_N0854_EEHISTORY_EHIOMOOBEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHIOMOOBEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EHIOMOOBEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHIOMOOBEN'


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
WHERE FormatCode = 'EHIOMOOBEN'
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
WHERE ExpFormatCode = 'EHIOMOOBEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHIOMOOBEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHIOMOOBEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHIOMOOBEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHIOMOOBEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHIOMOOBEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHIOMOOBEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHIOMOOBEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHIOMOOBEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHIOMOOBEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHIOMOOBEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHIOMOOBEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHIOMOOBEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHIOMOOBEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHIOMOOBEN];
GO
IF OBJECT_ID('U_EHIOMOOBEN_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_PEarHist];
GO
IF OBJECT_ID('U_EHIOMOOBEN_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_PDedHist];
GO
IF OBJECT_ID('U_EHIOMOOBEN_File') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_File];
GO
IF OBJECT_ID('U_EHIOMOOBEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_EEList];
GO
IF OBJECT_ID('U_EHIOMOOBEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_drvTbl];
GO
IF OBJECT_ID('U_EHIOMOOBEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_DedList];
GO
IF OBJECT_ID('U_EHIOMOOBEN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_AuditFields];
GO
IF OBJECT_ID('U_EHIOMOOBEN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHIOMOOBEN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHIOMOOBEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHIOMOOBEN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EHIOMOOBEN','Mutual Of Omaha AD&D/Life/Vol Life/LTD/STD','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EHIOMOOBENZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHIOMOOBENZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL,'"drvTransDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHIOMOOBENZ0','8','D','10','9',NULL,'Group ID',NULL,NULL,'"G000C276"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHIOMOOBENZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHIOMOOBENZ0','9','D','10','18',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHIOMOOBENZ0','36','D','10','27',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHIOMOOBENZ0','26','D','10','63',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHIOMOOBENZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHIOMOOBENZ0','19','D','10','90',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHIOMOOBENZ0','40','D','10','109',NULL,'Address Line 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHIOMOOBENZ0','80','D','10','149',NULL,'Address Line 2',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHIOMOOBENZ0','19','D','10','229',NULL,'City',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHIOMOOBENZ0','2','D','10','248',NULL,'State',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHIOMOOBENZ0','59','D','10','250',NULL,'Zip Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHIOMOOBENZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateOfHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHIOMOOBENZ0','76','D','10','317',NULL,'Employee Effective Date',NULL,NULL,'"drvEmployeeEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHIOMOOBENZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHIOMOOBENZ0','74','D','10','401',NULL,'Bill Group ID',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHIOMOOBENZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHIOMOOBENZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHIOMOOBENZ0','124','D','10','484',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHIOMOOBENZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHIOMOOBENZ0','194','D','10','616',NULL,'Class ID',NULL,NULL,'"drvClassID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHIOMOOBENZ0','1','D','10','810',NULL,'Product Category',NULL,NULL,'"drvBLProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHIOMOOBENZ0','8','D','10','811',NULL,'Effective Date',NULL,NULL,'"drvBLEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHIOMOOBENZ0','2','D','10','819',NULL,'Eligibility Event',NULL,NULL,'"drvBLEligibiltyEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHIOMOOBENZ0','10','D','10','821',NULL,'Plan ID',NULL,NULL,'"drvBLPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHIOMOOBENZ0','34','D','10','831',NULL,'Family Coverage Indicator',NULL,NULL,'"drvBLFamilyCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHIOMOOBENZ0','1','D','10','865',NULL,'Product Category',NULL,NULL,'"drvBADDProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHIOMOOBENZ0','8','D','10','866',NULL,'Effective Date',NULL,NULL,'"drvBADDEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHIOMOOBENZ0','2','D','10','874',NULL,'Eligibility Event',NULL,NULL,'"drvBADDEligibiltyEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHIOMOOBENZ0','10','D','10','876',NULL,'Plan ID',NULL,NULL,'"drvBADDPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHIOMOOBENZ0','34','D','10','886',NULL,'Family Coverage Indicator',NULL,NULL,'"drvBADDFamilyCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHIOMOOBENZ0','1','D','10','920',NULL,'Product Category',NULL,NULL,'"drvBSTDProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHIOMOOBENZ0','8','D','10','921',NULL,'Effective Date',NULL,NULL,'"drvBSTDEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHIOMOOBENZ0','2','D','10','929',NULL,'Eligibility Event',NULL,NULL,'"drvBSTDEligibiltyEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHIOMOOBENZ0','10','D','10','931',NULL,'Plan ID',NULL,NULL,'"drvBSTDPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHIOMOOBENZ0','34','D','10','941',NULL,'Family Coverage Indicator',NULL,NULL,'"drvBSTDFamilyCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHIOMOOBENZ0','1','D','10','975',NULL,'Product Category',NULL,NULL,'"drvBLTDProductCategory"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHIOMOOBENZ0','8','D','10','976',NULL,'Effective Date',NULL,NULL,'"drvBLTDEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHIOMOOBENZ0','2','D','10','984',NULL,'Eligibility Event',NULL,NULL,'"drvBLTDEligibiltyEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHIOMOOBENZ0','10','D','10','986',NULL,'Plan ID',NULL,NULL,'"drvBLTDPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHIOMOOBENZ0','34','D','10','996',NULL,'Family Coverage Indicator',NULL,NULL,'"drvBLTDFamilyCoverageInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHIOMOOBENZ0','1','D','10','1030',NULL,'Product Category',NULL,NULL,'"drvVolTermLifeEmpProductCat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHIOMOOBENZ0','8','D','10','1031',NULL,'Effective Date',NULL,NULL,'"drvVolTermLifeEmpEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHIOMOOBENZ0','2','D','10','1039',NULL,'Eligibility Event',NULL,NULL,'"drvVolTermLifeEmpEligEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHIOMOOBENZ0','10','D','10','1041',NULL,'Plan ID',NULL,NULL,'"drvVolTermLifeEmpPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHIOMOOBENZ0','5','D','10','1051',NULL,'Family Coverage Indicator',NULL,NULL,'"drvVolTermLifeEmpFamilyCvgInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHIOMOOBENZ0','8','D','10','1056',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvVolTermLifeEmpAppAmtEffDte"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHIOMOOBENZ0','21','D','10','1064',NULL,'Approved Amount',NULL,NULL,'"drvVolTermLifeEmpApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHIOMOOBENZ0','1','D','10','1085',NULL,'Product Category',NULL,NULL,'"drvVolTermLifeSpsProductCat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EHIOMOOBENZ0','8','D','10','1086',NULL,'Effective Date',NULL,NULL,'"drvVolTermLifeSpsEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EHIOMOOBENZ0','2','D','10','1094',NULL,'Eligibility Event',NULL,NULL,'"drvVolTermLifeSpsEligEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EHIOMOOBENZ0','10','D','10','1096',NULL,'Plan ID',NULL,NULL,'"drvVolTermLifeSpsPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EHIOMOOBENZ0','5','D','10','1106',NULL,'Family Coverage Indicator',NULL,NULL,'"drvVolTermLifeSpsFamilyCvgInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EHIOMOOBENZ0','8','D','10','1111',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvVolTermLifeSpsAppAmtEffDte"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EHIOMOOBENZ0','21','D','10','1119',NULL,'Approved Amount',NULL,NULL,'"drvVolTermLifeSpsApprovedAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EHIOMOOBENZ0','1','D','10','1140',NULL,'Product Category',NULL,NULL,'"drvVolTermLifeDepProductCat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EHIOMOOBENZ0','8','D','10','1141',NULL,'Effective Date',NULL,NULL,'"drvVolTermLifeDepEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EHIOMOOBENZ0','2','D','10','1149',NULL,'Eligibility Event',NULL,NULL,'"drvVolTermLifeDepEligEvent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EHIOMOOBENZ0','10','D','10','1151',NULL,'Plan ID',NULL,NULL,'"drvVolTermLifeDepPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EHIOMOOBENZ0','5','D','10','1161',NULL,'Family Coverage Indicator',NULL,NULL,'"drvVolTermLifeDepFamilyCvgInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EHIOMOOBENZ0','8','D','10','1166',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvVolTermLifeDepAppAmtEffDte"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EHIOMOOBENZ0','21','D','10','1174',NULL,'Approved Amount',NULL,NULL,'"drvVolTermLifeDepApprovedAmt"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHIOMOOBEN_20220801.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202207199','EMPEXPORT','OEACTIVE',NULL,'EHIOMOOBEN',NULL,NULL,NULL,'202207199','Jul 19 2022  5:01PM','Jul 19 2022  5:01PM','202207191',NULL,'','','202207191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202207199','EMPEXPORT','OEPASSIVE',NULL,'EHIOMOOBEN',NULL,NULL,NULL,'202207199','Jul 19 2022  5:01PM','Jul 19 2022  5:01PM','202207191',NULL,'','','202207191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual Of Omaha AD&D/Life/Vol','202207199','EMPEXPORT','ONDEM_XOE',NULL,'EHIOMOOBEN',NULL,NULL,NULL,'202207199','Jul 19 2022  5:01PM','Jul 19 2022  5:01PM','202207191',NULL,'','','202207191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual Of Omaha AD&D/Lif-Sched','202207199','EMPEXPORT','SCH_EHIOMO',NULL,'EHIOMOOBEN',NULL,NULL,NULL,'202207199','Jul 19 2022  5:01PM','Jul 19 2022  5:01PM','202207191',NULL,'','','202207191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Mutual Of Omaha AD&D/Lif-Test','202207199','EMPEXPORT','TEST_XOE',NULL,'EHIOMOOBEN',NULL,NULL,NULL,'202207199','Jul 19 2022  5:01PM','Jul 19 2022  5:01PM','202207191',NULL,'','','202207191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIOMOOBEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHIOMOOBEN','D10','dbo.U_EHIOMOOBEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHIOMOOBEN
-----------

IF OBJECT_ID('U_dsi_BDM_EHIOMOOBEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHIOMOOBEN] (
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
-- Create table U_EHIOMOOBEN_Audit
-----------

IF OBJECT_ID('U_EHIOMOOBEN_Audit') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_Audit] (
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
-- Create table U_EHIOMOOBEN_AuditFields
-----------

IF OBJECT_ID('U_EHIOMOOBEN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EHIOMOOBEN_DedList
-----------

IF OBJECT_ID('U_EHIOMOOBEN_DedList') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHIOMOOBEN_drvTbl
-----------

IF OBJECT_ID('U_EHIOMOOBEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvTransDate] char(8) NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(50) NULL,
    [drvNameFirst] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeEffectiveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryAmount] varchar(24) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvClassID] varchar(4) NOT NULL,
    [drvBLProductCategory] varchar(1) NULL,
    [drvBLEffectiveDate] datetime NULL,
    [drvBLEligibiltyEvent] varchar(2) NOT NULL,
    [drvBLPlanID] varchar(10) NULL,
    [drvBLFamilyCoverageInd] varchar(1) NULL,
    [drvBADDProductCategory] varchar(1) NULL,
    [drvBADDEffectiveDate] datetime NULL,
    [drvBADDEligibiltyEvent] varchar(2) NOT NULL,
    [drvBADDPlanID] varchar(10) NULL,
    [drvBADDFamilyCoverageInd] varchar(1) NULL,
    [drvBSTDProductCategory] varchar(1) NULL,
    [drvBSTDEffectiveDate] datetime NULL,
    [drvBSTDEligibiltyEvent] varchar(2) NULL,
    [drvBSTDPlanID] varchar(10) NULL,
    [drvBSTDFamilyCoverageInd] varchar(1) NULL,
    [drvBLTDProductCategory] varchar(1) NULL,
    [drvBLTDEffectiveDate] datetime NULL,
    [drvBLTDEligibiltyEvent] varchar(2) NULL,
    [drvBLTDPlanID] varchar(10) NULL,
    [drvBLTDFamilyCoverageInd] varchar(1) NULL,
    [drvVolTermLifeEmpProductCat] varchar(1) NULL,
    [drvVolTermLifeEmpEffDate] datetime NULL,
    [drvVolTermLifeEmpEligEvent] varchar(2) NULL,
    [drvVolTermLifeEmpPlanID] varchar(11) NOT NULL,
    [drvVolTermLifeEmpFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeEmpAppAmtEffDte] datetime NULL,
    [drvVolTermLifeEmpApprovedAmt] varchar(24) NULL,
    [drvVolTermLifeSpsProductCat] varchar(1) NULL,
    [drvVolTermLifeSpsEffDate] datetime NULL,
    [drvVolTermLifeSpsEligEvent] varchar(2) NULL,
    [drvVolTermLifeSpsPlanID] varchar(10) NULL,
    [drvVolTermLifeSpsFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeSpsAppAmtEffDte] datetime NULL,
    [drvVolTermLifeSpsApprovedAmt] varchar(24) NULL,
    [drvVolTermLifeDepProductCat] varchar(1) NULL,
    [drvVolTermLifeDepEffDate] datetime NULL,
    [drvVolTermLifeDepEligEvent] varchar(2) NULL,
    [drvVolTermLifeDepPlanID] varchar(10) NULL,
    [drvVolTermLifeDepFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeDepAppAmtEffDte] datetime NULL,
    [drvVolTermLifeDepApprovedAmt] varchar(24) NULL
);

-----------
-- Create table U_EHIOMOOBEN_EEList
-----------

IF OBJECT_ID('U_EHIOMOOBEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHIOMOOBEN_File
-----------

IF OBJECT_ID('U_EHIOMOOBEN_File') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);

-----------
-- Create table U_EHIOMOOBEN_PDedHist
-----------

IF OBJECT_ID('U_EHIOMOOBEN_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_PDedHist] (
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
-- Create table U_EHIOMOOBEN_PEarHist
-----------

IF OBJECT_ID('U_EHIOMOOBEN_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHIOMOOBEN_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHIOMOOBEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hiossen Implant

Created By: Marie Waters
Business Analyst: Curlin Beck
Create Date: 07/19/2022
Service Request Number: TekP-2022-02-23-02

Purpose: Mutual Of Omaha AD&D/Life/Vol Life/LTD/STD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHIOMOOBEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHIOMOOBEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHIOMOOBEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHIOMOOBEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHIOMOOBEN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIOMOOBEN', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIOMOOBEN', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIOMOOBEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIOMOOBEN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIOMOOBEN', 'SCH_EHIOMO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHIOMOOBEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHIOMOOBEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;;

    -- Set FormatCode
    SELECT @FormatCode = 'EHIOMOOBEN';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@FileMinCovDate  = '01/01/2022'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHIOMOOBEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHIOMOOBEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHIOMOOBEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHIOMOOBEN_AuditFields;
    CREATE TABLE dbo.U_EHIOMOOBEN_AuditFields (aTableName varchar(30),aFieldName varchar(30));

      INSERT INTO dbo.U_EHIOMOOBEN_AuditFields VALUES ('EmpComp','EecDateOfTermination');
      INSERT INTO dbo.U_EHIOMOOBEN_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHIOMOOBEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHIOMOOBEN_Audit;
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
    INTO dbo.U_EHIOMOOBEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EHIOMOOBEN_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EHIOMOOBEN_Audit ON dbo.U_EHIOMOOBEN_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EHIOMOOBEN_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EHIOMOOBEN_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,LIFEE,LIFEC,LIFES,ADD,GLIFE';

    IF OBJECT_ID('U_EHIOMOOBEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHIOMOOBEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHIOMOOBEN_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CountDependents','Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse','SPS,SP')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild','CHL,DPC,STC')

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

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_EHIOMOOBEN_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EHIOMOOBEN_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EHIOMOOBEN_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EHIOMOOBEN_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    --IF OBJECT_ID('U_EHIOMOOBEN_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EHIOMOOBEN_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_EHIOMOOBEN_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHIOMOOBEN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHIOMOOBEN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHIOMOOBEN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransDate = CONVERT(CHAR(8), GETDATE(), 112)
        ,drvRelationshipCode = CASE WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'F' THEN 'W'
                                    WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'M' THEN 'H'
                                    WHEN ConRelationship IN ('SPS','DP') AND ConGender NOT IN ('M','F') THEN 'H'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'F' THEN 'D'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'M' THEN 'S'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender NOT IN  ('M','F') THEN 'S'
                                    ELSE 'M'
                                END
        ,drvEmployeeID = EepSSN
        ,drvNameLast = CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END)) AS VARCHAR(50))
        ,drvNameFirst = CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END)) AS VARCHAR(50))
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOFBirth END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmployeeEffectiveDate = EecDateOfLastHire
        ,drvBillGroupEffectiveDate = CASE  WHEN BdmRecType = 'EMP' THEN 
                                            CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire  THEN EecDateOfLastHire ELSE EecDateOfOriginalHire END ---CASE WHEN EecDateOfOriginalHire < BdmBenStartDate then BdmBenStartDate END
                                        END
        ,drvBasicSalaryEffectiveDate =  MaxJobEffDate ---MAX(EjhJobEffDate) where EjhisRateChange = 'Y' ---CASE  WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), '5/1/2020') END 
        ,drvBasicSalaryAmount =  CASE  WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnPadZero(eecannsalary*100,16,0)  END
        ,drvClassEffectiveDate = CASE  WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire  THEN EecDateOfLastHire ELSE EecDateOfOriginalHire END 
                                    END
        ,drvClassID = 'A001'
        ,drvBLProductCategory =  CASE WHEN BdmRecType = 'EMP' AND GLIFE_DedCode IS NOT NULL THEN '1' END
        ,drvBLEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND GLIFE_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GLIFE_BenStatus = 'T' THEN DATEADD(DAY, +1, GLIFE_BenStopDate) ELSE GLIFE_BenStartDate END, '5/1/2020')
                                END
        ,drvBLEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND GLIFE_DedCode IS NOT NULL and GLIFE_BenStatus= 'T' THEN 'TM' else 'EM' END
        ,drvBLPlanID = CASE WHEN BdmRecType = 'EMP' AND GLIFE_DedCode IS NOT NULL THEN 'LTL00NCSAL' END
        ,drvBLFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND GLIFE_DedCode IS NOT NULL THEN 'C' END
        ,drvBADDProductCategory = CASE WHEN BdmRecType = 'EMP' AND ADD_DedCode IS NOT NULL then 'A' END
        ,drvBADDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND ADD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADD_BenStatus = 'T' THEN DATEADD(DAY, +1, ADD_BenStopDate) ELSE ADD_BenStartDate END, '5/1/2020')
                                END
        ,drvBADDEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND ADD_DedCode IS NOT NULL and ADD_BenStatus= 'T' then 'TM' else 'EM' END
        ,drvBADDPlanID = CASE WHEN BdmRecType = 'EMP' AND ADD_DedCode IS NOT NULL THEN 'ATA00NCSAL' END
        ,drvBADDFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND ADD_DedCode IS NOT NULL THEN 'C' END
        ,drvBSTDProductCategory = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 'S' END
        ,drvBSTDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN STD_BenStatus = 'T' THEN DATEADD(DAY, +1, STD_BenStopDate) ELSE STD_BenStartDate END, '5/1/2020')
                                    END
        ,drvBSTDEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 
                                    CASE WHEN STD_BenStatus = 'T' THEN 'TM' ELSE 'EM' END
                                    END
        ,drvBSTDPlanID =  CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN  'STS00NCSAL' END
        ,drvBSTDFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 'C' END
        ,drvBLTDProductCategory = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 'T'  END
        ,drvBLTDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LTD_BenStatus = 'T' THEN DATEADD(DAY, +1, LTD_BenStopDate) ELSE LTD_BenStartDate END, '5/1/2020')
                                END
        ,drvBLTDEligibiltyEvent =   CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 
                                    CASE WHEN LTD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBLTDPlanID = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN  'TTT00NCSAL' END
        ,drvBLTDFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeEmpProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN '3' END
        ,drvVolTermLifeEmpEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL 
                                         THEN  dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEE_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEE_BenStopDate) ELSE LIFEE_BenStartDate END, '5/1/2020')
                                        END
        ,drvVolTermLifeEmpEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 
                                            CASE WHEN LIFEE_BenStatus = 'T'  then 'TM' else 'EM' END 
                                            END
        ,drvVolTermLifeEmpPlanID =  CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL and EecEmpNo IN ('10000979','10001570') THEN 'ETL00CEEGF' else 'ETL00CEEVAL' END
        ,drvVolTermLifeEmpFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeEmpAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL  THEN LIFEE_BenStartDate END
        ,drvVolTermLifeEmpApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEE_BenAmt,10,0) END
        ,drvVolTermLifeSpsProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN  '4' END
        ,drvVolTermLifeSpsEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFES_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFES_BenStopDate) ELSE LIFES_BenStartDate END, '5/1/2020')
                                END
        ,drvVolTermLifeSpsEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN LIFEE_BenStatus = 'T'then 'TM' else 'EM' END
                                        END
        ,drvVolTermLifeSpsPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'ETL0CSPVAL' END
        ,drvVolTermLifeSpsFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeSpsAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN LIFES_BenStartDate END
        ,drvVolTermLifeSpsApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFES_BenAmt,10,0) END
        ,drvVolTermLifeDepProductCat =  CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN  '5' END
        ,drvVolTermLifeDepEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEC_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEC_BenStopDate) ELSE LIFEC_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolTermLifeDepEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN LIFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                     END
        ,drvVolTermLifeDepPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'ETL0CDPVAL' END
        ,drvVolTermLifeDepFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeDepAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN LIFEC_BenStartDate END
        ,drvVolTermLifeDepApprovedAmt =CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEC_BenAmt,10,0) END
    INTO dbo.U_EHIOMOOBEN_drvTbl
    FROM dbo.U_EHIOMOOBEN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EHIOMOOBEN WITH (NOLOCK)
 --       ON BdmEEID = xEEID 
        --AND BdmCoID = xCoID
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
                
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmDedCode END) AS ADD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode    
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmBenStatus END) AS ADD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStatus END) AS LTD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStatus END) AS LIFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStatus END) AS LIFEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStatus END) AS LIFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStatus END) AS GLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmBenStartDate END) AS ADD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BenStartDate
                 ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmBenStopDate END) AS ADD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BenStopDate
            FROM dbo.U_dsi_BDM_EHIOMOOBEN WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEE' THEN EdhEEBenAmt END) AS LIFEE_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFES' THEN EdhEEBenAmt END) AS LIFES_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEC' THEN EdhEEBenAmt END) AS LIFEC_BenAmt
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt
                        FROM (
                                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDate DESC) AS RN
                                FROM dbo.EmpHDed WITH (NOLOCK) 
                                WHERE EdhDedCode IN ('LIFEE', 'LIFES', 'LIFEC') 
                                    AND EdhBenStatus = 'A') AS T
                WHERE RN = 1) AS Y
                GROUP BY EdhEEID, EdhCOID
            ) AS Life_Amount
        ON EdhEEID = xEEID
        AND EdhCOID = XCOID
    LEFT JOIN dbo.U_EHIOMOOBEN_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
     LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, Max(EjhJobEffDate) AS MaxJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1
                Group By EjhEEID, EjhCOID, EjhReason) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        WHERE  EecEEType <> 'TES'
        and (EecEmplStatus  <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN DATEADD(DAY, -7, @StartDate) AND @EndDate))
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
ALTER VIEW dbo.dsi_vwEHIOMOOBEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHIOMOOBEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EHIOMOOBEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202207121'
       ,expStartPerControl     = '202207121'
       ,expLastEndPerControl   = '202207199'
       ,expEndPerControl       = '202207199'
WHERE expFormatCode = 'EHIOMOOBEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHIOMOOBEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHIOMOOBEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHIOMOOBEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHIOMOOBEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHIOMOOBEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHIOMOOBEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHIOMOOBEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHIOMOOBEN', 'UseFileName', 'V', 'Y'


-- End ripout