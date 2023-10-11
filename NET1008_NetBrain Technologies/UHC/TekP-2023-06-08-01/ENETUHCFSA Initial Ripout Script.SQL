/**********************************************************************************

ENETUHCFSA: UHC FSA Contribution Export

FormatCode:     ENETUHCFSA
Project:        UHC FSA Contribution Export
Client ID:      NET1008
Date/time:      2023-10-10 16:51:27.900
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP5DB02
Database:       ULTIPRO_WPNETB
Web Filename:   NET1008_AD5W2_EEHISTORY_ENETUHCFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENETUHCFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ENETUHCFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENETUHCFSA'


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
WHERE FormatCode = 'ENETUHCFSA'
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
WHERE ExpFormatCode = 'ENETUHCFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENETUHCFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENETUHCFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENETUHCFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENETUHCFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENETUHCFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENETUHCFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENETUHCFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENETUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENETUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENETUHCFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENETUHCFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENETUHCFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENETUHCFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENETUHCFSA];
GO
IF OBJECT_ID('U_ENETUHCFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_Trailer];
GO
IF OBJECT_ID('U_ENETUHCFSA_PperNumber') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_PperNumber];
GO
IF OBJECT_ID('U_ENETUHCFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_PEarHist];
GO
IF OBJECT_ID('U_ENETUHCFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_PDedHist];
GO
IF OBJECT_ID('U_ENETUHCFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_Header];
GO
IF OBJECT_ID('U_ENETUHCFSA_File') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_File];
GO
IF OBJECT_ID('U_ENETUHCFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_EEList];
GO
IF OBJECT_ID('U_ENETUHCFSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_drvTbl];
GO
IF OBJECT_ID('U_ENETUHCFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENETUHCFSA_DedList];
GO
IF OBJECT_ID('U_Dsi_drvTbl_ENETUHCFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_drvTbl_ENETUHCFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENETUHCFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENETUHCFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ENETUHCFSA','UHC FSA Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENETUHCFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENETUHCFSAZ0','19','H','01','1',NULL,'Header Filler',NULL,NULL,'"0000000000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENETUHCFSAZ0','1','H','01','20',NULL,'Header Master Layout',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENETUHCFSAZ0','3','H','01','21',NULL,'System Name',NULL,NULL,'"FSA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENETUHCFSAZ0','4','H','01','24',NULL,'System Number',NULL,NULL,'"5426"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENETUHCFSAZ0','8','H','01','28',NULL,'Client Code',NULL,NULL,'"NetBrain"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENETUHCFSAZ0','3','H','01','36',NULL,'Version Number',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENETUHCFSAZ0','8','H','01','39',NULL,'Date',NULL,NULL,'"drvDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENETUHCFSAZ0','9','H','01','47',NULL,'Customer Specific ID',NULL,NULL,'"931316111"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENETUHCFSAZ0','30','H','01','56',NULL,'Customer Name',NULL,NULL,'"NetBrain"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENETUHCFSAZ0','3','H','01','86',NULL,'Cycle',NULL,NULL,'"drvCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENETUHCFSAZ0','7','H','01','89',NULL,'Policy Number',NULL,NULL,'"0931316"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENETUHCFSAZ0','4','H','01','96',NULL,'Type of Feed',NULL,NULL,'"drvTypeofFeed"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENETUHCFSAZ0','1','H','01','100',NULL,'Multi-Coverage Data Indicator',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENETUHCFSAZ0','400','H','01','101',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENETUHCFSAZ0','1','D','10','1',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENETUHCFSAZ0','9','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENETUHCFSAZ0','9','D','10','11',NULL,'Employer ID/Employer Alt ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENETUHCFSAZ0','30','D','10','20',NULL,' Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENETUHCFSAZ0','14','D','10','50',NULL,' First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENETUHCFSAZ0','1','D','10','64',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENETUHCFSAZ0','1','D','10','65',NULL,' Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENETUHCFSAZ0','4','D','10','66',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENETUHCFSAZ0','4','D','10','70',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENETUHCFSAZ0','30','D','10','74',NULL,'Permanent Street Address 1',NULL,NULL,'"drvAddressLine"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENETUHCFSAZ0','30','D','10','104',NULL,'Permanent Street Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENETUHCFSAZ0','15','D','10','134',NULL,'Permanent City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENETUHCFSAZ0','2','D','10','149',NULL,'Permanent State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENETUHCFSAZ0','15','D','10','151',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENETUHCFSAZ0','9','D','10','166',NULL,'Permanent Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENETUHCFSAZ0','1','D','10','175',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENETUHCFSAZ0','8','D','10','176',NULL,' Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENETUHCFSAZ0','7','D','10','184',NULL,'Policy Number',NULL,NULL,'"0931316"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENETUHCFSAZ0','4','D','10','191',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENETUHCFSAZ0','8','D','10','195',NULL,'Plan Effective Date',NULL,NULL,'"drvPlanEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENETUHCFSAZ0','6','D','10','203',NULL,'Reporting Code 1',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENETUHCFSAZ0','2','D','10','209',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENETUHCFSAZ0','6','D','10','211',NULL,'Reporting Code 2',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENETUHCFSAZ0','2','D','10','217',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENETUHCFSAZ0','8','D','10','219',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENETUHCFSAZ0','11','D','10','227',NULL,'Numeric Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENETUHCFSAZ0','3','D','10','238',NULL,'Contribution Type 1',NULL,NULL,'"drvContributionType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENETUHCFSAZ0','1','D','10','241',NULL,'Contribution Source Code 1',NULL,NULL,'"drvContributionSourceCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENETUHCFSAZ0','1','D','10','242',NULL,'Contribution Sign 1',NULL,NULL,'"drvContributionSign1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENETUHCFSAZ0','7','D','10','243',NULL,'Contribution Amount 1',NULL,NULL,'"drvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENETUHCFSAZ0','3','D','10','250',NULL,'Contribution Type 2',NULL,NULL,'"drvContributionType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENETUHCFSAZ0','1','D','10','253',NULL,'Contribution Source Code 2',NULL,NULL,'"drvContributionSourceCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENETUHCFSAZ0','1','D','10','254',NULL,'Contribution Sign 2',NULL,NULL,'"drvContributionSign2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENETUHCFSAZ0','7','D','10','255',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENETUHCFSAZ0','3','D','10','262',NULL,'Contribution Type 3',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENETUHCFSAZ0','1','D','10','265',NULL,'Contribution Source Code 3',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENETUHCFSAZ0','1','D','10','266',NULL,'Contribution Sign 3',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENETUHCFSAZ0','7','D','10','267',NULL,'Contribution Amount 3',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENETUHCFSAZ0','3','D','10','274',NULL,'Contribution Type 4',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENETUHCFSAZ0','1','D','10','277',NULL,'Contribution Source Code 4',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENETUHCFSAZ0','1','D','10','278',NULL,'Contribution Sign 4',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENETUHCFSAZ0','7','D','10','279',NULL,'Contribution Amount 4',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENETUHCFSAZ0','1','D','10','286',NULL,'Automatic Submission Indicator/Coordinate Payment',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENETUHCFSAZ0','7','D','10','287',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENETUHCFSAZ0','8','D','10','294',NULL,'Healthcare or Limited Purpose FSA Termination Date',NULL,NULL,'"drvFSATerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENETUHCFSAZ0','1','D','10','302',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENETUHCFSAZ0','7','D','10','303',NULL,'Healthcare or Limited Purpose FSA Election Amount',NULL,NULL,'"drvFSAElectionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENETUHCFSAZ0','8','D','10','310',NULL,'Healthcare or Limited Purpose FSA Election Effecti',NULL,NULL,'"drvFSAEffectiveDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENETUHCFSAZ0','2','D','10','318',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENETUHCFSAZ0','1','D','10','320',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENETUHCFSAZ0','9','D','10','321',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENETUHCFSAZ0','17','D','10','330',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENETUHCFSAZ0','2','D','10','347',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENETUHCFSAZ0','121','D','10','349',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENETUHCFSAZ0','1','D','10','470',NULL,'Prefund Sign',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENETUHCFSAZ0','7','D','10','471',NULL,'Prefund Amount',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENETUHCFSAZ0','8','D','10','478',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvDepFSATerminationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ENETUHCFSAZ0','8','D','10','486',NULL,'Dependent Care FSA Election Effective Date',NULL,NULL,'"drvDepFSAElectionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ENETUHCFSAZ0','7','D','10','494',NULL,'Dependent Care FSA Election Amount',NULL,NULL,'"drvDepFSAElectionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENETUHCFSAZ0','20','T','90','1',NULL,'Filler',NULL,NULL,'"99999999999999999999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENETUHCFSAZ0','6','T','90','21',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENETUHCFSAZ0','1','T','90','27',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvTotalFsaContributionSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENETUHCFSAZ0','10','T','90','28',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvTotalFsaContributionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENETUHCFSAZ0','1','T','90','38',NULL,'Total Dependent Care FSA Contribution Amount Sign',NULL,NULL,'"drvTotalFsaDepContribSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENETUHCFSAZ0','10','T','90','39',NULL,'Total Dependent Care FSA Contribution Amount',NULL,NULL,'"drvTotalFsaDepContribAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENETUHCFSAZ0','10','T','90','49',NULL,'Total Healthcare and Limited Purpose FSA Election',NULL,NULL,'"drvTotalFSAElectionAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENETUHCFSAZ0','10','T','90','59',NULL,'Total Dependent Care FSA Election Amount',NULL,NULL,'"drvTotalDepCareFSAAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENETUHCFSAZ0','432','T','90','69',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENETUHCFSA_20231010.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202310099','EMPEXPORT','OEACTIVE',NULL,'ENETUHCFSA',NULL,NULL,NULL,'202310099','Oct  9 2023  9:48AM','Oct  9 2023  9:48AM','202309021',NULL,'','','202309021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202310099','EMPEXPORT','OEPASSIVE',NULL,'ENETUHCFSA',NULL,NULL,NULL,'202310099','Oct  9 2023  9:48AM','Oct  9 2023  9:48AM','202309021',NULL,'','','202309021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FSA Contribution Export','202310099','EMPEXPORT','ONDEM_XOE',NULL,'ENETUHCFSA',NULL,NULL,NULL,'202310099','Oct  9 2023  9:48AM','Oct  9 2023  9:48AM','202309021',NULL,'','','202309021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FSA Contribution Exp-Sched','202310099','EMPEXPORT','SCH_ENETUH',NULL,'ENETUHCFSA',NULL,NULL,NULL,'202310099','Oct  9 2023  9:48AM','Oct  9 2023  9:48AM','202309021',NULL,'','','202309021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'UHC FSA Contribution Exp-Test','202310099','EMPEXPORT','TEST_XOE',NULL,'ENETUHCFSA',NULL,NULL,NULL,'202310099','Oct  9 2023  9:48AM','Oct  9 2023  9:48AM','202309021',NULL,'','','202309021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENETUHCFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENETUHCFSA','H01','dbo.U_ENETUHCFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENETUHCFSA','D10','dbo.U_ENETUHCFSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENETUHCFSA','T90','dbo.U_ENETUHCFSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ENETUHCFSA
-----------

IF OBJECT_ID('U_dsi_BDM_ENETUHCFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENETUHCFSA] (
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
-- Create table U_Dsi_drvTbl_ENETUHCFSA_Audit
-----------

IF OBJECT_ID('U_Dsi_drvTbl_ENETUHCFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_Dsi_drvTbl_ENETUHCFSA_Audit] (
    [AudKey1Value] varchar(255) NULL,
    [AudKey2Value] varchar(255) NOT NULL,
    [AudKey3Value] varchar(255) NOT NULL,
    [AudTableName] varchar(128) NOT NULL,
    [AudFieldName] varchar(128) NOT NULL,
    [AudOldValue] nvarchar(2000) NULL,
    [AudNewValue] nvarchar(2000) NULL,
    [AudDateTime] datetime NOT NULL,
    [AudProcessedDateTime] datetime NOT NULL
);

-----------
-- Create table U_ENETUHCFSA_DedList
-----------

IF OBJECT_ID('U_ENETUHCFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENETUHCFSA_drvTbl
-----------

IF OBJECT_ID('U_ENETUHCFSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] varchar(8) NULL,
    [drvPlanCode] varchar(4) NULL,
    [drvPlanEffectiveDate] varchar(30) NULL,
    [drvEnrollmentDate] varchar(30) NULL,
    [drvContributionType1] varchar(3) NULL,
    [drvContributionSourceCode1] varchar(1) NULL,
    [drvContributionSign1] varchar(1) NULL,
    [drvContributionAmount1] varchar(30) NULL,
    [drvContributionType2] varchar(3) NULL,
    [drvContributionSourceCode2] varchar(1) NULL,
    [drvContributionSign2] varchar(1) NULL,
    [drvContributionAmount2] varchar(30) NULL,
    [drvFSATerminationDate] varchar(30) NULL,
    [drvFSAElectionAmount] varchar(30) NULL,
    [drvFSAEffectiveDate] varchar(30) NULL,
    [drvDepFSATerminationDate] varchar(30) NULL,
    [drvDepFSAElectionDate] varchar(30) NULL,
    [drvDepFSAElectionAmount] varchar(30) NULL
);

-----------
-- Create table U_ENETUHCFSA_EEList
-----------

IF OBJECT_ID('U_ENETUHCFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENETUHCFSA_File
-----------

IF OBJECT_ID('U_ENETUHCFSA_File') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ENETUHCFSA_Header
-----------

IF OBJECT_ID('U_ENETUHCFSA_Header') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_Header] (
    [drvDate] varchar(8) NULL,
    [drvCycle] varchar(3) NULL,
    [drvTypeofFeed] varchar(4) NOT NULL
);

-----------
-- Create table U_ENETUHCFSA_PDedHist
-----------

IF OBJECT_ID('U_ENETUHCFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhLSA] varchar(3) NULL,
    [PdhFSA] varchar(3) NULL,
    [PdhFSADC] varchar(5) NULL,
    [PdhEELSA] numeric NULL,
    [PdhEEFSA] numeric NULL,
    [PdhEEFSADC] numeric NULL,
    [PdhLSAStopDate] datetime NULL,
    [PdhSFSAStopDate] datetime NULL,
    [PdhFSADCStopDate] datetime NULL,
    [PdhLSAGoalAmt] money NULL,
    [PdhFSAGoalAmt] money NULL,
    [PdhFSADCGoalAmt] money NULL
);

-----------
-- Create table U_ENETUHCFSA_PEarHist
-----------

IF OBJECT_ID('U_ENETUHCFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPerControl] char(9) NULL,
    [PgrPayFrequency] char(1) NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_ENETUHCFSA_PperNumber
-----------

IF OBJECT_ID('U_ENETUHCFSA_PperNumber') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_PperNumber] (
    [pPerControl] varchar(8) NULL,
    [pRowNumber] char(2) NULL
);

-----------
-- Create table U_ENETUHCFSA_Trailer
-----------

IF OBJECT_ID('U_ENETUHCFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ENETUHCFSA_Trailer] (
    [drvRecordCount] varchar(6) NOT NULL,
    [drvTotalFsaContributionSign] varchar(1) NOT NULL,
    [drvTotalFsaContributionAmount] varchar(10) NOT NULL,
    [drvTotalFsaDepContribSign] varchar(1) NOT NULL,
    [drvTotalFsaDepContribAmount] varchar(10) NOT NULL,
    [drvTotalFSAElectionAmount] varchar(10) NOT NULL,
    [drvTotalDepCareFSAAmount] varchar(10) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENETUHCFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NetBrain Technologies, Inc.

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 10/09/2023
Service Request Number: TekP-2023-06-08-01

Purpose: UHC FSA Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENETUHCFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENETUHCFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENETUHCFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENETUHCFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENETUHCFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENETUHCFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENETUHCFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENETUHCFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENETUHCFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENETUHCFSA', 'SCH_ENETUH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENETUHCFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENETUHCFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ENETUHCFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = case when cast(getdate() as date) < cast(cast(year(getdate()) as varchar) + '-06-01' as varchar) -- MW added to auto grab updated min coverage date based on year
                                    then CONCAT(YEAR(GETDATE()) -1, '0601') ELSE CONCAT(YEAR(GETDATE()), '0601') END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENETUHCFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENETUHCFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,LSA,FSADC';

    IF OBJECT_ID('U_ENETUHCFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENETUHCFSA_DedList
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
    IF OBJECT_ID('U_ENETUHCFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_PDedHist;
     SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhLSA        = MAX(CASE WHEN PdhDedCode IN ('LSA') THEN 'LSA' ELSE '' END)
        ,PdhFSA        = MAX(CASE WHEN PdhDedCode IN ('FSA') THEN 'FSA' ELSE '' END)
        ,PdhFSADC        = MAX(CASE WHEN PdhDedCode IN ('FSADC') THEN 'FSADC' ELSE '' END)
        --,pdhLSAANDFSA   = '              '
        --,pdhFSADCANDFSA = '              '
        ,PdhEELSA      = SUM(CASE WHEN PdhDedCode IN ('LSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSA      = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSADC      = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLSAStopDate = MAX(CASE WHEN PdhDedCode IN ('LSA') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhSFSAStopDate = MAX(CASE WHEN PdhDedCode IN ('FSA') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhFSADCStopDate = MAX(CASE WHEN PdhDedCode IN ('FSADC') THEN ISNULL(EedBenStopDate, '') ELSE '' END)

        ,PdhLSAGoalAmt  =  MAX(CASE WHEN PdhDedCode IN ('LSA') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSAGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSA') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSADCGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSADC') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
    INTO dbo.U_ENETUHCFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENETUHCFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    JOIN dbo.EmpDed
        ON eedEEID = PdhEEID
        AND EedCoID = PdhCoID
    and eeddedcode = PdhDedCode -- added
        AND EedBenStatus IN ('A', 'T')
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00)
    ;


       -------------------------------
    ---- Working Table - PperNumber
    -------------------------------
    IF OBJECT_ID('U_ENETUHCFSA_PperNumber','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_PperNumber;

    SELECT pYear + pMonthDay as pPerControl, CAST(pRowNumber AS CHAR(2)) AS pRowNumber
    INTO dbo.U_ENETUHCFSA_PperNumber
    FROM (SELECT pYear, pMonthDay, 
    (ROW_NUMBER() OVER(PARTITION BY pYear ORDER BY pMonthDay)) pRowNumber
    FROM
    (SELECT DISTINCT
     LEFT(pdhPerControl, 4) AS pYear, SUBSTRING(pdhPerControl, 5, 4) AS pMonthDay
    FROM dbo.PDedHist) p) pr

    UPDATE dbo.U_ENETUHCFSA_PperNumber SET pRowNumber = '0' + pRowNumber WHERE LEN(pRowNumber) = 1
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENETUHCFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_PEarHist;
   SELECT DISTINCT
         PehEEID
        ,PrgPerControl          = MAX(PrgPerControl)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
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
    INTO dbo.U_ENETUHCFSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PehPayGroup = PehPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENETUHCFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENETUHCFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_drvTbl;
       SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine = ''
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth =  CONVERT(VARCHAR(8),EepDateOfBirth, 112)
        ,drvPlanCode = Case WHEN FSA_Dedcode IS NOT NULL THEN '0001'
                            WHEN FSADC_Dedcode IS NOT NULL THEN '0001'
                            WHEN LSA_Dedcode IS NOT NULL THEN '5001'
                            END
        ,drvPlanEffectiveDate = Convert(VARCHAR,CASE WHEN dbo.dsi_fnGetMinMaxDates('MAX', @StartDate, @FileMinCovDate) >= CAST(YEAR(@StartDate) AS CHAR(4)) + '0601' THEN  CAST(YEAR(@StartDate) AS CHAR(4)) + '0601' 
                                                            ELSE CAST(YEAR(BdmTVStartDate) AS CHAR(4)) + '0601' 
                                                        END , 112)
        ,drvEnrollmentDate = Convert(VARCHAR,CASE WHEN @ExportCode NOT LIKE 'OE%' THEN dbo.dsi_fnGetMinMaxDates('MAX',MaxBenStartDate , @FileMinCovDate)  ELSE  BdmTVStartDate END , 112) 
        ,drvContributionType1 = CASE WHEN PdhFSA = 'FSA' THEN 'MED' 
                                        WHEN PdhFSADC = 'FSADC' THEN 'MED' 
                                       
                                        ELSE NULL 
                                      END
        ,drvContributionSourceCode1 =  CASE WHEN PdhFSA = 'FSA' THEN 'E' 
                                       WHEN PdhFSADC = 'FSADC' THEN 'E'
                                     ELSE Null  
                                    END
        ,drvContributionSign1 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                     CASE WHEN Combined_BdmEEAmt > 0 OR pCombAmt > 0  THEN '+'
                                     WHEN Combined_BdmEEAmt < 0 and pCombAmt < 0 THEN '-' 
                                    ELSE NULL 
                                END
                                ELSE NULL 
                            END
        ,drvContributionAmount1 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                                        CASE WHEN CAST(dbo.dsi_fnPadZero(Combined_BdmEEAmt * 100,7,0) AS VARCHAR) > '0' THEN CAST(dbo.dsi_fnPadZero(Combined_BdmEEAmt * 100,7,0) AS VARCHAR)
                                                             ELSE CAST(dbo.dsi_fnPadZero(pCombAmt * 100,7,0) AS VARCHAR)
                                                             END
                                                ELSE NULL  END 
        ,drvContributionType2 = CASE WHEN PdhLSA = 'LSA' THEN 'DEP' ELSE NULL END
        ,drvContributionSourceCode2 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND PdhLSA is not null THEN 'E' ELSE NULL  END
        ,drvContributionSign2 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                        CASE WHEN PdhLSA is not null AND PdhEELSA > 0 THEN '+'
                                             WHEN PdhLSA is not null AND PdhEELSA < 0 THEN '-'
                                             ELSE NULL 
                                        END
                                     ELSE NULL 
                                END
        ,drvContributionAmount2 =  CASE WHEN @ExportCode NOT LIKE 'OE%' AND LSA_DedCode = 'LSA' AND LSA_BdmEEAmt > 0 THEN  CAST(dbo.dsi_fnPadZero(LSA_BdmEEAmt * 100,7,0) AS VARCHAR)
                                       ELSE NULL 
                                  END
        ,drvFSATerminationDate = CASE WHEN LSA_DedCode is not null AND LSA_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR,LSA_BenStopDate, 112)
                                           WHEN LSA_BenStopDate IS NULL and  PdhLSAStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhLSAStopDate, 112)    
                                           WHEN FSA_DedCode is not null AND FSA_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSA_BenStopDate, 112) 
                                           WHEN FSA_BenStopDate IS NULL and  PdhLSAStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhLSAStopDate, 112) 
                                      END
        ,drvFSAElectionAmount = CASE WHEN LSA_DedCode is not null AND LSA_BdmEEGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(LSA_BdmEEGoalAmt * 100,7,0) AS VARCHAR) 
                                             WHEN FSA_DedCode is not null AND FSA_BdmEEGoalAmt> 0 THEN CAST(dbo.dsi_fnPadZero(FSA_BdmEEGoalAmt * 100,7,0) AS VARCHAR) 
                                             ELSE NULL  
                                        END
        ,drvFSAEffectiveDate = CASE WHEN Combined_BdmDedCode is not null THEN CONVERT(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX',Combined_BenStartDate , @FileMinCovDate), 112)
                                             ELSE NULL  END
        ,drvDepFSATerminationDate = CASE WHEN FSADC_DedCode is not null AND FSADC_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSADC_BenStopDate, 112) ELSE NULL  END
        ,drvDepFSAElectionDate = CASE WHEN FSADC_DedCode is not null  THEN Convert(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX', FSADC_BenStartDate  , @FileMinCovDate), 112) ELSE NULL  END
        ,drvDepFSAElectionAmount = CASE WHEN FSADC_DedCode is not null THEN CAST(dbo.dsi_fnPadZero(LSA_BdmEEGoalAmt * 100,7,0) AS VARCHAR) ELSE NULL END  
    INTO dbo.U_ENETUHCFSA_drvTbl
    FROM dbo.U_ENETUHCFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN (SELECT pdhEEID AS pEEID, 
                      PdhLSA AS PdhLSA, 
                      PdhFSA AS PdhFSA,
                      PdhFSADC AS PdhFSADC,
                      CASE WHEN (PdhFSADC = 'LSA' or PdhFSA=  'FSA')  and   (PdhEEFSA + PdhEELSA) = 0.00 THEN PdhEECurAmt ELSE  PdhEEFSA + PdhEELSA END AS pCombAmt, 
                      PdhEELSA AS PdhEELSA,
                      CASE WHEN PdhLSAStopDate <> '' THEN PdhLSAStopDate ELSE NULL END AS PdhLSAStopDate,
                      CASE WHEN PdhSFSAStopDate <> '' THEN PdhSFSAStopDate ELSE NULL END AS PdhSFSAStopDate,
                      CASE WHEN PdhFSADCStopDate <> '' THEN PdhFSADCStopDate ELSE NULL END AS PdhFSADCStopDate,
                      PdhLSAGoalAmt AS PdhLSAGoalAmt,
                      PdhFSAGoalAmt AS PdhFSAGoalAmt,
                      PdhFSADCGoalAmt AS PdhFSADCGoalAmt
                FROM dbo.U_ENETUHCFSA_PDedHist) AS dPlan
        ON pEEID = xEEID
   JOIN (                                                                                                        ---MW added BDM section for correct dates
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID  
                
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmDedCode END) AS FSADC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmDedCode END) AS FSA_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmDedCode END) AS LSA_DedCode
             
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStatus END) AS FSADC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStatus END) AS FSA_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmBenStatus END) AS LSA_BenStatus
              
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStartDate END) AS FSADC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStartDate END) AS FSA_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmBenStartDate END) AS LSA_BenStartDate
             
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStopDate END) AS FSADC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStopDate END) AS FSA_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmBenStopDate END) AS LSA_BenStopDate
              
                ,MAX(CASE WHEN BdmDedCode IN ('FSADC','FSA') THEN BdmEEAmt END) AS Combined_BdmEEAmt

                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmEEAmt END) AS FSADC_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmEEGoalAmt END) AS FSADC_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEAmt END) AS FSA_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEGoalAmt END) AS FSA_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmEEAmt END) AS LSA_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'LSA' THEN BdmEEGoalAmt END) AS LSA_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode IN ('FSA','LSA') THEN 'Combined' END) as Combined_BdmDedCode
                ,MAX(CASE WHEN BdmDedCode IN ('FSA','LSA') THEN BdmBenStartDate END) AS Combined_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSADC','LSA') THEN BdmBenStartDate END) AS MaxBenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('FSA','FSADC','LSA') THEN BdmTVStartDate END ) AS BdmTVStartDate
            FROM dbo.U_dsi_BDM_ENETUHCFSA WITH (NOLOCK)
            Where bdmbenstatus NOT IN ( 'W', 'C')
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
       Where  ( EecEmplstatus <> 'T' OR (EecEmplStatus = 'T' AND  EecDateOfTermination BETWEEN  DATEADD(DAY, -14, @StartDate) AND @EndDate or (Combined_BdmEEAmt > 0.00 or pCombAmt > 0.00) )) 
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
      DECLARE @prgPaydate Date
    SELECT @prgPaydate = PrgPayDate FROM dbo.vw_int_PayReg WHERE  LEFT(prgPerControl,4) = LEFT(@EndPerControl,4)
                                                                        AND prgPerControl <= @EndPerControl
    
    IF OBJECT_ID('U_ENETUHCFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_Header;
    SELECT DISTINCT
        drvDate = CASE WHEN @ExportCode LIKE 'OE%' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0601'
                        ELSE CONVERT(CHAR(8), @prgPaydate, 112)
                   END
        ,drvCycle = CASE WHEN @ExportCode LIKE 'OE%' THEN 'E01' 
                        ELSE 'T' + MAX(pRowNumber) 
                    END
        ,drvTypeofFeed = CASE WHEN @ExportCode LIKE 'OE%' THEN 'ENRL' ELSE 'PROD' END
    INTO dbo.U_ENETUHCFSA_Header
      FROM dbo.U_ENETUHCFSA_PEarHist WITH (NOLOCK)
    CROSS JOIN dbo.U_ENETUHCFSA_PperNumber
          WHERE LEFT(pPerControl,4) = LEFT(@EndPerControl,4)
          AND pPerControl <= @EndPerControl

    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENETUHCFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ENETUHCFSA_Trailer;
    SELECT DISTINCT
         drvRecordCount = '      '
        ,drvTotalFsaContributionSign = ''
        ,drvTotalFsaContributionAmount = '          '
        ,drvTotalFsaDepContribSign = ''
        ,drvTotalFsaDepContribAmount = '          '
        ,drvTotalFSAElectionAmount = '          '
        ,drvTotalDepCareFSAAmount = '          '
    INTO dbo.U_ENETUHCFSA_Trailer


    DECLARE @RecordCount numeric,
            @TotHCLAmt numeric,
            @TotDepCareAmt numeric,
            @TotHCLimtiPurpAmt numeric,
            @TotDepCareELecAmt numeric

    SELECT @RecordCount = COUNT(*)
           ,@TotHCLAmt = SUM(CAST(drvContributionAmount1 AS INT)) 
           ,@TotDepCareAmt = SUM(CAST(drvContributionAmount2 AS BIGINT))
           ,@TotHCLimtiPurpAmt = SUM(CAST(drvFSAElectionAmount AS BIGINT))
           ,@TotDepCareELecAmt = SUM(CAST(drvDepFSAElectionAmount AS BIGINT))
           FROM dbo.U_ENETUHCFSA_drvTbl


    UPDATE dbo.U_ENETUHCFSA_Trailer
    SET     drvRecordCount = (dbo.dsi_fnpadzero(CAST(@RecordCount as Int), 6, 0))
           ,drvTotalFsaContributionSign  = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CASE WHEN @TotHCLAmt > 0 THEN '+' WHEN @TotHCLAmt < 0 THEN '-' ELSE ' ' END ELSE NULL END
           ,drvTotalFsaContributionAmount = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLAmt * 100,10,0) AS VARCHAR), '          ') ELSE NULL END
           ,drvTotalFsaDepContribSign = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CASE WHEN @TotDepCareAmt  > 0 THEN '+' WHEN @TotDepCareAmt  < 0 THEN '-' ELSE ' ' END ELSE NULL END
           ,drvTotalFsaDepContribAmount = CASE WHEN @ExportCode NOT LIKE 'OE%'THEN  ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareAmt * 100,10,0) AS VARCHAR), '          ') ELSE NULL END
           ,drvTotalFSAElectionAmount = ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLimtiPurpAmt * 100,10,0) AS VARCHAR), '          ')
           ,drvTotalDepCareFSAAmount  = ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareELecAmt * 100,10,0) AS VARCHAR), '          ')


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
ALTER VIEW dbo.dsi_vwENETUHCFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENETUHCFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENETUHCFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202309021'
       ,expStartPerControl     = '202309021'
       ,expLastEndPerControl   = '202310099'
       ,expEndPerControl       = '202310099'
WHERE expFormatCode = 'ENETUHCFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENETUHCFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENETUHCFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENETUHCFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENETUHCFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENETUHCFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENETUHCFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENETUHCFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENETUHCFSA', 'UseFileName', 'V', 'Y'


-- End ripout