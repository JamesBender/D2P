/**********************************************************************************

ECONMOOEXP: Mutual of Omaha Life Disability Export

FormatCode:     ECONMOOEXP
Project:        Mutual of Omaha Life Disability Export
Client ID:      CON1047
Date/time:      2023-05-24 16:17:25.723
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPCHOTI
Web Filename:   CON1047_L564G_EEHISTORY_ECONMOOEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECONMOOEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECONMOOEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECONMOOEXP'


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
WHERE FormatCode = 'ECONMOOEXP'
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
WHERE ExpFormatCode = 'ECONMOOEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECONMOOEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECONMOOEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECONMOOEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECONMOOEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECONMOOEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECONMOOEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECONMOOEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECONMOOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECONMOOEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECONMOOEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECONMOOEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECONMOOEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECONMOOEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECONMOOEXP];
GO
IF OBJECT_ID('U_ECONMOOEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_File];
GO
IF OBJECT_ID('U_ECONMOOEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_EEList];
GO
IF OBJECT_ID('U_ECONMOOEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_drvTbl];
GO
IF OBJECT_ID('U_ECONMOOEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_DedList];
GO
IF OBJECT_ID('U_ECONMOOEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_AuditFields];
GO
IF OBJECT_ID('U_ECONMOOEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECONMOOEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECONMOOEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECONMOOEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECONMOOEXP','Mutual of Omaha Life Disability Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECONMOOEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECONMOOEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL,'"drvTransDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECONMOOEXPZ0','8','D','10','2',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECONMOOEXPZ0','1','D','10','3',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECONMOOEXPZ0','9','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECONMOOEXPZ0','35','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECONMOOEXPZ0','15','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECONMOOEXPZ0','1','D','10','7',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECONMOOEXPZ0','8','D','10','8',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECONMOOEXPZ0','30','D','10','9',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECONMOOEXPZ0','30','D','10','10',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECONMOOEXPZ0','19','D','10','11',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECONMOOEXPZ0','2','D','10','12',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECONMOOEXPZ0','11','D','10','13',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECONMOOEXPZ0','8','D','10','14',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateofHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECONMOOEXPZ0','8','D','10','15',NULL,'Employee Effective Date',NULL,NULL,'"drvEmployeeEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECONMOOEXPZ0','8','D','10','16',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECONMOOEXPZ0','4','D','10','17',NULL,'Bill Group ID',NULL,NULL,'"drvBillGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECONMOOEXPZ0','8','D','10','18',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECONMOOEXPZ0','1','D','10','19',NULL,'Basic Salary Mode',NULL,NULL,'"drvBasicSalaryMode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECONMOOEXPZ0','16','D','10','20',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECONMOOEXPZ0','8','D','10','21',NULL,'1st Additional Compensation Effective Date',NULL,NULL,'"drvCcmpEffDate1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECONMOOEXPZ0','1','D','10','22',NULL,'1st Additional Compensation Mode',NULL,NULL,'"drvCompMode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECONMOOEXPZ0','2','D','10','23',NULL,'1st Additional Compensation Type',NULL,NULL,'"drvCompType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECONMOOEXPZ0','16','D','10','24',NULL,'1st Additional Compensation Amount',NULL,NULL,'"drvCompAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECONMOOEXPZ0','8','D','10','25',NULL,'2nd Additional Compensation Effective Date',NULL,NULL,'"drvCompEffDate2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECONMOOEXPZ0','1','D','10','26',NULL,'2nd Additional Compensation Mode',NULL,NULL,'"drvCompMode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECONMOOEXPZ0','2','D','10','27',NULL,'2nd Additional Compensation Type',NULL,NULL,'"drvCompType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECONMOOEXPZ0','16','D','10','28',NULL,'2nd Additional Compensation Amount',NULL,NULL,'"drvCompAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECONMOOEXPZ0','8','D','10','29',NULL,'3rd Additional Compensation Effective Date',NULL,NULL,'"drvCompEffDate3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECONMOOEXPZ0','1','D','10','30',NULL,'3rd Additional Compensation Mode',NULL,NULL,'"drvCompMode3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECONMOOEXPZ0','2','D','10','31',NULL,'3rd Additional Compensation Type',NULL,NULL,'"drvCompType3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECONMOOEXPZ0','16','D','10','32',NULL,'3rd Additional Compensation Amount',NULL,NULL,'"drvCompAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECONMOOEXPZ0','8','D','10','33',NULL,'4th Additional Compensation Effective Date',NULL,NULL,'"drvCcmpEffDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECONMOOEXPZ0','1','D','10','34',NULL,'4th Additional Compensation Mode',NULL,NULL,'"drvCompMode4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECONMOOEXPZ0','2','D','10','35',NULL,'4th Additional Compensation Type',NULL,NULL,'"drvCompType4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECONMOOEXPZ0','16','D','10','36',NULL,'4th Additional Compensation Amount',NULL,NULL,'"drvCompAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECONMOOEXPZ0','8','D','10','37',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECONMOOEXPZ0','4','D','10','38',NULL,'Class ID',NULL,NULL,'"drvCalssID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECONMOOEXPZ0','1','D','10','39',NULL,'Product Category',NULL,NULL,'"drvProdCategory1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECONMOOEXPZ0','8','D','10','40',NULL,'Effective Date',NULL,NULL,'"drvEffDate1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECONMOOEXPZ0','2','D','10','41',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECONMOOEXPZ0','10','D','10','42',NULL,'Plan ID',NULL,NULL,'"drvPlanID1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECONMOOEXPZ0','1','D','10','43',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECONMOOEXPZ0','1','D','10','44',NULL,'Product Category',NULL,NULL,'"drvProdCategory2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECONMOOEXPZ0','8','D','10','45',NULL,'Effective Date',NULL,NULL,'"drvEffDate2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECONMOOEXPZ0','2','D','10','46',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECONMOOEXPZ0','10','D','10','47',NULL,'Plan ID',NULL,NULL,'"drvPlanID2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECONMOOEXPZ0','1','D','10','48',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECONMOOEXPZ0','1','D','10','49',NULL,'Product Category',NULL,NULL,'"drvProdCategory3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECONMOOEXPZ0','8','D','10','50',NULL,'Effective Date',NULL,NULL,'"drvEffDate3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECONMOOEXPZ0','2','D','10','51',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECONMOOEXPZ0','10','D','10','52',NULL,'Plan ID',NULL,NULL,'"drvPlanID3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECONMOOEXPZ0','1','D','10','53',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECONMOOEXPZ0','1','D','10','54',NULL,'Product Category',NULL,NULL,'"drvProdCategory4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECONMOOEXPZ0','8','D','10','55',NULL,'Effective Date',NULL,NULL,'"drvEffDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECONMOOEXPZ0','2','D','10','56',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECONMOOEXPZ0','10','D','10','57',NULL,'Plan ID',NULL,NULL,'"drvPlanID4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECONMOOEXPZ0','1','D','10','58',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECONMOOEXPZ0','1','D','10','59',NULL,'Product Category',NULL,NULL,'"drvProdCategory5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECONMOOEXPZ0','8','D','10','60',NULL,'Effective Date',NULL,NULL,'"drvEffDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECONMOOEXPZ0','2','D','10','61',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECONMOOEXPZ0','10','D','10','62',NULL,'Plan ID',NULL,NULL,'"drvPlanID5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECONMOOEXPZ0','1','D','10','63',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECONMOOEXPZ0','8','D','10','64',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECONMOOEXPZ0','10','D','10','65',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECONMOOEXPZ0','1','D','10','66',NULL,'Product Category',NULL,NULL,'"drvProdCategory6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECONMOOEXPZ0','8','D','10','67',NULL,'Effective Date',NULL,NULL,'"drvEffDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECONMOOEXPZ0','2','D','10','68',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECONMOOEXPZ0','10','D','10','69',NULL,'Plan ID',NULL,NULL,'"drvPlanID6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECONMOOEXPZ0','1','D','10','70',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ECONMOOEXPZ0','8','D','10','71',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ECONMOOEXPZ0','10','D','10','72',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ECONMOOEXPZ0','1','D','10','73',NULL,'Product Category',NULL,NULL,'"drvProdCategory7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ECONMOOEXPZ0','8','D','10','74',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ECONMOOEXPZ0','2','D','10','75',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ECONMOOEXPZ0','10','D','10','76',NULL,'Plan ID',NULL,NULL,'"drvPlanID7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ECONMOOEXPZ0','1','D','10','77',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ECONMOOEXPZ0','8','D','10','78',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ECONMOOEXPZ0','10','D','10','79',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ECONMOOEXPZ0','1','D','10','80',NULL,'Product Category',NULL,NULL,'"drvProdCategory8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ECONMOOEXPZ0','8','D','10','81',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ECONMOOEXPZ0','2','D','10','82',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ECONMOOEXPZ0','10','D','10','83',NULL,'Plan ID',NULL,NULL,'"drvPlanID8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ECONMOOEXPZ0','1','D','10','84',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ECONMOOEXPZ0','8','D','10','85',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmountEffDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ECONMOOEXPZ0','10','D','10','86',NULL,'Approved Amount',NULL,NULL,'"drvapprovedAmt8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ECONMOOEXPZ0','1','D','10','87',NULL,'Product Category',NULL,NULL,'"drvProdCategory9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ECONMOOEXPZ0','8','D','10','88',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ECONMOOEXPZ0','2','D','10','89',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ECONMOOEXPZ0','10','D','10','90',NULL,'Plan ID',NULL,NULL,'"drvPlanID9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ECONMOOEXPZ0','1','D','10','91',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ECONMOOEXPZ0','8','D','10','92',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmountEffDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ECONMOOEXPZ0','10','D','10','93',NULL,'Approved Amount',NULL,NULL,'"drvapprovedAmt9"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECONMOOEXP_20230524.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202305239','EMPEXPORT','OEACTIVE',NULL,'ECONMOOEXP',NULL,NULL,NULL,'202305239','May 23 2023  5:07PM','May 23 2023  5:07PM','202305231',NULL,'','','202305231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202305239','EMPEXPORT','OEPASSIVE',NULL,'ECONMOOEXP',NULL,NULL,NULL,'202305239','May 23 2023  5:07PM','May 23 2023  5:07PM','202305231',NULL,'','','202305231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Disabilit','202305239','EMPEXPORT','ONDEM_XOE',NULL,'ECONMOOEXP',NULL,NULL,NULL,'202305239','May 23 2023  5:07PM','May 23 2023  5:07PM','202305231',NULL,'','','202305231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Sched','202305239','EMPEXPORT','SCH_ECONMO',NULL,'ECONMOOEXP',NULL,NULL,NULL,'202305239','May 23 2023  5:07PM','May 23 2023  5:07PM','202305231',NULL,'','','202305231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Test','202305239','EMPEXPORT','TEST_XOE',NULL,'ECONMOOEXP',NULL,NULL,NULL,'202305239','May 23 2023  5:07PM','May 23 2023  5:07PM','202305231',NULL,'','','202305231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECONMOOEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECONMOOEXP','D10','dbo.U_ECONMOOEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECONMOOEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECONMOOEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECONMOOEXP] (
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
-- Create table U_ECONMOOEXP_Audit
-----------

IF OBJECT_ID('U_ECONMOOEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_Audit] (
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
-- Create table U_ECONMOOEXP_AuditFields
-----------

IF OBJECT_ID('U_ECONMOOEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECONMOOEXP_DedList
-----------

IF OBJECT_ID('U_ECONMOOEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECONMOOEXP_drvTbl
-----------

IF OBJECT_ID('U_ECONMOOEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransDate] varchar(8) NULL,
    [drvGroupID] varchar(8) NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateofBirth] varchar(8) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDateofHire] varchar(8) NULL,
    [drvEmployeeEffectiveDate] varchar(8) NULL,
    [drvBillGroupEffectiveDate] varchar(8) NULL,
    [drvBillGroupID] varchar(4) NOT NULL,
    [drvBasicSalaryEffectiveDate] varchar(8) NULL,
    [drvBasicSalaryMode] varchar(1) NOT NULL,
    [drvBasicSalaryAmount] nvarchar(4000) NULL,
    [drvCcmpEffDate1] varchar(1) NOT NULL,
    [drvCompMode1] varchar(1) NOT NULL,
    [drvCompType1] varchar(1) NOT NULL,
    [drvCompAmount1] varchar(1) NOT NULL,
    [drvCompEffDate2] varchar(1) NOT NULL,
    [drvCompMode2] varchar(1) NOT NULL,
    [drvCompType2] varchar(1) NOT NULL,
    [drvCompAmount2] varchar(1) NOT NULL,
    [drvCompEffDate3] varchar(1) NOT NULL,
    [drvCompMode3] varchar(1) NOT NULL,
    [drvCompType3] varchar(1) NOT NULL,
    [drvCompAmount3] varchar(1) NOT NULL,
    [drvCcmpEffDate4] varchar(1) NOT NULL,
    [drvCompMode4] varchar(1) NOT NULL,
    [drvCompType4] varchar(1) NOT NULL,
    [drvCompAmount4] varchar(1) NOT NULL,
    [drvClassEffDate] varchar(8) NULL,
    [drvCalssID] varchar(5) NULL,
    [drvProdCategory1] varchar(1) NULL,
    [drvEffDate1] varchar(8) NULL,
    [drvEligibilityEvent1] varchar(2) NOT NULL,
    [drvPlanID1] varchar(10) NULL,
    [drvFamilyCoverageIndicator1] varchar(1) NULL,
    [drvProdCategory2] varchar(1) NULL,
    [drvEffDate2] varchar(8) NULL,
    [drvEligibilityEvent2] varchar(2) NOT NULL,
    [drvPlanID2] varchar(10) NULL,
    [drvFamilyCoverageIndicator2] varchar(1) NULL,
    [drvProdCategory3] varchar(1) NULL,
    [drvEffDate3] varchar(8) NULL,
    [drvEligibilityEvent3] varchar(2) NOT NULL,
    [drvPlanID3] varchar(10) NULL,
    [drvFamilyCoverageIndicator3] varchar(1) NULL,
    [drvProdCategory4] varchar(1) NULL,
    [drvEffDate4] varchar(8) NULL,
    [drvEligibilityEvent4] varchar(2) NOT NULL,
    [drvPlanID4] varchar(10) NULL,
    [drvFamilyCoverageIndicator4] varchar(1) NULL,
    [drvProdCategory5] varchar(1) NULL,
    [drvEffDate5] varchar(8) NULL,
    [drvEligibilityEvent5] varchar(2) NOT NULL,
    [drvPlanID5] varchar(10) NULL,
    [drvFamilyCoverageIndicator5] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate5] varchar(8) NULL,
    [drvApprovedAmount5] nvarchar(4000) NULL,
    [drvProdCategory6] varchar(1) NULL,
    [drvEffDate6] varchar(8) NULL,
    [drvEligibilityEvent6] varchar(2) NOT NULL,
    [drvPlanID6] varchar(10) NULL,
    [drvFamilyCoverageIndicator6] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate6] varchar(8) NULL,
    [drvApprovedAmount6] nvarchar(4000) NULL,
    [drvProdCategory7] varchar(1) NULL,
    [drvEffectiveDate7] varchar(8) NULL,
    [drvEligibilityEvent7] varchar(2) NOT NULL,
    [drvPlanID7] varchar(10) NULL,
    [drvFamilyCoverageIndicator7] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate7] varchar(8) NULL,
    [drvApprovedAmount7] nvarchar(4000) NULL,
    [drvProdCategory8] varchar(1) NULL,
    [drvEffectiveDate8] varchar(8) NULL,
    [drvEligibilityEvent8] varchar(2) NOT NULL,
    [drvPlanID8] varchar(10) NULL,
    [drvFamilyCoverageIndicator8] varchar(1) NULL,
    [drvApprovedAmountEffDate8] varchar(8) NULL,
    [drvapprovedAmt8] varchar(1) NULL,
    [drvProdCategory9] varchar(8) NULL,
    [drvEffectiveDate9] varchar(2) NOT NULL,
    [drvEligibilityEvent9] varchar(8) NULL,
    [drvPlanID9] varchar(10) NULL,
    [drvFamilyCoverageIndicator9] varchar(1) NULL,
    [drvApprovedAmountEffDate9] varchar(8) NULL,
    [drvapprovedAmt9] nvarchar(4000) NULL
);

-----------
-- Create table U_ECONMOOEXP_EEList
-----------

IF OBJECT_ID('U_ECONMOOEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECONMOOEXP_File
-----------

IF OBJECT_ID('U_ECONMOOEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECONMOOEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECONMOOEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: San Diego Convention Center

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 05/23/2023
Service Request Number: TekP-2023-03-22-04

Purpose: Mutual of Omaha Life Disability Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECONMOOEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECONMOOEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECONMOOEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECONMOOEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECONMOOEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECONMOOEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECONMOOEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECONMOOEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECONMOOEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECONMOOEXP', 'SCH_ECONMO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECONMOOEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECONMOOEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECONMOOEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@FileMinCovDate  = '05/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECONMOOEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECONMOOEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECONMOOEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECONMOOEXP_AuditFields;
    CREATE TABLE dbo.U_ECONMOOEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
       INSERT INTO dbo.U_ECONMOOEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
      INSERT INTO dbo.U_ECONMOOEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECONMOOEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECONMOOEXP_Audit;
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
    INTO dbo.U_ECONMOOEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECONMOOEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECONMOOEXP_Audit ON dbo.U_ECONMOOEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECONMOOEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECONMOOEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,ADD,STD,LTD,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_ECONMOOEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECONMOOEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECONMOOEXP_DedList
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECONMOOEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECONMOOEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECONMOOEXP_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransDate = CONVERT(VARCHAR(8),@Rundate, 112)
        ,drvGroupID = CASE WHEN EecPayGroup = 'MCH' THEN 'G000AQIL'
                           WHEN EecPayGroup in ('EM', 'WH', 'PFFBK', 'BERPRO', 'FSO', 'BELLC', 'TRIFLY') THEN  'G000BDSP'
                        END
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN 'M' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ISNULL(ConGender,'') IN ( 'M', '')THEN 'H' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ConGender = 'F' THEN 'W' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ISNULL(ConGender, '') IN ( 'M', '') THEN 'S'
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConGender = 'F' THEN 'D' 
                                   -- WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConIsDisabled ='Y' AND (SELECT FLOOR(DATEDIFF(DAY, GetDate() , ConDateofbirth) / 365.25)) >=  26 THEN 'I'
                                    ELSE 'M'
                                END
        ,drvEmployeeID = EecEmpNo
        ,drvLastName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(dbo.dsi_fnRemoveChars('.,/-^&',CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END)) AS VARCHAR(50))), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvFirstName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(dbo.dsi_fnRemoveChars('.,/-^&',CAST(ltrim(rtrim(CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END)) AS VARCHAR(50))), 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u')
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateofBirth = CONVERT(VARCHAR(8),CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOFBirth END,112)
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-^&',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-^&',EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDateofHire = CONVERT(VARCHAR(8),EecDateofLastHire, 112)
        ,drvEmployeeEffectiveDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', All_BenStartDate , @FileMinCovDate) , 112) 
        ,drvBillGroupEffectiveDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', All_BenStartDate , @FileMinCovDate) , 112) 
        ,drvBillGroupID = '0001'
        ,drvBasicSalaryEffectiveDate =  CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @FileMinCovDate, eecDateOfLastHire), 112)
        ,drvBasicSalaryMode = 'A'
        ,drvBasicSalaryAmount = Format(EecAnnSalary, '0000000000000000')
        ,drvCcmpEffDate1 = ''--CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', ALL_BenStartDate , @FileMinCovDate), 112) 
        ,drvCompMode1 = ''
        ,drvCompType1 = ''
        ,drvCompAmount1 = ''
        ,drvCompEffDate2 = ''
        ,drvCompMode2 = ''
        ,drvCompType2 = ''
        ,drvCompAmount2 = ''
        ,drvCompEffDate3 = ''
        ,drvCompMode3 = ''
        ,drvCompType3 = ''
        ,drvCompAmount3 = ''
        ,drvCcmpEffDate4 = ''
        ,drvCompMode4 = ''
        ,drvCompType4 = ''
        ,drvCompAmount4 = ''
        ,drvClassEffDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', ALL_BenStartDate , @FileMinCovDate), 112) 
        ,drvCalssID = CASE WHEN EecSalaryOrHourly = 'H' and ISnull(GFStatus, 0) = '0'  THEN 'A001'
                            WHEN EecSalaryOrHourly = 'S'and EecDedGroupCode in ('MGRMG', 'PFFHM', 'MGRH') THEN 'A001'
                            WHEN EecSalaryOrHourly = 'S' and EecDedGroupCode not in ('MGRMG', 'PFFHM', 'MGRH') THEN 'A0002'
                            WHEN  GFStatus = '1' THEN 'A003'                            
                        END
                    
        ,drvProdCategory1 = CASE WHEN GLIFE_DedCode is not null THEN '1' END
        ,drvEffDate1 = CASE WHEN GLIFE_DedCode is not null AND GLIFE_BenStatus   = 'T' THEN GLIFE_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', GLIFE_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent1 = CASE WHEN GLIFE_DedCode is not null AND GLIFE_BenStatus = 'T'  THEN 'TM' ELSE 'EN' END
        ,drvPlanID1 = CASE WHEN GLIFE_DedCode is not null THEN 'LTL00NCSAL' END
        ,drvFamilyCoverageIndicator1 = CASE WHEN GLIFE_DedCode is not null THEN 'C' END
        ,drvProdCategory2 = CASE WHEN ADD_DedCode is not null THEN 'a' END
        ,drvEffDate2 = CASE WHEN ADD_DedCode is not null AND ADD_BenStatus   = 'T' THEN ADD_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', ADD_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent2 = CASE WHEN ADD_DedCode is not null AND ADD_BenStatus = 'T'  THEN 'TM' ELSE 'EN' END
        ,drvPlanID2 = CASE WHEN ADD_DedCode is not null THEN  'ATA00NCSAL' END
        ,drvFamilyCoverageIndicator2 = CASE WHEN ADD_DedCode is not null THEN 'C' END
        ,drvProdCategory3 = CASE WHEN STD_DedCode is not null THEN 'S' END
        ,drvEffDate3 = CASE WHEN STD_DedCode is not null AND STD_BenStatus   = 'T' THEN STD_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent3 = CASE WHEN STD_DedCode is not null AND STD_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID3 = CASE WHEN STD_DedCode is not null THEN 'STS00NCSAL' END
        ,drvFamilyCoverageIndicator3 = CASE WHEN STD_DedCode is not null THEN 'C' END
        ,drvProdCategory4 = CASE WHEN LTD_DedCode is not null THEN 'T' END
        ,drvEffDate4 =  CASE WHEN LTD_DedCode is not null AND LTD_BenStatus   = 'T' THEN LTD_BenStopDate ELSE  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LTD_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent4 = CASE WHEN LTD_DedCode is not null AND LTD_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID4 = CASE WHEN LTD_DedCode is not null THEN 'TTT00NCSAL' END
        ,drvFamilyCoverageIndicator4 = CASE WHEN LTD_DedCode is not null THEN 'C' END
        ,drvProdCategory5 = CASE WHEN LIFEE_DedCode is not null THEN '3' END
        ,drvEffDate5 = CASE WHEN LIFEE_DedCode is not null AND LIFEE_BenStatus   = 'T' THEN LIFEE_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent5 = CASE WHEN LIFEE_DedCode is not null AND LIFEE_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID5 = CASE WHEN LIFEE_DedCode is not null THEN 'ETL0CEEVAL' END
        ,drvFamilyCoverageIndicator5 = CASE WHEN LIFEE_DedCode is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate5 = CASE WHEN LIFEE_DedCode is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_BenStartDate , @FileMinCovDate), 112) END
        ,drvApprovedAmount5 =  CASE WHEN LIFEE_DedCode is not null THEN LIFEE_BenAmt END
        ,drvProdCategory6 = CASE WHEN LIFES_DedCode is not null THEN '4' END
        ,drvEffDate6 = CASE WHEN LIFES_DedCode is not null AND LIFES_BenStatus   = 'T' THEN LIFES_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFES_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent6 = CASE WHEN LIFES_DedCode is not null AND LIFES_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID6 = CASE WHEN LIFES_DedCode is not null THEN 'ETL0CSPVAL' END
        ,drvFamilyCoverageIndicator6 = CASE WHEN LIFES_DedCode is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate6 = CASE WHEN LIFES_DedCode is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFES_BenStartDate , @FileMinCovDate), 112) END
        ,drvApprovedAmount6 = CASE WHEN LIFES_DedCode is not null THEN LIFES_BenAmt END
        ,drvProdCategory7 = CASE WHEN LIFEC_DedCode is not null THEN '5' END
        ,drvEffectiveDate7 = CASE WHEN LIFEC_DedCode is not null AND LIFEC_BenStatus   = 'T' THEN LIFEC_BenStopDate ELSE  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEC_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent7 = CASE WHEN LIFEC_DedCode is not null AND LIFEC_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID7 = CASE WHEN LIFEC_DedCode is not null THEN 'ETL0CDPVAL' END
        ,drvFamilyCoverageIndicator7 = CASE WHEN LIFEC_DedCode is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate7 = CASE WHEN LIFEC_DedCode is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEC_BenStartDate , @FileMinCovDate), 112) END
        ,drvApprovedAmount7 = CASE WHEN LIFEC_DedCode is not null THEN LIFEC_BenAmt END
        ,drvProdCategory8 = CASE WHEN LIFEE_DedCode is not null THEN 'c' END
        ,drvEffectiveDate8 = CASE WHEN LIFEE_DedCode is not null AND LIFEE_BenStatus   = 'T' THEN LIFEE_BenStopDate ELSE  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_BenStartDate , @FileMinCovDate), 112) END
        ,drvEligibilityEvent8 = CASE WHEN LIFEE_DedCode is not null AND LIFEE_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvPlanID8 = CASE WHEN LIFEE_DedCode is not null THEN 'BTA0CEEVAL' END
        ,drvFamilyCoverageIndicator8 = CASE WHEN LIFEE_DedCode is not null THEN 'C' END
        ,drvApprovedAmountEffDate8 = CASE WHEN LIFEE_DedCode is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFEE_BenStartDate , @FileMinCovDate), 112) END
        ,drvapprovedAmt8 = CASE WHEN LIFES_DedCode is not null THEN 'e' END
        ,drvProdCategory9 = CASE WHEN LIFES_DedCode is not null AND LIFES_BenStatus   = 'T' THEN LIFES_BenStopDate ELSE CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFES_BenStartDate , @FileMinCovDate), 112) END
        ,drvEffectiveDate9 = CASE WHEN LIFES_DedCode is not null AND LIFES_BenStatus   = 'T' THEN 'TM' ELSE 'EN' END
        ,drvEligibilityEvent9 = CASE WHEN LIFES_DedCode is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFES_BenStartDate , @FileMinCovDate), 112) END
        ,drvPlanID9 = CASE WHEN LIFES_DedCode is not null THEN  'BTA0CSPVAL' END
        ,drvFamilyCoverageIndicator9 = CASE WHEN LIFES_DedCode is not null THEN 'C' END
        ,drvApprovedAmountEffDate9 = CASE WHEN LIFES_DedCode is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', LIFES_BenStartDate , @FileMinCovDate), 112) END 
        ,drvapprovedAmt9 = CASE WHEN LIFES_DedCode is not null THEN LIFES_BenAmt END
    INTO dbo.U_ECONMOOEXP_drvTbl
    FROM dbo.U_ECONMOOEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
                
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADD'   THEN BdmDedCode END) AS ADD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD'   THEN BdmDedCode END) AS LTD_DedCode

                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD'   THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode    
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStatus END) AS GLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADD'   THEN BdmBenStatus END) AS ADD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LTD'   THEN BdmBenStatus END) AS LTD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStatus END) AS LIFEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD'   THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStatus END) AS LIFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStatus END) AS LIFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS GLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADD'   THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS ADD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD'   THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS LTD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS LIFEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD'   THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS LIFES_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS LIFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS GLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADD'   THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS ADD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD'   THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS LTD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS LIFEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'STD'   THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS STD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS LIFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112)  END) AS LIFEC_BenStopDate
              
                ,MAX(CASE WHEN BdmDedCode IN ('GLIFE','ADD','LTD','STD','LIFES','LIFEC','LIFEE') THEN BdmDedCode END) AS ALL_DedCode
            
                ,MAX(CASE WHEN BdmDedCode IN ('GLIFE','ADD','LTD','STD','LIFES','LIFEC','LIFEE') THEN BdmBenStatus END) AS ALL_BenStatus
             
                ,MAX(CASE WHEN BdmDedCode IN ('GLIFE','ADD','LTD','STD','LIFES','LIFEC','LIFEE') THEN CONVERT(VARCHAR(8),BdmBenStartDate, 112) END) AS ALL_BenStartDate       
           
                ,MAX(CASE WHEN BdmDedCode IN ('GLIFE','ADD','LTD','STD','LIFES','LIFEC','LIFEE') THEN CONVERT(VARCHAR(8),DATEADD(DAY, +1,BdmBenStopDate), 112) END) AS ALL_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN FORMAT(GLIFE_BenAmt, '0000000000') END ) as GLIFE_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN FORMAT( LIFES_BenAmt, '0000000000') END ) LIFES_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN FORMAT(LIFEC_BenAmt , '0000000000')END) AS LIFEC_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN FORMAT(LIFEE_BenAmt, '0000000000') END) AS LIFEE_BenAmt
            FROM dbo.U_dsi_BDM_ECONMOOEXP WITH (NOLOCK)
        LEFT JOIN (SELECT EdhEEID, EdhCOID
                    ,MAX(CASE WHEN EdhDedCode = 'GLIFE' THEN EdhEEBenAmt END) AS GLIFE_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEE' THEN EdhEEBenAmt END) AS LIFEE_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFES' THEN EdhEEBenAmt END) AS LIFES_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEC' THEN EdhEEBenAmt END) AS LIFEC_BenAmt
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt
                        FROM (
                                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDate DESC) AS RN
                                FROM dbo.EmpHDed WITH (NOLOCK) 
                                WHERE EdhDedCode IN ('GLIFE', 'LIFEE', 'LIFES', 'LIFEC') 
                                    AND EdhBenStatus = 'A') AS T
                WHERE RN = 1) AS Y
                      GROUP BY EdhEEID, EdhCOID
            ) AS BenAmount
        ON EdhEEID = BdmEEID
        AND EdhCOID = BdmCOID
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN ( 
      select StandardPrimaryKeyString1 AS GFEEID,StandardPrimaryKeyString2, BooleanValue AS GFStatus, Max(Effective) As CreateDate 
         FROM MetaObject mo (NOLOCK)
        JOIN MetaFieldValue mfv (NOLOCK) ON mfv.ObjectId = mo.Id 
        WHERE mo.ClassUniqueId = 'SEmployment'
    and fielduniqueid = '_BGrandfartheredStatus'

    Group by  StandardPrimaryKeyString1,StandardPrimaryKeyString2 ,BooleanValue


    ) GF
    ON GFEEID =  XEEID
    LEFT JOIN dbo.U_ECONMOOEXP_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
    WHERE  EecEEType NOT IN ('TES')
    and (EecEmplStatus  <> 'T' OR (EecEmplStatus = 'T' and EecTermreason <> 'TRO' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN DATEADD(DAY, -7, @StartDate) AND @EndDate))
    ;
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
ALTER VIEW dbo.dsi_vwECONMOOEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECONMOOEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECONMOOEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202305161'
       ,expStartPerControl     = '202305161'
       ,expLastEndPerControl   = '202305239'
       ,expEndPerControl       = '202305239'
WHERE expFormatCode = 'ECONMOOEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECONMOOEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECONMOOEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECONMOOEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECONMOOEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECONMOOEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECONMOOEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECONMOOEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECONMOOEXP', 'UseFileName', 'V', 'Y'


-- End ripout