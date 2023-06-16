/**********************************************************************************

ESANMOOEXP: Mutual of Omaha Life Disability Export

FormatCode:     ESANMOOEXP
Project:        Mutual of Omaha Life Disability Export
Client ID:      SAN1003
Date/time:      2023-06-11 17:56:04.563
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N24
Server:         N2SUP4DB02
Database:       ULTIPRO_MSDCC
Web Filename:   SAN1003_26551_EEHISTORY_ESANMOOEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

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

IF OBJECT_ID('dsi_vwESANMOOEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESANMOOEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESANMOOEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESANMOOEXP];
GO
IF OBJECT_ID('U_ESANMOOEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_File];
GO
IF OBJECT_ID('U_ESANMOOEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_EEList];
GO
IF OBJECT_ID('U_ESANMOOEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_drvTbl];
GO
IF OBJECT_ID('U_ESANMOOEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_DedList];
GO
IF OBJECT_ID('U_ESANMOOEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_AuditFields];
GO
IF OBJECT_ID('U_ESANMOOEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESANMOOEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESANMOOEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESANMOOEXP];
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
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESANMOOEXPZ0','10','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESANMOOEXPZ0','35','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESANMOOEXPZ0','15','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESANMOOEXPZ0','11','D','10','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESANMOOEXPZ0','1','D','10','8',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESANMOOEXPZ0','8','D','10','9',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESANMOOEXPZ0','11','D','10','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESANMOOEXPZ0','30','D','10','11',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESANMOOEXPZ0','10','D','10','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESANMOOEXPZ0','30','D','10','13',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESANMOOEXPZ0','50','D','10','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESANMOOEXPZ0','19','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESANMOOEXPZ0','2','D','10','16',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESANMOOEXPZ0','11','D','10','17',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESANMOOEXPZ0','48','D','10','18',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESANMOOEXPZ0','8','D','10','19',NULL,'Date of Hire (DOH)',NULL,NULL,'"drvDateofHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESANMOOEXPZ0','8','D','10','20',NULL,'Employee Effective Date',NULL,NULL,'"drvEmployeeEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESANMOOEXPZ0','68','D','10','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESANMOOEXPZ0','8','D','10','22',NULL,'Bill Group Effective Date',NULL,NULL,'"drvBillGroupEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESANMOOEXPZ0','4','D','10','23',NULL,'Bill Group ID',NULL,NULL,'"drvBillGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESANMOOEXPZ0','70','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESANMOOEXPZ0','8','D','10','25',NULL,'Basic Salary Effective Date',NULL,NULL,'"drvBasicSalaryEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESANMOOEXPZ0','1','D','10','26',NULL,'Basic Salary Mode',NULL,NULL,'"drvBasicSalaryMode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESANMOOEXPZ0','16','D','10','27',NULL,'Basic Salary Amount',NULL,NULL,'"drvBasicSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESANMOOEXPZ0','108','D','10','28',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESANMOOEXPZ0','8','D','10','29',NULL,'1st Additional Compensation Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESANMOOEXPZ0','4','D','10','30',NULL,'1st Additional Compensation Mode',NULL,NULL,'"drvClassID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESANMOOEXPZ0','135','D','10','31',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESANMOOEXPZ0','1','D','10','32',NULL,'1st Additional Compensation Type',NULL,NULL,'"drvProductCategory1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESANMOOEXPZ0','8','D','10','33',NULL,'1st Additional Compensation Amount',NULL,NULL,'"drvEffectiveDate1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESANMOOEXPZ0','2','D','10','34',NULL,'2nd Additional Compensation Effective Date',NULL,NULL,'"drvEligibilityEvent1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESANMOOEXPZ0','10','D','10','35',NULL,'2nd Additional Compensation Mode',NULL,NULL,'"drvPlanID1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESANMOOEXPZ0','1','D','10','36',NULL,'2nd Additional Compensation Type',NULL,NULL,'"drvFamilyCoverageIndicator1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESANMOOEXPZ0','33','D','10','37',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESANMOOEXPZ0','1','D','10','38',NULL,'2nd Additional Compensation Amount',NULL,NULL,'"drvProductCategory2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESANMOOEXPZ0','8','D','10','39',NULL,'3rd Additional Compensation Effective Date',NULL,NULL,'"drvEffectiveDate2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESANMOOEXPZ0','2','D','10','40',NULL,'3rd Additional Compensation Mode',NULL,NULL,'"drvEligibilityEvent2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESANMOOEXPZ0','10','D','10','41',NULL,'3rd Additional Compensation Type',NULL,NULL,'"drvPlanID2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESANMOOEXPZ0','1','D','10','42',NULL,'3rd Additional Compensation Amount',NULL,NULL,'"drvFamilyCoverageIndicator2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESANMOOEXPZ0','33','D','10','43',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESANMOOEXPZ0','1','D','10','44',NULL,'4th Additional Compensation Effective Date',NULL,NULL,'"drvProductCategory3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESANMOOEXPZ0','8','D','10','45',NULL,'4th Additional Compensation Mode',NULL,NULL,'"drvEffectiveDate3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESANMOOEXPZ0','2','D','10','46',NULL,'4th Additional Compensation Type',NULL,NULL,'"drvEligibilityEvent3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESANMOOEXPZ0','10','D','10','47',NULL,'4th Additional Compensation Amount',NULL,NULL,'"drvPlanID3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESANMOOEXPZ0','1','D','10','48',NULL,'Class Effective Date',NULL,NULL,'"drvFamilyCoverageIndicator3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESANMOOEXPZ0','33','D','10','49',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESANMOOEXPZ0','1','D','10','50',NULL,'Class ID',NULL,NULL,'"drvProductCategory4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESANMOOEXPZ0','8','D','10','51',NULL,'Filler',NULL,NULL,'"drvEffectiveDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESANMOOEXPZ0','2','D','10','52',NULL,'Product Category',NULL,NULL,'"drvEligibilityEvent4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESANMOOEXPZ0','10','D','10','53',NULL,'Effective Date',NULL,NULL,'"drvPlanID4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESANMOOEXPZ0','1','D','10','54',NULL,'Eligibility Event',NULL,NULL,'"drvFamilyCoverageIndicator4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESANMOOEXPZ0','4','D','10','55',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESANMOOEXPZ0','8','D','10','56',NULL,'Plan ID',NULL,NULL,'"drvApprovedAmtEffectiveDate4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESANMOOEXPZ0','10','D','10','57',NULL,'Family Coverage Indicator',NULL,NULL,'"drvApprovedAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESANMOOEXPZ0','11','D','10','58',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESANMOOEXPZ0','1','D','10','59',NULL,'Product Category',NULL,NULL,'"drvProductCategory5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESANMOOEXPZ0','8','D','10','60',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESANMOOEXPZ0','2','D','10','61',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESANMOOEXPZ0','10','D','10','62',NULL,'Plan ID',NULL,NULL,'"drvPlanID5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESANMOOEXPZ0','1','D','10','63',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESANMOOEXPZ0','4','D','10','64',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESANMOOEXPZ0','8','D','10','65',NULL,'Product Category',NULL,NULL,'"drvApprovedAmtEffectiveDate5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESANMOOEXPZ0','10','D','10','66',NULL,'Effective Date',NULL,NULL,'"drvApprovedAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESANMOOEXPZ0','11','D','10','67',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESANMOOEXPZ0','1','D','10','68',NULL,'Eligibility Event',NULL,NULL,'"drvProductCategory6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESANMOOEXPZ0','8','D','10','69',NULL,'Plan ID',NULL,NULL,'"drvEffectiveDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESANMOOEXPZ0','2','D','10','70',NULL,'Family Coverage Indicator',NULL,NULL,'"drvEligibilityEvent6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESANMOOEXPZ0','10','D','10','71',NULL,'Filler',NULL,NULL,'"drvPlanID6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESANMOOEXPZ0','1','D','10','72',NULL,'Product Category',NULL,NULL,'"drvFamilyCoverageIndicator6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESANMOOEXPZ0','4','D','10','73',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESANMOOEXPZ0','8','D','10','74',NULL,'Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESANMOOEXPZ0','10','D','10','75',NULL,'Eligibility Event',NULL,NULL,'"drvApprovedAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESANMOOEXPZ0','11','D','10','76',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESANMOOEXPZ0','1','D','10','77',NULL,'Product Category',NULL,NULL,'"drvProductCategory7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESANMOOEXPZ0','8','D','10','78',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESANMOOEXPZ0','2','D','10','79',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESANMOOEXPZ0','10','D','10','80',NULL,'Plan ID',NULL,NULL,'"drvPlanID7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESANMOOEXPZ0','1','D','10','81',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESANMOOEXPZ0','4','D','10','82',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESANMOOEXPZ0','8','D','10','83',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESANMOOEXPZ0','10','D','10','84',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ESANMOOEXPZ0','11','D','10','85',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ESANMOOEXPZ0','1','D','10','86',NULL,'Product Category',NULL,NULL,'"drvProductCategory8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ESANMOOEXPZ0','8','D','10','87',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ESANMOOEXPZ0','2','D','10','88',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ESANMOOEXPZ0','10','D','10','89',NULL,'Plan ID',NULL,NULL,'"drvPlanID8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ESANMOOEXPZ0','1','D','10','90',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ESANMOOEXPZ0','4','D','10','91',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ESANMOOEXPZ0','8','D','10','92',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ESANMOOEXPZ0','10','D','10','93',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ESANMOOEXPZ0','11','D','10','94',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ESANMOOEXPZ0','1','D','10','95',NULL,'Product Category',NULL,NULL,'"drvProductCategory9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ESANMOOEXPZ0','8','D','10','96',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ESANMOOEXPZ0','2','D','10','97',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ESANMOOEXPZ0','10','D','10','98',NULL,'Plan ID',NULL,NULL,'"drvPlanID9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ESANMOOEXPZ0','1','D','10','99',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ESANMOOEXPZ0','4','D','10','100',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ESANMOOEXPZ0','8','D','10','101',NULL,'Approved Amount Effective Date',NULL,NULL,'"drvApprovedAmtEffectiveDate9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ESANMOOEXPZ0','10','D','10','102',NULL,'Approved Amount',NULL,NULL,'"drvApprovedAmount9"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ESANMOOEXPZ0','11','D','10','103',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ESANMOOEXPZ0','1','D','10','104',NULL,'Product Category',NULL,NULL,'"drvProductCategory10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ESANMOOEXPZ0','8','D','10','105',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ESANMOOEXPZ0','2','D','10','106',NULL,'Eligibility Event',NULL,NULL,'"drvEligibilityEvent10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ESANMOOEXPZ0','10','D','10','107',NULL,'Plan ID',NULL,NULL,'"drvPlanID10"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ESANMOOEXPZ0','1','D','10','108',NULL,'Family Coverage Indicator',NULL,NULL,'"drvFamilyCoverageIndicator10"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESANMOOEXP_20230611.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202306119','EMPEXPORT','OEACTIVE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202306119','Jun 11 2023  5:51PM','Jun 11 2023  5:51PM','202306111',NULL,'','','202306111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202306119','EMPEXPORT','OEPASSIVE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202306119','Jun 11 2023  5:51PM','Jun 11 2023  5:51PM','202306111',NULL,'','','202306111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Disabilit','202306119','EMPEXPORT','ONDEM_XOE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202306119','Jun 11 2023  5:51PM','Jun 11 2023  5:51PM','202306111',NULL,'','','202306111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Sched','202306119','EMPEXPORT','SCH_ESANMO',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202306119','Jun 11 2023  5:51PM','Jun 11 2023  5:51PM','202306111',NULL,'','','202306111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Mutual of Omaha Life Dis-Test','202306119','EMPEXPORT','TEST_XOE',NULL,'ESANMOOEXP',NULL,NULL,NULL,'202306119','Jun 11 2023  5:51PM','Jun 11 2023  5:51PM','202306111',NULL,'','','202306111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESANMOOEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESANMOOEXP','D10','dbo.U_ESANMOOEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESANMOOEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ESANMOOEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESANMOOEXP] (
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
-- Create table U_ESANMOOEXP_Audit
-----------

IF OBJECT_ID('U_ESANMOOEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_Audit] (
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
-- Create table U_ESANMOOEXP_AuditFields
-----------

IF OBJECT_ID('U_ESANMOOEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESANMOOEXP_DedList
-----------

IF OBJECT_ID('U_ESANMOOEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESANMOOEXP_drvTbl
-----------

IF OBJECT_ID('U_ESANMOOEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTransDate] varchar(8) NULL,
    [drvGroupID] varchar(8) NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] varchar(24) NULL,
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
    [drvClassEffectiveDate] varchar(8) NULL,
    [drvClassID] varchar(4) NOT NULL,
    [drvProductCategory1] varchar(1) NULL,
    [drvEffectiveDate1] varchar(8) NULL,
    [drvEligibilityEvent1] varchar(2) NULL,
    [drvPlanID1] varchar(10) NULL,
    [drvFamilyCoverageIndicator1] varchar(1) NULL,
    [drvProductCategory2] varchar(1) NULL,
    [drvEffectiveDate2] varchar(8) NULL,
    [drvEligibilityEvent2] varchar(2) NULL,
    [drvPlanID2] varchar(10) NULL,
    [drvFamilyCoverageIndicator2] varchar(1) NULL,
    [drvProductCategory3] varchar(1) NULL,
    [drvEffectiveDate3] varchar(8) NULL,
    [drvEligibilityEvent3] varchar(2) NULL,
    [drvPlanID3] varchar(10) NULL,
    [drvFamilyCoverageIndicator3] varchar(1) NULL,
    [drvProductCategory4] varchar(1) NULL,
    [drvEffectiveDate4] varchar(8) NULL,
    [drvEligibilityEvent4] varchar(2) NULL,
    [drvPlanID4] varchar(10) NULL,
    [drvFamilyCoverageIndicator4] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate4] varchar(8) NULL,
    [drvApprovedAmount4] nvarchar(4000) NULL,
    [drvProductCategory5] varchar(1) NULL,
    [drvEffectiveDate5] varchar(8) NULL,
    [drvEligibilityEvent5] varchar(2) NULL,
    [drvPlanID5] varchar(10) NULL,
    [drvFamilyCoverageIndicator5] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate5] varchar(8) NULL,
    [drvApprovedAmount5] nvarchar(4000) NULL,
    [drvProductCategory6] varchar(1) NULL,
    [drvEffectiveDate6] varchar(8) NULL,
    [drvEligibilityEvent6] varchar(2) NULL,
    [drvPlanID6] varchar(10) NULL,
    [drvFamilyCoverageIndicator6] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate6] varchar(8) NULL,
    [drvApprovedAmount6] varchar(10) NULL,
    [drvProductCategory7] varchar(1) NULL,
    [drvEffectiveDate7] varchar(8) NULL,
    [drvEligibilityEvent7] varchar(2) NULL,
    [drvPlanID7] varchar(10) NULL,
    [drvFamilyCoverageIndicator7] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate7] varchar(8) NULL,
    [drvApprovedAmount7] nvarchar(4000) NULL,
    [drvProductCategory8] varchar(1) NULL,
    [drvEffectiveDate8] varchar(8) NULL,
    [drvEligibilityEvent8] varchar(2) NULL,
    [drvPlanID8] varchar(10) NULL,
    [drvFamilyCoverageIndicator8] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate8] varchar(8) NULL,
    [drvApprovedAmount8] nvarchar(4000) NULL,
    [drvProductCategory9] varchar(1) NULL,
    [drvEffectiveDate9] varchar(8) NULL,
    [drvEligibilityEvent9] varchar(2) NULL,
    [drvPlanID9] varchar(10) NULL,
    [drvFamilyCoverageIndicator9] varchar(1) NULL,
    [drvApprovedAmtEffectiveDate9] varchar(8) NULL,
    [drvApprovedAmount9] nvarchar(4000) NULL,
    [drvProductCategory10] varchar(1) NULL,
    [drvEffectiveDate10] varchar(8) NULL,
    [drvEligibilityEvent10] varchar(2) NULL,
    [drvPlanID10] varchar(10) NULL,
    [drvFamilyCoverageIndicator10] varchar(1) NULL
);

-----------
-- Create table U_ESANMOOEXP_EEList
-----------

IF OBJECT_ID('U_ESANMOOEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESANMOOEXP_File
-----------

IF OBJECT_ID('U_ESANMOOEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESANMOOEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
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
    INSERT INTO dbo.U_ESANMOOEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
      INSERT INTO dbo.U_ESANMOOEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
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
    SET @DedList = 'GTLER,DEPER,LTDER,LTDEX,GVLEE,GVLSP,GVLCH,ADDEM,ADDSP,ADDCH';  --20230413 KAE REMOVED 'ADDEE'

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
        ,drvTransDate = CONVERT(VARCHAR(8),@Rundate, 112)
        ,drvGroupID = 'G000AZNK'
        ,drvRelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN 'M' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ISNULL(ConGender,'') IN ( 'M', '')THEN 'H' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('SPS','DOP') AND ConGender = 'F' THEN 'W' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ISNULL(ConGender, '') IN ( 'M', '') THEN 'S'
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConGender = 'F' THEN 'D' 
                                    WHEN BdmRecType = 'DEP'  AND  ConRelationship IN ('CHA','CHD','CHL', 'STC')  AND ConIsDisabled ='Y' AND (SELECT FLOOR(DATEDIFF(DAY, GetDate() , ConDateofbirth) / 365.25)) >=  26 THEN 'Y'
                                    ELSE 'I' 
                                END
        ,drvEmployeeID = dbo.dsi_fnpadzero(EepSSN, 9, 0)
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
        ,drvBillGroupEffectiveDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', All_BenStartDate , @FileMinCovDate), 112) 
        ,drvBillGroupID = '0001'
        ,drvBasicSalaryEffectiveDate =  CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @FileMinCovDate, eecDateOfLastHire), 112) 
        ,drvBasicSalaryMode = 'A'
        ,drvBasicSalaryAmount = Format(EecAnnSalary, '0000000000000000')
        ,drvClassEffectiveDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', ALL_BenStartDate , @FileMinCovDate), 112) 
        ,drvClassID = 'A001'
        ,drvProductCategory1 = CASE WHEN GTLER_DedCode Is not null THEN '1' END
        ,drvEffectiveDate1 = CASE WHEN GTLER_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GTLER_BenStatus = 'T' THEN DATEADD(DAY, +1, GTLER_BenStopDate) ELSE GTLER_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent1 = CASE WHEN GTLER_DedCode Is not null and GTLER_BenStatus IN ('C','T') THEN 'TM' WHEN GTLER_DedCode Is not null  and GTLER_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID1 = CASE WHEN GTLER_DedCode Is not null THEN 'LTL00NCSAL' END
        ,drvFamilyCoverageIndicator1 = CASE WHEN GTLER_DedCode Is not null THEN 'C' END
        ,drvProductCategory2 = CASE WHEN ADDEM_DedCode Is not null THEN 'a' END
        ,drvEffectiveDate2 = CASE WHEN ADDEM_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDEM_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDEM_BenStopDate) ELSE ADDEM_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent2 = CASE WHEN ADDEM_DedCode Is not null and ADDEM_BenStatus IN ('C','T') THEN 'TM' WHEN ADDEM_DedCode Is not null  and ADDEM_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID2 = CASE WHEN ADDEM_DedCode Is not null THEN 'ATA00NCSAL' END
        ,drvFamilyCoverageIndicator2 = CASE WHEN ADDEM_DedCode Is not null THEN 'C' END
        ,drvProductCategory3 = CASE WHEN LTD_DedCode Is not null  THEN 'T' END
        ,drvEffectiveDate3 = CASE WHEN LTD_DedCode Is not null THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LTD_BenStatus = 'T' THEN DATEADD(DAY, +1, LTD_BenStopDate) ELSE LTD_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent3 =  CASE WHEN LTD_DedCode Is not null and LTD_BenStatus IN ('C','T') THEN 'TM' WHEN LTD_DedCode Is not null  and LTD_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID3 = CASE WHEN LTD_DedCode Is not null THEN 'TTT00NCSAL' END
        ,drvFamilyCoverageIndicator3 = CASE WHEN LTD_DedCode Is not null THEN 'C' END
        ,drvProductCategory4 = CASE WHEN GVLEE_DedCode Is not null THEN '3' END
        ,drvEffectiveDate4 = CASE WHEN GVLEE_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLEE_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLEE_BenStopDate) ELSE GVLEE_BenStartDate END, @FileMinCovDate), 112)END
        ,drvEligibilityEvent4 = CASE WHEN GVLEE_DedCode Is not null and GVLEE_BenStatus IN ('C','T') THEN 'TM' WHEN GVLEE_DedCode Is not null  and GVLEE_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID4 = CASE WHEN GVLEE_DedCode Is not null THEN 'ETL0CEEVAL' END
        ,drvFamilyCoverageIndicator4 = CASE WHEN GVLEE_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate4 = CASE WHEN GVLEE_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',  GVLEE_BenStartDate , @FileMinCovDate), 112) END
        ,drvApprovedAmount4 = CASE WHEN GVLEE_DedCode Is not null THEN FORMAT(GVLEE_BenAmt, '0000000000') END
        ,drvProductCategory5 = CASE WHEN GVLSP_DedCode Is not null THEN '4' END
        ,drvEffectiveDate5 = CASE WHEN GVLSP_DedCode Is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLSP_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLSP_BenStopDate) ELSE GVLSP_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent5 = CASE WHEN GVLSP_DedCode Is not null and GVLSP_BenStatus IN ('C','T') THEN 'TM' WHEN GVLSP_DedCode Is not null  and GVLSP_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID5 = CASE WHEN GVLSP_DedCode Is not null THEN 'ETL0CSPVAL' END
        ,drvFamilyCoverageIndicator5 = CASE WHEN GVLSP_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate5 = CASE WHEN GVLSP_DedCode Is not null THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX',  GVLSP_BenStartDate , @FileMinCovDate),112) END
        ,drvApprovedAmount5 =  CASE WHEN GVLSP_DedCode Is not null THEN FORMAT(GVLSP_BenAmt, '0000000000') END
        ,drvProductCategory6 =CASE WHEN GVLCH_DedCode Is not null THEN  '5' END
        ,drvEffectiveDate6 = CASE WHEN GVLCH_DedCode Is not null THEN  CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN GVLCH_BenStatus = 'T' THEN DATEADD(DAY, +1, GVLCH_BenStopDate) ELSE GVLCH_BenStartDate END, @FileMinCovDate),112) END
        ,drvEligibilityEvent6 = CASE WHEN GVLCH_DedCode Is not null and GVLCH_BenStatus IN ('C','T') THEN 'TM' WHEN GVLCH_DedCode Is not null  and GVLCH_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID6 = CASE WHEN GVLCH_DedCode Is not null THEN 'ETL0CDPVAL' END
        ,drvFamilyCoverageIndicator6 = CASE WHEN GVLCH_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate6 = CASE WHEN GVLCH_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',  GVLCH_BenStartDate , @FileMinCovDate),112)  END
        ,drvApprovedAmount6 = CASE WHEN GVLCH_DedCode Is not null THEN GVLCH_BenAmt END
        ,drvProductCategory7 = CASE WHEN ADDEM_BenStatus is not null THEN 'c'END   --20230413 KAE REMOVED 'ADDEE'
        ,drvEffectiveDate7 = CASE WHEN ADDEM_BenStatus is not null THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDEM_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDEM_BenStopDate) ELSE ADDEM_BenStartDate END, @FileMinCovDate), 112)END   --20230413 KAE REMOVED 'ADDEE'
        ,drvEligibilityEvent7 = CASE WHEN ADDEM_DedCode Is not null and ADDEM_BenStatus IN ('C','T') THEN 'TM' WHEN ADDEM_DedCode Is not null  and ADDEM_BenStatus NOT IN ('C','T') THEN  'EN' END  --20230413 KAE REMOVED 'ADDEE'
        ,drvPlanID7 = CASE WHEN ADDEM_DedCode Is not null THEN 'ETL0CEEVAL' END  --20230413 KAE REMOVED 'ADDEE'
        ,drvFamilyCoverageIndicator7 =CASE WHEN ADDEM_DedCode Is not null THEN  'C' END   --20230413 KAE REMOVED 'ADDEE'
        ,drvApprovedAmtEffectiveDate7 =  CASE WHEN ADDEM_DedCode Is not null THEN CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',  ADDEM_BenStartDate , @FileMinCovDate) , 112) END  --20230413 KAE REMOVED 'ADDEE'
        ,drvApprovedAmount7 = CASE WHEN ADDEM_DedCode Is not null THEN FORMAT(ADDEM_BenAmt, '0000000000') END  --20230413 KAE REMOVED 'ADDEE'
        ,drvProductCategory8 =  CASE WHEN ADDSP_DedCode Is not null THEN 'e' END
        ,drvEffectiveDate8 = CASE WHEN ADDSP_DedCode Is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDSP_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDSP_BenStopDate) ELSE ADDSP_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent8 = CASE WHEN ADDSP_DedCode Is not null and ADDSP_BenStatus IN ('C','T') THEN 'TM' WHEN ADDSP_DedCode Is not null  and ADDSP_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID8 = CASE WHEN ADDSP_DedCode Is not null THEN 'ETL0CSPVAL' END
        ,drvFamilyCoverageIndicator8 = CASE WHEN ADDSP_DedCode Is not null  THEN 'C' END
        ,drvApprovedAmtEffectiveDate8 = CASE WHEN ADDSP_DedCode Is not null  THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',  ADDSP_BenStartDate , @FileMinCovDate),112) END
        ,drvApprovedAmount8 = CASE WHEN ADDSP_DedCode Is not null  THEN FORMAT(ADDSP_BenAmt, '0000000000') END
        ,drvProductCategory9 =  CASE WHEN ADDCH_DedCode Is not null THEN 'd' END
        ,drvEffectiveDate9 =CASE WHEN ADDCH_DedCode Is not null  THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN ADDCH_BenStatus = 'T' THEN DATEADD(DAY, +1, ADDCH_BenStopDate) ELSE ADDCH_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent9 = CASE WHEN ADDCH_DedCode Is not null and ADDCH_BenStatus IN ('C','T') THEN 'TM' WHEN ADDCH_DedCode Is not null  and ADDCH_BenStatus NOT IN ('C','T') THEN  'EN' END
        ,drvPlanID9 = CASE WHEN ADDCH_DedCode Is not null THEN 'ETL0CDPVAL' END
        ,drvFamilyCoverageIndicator9 = CASE WHEN ADDCH_DedCode Is not null THEN 'C' END
        ,drvApprovedAmtEffectiveDate9 = CASE WHEN ADDCH_DedCode Is not null THEN  CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',  ADDCH_BenStartDate , @FileMinCovDate), 112) END
        ,drvApprovedAmount9 = CASE WHEN ADDCH_DedCode Is not null  THEN FORMAT(ADDCH_BenAmt, '0000000000') END
        ,drvProductCategory10 = CASE WHEN DEPER_DedCode is not null THEN '6' END
        ,drvEffectiveDate10 = CASE WHEN DEPER_DedCode Is not null  THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN DEPER_BenStatus = 'T' THEN DATEADD(DAY, +1, DEPER_BenStopDate) ELSE DEPER_BenStartDate END, @FileMinCovDate), 112) END
        ,drvEligibilityEvent10 = CASE WHEN DEPER_DedCode Is not null  and DEPER_BenStatus IN ('C','T') THEN 'TM' WHEN DEPER_DedCode Is not null  and DEPER_BenStatus NOT IN ('C','T') THEN  'EN' END
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
                --,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmDedCode END) AS ADDEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmDedCode END) AS ADDEM_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmDedCode END) AS ADDSP_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmDedCode END) AS ADDCH_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmDedCode END) AS ALL_DedCode
                --,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStatus END) AS ADDEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStatus END) AS ADDEM_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStatus END) AS ADDSP_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStatus END) AS ADDCH_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmBenStatus END) AS ALL_BenStatus
                --,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStartDate END) AS ADDEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStartDate END) AS ADDEM_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStartDate END) AS ADDSP_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStartDate END) AS ADDCH_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH', 'ADDEE') THEN BdmBenStartDate END) AS ALL_BenStartDate
       
                --,MAX(CASE WHEN BdmDedCode = 'ADDEE' THEN BdmBenStopDate END) AS ADDEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmBenStopDate END) AS ADDEM_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmBenStopDate END) AS ADDSP_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmBenStopDate END) AS ADDCH_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('GTLER','DEPER','LTDER','LTDEX','GVLEE','GVLSP','GVLCH','ADDEM','ADDSP','ADDCH','ADDEE') THEN BdmBenStopDate END) AS ALL_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'ADDEM' THEN BdmEEAmt END) AS ADDEM_BenAmt
                --,MAX(CASE WHEN BdmDedCode = 'ADDSP' THEN BdmEEAmt END) AS ADDSP_BenAmt
                --,MAX(CASE WHEN BdmDedCode = 'ADDCH' THEN BdmEEAmt END) AS ADDCH_BenAmt
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
                    ,MAX(CASE WHEN EdhDedCode = 'GVLCH' AND EdhBenOption = '2K' THEN '0000002000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='3K' THEN '0000003000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='4K' THEN '0000004000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption = '5K' THEN '0000005000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='6K' THEN '0000006000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='7K' THEN '0000007000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='8K' THEN '0000008000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='9K' THEN '0000009000'
                              WHEN EdhDedCode = 'GVLCH' AND EdhBenOption ='10K' THEN '0000010000' END) AS GVLCH_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'ADDEM' THEN EdhEEBenAmt END) AS ADDEM_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'ADDSP' THEN EdhEEBenAmt END) AS ADDSP_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'ADDCH' THEN EdhEEBenAmt END) AS ADDCH_BenAmt
                    --,MAX(CASE WHEN EdhDedCode = 'ADDEE' THEN EdhEEBenAmt END) AS ADDEE_BenAmt
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode,EdhBenOption, EdhEEBenAmt
                        FROM (
                                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, EdhBenOption, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDate DESC) AS RN
                                FROM dbo.EmpHDed WITH (NOLOCK) 
                                WHERE EdhDedCode IN ('GVLEE', 'GVLSP', 'GVLCH','ADDEM','ADDSP','ADDCH') 
                                    AND EdhBenStatus = 'A') AS T
                WHERE RN = 1) AS Y
                
                  GROUP BY EdhEEID, EdhCOID
            ) AS BenAmount
        ON EdhEEID = xEEID
        AND EdhCOID = XCOID
    LEFT JOIN dbo.U_ESANMOOEXP_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
    WHERE  EecEEType IN ('FT', 'PT', 'REG', 'VHE')
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
CREATE VIEW dbo.dsi_vwESANMOOEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESANMOOEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

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