/**********************************************************************************

EIATMETEXP: MetLife Basic And Vol Export

FormatCode:     EIATMETEXP
Project:        MetLife Basic And Vol Export
Client ID:      IAT1000
Date/time:      2022-10-06 15:05:22.697
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATMETEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATMETEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATMETEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATMETEXP'


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
WHERE FormatCode = 'EIATMETEXP'
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
WHERE ExpFormatCode = 'EIATMETEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATMETEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATMETEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATMETEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATMETEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATMETEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATMETEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATMETEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATMETEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATMETEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATMETEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATMETEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATMETEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATMETEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATMETEXP];
GO
IF OBJECT_ID('U_EIATMETEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_Trailer];
GO
IF OBJECT_ID('U_EIATMETEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_Header];
GO
IF OBJECT_ID('U_EIATMETEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_File];
GO
IF OBJECT_ID('U_EIATMETEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_EEList];
GO
IF OBJECT_ID('U_EIATMETEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_drvTbl];
GO
IF OBJECT_ID('U_EIATMETEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIATMETEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EIATMETEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIATMETEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EIATMETEXP','MetLife Basic And Vol Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EIATMETEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETEXPZ0','1','H','01','1',NULL,'Transaction Code',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETEXPZ0','7','H','01','2',NULL,'Customer Number',NULL,NULL,'"9241091"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETEXPZ0','8','H','01','9',NULL,'File Creation Date',NULL,NULL,'"drvFileCreationDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATMETEXPZ0','1984','H','01','17',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETEXPZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL,'"E"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETEXPZ0','7','D','10','2',NULL,'Customer Number ',NULL,NULL,'"9241091"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETEXPZ0','11','D','10','9',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATMETEXPZ0','11','D','10','20',NULL,'Employee ID #',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATMETEXPZ0','9','D','10','31',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATMETEXPZ0','11','D','10','40',NULL,'Member SSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATMETEXPZ0','1','D','10','51',NULL,'Relationship Code',NULL,NULL,'"0"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATMETEXPZ0','20','D','10','52',NULL,'Member Last Name',NULL,NULL,'"drvMemberLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATMETEXPZ0','12','D','10','72',NULL,'Member First Name',NULL,NULL,'"drvMemberFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATMETEXPZ0','1','D','10','84',NULL,'Member Middle Initial',NULL,NULL,'"drvMemberMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATMETEXPZ0','8','D','10','85',NULL,'Member Birth Date',NULL,NULL,'"drvMemberBirthDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATMETEXPZ0','1','D','10','93',NULL,'Member’s Marital Status ',NULL,NULL,'"drvMemberMaritalstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATMETEXPZ0','1','D','10','94',NULL,'Member’s Sex',NULL,NULL,'"drvMemberSex"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATMETEXPZ0','8','D','10','95',NULL,'Employment Date',NULL,NULL,'"drvEmploymentDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATMETEXPZ0','8','D','10','103',NULL,'Retirement Date',NULL,NULL,'"drvRetirementDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATMETEXPZ0','10','D','10','111',NULL,'Home Telephone',NULL,NULL,'"drvHomeTelephone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIATMETEXPZ0','10','D','10','121',NULL,'Alternate Phone Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIATMETEXPZ0','1','D','10','131',NULL,'Alternate Phone Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIATMETEXPZ0','40','D','10','132',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIATMETEXPZ0','1','D','10','172',NULL,'Foreign Address Ind.',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIATMETEXPZ0','32','D','10','173',NULL,'Street Address 1',NULL,NULL,'"drvStreetAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIATMETEXPZ0','32','D','10','205',NULL,'Street Address 2',NULL,NULL,'"drvStreetAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIATMETEXPZ0','21','D','10','237',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIATMETEXPZ0','2','D','10','258',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIATMETEXPZ0','9','D','10','260',NULL,'Zip code',NULL,NULL,'"drvZipcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIATMETEXPZ0','9','D','10','269',NULL,'Annual Salary',NULL,NULL,'"drvAnnualsalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIATMETEXPZ0','8','D','10','278',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectivedate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIATMETEXPZ0','1','D','10','286',NULL,'Job Status Code ',NULL,NULL,'"drvJobStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIATMETEXPZ0','8','D','10','287',NULL,'Status Code Effective Date',NULL,NULL,'"drvStatusEffectiveDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIATMETEXPZ0','1','D','10','295',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIATMETEXPZ0','1','D','10','296',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIATMETEXPZ0','10','D','10','297',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIATMETEXPZ0','10','D','10','307',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIATMETEXPZ0','5','D','10','317',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIATMETEXPZ0','10','D','10','322',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EIATMETEXPZ0','2','D','10','332',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EIATMETEXPZ0','1','D','10','334',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EIATMETEXPZ0','8','D','10','335',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EIATMETEXPZ0','8','D','10','343',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EIATMETEXPZ0','8','D','10','351',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EIATMETEXPZ0','8','D','10','359',NULL,'Space Fill',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EIATMETEXPZ0','222','D','10','367',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EIATMETEXPZ0','2','D','10','589',NULL,'Coverage Type',NULL,NULL,'"drvCoverageType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EIATMETEXPZ0','8','D','10','591',NULL,'Coverage Start Date',NULL,NULL,'"drvCoverageStartDate1"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EIATMETEXPZ0','8','D','10','599',NULL,'Coverage Termination Date',NULL,NULL,'"drvCoverageterminationDate1"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EIATMETEXPZ0','7','D','10','607',NULL,'MetLife Group Number',NULL,NULL,'"drvMetLifeGroupNumber1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EIATMETEXPZ0','4','D','10','614',NULL,'MetLife Subdivision',NULL,NULL,'"drvMedLifeSubdivision1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EIATMETEXPZ0','4','D','10','618',NULL,'MetLife Branch',NULL,NULL,'"drvMetLifeBranch1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EIATMETEXPZ0','4','D','10','622',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EIATMETEXPZ0','1','D','10','622',NULL,'EnrollmentStatus',NULL,NULL,'"drvEnrollmentStatus1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EIATMETEXPZ0','9','D','10','626',NULL,'Multiple of Salary selected',NULL,NULL,'"drvMultipleSalarySelected1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EIATMETEXPZ0','3','D','10','635',NULL,'Coverage Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EIATMETEXPZ0','9','D','10','638',NULL,'Basic Life Face Amount',NULL,NULL,'"drvBasicLifeFaceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EIATMETEXPZ0','17','D','10','647',NULL,'Filler  ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EIATMETEXPZ0','1','D','10','647',NULL,'Basic Life – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EIATMETEXPZ0','10','D','10','664',NULL,'Basic Life - StarTrak Customer Num',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EIATMETEXPZ0','10','D','10','674',NULL,'Basic Life - StarTrak Reporting Loc Num',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EIATMETEXPZ0','58','D','10','684',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EIATMETEXPZ0','2','D','10','684',NULL,'Coverage Type',NULL,NULL,'"drvCoverageType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EIATMETEXPZ0','8','D','10','742',NULL,'Coverage Start Date',NULL,NULL,'"drvCoverageStartDate2"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EIATMETEXPZ0','8','D','10','750',NULL,'Coverage Termination Date',NULL,NULL,'"drvCoverageTerminationdate2"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EIATMETEXPZ0','7','D','10','758',NULL,'MetLife Group Number',NULL,NULL,'"drvMetLifeGroupNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EIATMETEXPZ0','4','D','10','765',NULL,'MetLife Subdivision',NULL,NULL,'"drvMetLifeSubdivision2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EIATMETEXPZ0','4','D','10','769',NULL,'MetLife Branch',NULL,NULL,'"MetLifeBranch2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EIATMETEXPZ0','4','D','10','773',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EIATMETEXPZ0','2','D','10','777',NULL,'Enrollment Status',NULL,NULL,'"drvEnrollmentStatus2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EIATMETEXPZ0','2','D','10','779',NULL,'OL Multiple of Salary',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EIATMETEXPZ0','3','D','10','781',NULL,'OL Cov Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EIATMETEXPZ0','9','D','10','784',NULL,'OL Face Amount',NULL,NULL,'"drvOLFaceAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EIATMETEXPZ0','17','D','10','793',NULL,'Filler  ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EIATMETEXPZ0','1','D','10','810',NULL,'OL – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EIATMETEXPZ0','10','D','10','811',NULL,'OL StarTrak Customer Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EIATMETEXPZ0','10','D','10','821',NULL,'OL StarTrak Reporting Location Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EIATMETEXPZ0','58','D','10','831',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EIATMETEXPZ0','2','D','10','831',NULL,'Coverage Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EIATMETEXPZ0','8','D','10','889',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EIATMETEXPZ0','8','D','10','897',NULL,'Coverage Termination Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EIATMETEXPZ0','7','D','10','905',NULL,'MetLife Group #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EIATMETEXPZ0','4','D','10','912',NULL,'MetLife Subdivision',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EIATMETEXPZ0','4','D','10','916',NULL,'MetLife Branch',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EIATMETEXPZ0','4','D','10','920',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EIATMETEXPZ0','1','D','10','924',NULL,'Enrollment Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EIATMETEXPZ0','2','D','10','925',NULL,'AD Multiple of Salary selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EIATMETEXPZ0','3','D','10','927',NULL,'AD Coverage Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EIATMETEXPZ0','9','D','10','930',NULL,'AD Face Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EIATMETEXPZ0','19','D','10','939',NULL,'Filler  ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EIATMETEXPZ0','1','D','10','958',NULL,'AD– Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EIATMETEXPZ0','10','D','10','959',NULL,'AD StarTrak Customer Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EIATMETEXPZ0','10','D','10','969',NULL,'AD StarTrak Reporting Location Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EIATMETEXPZ0','30','D','10','979',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EIATMETEXPZ0','2','D','10','1009',NULL,'Coverage Type',NULL,NULL,'"drvCovergeType3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EIATMETEXPZ0','8','D','10','1011',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'"drvCoverageStartDate3"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EIATMETEXPZ0','8','D','10','1019',NULL,'Coverage Termination Date',NULL,NULL,'"drvCoverageTerminationdate3"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EIATMETEXPZ0','7','D','10','1027',NULL,'MetLife Group Number',NULL,NULL,'"drvMetLifeGroupNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EIATMETEXPZ0','4','D','10','1034',NULL,'MetLife Subdivision',NULL,NULL,'"drvMetLifeSubdivisiondr3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EIATMETEXPZ0','4','D','10','1038',NULL,'MetLife Branch',NULL,NULL,'"drvMetlifeBranch3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EIATMETEXPZ0','4','D','10','1042',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EIATMETEXPZ0','1','D','10','1046',NULL,'Enrollment Status',NULL,NULL,'"drvEnrollmentStatus3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EIATMETEXPZ0','2','D','10','1047',NULL,'OA Multiple of Salary selected',NULL,NULL,'"drvOAMultipleSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EIATMETEXPZ0','3','D','10','1049',NULL,'OA Coverage Percentage selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EIATMETEXPZ0','9','D','10','1052',NULL,'OA Face Amount',NULL,NULL,'"drvOAFaceAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EIATMETEXPZ0','16','D','10','1061',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EIATMETEXPZ0','1','D','10','1077',NULL,'OA – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EIATMETEXPZ0','10','D','10','1078',NULL,'OA StarTrak Customer Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EIATMETEXPZ0','10','D','10','1088',NULL,'OA StarTrak Reporting Location Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EIATMETEXPZ0','30','D','10','1098',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EIATMETEXPZ0','2','D','10','1098',NULL,'Coverage Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EIATMETEXPZ0','8','D','10','1128',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EIATMETEXPZ0','8','D','10','1136',NULL,'Coverage Termination Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EIATMETEXPZ0','7','D','10','1144',NULL,'MetLife Group Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EIATMETEXPZ0','4','D','10','1151',NULL,'MetLife Subdivision',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EIATMETEXPZ0','4','D','10','1155',NULL,'MetLife Branch',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EIATMETEXPZ0','4','D','10','1159',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EIATMETEXPZ0','1','D','10','1163',NULL,'Enrollment Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EIATMETEXPZ0','2','D','10','1164',NULL,'Multiple of Salary selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EIATMETEXPZ0','3','D','10','1166',NULL,'Coverage Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EIATMETEXPZ0','9','D','10','1169',NULL,'VAD&D Face Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EIATMETEXPZ0','1','D','10','1178',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EIATMETEXPZ0','2','D','10','1179',NULL,'Voluntary AD&D Coverage Level',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EIATMETEXPZ0','16','D','10','1181',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EIATMETEXPZ0','1','D','10','1197',NULL,'Voluntary AD&D  – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EIATMETEXPZ0','10','D','10','1198',NULL,'VA StarTrak Customer #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EIATMETEXPZ0','10','D','10','1208',NULL,'VA StarTrak Reporting Location Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EIATMETEXPZ0','30','D','10','1218',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EIATMETEXPZ0','2','D','10','1248',NULL,'Coverage Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EIATMETEXPZ0','8','D','10','1250',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EIATMETEXPZ0','8','D','10','1258',NULL,'Coverage Termination Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EIATMETEXPZ0','7','D','10','1266',NULL,'MetLife Group #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EIATMETEXPZ0','4','D','10','1273',NULL,'MetLife Subdivision',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EIATMETEXPZ0','4','D','10','1277',NULL,'MetLife Branch',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EIATMETEXPZ0','4','D','10','1281',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EIATMETEXPZ0','1','D','10','1285',NULL,'Enrollment Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EIATMETEXPZ0','2','D','10','1286',NULL,'DL Multiple of Salary selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EIATMETEXPZ0','3','D','10','1288',NULL,'DL Coverage Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EIATMETEXPZ0','9','D','10','1291',NULL,'DL Face Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EIATMETEXPZ0','17','D','10','1300',NULL,'Filler  ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EIATMETEXPZ0','1','D','10','1317',NULL,'DL – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EIATMETEXPZ0','10','D','10','1318',NULL,'DL  StarTrak Customer Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EIATMETEXPZ0','10','D','10','1328',NULL,'DL StarTrak Reporting Location #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EIATMETEXPZ0','58','D','10','1338',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EIATMETEXPZ0','2','D','10','1396',NULL,'Coverage Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EIATMETEXPZ0','8','D','10','1398',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EIATMETEXPZ0','8','D','10','1406',NULL,'Coverage Termination Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EIATMETEXPZ0','7','D','10','1414',NULL,'MetLife Group #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EIATMETEXPZ0','4','D','10','1421',NULL,'MetLife Subdivision',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EIATMETEXPZ0','4','D','10','1425',NULL,'MetLife Branch',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EIATMETEXPZ0','4','D','10','1429',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EIATMETEXPZ0','1','D','10','1433',NULL,'DA Enrollment Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EIATMETEXPZ0','2','D','10','1434',NULL,'DA Multiple of Salary selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EIATMETEXPZ0','3','D','10','1436',NULL,'DA Coverage Percentage selected',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EIATMETEXPZ0','9','D','10','1439',NULL,'DA Face Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EIATMETEXPZ0','17','D','10','1448',NULL,'Filler  ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EIATMETEXPZ0','1','D','10','1465',NULL,'DA – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EIATMETEXPZ0','10','D','10','1466',NULL,'DA StarTrak Customer #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EIATMETEXPZ0','10','D','10','1476',NULL,'DA StarTrak Reporting Location Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EIATMETEXPZ0','30','D','10','1486',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EIATMETEXPZ0','2','D','10','1516',NULL,'Coverage Type',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EIATMETEXPZ0','8','D','10','1518',NULL,'Coverage Start/Eligibility Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EIATMETEXPZ0','8','D','10','1526',NULL,'Coverage Termination Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EIATMETEXPZ0','7','D','10','1534',NULL,'MetLife Group #',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EIATMETEXPZ0','4','D','10','1541',NULL,'MetLife Subdivision',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EIATMETEXPZ0','4','D','10','1545',NULL,'MetLife Branch',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EIATMETEXPZ0','4','D','10','1549',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EIATMETEXPZ0','1','D','10','1553',NULL,'Enrollment Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EIATMETEXPZ0','2','D','10','1554',NULL,'Multiple of Salary selected ',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EIATMETEXPZ0','9','D','10','1556',NULL,'UD Face Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EIATMETEXPZ0','17','D','10','1565',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EIATMETEXPZ0','5','D','10','1582',NULL,'Dependent GUL – Accumulation Fund Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EIATMETEXPZ0','4','D','10','1587',NULL,'Dependent GUL Premium Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EIATMETEXPZ0','1','D','10','1591',NULL,'UD – Assigned Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EIATMETEXPZ0','10','D','10','1592',NULL,'Dependent GUL - StarTrak Customer Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EIATMETEXPZ0','10','D','10','1602',NULL,'Dependent GUL - StarTrak Reporting Loc Num',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EIATMETEXPZ0','177','D','10','1612',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATMETEXPZ0','1','T','90','1',NULL,'Transaction Code',NULL,NULL,'"Z"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATMETEXPZ0','7','T','90','2',NULL,'Customer Number',NULL,NULL,'"9241091"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATMETEXPZ0','8','T','90','9',NULL,'Total Record Count',NULL,NULL,'"drvTotalRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATMETEXPZ0','1984','T','90','17',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATMETEXP_20221006.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210039','EMPEXPORT','OEACTIVE',NULL,'EIATMETEXP',NULL,NULL,NULL,'202210039','Oct  3 2022  4:36PM','Oct  3 2022  4:36PM','202210031',NULL,'','','202210031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210039','EMPEXPORT','OEPASSIVE',NULL,'EIATMETEXP',NULL,NULL,NULL,'202210039','Oct  3 2022  4:36PM','Oct  3 2022  4:36PM','202210031',NULL,'','','202210031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Basic And Vol Export','202210039','EMPEXPORT','ONDEM_XOE',NULL,'EIATMETEXP',NULL,NULL,NULL,'202210039','Oct  3 2022  4:36PM','Oct  3 2022  4:36PM','202210031',NULL,'','','202210031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Basic And Vol Ex-Sched','202210039','EMPEXPORT','SCH_EIATME',NULL,'EIATMETEXP',NULL,NULL,NULL,'202210039','Oct  3 2022  4:36PM','Oct  3 2022  4:36PM','202210031',NULL,'','','202210031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'MetLife Basic And Vol Ex-Test','202210039','EMPEXPORT','TEST_XOE',NULL,'EIATMETEXP',NULL,NULL,NULL,'202210039','Oct  3 2022  4:36PM','Oct  3 2022  4:36PM','202210031',NULL,'','','202210031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATMETEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETEXP','H01','dbo.U_EIATMETEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETEXP','D10','dbo.U_EIATMETEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATMETEXP','T90','dbo.U_EIATMETEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIATMETEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EIATMETEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIATMETEXP] (
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
-- Create table U_EIATMETEXP_DedList
-----------

IF OBJECT_ID('U_EIATMETEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIATMETEXP_drvTbl
-----------

IF OBJECT_ID('U_EIATMETEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(11) NULL,
    [drvEmployeeID] char(12) NOT NULL,
    [drvMemberSSN] char(11) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberMiddleInitial] varchar(1) NULL,
    [drvMemberBirthDate] datetime NULL,
    [drvMemberMaritalstatus] varchar(1) NULL,
    [drvMemberSex] varchar(1) NULL,
    [drvEmploymentDate] datetime NULL,
    [drvRetirementDate] datetime NULL,
    [drvHomeTelephone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvStreetAddress1] varchar(255) NULL,
    [drvStreetAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipcode] varchar(50) NULL,
    [drvAnnualsalary] varchar(24) NULL,
    [drvSalaryEffectivedate] datetime NULL,
    [drvJobStatusCode] char(1) NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvCoverageType1] varchar(1) NULL,
    [drvCoverageStartDate1] datetime NULL,
    [drvCoverageterminationDate1] datetime NULL,
    [drvMetLifeGroupNumber1] varchar(6) NULL,
    [drvMedLifeSubdivision1] varchar(4) NULL,
    [drvMetLifeBranch1] varchar(4) NULL,
    [drvEnrollmentStatus1] varchar(1) NULL,
    [drvMultipleSalarySelected1] varchar(24) NULL,
    [drvBasicLifeFaceAmt] varchar(24) NULL,
    [drvCoverageType2] varchar(2) NULL,
    [drvCoverageStartDate2] datetime NULL,
    [drvCoverageTerminationdate2] datetime NULL,
    [drvMetLifeGroupNumber2] varchar(6) NULL,
    [drvMetLifeSubdivision2] varchar(4) NULL,
    [MetLifeBranch2] varchar(4) NULL,
    [drvEnrollmentStatus2] varchar(1) NULL,
    [drvOLFaceAmount2] varchar(24) NULL,
    [drvCovergeType3] varchar(2) NULL,
    [drvCoverageStartDate3] datetime NULL,
    [drvCoverageTerminationdate3] datetime NULL,
    [drvMetLifeGroupNumber3] varchar(6) NULL,
    [drvMetLifeSubdivisiondr3] varchar(4) NULL,
    [drvMetlifeBranch3] varchar(4) NULL,
    [drvEnrollmentStatus3] varchar(1) NULL,
    [drvOAMultipleSalary] varchar(24) NULL,
    [drvOAFaceAmount3] varchar(24) NULL
);

-----------
-- Create table U_EIATMETEXP_EEList
-----------

IF OBJECT_ID('U_EIATMETEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATMETEXP_File
-----------

IF OBJECT_ID('U_EIATMETEXP_File') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);

-----------
-- Create table U_EIATMETEXP_Header
-----------

IF OBJECT_ID('U_EIATMETEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_Header] (
    [drvFileCreationDate] datetime NOT NULL
);

-----------
-- Create table U_EIATMETEXP_Trailer
-----------

IF OBJECT_ID('U_EIATMETEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EIATMETEXP_Trailer] (
    [drvTotalRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATMETEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance

Created By: Roger Bynum
Business Analyst: Kim Ephram
Create Date: 10/03/2022
Service Request Number: TekP-2022-08-18-01

Purpose: MetLife Basic And Vol Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATMETEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATMETEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATMETEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATMETEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATMETEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATMETEXP', 'SCH_EIATME';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIATMETEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATMETEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIATMETEXP';

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
    DELETE FROM dbo.U_EIATMETEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATMETEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EIATMETEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIATMETEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LIFEC,LIFEE,LIFES,VDL,VL,VOL,ADDE,GTL');
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
    -- DETAIL RECORD - U_EIATMETEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATMETEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber                = eepSSN
        ,drvEmployeeID                    = EepEEID
        ,drvMemberSSN                    = eepSSN
        ,drvMemberLastName                = EepNameLast
        ,drvMemberFirstName                = EepNameFirst
        ,drvMemberMiddleInitial            = LEFT(EepNameMiddle,1)
        ,drvMemberBirthDate                = EepDateOfBirth
        ,drvMemberMaritalstatus            = CASE WHEN EepMaritalStatus IN ('M','S') THEN eepMaritalStatus ELSE 'U' END
        ,drvMemberSex                    = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvEmploymentDate                = EecDateOfLastHire
        ,drvRetirementDate                = EecDateOfRetirement
        ,drvHomeTelephone                = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN EepPhoneHomeNumber
                                               ELSE (Select top 1 efoPhoneNumber from dbo.EmpMPhon where efoeeid = xeeid and efoPhoneType = 'CEL')
                                          END
        ,drvEmailAddress                = EepAddressEMail
        ,drvStreetAddress1                = EepAddressLine1
        ,drvStreetAddress2                = EepAddressLine2
        ,drvCity                        = EepAddressCity
        ,drvState                        = EepAddressState
        ,drvZipcode                        = EepAddressZipCode
        ,drvAnnualsalary                = dbo.dsi_fnpadzero((ISNULL(REPLACE(EecAnnSalary,'.', ''),0)),9,0)  
        ,drvSalaryEffectivedate            = EecEmplStatusStartDate
        ,drvJobStatusCode                = EecEmplStatus 
        ,drvStatusEffectiveDate            = EecEmplStatusStartDate
        ,drvCoverageType1                = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN 'L' END
        ,drvCoverageStartDate1            = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN CASE WHEN GLIFE_BenStartDate > '2023-01-01'THEN GLIFE_BenStartDate ELSE '2023-01-01' END END
        ,drvCoverageterminationDate1    = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN GLIFE_BenStopDate END
        ,drvMetLifeGroupNumber1            = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN '241091' END
        ,drvMedLifeSubdivision1            = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN '0001' END
        ,drvMetLifeBranch1                = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN '0001' END
        ,drvEnrollmentStatus1            = CASE WHEN GLIFE_DedCode = 'GLIFE' AND GLIFE_BdmBenStatus = 'A' THEN 'P' END
        ,drvMultipleSalarySelected1        = CASE WHEN GLIFE_DedCode = 'GLIFE' THEN dbo.dsi_fnpadzero((ISNULL(REPLACE(GLIFE_BdmEECalcRateOrPct,'.', ''),0)),9,0)  END
        ,drvBasicLifeFaceAmt            = dbo.dsi_fnpadzero((ISNULL(REPLACE(GLIFE_BdmEEAmt,'.', ''),0)),9,0)
        ,drvCoverageType2                = CASE WHEN VL_DedCode = 'VL' THEN 'OL' END
        ,drvCoverageStartDate2            = CASE WHEN VL_DedCode = 'VL' THEN CASE WHEN VL_BenStartDate > '2023-01-01'THEN VL_BenStartDate ELSE '2023-01-01' END END
        ,drvCoverageTerminationdate2    = CASE WHEN VL_DedCode = 'VL' THEN VL_BenStopDate END
        ,drvMetLifeGroupNumber2            = CASE WHEN VL_DedCode = 'VL' THEN '241091'END
        ,drvMetLifeSubdivision2            = CASE WHEN VL_DedCode = 'VL' THEN '0001' END
        ,MetLifeBranch2                    = CASE WHEN VL_DedCode = 'VL' THEN '0001' END
        ,drvEnrollmentStatus2            = CASE WHEN VL_DedCode = 'VL' AND VL_BdmBenStatus = 'A' THEN 'P' END
        ,drvOLFaceAmount2                = dbo.dsi_fnpadzero((ISNULL(REPLACE(VL_BdmEEAmt,'.', ''),0)),9,0)
        ,drvCovergeType3                = CASE WHEN ADDE_DedCode = 'ADDE' THEN 'OA' END
        ,drvCoverageStartDate3            = CASE WHEN ADDE_DedCode = 'ADDE' THEN ADDE_BenStartDate END
        ,drvCoverageTerminationdate3    = CASE WHEN ADDE_DedCode = 'ADDE' THEN ADDE_BenStopDate END
        ,drvMetLifeGroupNumber3            = CASE WHEN ADDE_DedCode = 'ADDE' THEN  '241091'END 
        ,drvMetLifeSubdivisiondr3        = CASE WHEN ADDE_DedCode = 'ADDE' THEN '0001' END
        ,drvMetlifeBranch3                = CASE WHEN ADDE_DedCode = 'ADDE' THEN '0001' END
        ,drvEnrollmentStatus3            = CASE WHEN ADDE_DedCode = 'ADDE' AND ADDE_BdmBenStatus = 'A' THEN 'P' END
        ,drvOAMultipleSalary            = CASE WHEN ADDE_DedCode = 'ADDE' THEN dbo.dsi_fnpadzero((ISNULL(REPLACE(ADDE_BdmEECalcRateOrPct,'.', ''),0)),9,0) END
        ,drvOAFaceAmount3                = dbo.dsi_fnpadzero((ISNULL(REPLACE(ADDE_BdmEEAmt,'.', ''),0)),9,0) 
    INTO dbo.U_EIATMETEXP_drvTbl
    FROM dbo.U_EIATMETEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
 --       AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN(SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmDedCode END) AS VL_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmDedCode END) AS ADDE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmBenStartDate END) AS VL_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmBenStartDate END) AS ADDE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmBenStopDate END) AS VL_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmBenStopDate END) AS ADDE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmEECalcRateOrPct END) AS GLIFE_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmEECalcRateOrPct END) AS VL_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmEECalcRateOrPct END) AS ADDE_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStatus END) AS GLIFE_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmBenStatus END) AS VL_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmBenStatus END) AS ADDE_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmEEAmt END) AS GLIFE_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'VL'    THEN BdmEEAmt END) AS VL_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'ADDE'    THEN BdmEEAmt END) AS ADDE_BdmEEAmt
            FROM dbo.U_dsi_BDM_EIATMETEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS BdmFlattened
     ON xEEID = BdmEEID
     AND xCOID = BdmCOID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIATMETEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETEXP_Header;
    SELECT DISTINCT
         drvFileCreationDate = GETDATE()
    INTO dbo.U_EIATMETEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EIATMETEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EIATMETEXP_Trailer;
    SELECT DISTINCT
         drvTotalRecordCount = COUNT(1)
    INTO dbo.U_EIATMETEXP_Trailer
         FROM dbo.U_EIATMETEXP_drvTbl WITH (NOLOCK)

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
ALTER VIEW dbo.dsi_vwEIATMETEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATMETEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATMETEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209261'
       ,expStartPerControl     = '202209261'
       ,expLastEndPerControl   = '202210039'
       ,expEndPerControl       = '202210039'
WHERE expFormatCode = 'EIATMETEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATMETEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATMETEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATMETEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATMETEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATMETEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATMETEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATMETEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATMETEXP', 'UseFileName', 'V', 'Y'


-- End ripout