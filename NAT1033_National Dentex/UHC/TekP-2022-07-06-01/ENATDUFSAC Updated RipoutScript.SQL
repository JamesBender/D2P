/**********************************************************************************

ENATDUFSAC: UHC FSA Combined Export

FormatCode:     ENATDUFSAC
Project:        UHC FSA Combined Export
Client ID:      NAT1033
Date/time:      2022-10-06 08:12:59.973
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E31
Server:         E3SUP1DB02
Database:       ULTIPRO_NDC
Web Filename:   NAT1033_F81AE_EEHISTORY_ENATDUFSAC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENATDUFSAC_SavePath') IS NOT NULL DROP TABLE dbo.U_ENATDUFSAC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENATDUFSAC'


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
WHERE FormatCode = 'ENATDUFSAC'
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
WHERE ExpFormatCode = 'ENATDUFSAC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENATDUFSAC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENATDUFSAC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENATDUFSAC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENATDUFSAC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENATDUFSAC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENATDUFSAC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENATDUFSAC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENATDUFSAC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENATDUFSAC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENATDUFSAC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENATDUFSAC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENATDUFSAC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENATDUFSAC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENATDUFSAC];
GO
IF OBJECT_ID('U_ENATDUFSAC_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_Trailer];
GO
IF OBJECT_ID('U_ENATDUFSAC_PperNumber') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_PperNumber];
GO
IF OBJECT_ID('U_ENATDUFSAC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_PEarHist];
GO
IF OBJECT_ID('U_ENATDUFSAC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_PDedHist];
GO
IF OBJECT_ID('U_ENATDUFSAC_Header') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_Header];
GO
IF OBJECT_ID('U_ENATDUFSAC_File') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_File];
GO
IF OBJECT_ID('U_ENATDUFSAC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_EEList];
GO
IF OBJECT_ID('U_ENATDUFSAC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_drvTbl];
GO
IF OBJECT_ID('U_ENATDUFSAC_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENATDUFSAC_DedList];
GO
IF OBJECT_ID('U_Dsi_drvTbl_ENATDUFSAC_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_drvTbl_ENATDUFSAC_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENATDUFSAC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENATDUFSAC];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ENATDUFSAC','UHC FSA Combined Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENATDUFSACZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATDUFSACZ0','19','H','01','1',NULL,'Header Filler',NULL,NULL,'"0000000000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATDUFSACZ0','1','H','01','20',NULL,'Header Master Layout',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATDUFSACZ0','3','H','01','21',NULL,'System Name',NULL,NULL,'"FSA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATDUFSACZ0','4','H','01','24',NULL,'System Number',NULL,NULL,'"5426"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATDUFSACZ0','8','H','01','28',NULL,'Client Code',NULL,NULL,'"NATDENT1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATDUFSACZ0','3','H','01','36',NULL,'Version Number',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATDUFSACZ0','8','H','01','39',NULL,'Date',NULL,NULL,'"drvDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENATDUFSACZ0','9','H','01','47',NULL,'Customer Specific ID',NULL,NULL,'"927874111"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENATDUFSACZ0','30','H','01','56',NULL,'Customer Name',NULL,NULL,'"National Dentex$$$$$$$$$$$$$$$"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENATDUFSACZ0','3','H','01','86',NULL,'Cycle',NULL,NULL,'"drvCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENATDUFSACZ0','7','H','01','89',NULL,'Policy Number',NULL,NULL,'"927874"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENATDUFSACZ0','4','H','01','96',NULL,'Type of Feed',NULL,NULL,'"drvTypeofFeed"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENATDUFSACZ0','1','H','01','100',NULL,'Multi-Coverage Data Indicator',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENATDUFSACZ0','400','H','01','101',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATDUFSACZ0','1','D','10','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATDUFSACZ0','9','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATDUFSACZ0','9','D','10','11',NULL,'Employer ID',NULL,NULL,'"drvEmployerID"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATDUFSACZ0','30','D','10','20',NULL,'Member Last Name',NULL,NULL,'"drvMemberLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATDUFSACZ0','14','D','10','50',NULL,'Member First Name',NULL,NULL,'"drvMemberFirstname"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATDUFSACZ0','1','D','10','64',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATDUFSACZ0','1','D','10','65',NULL,'Member Middle Initial',NULL,NULL,'"drvMemberMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENATDUFSACZ0','4','D','10','66',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENATDUFSACZ0','4','D','10','70',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENATDUFSACZ0','30','D','10','74',NULL,'Permanent Street Address 1',NULL,NULL,'"drvPermStreetAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENATDUFSACZ0','30','D','10','104',NULL,'Permanent Street Address 2',NULL,NULL,'"drvPermStreetAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENATDUFSACZ0','15','D','10','134',NULL,'Permanent City',NULL,NULL,'"drvPermanentCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENATDUFSACZ0','2','D','10','149',NULL,'Permanent State',NULL,NULL,'"drvPermanentState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENATDUFSACZ0','15','D','10','151',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENATDUFSACZ0','9','D','10','166',NULL,'Permanent Zip Code',NULL,NULL,'"drvPermanentZipcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENATDUFSACZ0','1','D','10','175',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENATDUFSACZ0','8','D','10','176',NULL,'Member Birth Date',NULL,NULL,'"drvMemberBirthDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENATDUFSACZ0','7','D','10','184',NULL,'Policy Number',NULL,NULL,'"0927874"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENATDUFSACZ0','4','D','10','191',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENATDUFSACZ0','8','D','10','195',NULL,'Plan Effective Date',NULL,NULL,'"drvPlanEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENATDUFSACZ0','6','D','10','203',NULL,'Reporting Code 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENATDUFSACZ0','2','D','10','209',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENATDUFSACZ0','6','D','10','211',NULL,'Reporting Code 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENATDUFSACZ0','2','D','10','217',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENATDUFSACZ0','8','D','10','219',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENATDUFSACZ0','11','D','10','227',NULL,'Numeric Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENATDUFSACZ0','3','D','10','238',NULL,'Contribution Type 1',NULL,NULL,'"drvContributionType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENATDUFSACZ0','1','D','10','241',NULL,'Contribution Source Code 1',NULL,NULL,'"drvContributionSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENATDUFSACZ0','1','D','10','242',NULL,'Contribution Sign 1',NULL,NULL,'"drvContributionSign1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENATDUFSACZ0','7','D','10','243',NULL,'Contribution Amount 1',NULL,NULL,'"drvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENATDUFSACZ0','3','D','10','250',NULL,'Contribution Type 2',NULL,NULL,'"DEP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENATDUFSACZ0','1','D','10','253',NULL,'Contribution Source Code 2',NULL,NULL,'"drvContributionSourceCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENATDUFSACZ0','1','D','10','254',NULL,'Contribution Sign 2',NULL,NULL,'"drvContributionSign2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENATDUFSACZ0','7','D','10','255',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENATDUFSACZ0','3','D','10','262',NULL,'Contribution Type 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENATDUFSACZ0','1','D','10','265',NULL,'Contribution Source Code 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENATDUFSACZ0','1','D','10','266',NULL,'Contribution Sign 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENATDUFSACZ0','7','D','10','267',NULL,'Contribution Amount 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENATDUFSACZ0','3','D','10','274',NULL,'Contribution Type 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENATDUFSACZ0','1','D','10','277',NULL,'Contribution Source Code 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENATDUFSACZ0','1','D','10','278',NULL,'Contribution Sign 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENATDUFSACZ0','7','D','10','279',NULL,'Contribution Amount 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENATDUFSACZ0','1','D','10','286',NULL,'Automatic Submission Indicator/Coordinate Payment',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENATDUFSACZ0','7','D','10','287',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENATDUFSACZ0','8','D','10','294',NULL,'Healthcare or Limited Purpose FSA Termination Date',NULL,NULL,'"drvHealthcareorLimitedTerm"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENATDUFSACZ0','1','D','10','302',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENATDUFSACZ0','7','D','10','303',NULL,'Healthcare or Limited Purpose FSA Election Amount',NULL,NULL,'"drvHealthcareorLimitedAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENATDUFSACZ0','8','D','10','310',NULL,'Healthcare or Limited Purpose FSA Election Effecti',NULL,NULL,'"drvHealthcareorLimitedEDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENATDUFSACZ0','2','D','10','318',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENATDUFSACZ0','1','D','10','320',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENATDUFSACZ0','9','D','10','321',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENATDUFSACZ0','17','D','10','330',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENATDUFSACZ0','2','D','10','347',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENATDUFSACZ0','102','D','10','349',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENATDUFSACZ0','2','D','10','451',NULL,'Family Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENATDUFSACZ0','8','D','10','453',NULL,'Family level Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENATDUFSACZ0','1','D','10','461',NULL,'Payroll Frequency',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ENATDUFSACZ0','8','D','10','462',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ENATDUFSACZ0','1','D','10','470',NULL,'Prefund Sign',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ENATDUFSACZ0','7','D','10','471',NULL,'Prefund Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ENATDUFSACZ0','8','D','10','478',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvDependentCareFSATermDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ENATDUFSACZ0','8','D','10','486',NULL,'Dependent Care FSA Election Effective Date',NULL,NULL,'"drvDependentCareElecEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ENATDUFSACZ0','7','D','10','494',NULL,'Dependent Care FSA Election Amount',NULL,NULL,'"drvDependentCareFSAElecAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENATDUFSACZ0','6','T','90','1',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENATDUFSACZ0','1','T','90','7',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvTotalHCAndLimitedPurpSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENATDUFSACZ0','10','T','90','8',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvTotalHCAndLimitedPurpAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENATDUFSACZ0','1','T','90','18',NULL,'Total Dependent Care FSA Contribution Amount Sign',NULL,NULL,'"drvTotalDeoendentCareContSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENATDUFSACZ0','10','T','90','19',NULL,'Total Dependent Care FSA Contribution Amount',NULL,NULL,'"drvTotalDependentCareContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENATDUFSACZ0','10','T','90','29',NULL,'Total Healthcare and Limited Purpose FSA Election',NULL,NULL,'"drvTotalHCAndLimitPurpElecAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENATDUFSACZ0','10','T','90','39',NULL,'Total Dependent Care FSA Election Amount',NULL,NULL,'"drvTotalDependCareElectAmt"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENATDUFSAC_20221006.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202208319','EMPEXPORT','OEACTIVE',NULL,'ENATDUFSAC',NULL,NULL,NULL,'202208319','Aug 12 2022 10:25AM','Aug 12 2022 10:25AM','202208011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208319','EMPEXPORT','OEPASSIVE',NULL,'ENATDUFSAC',NULL,NULL,NULL,'202208319','Aug 12 2022 10:25AM','Aug 12 2022 10:25AM','202208011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UHC FSA Combined Export','202208319','EMPEXPORT','ONDEM_XOE',NULL,'ENATDUFSAC',NULL,NULL,NULL,'202208319','Aug 12 2022 10:25AM','Aug 12 2022 10:25AM','202208011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202208319','EMPEXPORT','SCH_ENATDU',NULL,'ENATDUFSAC',NULL,NULL,NULL,'202208319','Aug 12 2022 10:25AM','Aug 12 2022 10:25AM','202208011',NULL,'','','202108011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202209301','EMPEXPORT','TEST_XOE','Oct  4 2022 12:00AM','ENATDUFSAC',NULL,NULL,NULL,'202209301','Sep 30 2022 12:00AM','Sep 24 2022 12:00AM','202209301',NULL,'','','202209301',dbo.fn_GetTimedKey(),NULL,'us3kEpNAT1033',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENATDUFSAC','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATDUFSAC','H01','dbo.U_ENATDUFSAC_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATDUFSAC','D10','dbo.U_ENATDUFSAC_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENATDUFSAC','T90','dbo.U_ENATDUFSAC_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ENATDUFSAC
-----------

IF OBJECT_ID('U_dsi_BDM_ENATDUFSAC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENATDUFSAC] (
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
-- Create table U_Dsi_drvTbl_ENATDUFSAC_Audit
-----------

IF OBJECT_ID('U_Dsi_drvTbl_ENATDUFSAC_Audit') IS NULL
CREATE TABLE [dbo].[U_Dsi_drvTbl_ENATDUFSAC_Audit] (
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
-- Create table U_ENATDUFSAC_DedList
-----------

IF OBJECT_ID('U_ENATDUFSAC_DedList') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENATDUFSAC_drvTbl
-----------

IF OBJECT_ID('U_ENATDUFSAC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberFirstname] varchar(100) NULL,
    [drvMemberMiddleInitial] varchar(1) NOT NULL,
    [drvPermStreetAddress1] varchar(255) NULL,
    [drvPermStreetAddress2] varchar(255) NOT NULL,
    [drvPermanentCity] varchar(255) NULL,
    [drvPermanentState] varchar(255) NULL,
    [drvPermanentZipcode] varchar(50) NULL,
    [drvMemberBirthDate] varchar(8) NULL,
    [drvPlanCode] varchar(4) NULL,
    [drvPlanEffectiveDate] varchar(30) NULL,
    [drvEnrollmentDate] varchar(30) NULL,
    [drvContributionType1] varchar(3) NULL,
    [drvContributionSource1] varchar(1) NULL,
    [drvContributionSign1] varchar(1) NULL,
    [drvContributionAmount1] varchar(30) NULL,
    [drvContributionSourceCode2] varchar(1) NULL,
    [drvContributionSign2] varchar(1) NULL,
    [drvContributionAmount2] varchar(30) NULL,
    [drvHealthcareorLimitedTerm] varchar(30) NULL,
    [drvHealthcareorLimitedAmount] varchar(30) NULL,
    [drvHealthcareorLimitedEDate] varchar(30) NULL,
    [drvDependentCareFSATermDate] varchar(30) NULL,
    [drvDependentCareElecEffDate] varchar(30) NULL,
    [drvDependentCareFSAElecAmount] varchar(30) NULL
);

-----------
-- Create table U_ENATDUFSAC_EEList
-----------

IF OBJECT_ID('U_ENATDUFSAC_EEList') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENATDUFSAC_File
-----------

IF OBJECT_ID('U_ENATDUFSAC_File') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ENATDUFSAC_Header
-----------

IF OBJECT_ID('U_ENATDUFSAC_Header') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_Header] (
    [drvDate] varchar(8) NULL,
    [drvCycle] varchar(3) NULL,
    [drvTypeofFeed] varchar(4) NOT NULL
);

-----------
-- Create table U_ENATDUFSAC_PDedHist
-----------

IF OBJECT_ID('U_ENATDUFSAC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSADP] varchar(5) NULL,
    [PdhFSALT] varchar(5) NULL,
    [PdhFSAMD] varchar(5) NULL,
    [pdhFSADPANDFSALT] varchar(14) NOT NULL,
    [pdhFSAMDANDFSALT] varchar(14) NOT NULL,
    [PdhEEFSADP] numeric NULL,
    [PdhEEFSALT] numeric NULL,
    [PdhEEFSAMD] numeric NULL,
    [PdhFSADPStopDate] datetime NULL,
    [PdhSFALTStopDate] datetime NULL,
    [PdhFSAMDStopDate] datetime NULL,
    [PdhFSADPGoalAmt] money NULL,
    [PdhFSALTGoalAmt] money NULL,
    [PdhFSAMDGoalAmt] money NULL
);

-----------
-- Create table U_ENATDUFSAC_PEarHist
-----------

IF OBJECT_ID('U_ENATDUFSAC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_PEarHist] (
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

-----------
-- Create table U_ENATDUFSAC_PperNumber
-----------

IF OBJECT_ID('U_ENATDUFSAC_PperNumber') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_PperNumber] (
    [pPerControl] varchar(8) NULL,
    [pRowNumber] char(2) NULL
);

-----------
-- Create table U_ENATDUFSAC_Trailer
-----------

IF OBJECT_ID('U_ENATDUFSAC_Trailer') IS NULL
CREATE TABLE [dbo].[U_ENATDUFSAC_Trailer] (
    [drvRecordCount] varchar(6) NOT NULL,
    [drvTotalHCAndLimitedPurpSign] varchar(1) NOT NULL,
    [drvTotalHCAndLimitedPurpAmt] varchar(10) NOT NULL,
    [drvTotalDeoendentCareContSign] varchar(1) NOT NULL,
    [drvTotalDependentCareContAmt] varchar(10) NOT NULL,
    [drvTotalHCAndLimitPurpElecAmt] varchar(10) NOT NULL,
    [drvTotalDependCareElectAmt] varchar(10) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENATDUFSAC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: National Dentex

Created By: Roger Bynum
Business Analyst: Kim Ephram
Create Date: 08/12/2022
Service Request Number: SR-2016-00012345

Purpose: UHC FSA Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters      10/05/2022     TekP-2022-07-06-01   Updated code to pull dates from BDM

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENATDUFSAC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENATDUFSAC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENATDUFSAC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENATDUFSAC', 'SCH_ENATDU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENATDUFSAC';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENATDUFSAC', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
     DECLARE @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ENATDUFSAC';

    -- Declare dates from Parameter file
      SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
		,@FileMinCovDate  = case when cast(getdate() as date) < cast(cast(year(getdate()) as varchar) + '-07-01' as varchar) -- MW added to auto grab updated min coverage date based on year
                                    then CONCAT(YEAR(GETDATE()) -1, '0701') ELSE CONCAT(YEAR(GETDATE()), '0701') END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENATDUFSAC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENATDUFSAC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD,FSALT,FSADP';

    IF OBJECT_ID('U_ENATDUFSAC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENATDUFSAC_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','15');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','15');

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
    IF OBJECT_ID('U_ENATDUFSAC_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts

        ,PdhFSADP        = MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN 'FSADP' ELSE '' END)
        ,PdhFSALT        = MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN 'FSALT' ELSE '' END)
        ,PdhFSAMD        = MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN 'FSAMD' ELSE '' END)
        ,pdhFSADPANDFSALT = '              '
        ,pdhFSAMDANDFSALT = '              '

        ,PdhEEFSADP      = SUM(CASE WHEN PdhDedCode IN ('FSADP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSALT      = SUM(CASE WHEN PdhDedCode IN ('FSALT') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEFSAMD      = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhERCurAmt ELSE 0.00 END)

        ,PdhFSADPStopDate = MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhSFALTStopDate = MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN ISNULL(EedBenStopDate, '') ELSE '' END)
        ,PdhFSAMDStopDate = MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN ISNULL(EedBenStopDate, '') ELSE '' END)

        ,PdhFSADPGoalAmt  =  MAX(CASE WHEN PdhDedCode IN ('FSADP') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSALTGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSALT') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)
        ,PdhFSAMDGoalAmt =  MAX(CASE WHEN PdhDedCode IN ('FSAMD') THEN ISNULL(pdhEEGoalAmt, '') ELSE '' END)



    INTO dbo.U_ENATDUFSAC_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENATDUFSAC_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    JOIN dbo.EmpDed
        ON eedEEID = PdhEEID
        AND EedCoID = PdhCoID
        AND ISNULL(EedBenStatus, 'W') IN ('A', 'T')
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00)
    ;
    UPDATE dbo.U_ENATDUFSAC_PDedHist
        SET pdhFSADPANDFSALT = 'fSADPAndFSALT'
        WHERE pdhEEID IN
        (SELECT PdhEEID 
        FROM dbo.U_ENATDUFSAC_PDedHist
        WHERE PdhFSADP = 'FSADP'
        AND PdhFSALT = 'FSALT')
    UPDATE dbo.U_ENATDUFSAC_PDedHist
        SET pdhFSAMDANDFSALT = 'FSAMDAndFSALT'
        WHERE pdhEEID IN
        (SELECT PdhEEID 
        FROM dbo.U_ENATDUFSAC_PDedHist
        WHERE PdhFSAMD = 'FSAMD'
        AND PdhFSALT = 'FSALT')
    ;

    -----------
    -- Remove terminations except in the range
    -----------

    IF OBJECT_ID('dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit')     IS NOT NULL  DROP TABLE dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit;

    SELECT DISTINCT

    AudKey1Value,
    AudKey2Value,
    AudKey3Value,
    AudTableName,
    AudFieldName,
    AudOldValue,
    AudNewValue,
    AudDateTime,
    AudProcessedDateTime

    INTO dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit
    FROM dbo.U_ENATDUFSAC_EELIST
    JOIN dbo.vw_AuditEEdata ON AudKey1Value = xEEID
    -- Want maximum audit key in case of multiple changes
    JOIN (SELECT AudKey1Value MaxEEID, AudFieldName MaxFieldName, MAX(AudProcessedDateTime) AS MaxDateTime
          FROM dbo.vw_AuditEEdata
          WHERE AudTableName IN ('EmpComp','Contacts') 
          AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
          AND AudProcessedDateTime BETWEEN @StartDate AND @EndDate
          GROUP BY AudKey1Value,AudFieldName) MaxAudit ON AudKey1Value = MaxEEID AND AudFieldName = MaxFieldName AND AudProcessedDateTime = MaxDateTime
    WHERE AudTableName IN ('EmpComp','Contacts') 
    AND AudFieldName IN ('EecEmplStatus','ConNameFirst')
    AND AudProcessedDateTime BETWEEN @StartDate AND @EndDate;

    DELETE A
    FROM dbo.U_ENATDUFSAC_EELIST A
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID AND EecEmplStatus = 'T'
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_Dsi_drvTbl_ENATDUFSAC_Audit WHERE EecEEID = AudKey1Value AND EecCOID = AudKey2Value AND AudNewValue = 'T');


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENATDUFSAC_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PEarHist;
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
    INTO dbo.U_ENATDUFSAC_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - PperNumber
    -----------------------------
    IF OBJECT_ID('U_ENATDUFSAC_PperNumber','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_PperNumber;

    SELECT pYear + pMonthDay as pPerControl, CAST(pRowNumber AS CHAR(2)) AS pRowNumber
    INTO dbo.U_ENATDUFSAC_PperNumber
    FROM (SELECT pYear, pMonthDay, 
    (ROW_NUMBER() OVER(PARTITION BY pYear ORDER BY pMonthDay)) pRowNumber
    FROM
    (SELECT DISTINCT
     LEFT(pdhPerControl, 4) AS pYear, SUBSTRING(pdhPerControl, 5, 4) AS pMonthDay
    FROM dbo.PDedHist) p) pr

    UPDATE dbo.U_ENATDUFSAC_PperNumber SET pRowNumber = '0' + pRowNumber WHERE LEN(pRowNumber) = 1

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENATDUFSAC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENATDUFSAC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_drvTbl;
   SELECT DISTINCT
       drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EepSSN
        ,drvMemberLastName = EepNameLast
        ,drvMemberFirstname = EepNameFirst
        ,drvMemberMiddleInitial = ISNULL(LEFT(EepNameMiddle,1), ' ')
        ,drvPermStreetAddress1 = EepAddressLine1
        ,drvPermStreetAddress2 = ISNULL(EepAddressLine2, '                              ')
        ,drvPermanentCity = EepAddressCity
        ,drvPermanentState = EepAddressState
        ,drvPermanentZipcode = Case when Right(EepAddressZipCode, 4) = 0000 then Left(EepAddressZipCode,5) ELSE EepAddressZipCode END
        ,drvMemberBirthDate = CONVERT(VARCHAR(8),EepDateOfBirth, 112)
        ,drvPlanCode =     CASE WHEN pdhFSADPANDFSALT = 'FSADPANDFSALT' THEN '5001'
                                WHEN pdhFSAMDANDFSALT = 'FSAMDANDFSALT' THEN '0001'
                                WHEN PdhFSADP = 'FSADP' THEN '0001'
                                WHEN PdhFSALT = 'FSALT' THEN '5001'
                                WHEN PdhFSAMD = 'FSAMD' THEN '0001'
                                ELSE NULL --MW changed to use null
                        END
        ,drvPlanEffectiveDate =  Convert(VARCHAR,CASE WHEN dbo.dsi_fnGetMinMaxDates('MAX', @StartDate, '7/1/2022') >= CAST(YEAR(@StartDate) AS CHAR(4)) + '0701' THEN  CAST(YEAR(@StartDate) AS CHAR(4)) + '0701'  --MW changed from CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' to grab correcct plan year when year changes
                                                            ELSE CAST(YEAR(BdmTVStartDate) AS CHAR(4)) + '0701' --MW BdmTVStartDate updates with Open Enrollment
                                                        END , 112)
        ,drvEnrollmentDate = Convert(VARCHAR,CASE WHEN @ExportCode NOT LIKE 'OE%' THEN dbo.dsi_fnGetMinMaxDates('MAX',MaxBenStartDate , @FileMinCovDate)  ELSE  BdmTVStartDate END , 112) --MW changed to use min file date and BdmTVStartDate updates with Open Enrollment  changed from CASE WHEN @ExportCode NOT LIKE 'OE%' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END 
        ,drvContributionType1 = CASE    WHEN PdhFSALT = 'FSALT' THEN 'MED' 
                                        WHEN PdhFSAMD = 'FSAMD' THEN 'MED' 
                                        WHEN PdhFSADP = 'FSADP' THEN  Null ---MT added 9/20/22
                                        ELSE NULL  END--MW changed to use null
        ,drvContributionSource1 = CASE WHEN PdhFSADP  <> 'FSADP'  THEN  'E'  ELSE NULL  END ---MT added 9/20/22
        ,drvContributionSign1 = CASE WHEN pCombAmt > 0 THEN '+'
                                     WHEN pCombAmt < 0 THEN '-'
                                    ELSE NULL --MW changed to use null
                                END
        ,drvContributionAmount1 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND pCombAmt > 0 THEN CAST(dbo.dsi_fnPadZero(pCombAmt * 100,7,0) AS VARCHAR) ELSE NULL  END
        ,drvContributionSourceCode2 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND PdhFSADP = 'FSADP' THEN 'E' ELSE NULL  END
        ,drvContributionSign2 = CASE WHEN @ExportCode NOT LIKE 'OE%' THEN
                                        CASE WHEN PdhFSADP = 'FSADP' AND PdhEEFSADP > 0 THEN '+'
                                             WHEN PdhFSADP = 'FSADP' AND PdhEEFSADP < 0 THEN '-'
                                             ELSE NULL --MW changed to use null
                                        END
                                     ELSE NULL --MW changed to use null
                                END
        ,drvContributionAmount2 = CASE WHEN @ExportCode NOT LIKE 'OE%' AND FSADP_DedCode = 'FSADP' AND FSADP_BdmEEAmt > 0 THEN  CAST(dbo.dsi_fnPadZero(FSADP_BdmEEAmt * 100,7,0) AS VARCHAR)--REPLACE(SUBSTRING(CAST(dbo.dsi_fnPadZero(PdhEEFSADP,7,0) AS VARCHAR), 1, LEN(PdhEEFSADP) - 2),'.','')
                                       ELSE NULL --MW changed to use null
                                  END
        ,drvHealthcareorLimitedTerm = CASE WHEN FSAMD_DedCode = 'FSAMD' AND FSAMD_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSAMD_BenStopDate, 112)  --MW changed to use BDM --PdhFSAMD = 'FSAMD' AND PdhFSAMDStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhFSAMDStopDate, 112) 
                                           WHEN FSALT_DedCode = 'FSALT' AND FSALT_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSALT_BenStopDate, 112)  --MW changed to use BDM --WHEN PdhFSALT = 'FSALT' AND PdhSFALTStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhSFALTStopDate, 112)       
                                           ELSE NULL --MW changed to use null
                                      END
        ,drvHealthcareorLimitedAmount = CASE WHEN FSAMD_DedCode ='FSAMD' AND FSAMD_BdmEEGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(FSAMD_BdmEEGoalAmt * 100,7,0) AS VARCHAR) --MW changed to use BDM --WHEN PdhFSAMD = 'FSAMD' AND PdhFSAMDGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(PdhFSAMDGoalAmt * 100,7,0) AS VARCHAR)
                                             WHEN FSALT_DedCode= 'FSALT' AND FSALT_BdmEEGoalAmt> 0 THEN CAST(dbo.dsi_fnPadZero(FSALT_BdmEEGoalAmt * 100,7,0) AS VARCHAR) --MW changed to use BDM --WHEN PdhFSALT = 'FSALT' AND pdhFSALTGoalAmt > 0 THEN CAST(dbo.dsi_fnPadZero(PdhFSALTGoalAmt * 100,7,0) AS VARCHAR)
                                             ELSE NULL  --MW changed to use null
                                        END
                                        
        ,drvHealthcareorLimitedEDate = CASE WHEN Combined_BdmDedCode = 'Combined' THEN CONVERT(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX',Combined_BenStartDate , @FileMinCovDate), 112)--MW changed to use BDM and Min File Date   --CASE WHEN PdhFSAMD = 'FSAMD' AND PdhFSAMDStopDate IS NOT NULL THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END
                                             ELSE NULL  END--MW changed to use null
        
        
        ,drvDependentCareFSATermDate = CASE WHEN FSADP_DedCode = 'FSADP' AND FSADP_BenStopDate IS NOT NULL THEN CONVERT(VARCHAR, FSADP_BenStopDate, 112) ELSE NULL  END  --MW changed to use BDM       --CASE WHEN PdhFSADP = 'FSADP' AND PdhFSADPStopDate IS NOT NULL THEN CONVERT(VARCHAR, PdhFSADPStopDate, 112) ELSE  '        ' END   
        ,drvDependentCareElecEffDate = CASE WHEN FSADP_DedCode= 'FSADP'  THEN Convert(VARCHAR,dbo.dsi_fnGetMinMaxDates('MAX', FSADP_BenStartDate  , @FileMinCovDate), 112) ELSE NULL  END--MW changed to use BDM and Min File Date --CASE WHEN PdhFSADP = 'FSADP' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701' ELSE '        ' END
        ,drvDependentCareFSAElecAmount = CASE WHEN FSADP_DedCode = 'FSADP' THEN CAST(dbo.dsi_fnPadZero(FSADP_BdmEEGoalAmt * 100,7,0) AS VARCHAR) ELSE NULL END --MW changed to use BDM --CASE WHEN PdhFSADP = 'FSADP' THEN CAST(dbo.dsi_fnPadZero(PdhFSADPGoalAmt * 100,7,0) AS VARCHAR) ELSE '       ' END
    INTO dbo.U_ENATDUFSAC_drvTbl
    FROM dbo.U_ENATDUFSAC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
  --  JOIN dbo.U_dsi_BDM_ENATDUFSAC WITH (NOLOCK)
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID
        --AND bdmEEAmt <> 0
    --JOIN dbo.Payreg WITH (NOLOCK)
        --ON PrgEEID = xEEID
        --AND prgCOID = xCOID
  --  JOIN dbo.PDedHist WITH (NOLOCK)
  --      ON pdhEEID = xEEID
        --AND PdhDedCode = BdmDedCode
    --LEFT JOIN dbo.EmpDed WITH (NOLOCK)
    --    ON EedEEID = xEEID
    --    AND EedDedCode IN ('FSAMD','FSALT','FSADP')
        --AND EedDedCode = BdmDedCode
        --AND EedCoID = xCOID
     JOIN (SELECT pdhEEID AS pEEID, 
                      PdhFSADP AS PdhFSADP, 
                      PdhFSALT AS PdhFSALT,
                      PdhFSAMD AS PdhFSAMD,
                      pdhFSADPANDFSALT AS pdhFSADPANDFSALT,
                      pdhFSAMDANDFSALT AS pdhFSAMDANDFSALT,
                      PdhEEFSALT + PdhEEFSAMD  AS pCombAmt,
                      PdhEEFSADP AS PdhEEFSADP,
                      CASE WHEN PdhFSADPStopDate <> '' THEN PdhFSADPStopDate ELSE NULL END AS PdhFSADPStopDate,
                      CASE WHEN PdhSFALTStopDate <> '' THEN PdhSFALTStopDate ELSE NULL END AS PdhSFALTStopDate,
                      CASE WHEN PdhFSAMDStopDate <> '' THEN PdhFSAMDStopDate ELSE NULL END AS PdhFSAMDStopDate,
                      PdhFSADPGoalAmt AS PdhFSADPGoalAmt,
                      PdhFSALTGoalAmt AS PdhFSALTGoalAmt,
                      PdhFSAMDGoalAmt AS PdhFSAMDGoalAmt
                FROM dbo.U_ENATDUFSAC_PDedHist) AS dPlan
        ON pEEID = xEEID
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID  
                
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmDedCode END) AS FSAMD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmDedCode END) AS FSALT_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmDedCode END) AS FSADP_DedCode
                --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                --,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                --,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode    
                --,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS GLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStatus END) AS FSAMD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStatus END) AS FSALT_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStatus END) AS FSADP_BenStatus
                --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStatus END) AS LIFEC_BenStatus
                --,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStatus END) AS LIFEE_BenStatus
                --,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStatus END) AS LIFES_BenStatus
                --,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStatus END) AS GLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStartDate END) AS FSAMD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStartDate END) AS FSALT_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStartDate END) AS FSADP_BenStartDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BenStartDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BenStartDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BenStartDate
                 --,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStopDate END) AS FSAMD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmBenStopDate END) AS FSALT_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmBenStopDate END) AS FSADP_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
                --,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmEEAmt END) AS FSAMD_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmEEGoalAmt END) AS FSAMD_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmEEAmt END) AS FSALT_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSALT' THEN BdmEEGoalAmt END) AS FSALT_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmEEAmt END) AS FSADP_BdmEEAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADP' THEN BdmEEGoalAmt END) AS FSADP_BdmEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD') THEN 'Combined' END) as Combined_BdmDedCode
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD') THEN BdmBenStartDate END) AS Combined_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD','FSADP') THEN BdmBenStartDate END) AS MaxBenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ( 'FSALT','FSAMD','FSADP') THEN BdmTVStartDate END ) AS BdmTVStartDate
            FROM dbo.U_dsi_BDM_ENATDUFSAC WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    
    ;
 
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    DECLARE @prgPaydate Date
    SELECT @prgPaydate = PrgPayDate FROM dbo.vw_int_PayReg WHERE  LEFT(prgPerControl,4) = LEFT(@EndPerControl,4)
                                                                        AND prgPerControl <= @EndPerControl
    IF OBJECT_ID('U_ENATDUFSAC_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_Header;
    SELECT DISTINCT
         drvDate = CASE WHEN @ExportCode LIKE 'OE%' THEN CAST(YEAR(GETDATE()) AS CHAR(4)) + '0701'
                        ELSE CONVERT(CHAR(8), @prgPaydate, 112)
                   END
        ,drvCycle = CASE WHEN @ExportCode LIKE 'OE%' THEN 'E01' 
                        ELSE 'B' + MAX(pRowNumber) -- Todo, Check for PgrPayFrequency = B 
                    END
        ,drvTypeofFeed = CASE WHEN @ExportCode LIKE 'OE%' THEN 'ENRL' ELSE 'PROD' END
    INTO dbo.U_ENATDUFSAC_Header
    FROM dbo.U_ENATDUFSAC_PEarHist WITH (NOLOCK)
    CROSS JOIN dbo.U_ENATDUFSAC_PperNumber
          WHERE LEFT(pPerControl,4) = LEFT(@EndPerControl,4)
          AND pPerControl <= @EndPerControl
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENATDUFSAC_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ENATDUFSAC_Trailer;
    SELECT DISTINCT
         drvRecordCount = '      '
        ,drvTotalHCAndLimitedPurpSign = ' '
        ,drvTotalHCAndLimitedPurpAmt = '          '
        ,drvTotalDeoendentCareContSign = ' '
        ,drvTotalDependentCareContAmt = '          '
        ,drvTotalHCAndLimitPurpElecAmt = '          '
        ,drvTotalDependCareElectAmt = '          '
    INTO dbo.U_ENATDUFSAC_Trailer
    ;


    DECLARE @RecordCount INT,
            @TotHCLAmt numeric,
            @TotDepCareAmt numeric,
            @TotHCLimtiPurpAmt numeric,
            @TotDepCareELecAmt numeric

    SELECT @RecordCount = COUNT(*)
           ,@TotHCLAmt = SUM(CAST(drvContributionAmount1 AS INT)) 
           ,@TotDepCareAmt = SUM(CAST(drvContributionAmount2 AS BIGINT))
           ,@TotHCLimtiPurpAmt = SUM(CAST(drvHealthcareorLimitedAmount AS BIGINT))
           ,@TotDepCareELecAmt = SUM(CAST(drvDependentCareFSAElecAmount AS BIGINT))
           FROM dbo.U_ENATDUFSAC_drvTbl


    UPDATE dbo.U_ENATDUFSAC_Trailer
    SET        drvRecordCount = @RecordCount
           ,drvTotalHCAndLimitedPurpSign = CASE WHEN @TotHCLAmt > 0 THEN '+' WHEN @TotHCLAmt < 0 THEN '-' ELSE ' ' END
           ,drvTotalHCAndLimitedPurpAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLAmt * 100,10,0) AS VARCHAR), '          ')
           ,drvTotalDeoendentCareContSign = CASE WHEN @TotDepCareAmt  > 0 THEN '+' WHEN @TotDepCareAmt  < 0 THEN '-' ELSE ' ' END
           ,drvTotalDependentCareContAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareAmt * 100,10,0) AS VARCHAR), '          ')
           ,drvTotalHCAndLimitPurpElecAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotHCLimtiPurpAmt * 100,10,0) AS VARCHAR), '          ')
           ,drvTotalDependCareElectAmt = ISNULL(CAST(dbo.dsi_fnPadZero(@TotDepCareELecAmt * 100,10,0) AS VARCHAR), '          ')


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwENATDUFSAC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENATDUFSAC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENATDUFSAC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208251'
       ,expStartPerControl     = '202108251'
       ,expLastEndPerControl   = '202208319'
       ,expEndPerControl       = '202208319'
WHERE expFormatCode = 'ENATDUFSAC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENATDUFSAC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENATDUFSAC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENATDUFSAC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENATDUFSAC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENATDUFSAC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENATDUFSAC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENATDUFSAC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENATDUFSAC', 'UseFileName', 'V', 'Y'


-- End ripout