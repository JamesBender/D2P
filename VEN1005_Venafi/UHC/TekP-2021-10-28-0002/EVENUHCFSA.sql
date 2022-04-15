/**********************************************************************************

EVENUHCFSA: UHC FSA and Dep Care

FormatCode:     EVENUHCFSA
Project:        UHC FSA and Dep Care
Client ID:      VEN1005
Date/time:      2022-04-15 17:15:45.623
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPVENA
Web Filename:   VEN1005_HLL35_EEHISTORY_EVENUHCFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EVENUHCFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EVENUHCFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EVENUHCFSA'


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
WHERE FormatCode = 'EVENUHCFSA'
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
WHERE ExpFormatCode = 'EVENUHCFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EVENUHCFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EVENUHCFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EVENUHCFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EVENUHCFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EVENUHCFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EVENUHCFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EVENUHCFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EVENUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EVENUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EVENUHCFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEVENUHCFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVENUHCFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVENUHCFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENUHCFSA];
GO
IF OBJECT_ID('U_EVENUHCFSA_TR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_TR_drvTbl];
GO
IF OBJECT_ID('U_EVENUHCFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_PEarHist];
GO
IF OBJECT_ID('U_EVENUHCFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_PDedHist];
GO
IF OBJECT_ID('U_EVENUHCFSA_OE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_OE_drvTbl];
GO
IF OBJECT_ID('U_EVENUHCFSA_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_HDR_drvTbl];
GO
IF OBJECT_ID('U_EVENUHCFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_File];
GO
IF OBJECT_ID('U_EVENUHCFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_EEList];
GO
IF OBJECT_ID('U_EVENUHCFSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_drvTbl];
GO
IF OBJECT_ID('U_EVENUHCFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_DedList];
GO
IF OBJECT_ID('U_EVENUHCFSA_CB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_CB_drvTbl];
GO
IF OBJECT_ID('U_EVENUHCFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_AuditFields];
GO
IF OBJECT_ID('U_EVENUHCFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVENUHCFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EVENUHCFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVENUHCFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EVENUHCFSA','UHC FSA and Dep Care','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EVENUHCFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENUHCFSAZ0','19','H','01','1',NULL,'Header Filler',NULL,NULL,'"drvHeaderFill"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENUHCFSAZ0','1','H','01','20',NULL,'Header Master Layout',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENUHCFSAZ0','3','H','01','21',NULL,'System Name',NULL,NULL,'"FSA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENUHCFSAZ0','4','H','01','24',NULL,'System Number',NULL,NULL,'"5426"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENUHCFSAZ0','8','H','01','28',NULL,'Client Code',NULL,NULL,'"VENAFI001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENUHCFSAZ0','3','H','01','36',NULL,'Version Number',NULL,NULL,'"drvVersionNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENUHCFSAZ0','8','H','01','39',NULL,'Date',NULL,NULL,'"drvDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENUHCFSAZ0','9','H','01','47',NULL,'Customer Specific IOD',NULL,NULL,'"drvCustSpecID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVENUHCFSAZ0','30','H','01','56',NULL,'Customer Name',NULL,NULL,'"Venafi Inc"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVENUHCFSAZ0','3','H','01','86',NULL,'Cycle',NULL,NULL,'"drvCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVENUHCFSAZ0','7','H','01','89',NULL,'Policy Number',NULL,NULL,'"drvPolicyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVENUHCFSAZ0','4','H','01','96',NULL,'Type of Feed',NULL,NULL,'"drvTypeofFeed"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EVENUHCFSAZ0','1','H','01','100',NULL,'Multi-Coverage Data Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EVENUHCFSAZ0','400','H','01','101',NULL,'Filler',NULL,NULL,'""','(SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENUHCFSAZ0','1','D','10','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENUHCFSAZ0','9','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENUHCFSAZ0','9','D','10','11',NULL,'Employer ID',NULL,NULL,'"drvEmployerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENUHCFSAZ0','30','D','10','20',NULL,'Member Last Name',NULL,NULL,'"drvMemberLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENUHCFSAZ0','14','D','10','20',NULL,'Member First Name',NULL,NULL,'"drvMemberFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENUHCFSAZ0','1','D','10','50',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENUHCFSAZ0','1','D','10','34',NULL,'Member Middle Name',NULL,NULL,'"drvMemberMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENUHCFSAZ0','4','D','10','51',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVENUHCFSAZ0','4','D','10','35',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVENUHCFSAZ0','30','D','10','55',NULL,'Permanent Street Address 1',NULL,NULL,'"drvPermStreetAddr1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVENUHCFSAZ0','30','D','10','39',NULL,'Permanent Street Address 2',NULL,NULL,'"drvPermStreetAddr2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVENUHCFSAZ0','15','D','10','85',NULL,'Permanent City',NULL,NULL,'"drvPermCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EVENUHCFSAZ0','2','D','10','69',NULL,'Permanent State',NULL,NULL,'"drvPermState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EVENUHCFSAZ0','15','D','10','100',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EVENUHCFSAZ0','9','D','10','71',NULL,'Permanent Zip Code',NULL,NULL,'"drvPermZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EVENUHCFSAZ0','1','D','10','115',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EVENUHCFSAZ0','8','D','10','80',NULL,'Member Birth Date',NULL,NULL,'"dmvMembBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EVENUHCFSAZ0','7','D','10','116',NULL,'Policy Number',NULL,NULL,'"dlvPolicyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EVENUHCFSAZ0','4','D','10','88',NULL,'Plan Code',NULL,NULL,'"dlvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EVENUHCFSAZ0','8','D','10','123',NULL,'Plan Effective Date',NULL,NULL,'"davPlanEffective"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EVENUHCFSAZ0','6','D','10','92',NULL,'Reporting Code 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EVENUHCFSAZ0','2','D','10','131',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EVENUHCFSAZ0','6','D','10','98',NULL,'Reporting Code 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EVENUHCFSAZ0','2','D','10','133',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EVENUHCFSAZ0','8','D','10','104',NULL,'Enrollment Date',NULL,NULL,'"dlvEnrollmentDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EVENUHCFSAZ0','11','D','10','135',NULL,'Numeric Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EVENUHCFSAZ0','3','D','10','112',NULL,'Contribution Type',NULL,NULL,'"dlvContributionType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EVENUHCFSAZ0','1','D','10','146',NULL,'Contribution Source Code 1',NULL,NULL,'"dnvContSourceCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EVENUHCFSAZ0','1','D','10','115',NULL,'Contribution Sign 1',NULL,NULL,'"dlvContributionSign1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EVENUHCFSAZ0','7','D','10','147',NULL,'Contribution Amount 1',NULL,NULL,'"dlvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EVENUHCFSAZ0','3','D','10','116',NULL,'Contribution Type 2',NULL,NULL,'"dlvContributionType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EVENUHCFSAZ0','1','D','10','154',NULL,'Contribution Source Code 2',NULL,NULL,'"dnvContSourceCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EVENUHCFSAZ0','1','D','10','119',NULL,'Contribution Sign 2',NULL,NULL,'"dlvContributionSign2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EVENUHCFSAZ0','7','D','10','155',NULL,'Contribution Amount 2',NULL,NULL,'"dlvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EVENUHCFSAZ0','3','D','10','120',NULL,'Contribution Type 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EVENUHCFSAZ0','1','D','10','162',NULL,'Contribution Source Code 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EVENUHCFSAZ0','1','D','10','123',NULL,'Contribution Sign 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EVENUHCFSAZ0','7','D','10','163',NULL,'Contribution Amount 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EVENUHCFSAZ0','3','D','10','124',NULL,'Contribution Type 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EVENUHCFSAZ0','1','D','10','170',NULL,'Contribution Source Code 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EVENUHCFSAZ0','1','D','10','127',NULL,'Contribution Sign 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EVENUHCFSAZ0','7','D','10','171',NULL,'Contribution Amount 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EVENUHCFSAZ0','1','D','10','128',NULL,'Automatic Submission Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EVENUHCFSAZ0','7','D','10','178',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EVENUHCFSAZ0','8','D','10','129',NULL,'Healthcare or Limited Purpose Term Date',NULL,NULL,'"drvHCorLPTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EVENUHCFSAZ0','1','D','10','185',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EVENUHCFSAZ0','7','D','10','137',NULL,'Healthcare or Limited Purpose FSA Elec Amt',NULL,NULL,'"drvHCorLPFSAElecAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EVENUHCFSAZ0','8','D','10','186',NULL,'Healthcare or Limited Purpose FSA Eff Date',NULL,NULL,'"drvHCorLPFSAEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EVENUHCFSAZ0','2','D','10','144',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EVENUHCFSAZ0','1','D','10','194',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EVENUHCFSAZ0','9','D','10','146',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EVENUHCFSAZ0','17','D','10','195',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EVENUHCFSAZ0','2','D','10','155',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EVENUHCFSAZ0','121','D','10','212',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EVENUHCFSAZ0','1','D','10','157',NULL,'Prefund Sign',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EVENUHCFSAZ0','7','D','10','333',NULL,'Prefund Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EVENUHCFSAZ0','8','D','10','158',NULL,'Dependent Care FSA Term Date',NULL,NULL,'"drvDepCareFSATermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EVENUHCFSAZ0','8','D','10','340',NULL,'Dep Care FSA Election Eff Date',NULL,NULL,'"drvDepCareFSAElectDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EVENUHCFSAZ0','7','D','10','166',NULL,'Dep Care FSA Election Amt',NULL,NULL,'"drvDepCareFSAElecAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVENUHCFSAZ0','20','T','90','1',NULL,'Filler',NULL,NULL,'"drvFiller9s"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVENUHCFSAZ0','6','T','90','21',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVENUHCFSAZ0','1','T','90','27',NULL,'Total HC and L Purpose FSA Contrib Sign',NULL,NULL,'"drvTotalHCandLPFSAContSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVENUHCFSAZ0','10','T','90','28',NULL,'Total HC and L Purpose FSA Contrib Amt',NULL,NULL,'"drvTotalHCandLPFSAContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVENUHCFSAZ0','1','T','90','38',NULL,'Total Dep Care FSA Contrib Amt Sign',NULL,NULL,'"drvTotalDCFSAContAmtSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVENUHCFSAZ0','10','T','90','39',NULL,'Total Dep Care FSA Contrib Amt',NULL,NULL,'"drvTotalDCFSAContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVENUHCFSAZ0','10','T','90','49',NULL,'Total HC and Limited Purpose FSA Amt',NULL,NULL,'"drvTotalHCandLPFSAAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVENUHCFSAZ0','10','T','90','59',NULL,'Total Dep Care FSA Amt',NULL,NULL,'"drvTotalDCFSAAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVENUHCFSAZ0','432','T','90','69',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EVENUHCFSA_20220415.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UHC FSA and Dep Care','202204309','EMPEXPORT','CONTRIB','Apr 14 2022  9:01AM','EVENUHCFSA',NULL,NULL,NULL,'202204309','Apr 15 2022 12:00AM','Dec 30 1899 12:00AM','202103231','0','','','202103231',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'UHC FSA and Dep Care OE','202204309','EMPEXPORT','ONDEM_XOE',NULL,'EVENUHCFSA',NULL,NULL,NULL,'202204309','Mar 30 2022  9:01AM','Mar 30 2022  9:01AM','202103231',NULL,'','','202103231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UHC FSA and Dep Care-Sched','202204309','EMPEXPORT','SCH_EVENUH','Apr 14 2022  8:51AM','EVENUHCFSA',NULL,NULL,NULL,'202204309','Apr 15 2022 12:00AM','Dec 30 1899 12:00AM','202103231','0','','','202103231',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FSA and Dep Care OE-Sched','202204309','EMPEXPORT','SCH_XOE',NULL,'EVENUHCFSA',NULL,NULL,NULL,'202204309','Mar 30 2022  9:01AM','Mar 30 2022  9:01AM','202103231',NULL,'','','202103231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVENUHCFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENUHCFSA','H01','dbo.U_EVENUHCFSA_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENUHCFSA','D10','dbo.U_EVENUHCFSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVENUHCFSA','T90','dbo.U_EVENUHCFSA_TR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EVENUHCFSA
-----------

IF OBJECT_ID('U_dsi_BDM_EVENUHCFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVENUHCFSA] (
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
-- Create table U_EVENUHCFSA_Audit
-----------

IF OBJECT_ID('U_EVENUHCFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_Audit] (
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
-- Create table U_EVENUHCFSA_AuditFields
-----------

IF OBJECT_ID('U_EVENUHCFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EVENUHCFSA_CB_drvTbl
-----------

IF OBJECT_ID('U_EVENUHCFSA_CB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_CB_drvTbl] (
    [drvTotalHCandLPFSAAmt2] money NULL,
    [drvTotalDCFSAAmt2] money NULL
);

-----------
-- Create table U_EVENUHCFSA_DedList
-----------

IF OBJECT_ID('U_EVENUHCFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EVENUHCFSA_drvTbl
-----------

IF OBJECT_ID('U_EVENUHCFSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployerID] varchar(9) NOT NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberMiddleName] varchar(1) NULL,
    [drvPermStreetAddr1] varchar(255) NULL,
    [drvPermStreetAddr2] varchar(255) NULL,
    [drvPermCity] varchar(255) NULL,
    [drvPermState] varchar(255) NULL,
    [drvPermZip] varchar(50) NULL,
    [dmvMembBirth] datetime NULL,
    [dlvPolicyNumber] varchar(7) NOT NULL,
    [dlvPlanCode] varchar(4) NULL,
    [davPlanEffective] datetime NULL,
    [dlvEnrollmentDate] datetime NULL,
    [dlvContributionType] varchar(3) NOT NULL,
    [dnvContSourceCode1] varchar(1) NOT NULL,
    [dlvContributionSign1] varchar(1) NOT NULL,
    [dlvContributionAmount1] varchar(7) NOT NULL,
    [dlvContributionType2] varchar(3) NOT NULL,
    [dnvContSourceCode2] varchar(1) NOT NULL,
    [dlvContributionSign2] varchar(1) NOT NULL,
    [dlvContributionAmount2] varchar(7) NOT NULL,
    [drvHCorLPTermDate] datetime NULL,
    [drvHCorLPFSAElecAmt] varchar(24) NULL,
    [drvHCorLPFSAEffDate] datetime NULL,
    [drvDepCareFSATermDate] datetime NULL,
    [drvDepCareFSAElectDate] datetime NULL,
    [drvDepCareFSAElecAmt] varchar(24) NULL
);

-----------
-- Create table U_EVENUHCFSA_EEList
-----------

IF OBJECT_ID('U_EVENUHCFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EVENUHCFSA_File
-----------

IF OBJECT_ID('U_EVENUHCFSA_File') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EVENUHCFSA_HDR_drvTbl
-----------

IF OBJECT_ID('U_EVENUHCFSA_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_HDR_drvTbl] (
    [drvHeaderFill] varchar(19) NOT NULL,
    [drvVersionNumber] varchar(3) NOT NULL,
    [drvDate] datetime NULL,
    [drvCustSpecID] varchar(9) NOT NULL,
    [drvCycle] varchar(3) NOT NULL,
    [drvPolicyNumber] varchar(7) NOT NULL,
    [drvTypeofFeed] varchar(4) NOT NULL
);

-----------
-- Create table U_EVENUHCFSA_OE_drvTbl
-----------

IF OBJECT_ID('U_EVENUHCFSA_OE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_OE_drvTbl] (
    [drvTotalHCandLPFSAAmt2] money NULL,
    [drvTotalDCFSAAmt2] money NULL
);

-----------
-- Create table U_EVENUHCFSA_PDedHist
-----------

IF OBJECT_ID('U_EVENUHCFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL
);

-----------
-- Create table U_EVENUHCFSA_PEarHist
-----------

IF OBJECT_ID('U_EVENUHCFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_PEarHist] (
    [PrgPayDate] datetime NULL,
    [PrgPerControl] char(9) NULL,
    [PgrPayFrequency] char(1) NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL
);

-----------
-- Create table U_EVENUHCFSA_TR_drvTbl
-----------

IF OBJECT_ID('U_EVENUHCFSA_TR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVENUHCFSA_TR_drvTbl] (
    [drvFiller9s] varchar(20) NOT NULL,
    [drvRecordCount] varchar(24) NULL,
    [drvTotalHCandLPFSAContSign] varchar(1) NOT NULL,
    [drvTotalHCandLPFSAContAmt] varchar(10) NOT NULL,
    [drvTotalDCFSAContAmtSign] varchar(1) NOT NULL,
    [drvTotalDCFSAContAmt] varchar(10) NOT NULL,
    [drvTotalHCandLPFSAAmt] varchar(24) NULL,
    [drvTotalDCFSAAmt] varchar(24) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVENUHCFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Venafi

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 03/30/2022
Service Request Number: TekP-2021-10-28-0002

Purpose: UHC FSA and Dep Care

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVENUHCFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVENUHCFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVENUHCFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVENUHCFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVENUHCFSA' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103231'
       ,expStartPerControl     = '202103231'
       ,expLastEndPerControl   = '202204309'
       ,expEndPerControl       = '202204309'
WHERE expFormatCode = 'EVENUHCFSA';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENUHCFSA', 'CONTRIB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENUHCFSA', 'SCH_EVENUH';

---Open Enrollment File -
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENUHCFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVENUHCFSA', 'SCH_XOE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVENUHCFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EVENUHCFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVENUHCFSA';

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
    DELETE FROM dbo.U_EVENUHCFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVENUHCFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EVENUHCFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_AuditFields;
    CREATE TABLE dbo.U_EVENUHCFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EVENUHCFSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EVENUHCFSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EVENUHCFSA_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EVENUHCFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_Audit;
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
    INTO dbo.U_EVENUHCFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EVENUHCFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVENUHCFSA_Audit ON dbo.U_EVENUHCFSA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EVENUHCFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EVENUHCFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, FSADC, FSAL';

    IF OBJECT_ID('U_EVENUHCFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVENUHCFSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','FSA,FSADC,FSAL');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC,STC,DIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
   
       /*-- Required OE parameters*/

    --IF @ExportCode LIKE '%ONDEM_XOE'
 -- BEGIN
 --       INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
 --   END;

    -- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EVENUHCFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_PEarHist;
    SELECT DISTINCT
         --PehEEID
         PrgPayDate             = MAX(PrgPayDate)
        ,PrgPerControl            = MAX(PrgPerControl)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)    
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
    INTO dbo.U_EVENUHCFSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
        AND PehPerControl between @StartPerControl and @EndPerControl
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PehPayGroup = PehPayGroup
    GROUP BY PrgPayDate, PgrPayFrequency
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EVENUHCFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('FSAL') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('FSAL','FSA') THEN PdhERCurAmt ELSE 0.00 END)  
    INTO dbo.U_EVENUHCFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EVENUHCFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl 
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables - All data should be left justified.  
    --==========================================
      ------------------------------------------------------------------------------------------------
    --Contribution File
    IF @ExportCode  LIKE 'CONTRIB%' or @ExportCode  LIKE 'SCH_EVENUH%'
    BEGIN

    ---------------------------------
    -- DETAIL RECORD - U_EVENUHCFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVENUHCFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployerID = '000000000'
        ,drvMemberLastName = EepNameLast
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberMiddleName = LEFT(EepNameMiddle,1)
        ,drvPermStreetAddr1 = eepAddressLine1
        ,drvPermStreetAddr2 = eepAddressLine2
        ,drvPermCity = EepAddressCity
        ,drvPermState = EepAddressState
        ,drvPermZip = EepAddressZipCode
        ,dmvMembBirth = EepDateOfBirth
        ,dlvPolicyNumber = '0925515'
        ,dlvPlanCode =  CASE    WHEN DedCode_FSA ='FSA' AND DedCode_FSADC = '' THEN '0001'
                                WHEN DedCode_FSA ='' AND DedCode_FSADC = 'FSADC' AND DedCode_FSAL = '' THEN '0001'
                                WHEN DedCode_FSA ='FSA' AND DedCode_FSADC = 'FSADC' THEN '0001'
                                WHEN DedCode_FSAL = 'FSAL' AND DedCode_FSADC = '' THEN '5001'
                                WHEN DedCode_FSAL = 'FSAL' AND DedCode_FSADC = 'FSADC' THEN '5001'
                                END
        ,davPlanEffective = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) 
        ,dlvEnrollmentDate = EedBenStartDate
        ,dlvContributionType = CASE WHEN DedCode_FSA in ('FSA') THEN 'MED' WHEN DedCode_FSAL in ('FSAL') THEN 'MED' END 
        ,dnvContSourceCode1 = 'E'
        ,dlvContributionSign1 = CASE WHEN PdhSource2 > 0 THEN '+' WHEN PdhSource3 > 0 THEN '+' WHEN PdhSource2 < 0 THEN '-' WHEN PdhSource3 < 0 THEN '-' END
        ,dlvContributionAmount1 = CASE WHEN PdhSource2 > 0 THEN dbo.dsi_fnPadZero(PdhSource2*100, 7,0) WHEN PdhSource3 > 0 THEN dbo.dsi_fnPadZero(PdhSource3*100, 7,0)END
        ,dlvContributionAmount1b = CASE WHEN PdhSource2 > 0 THEN PdhSource2 WHEN PdhSource3 > 0 THEN PdhSource3 END
        ,dlvContributionType2 = CASE WHEN DedCode_FSADC in ('FSADC') THEN 'DEP' END 
        ,dnvContSourceCode2 = 'E'
        ,dlvContributionSign2 = CASE WHEN PdhSource1 > 0 THEN '+'  WHEN PdhSource1 < 0 THEN '-' END
        ,dlvContributionAmount2 = CASE WHEN PdhSource1 > 0 THEN dbo.dsi_fnPadZero(PdhSource1*100, 7,0) END
        ,dlvContributionAmount2b = CASE WHEN PdhSource1 > 0 THEN PdhSource1 END
        ,drvHCorLPTermDate = CASE WHEN DedCode_FSA  ='FSA' THEN EecDateOfTermination WHEN DedCode_FSAL ='FSAL' THEN EecDateOfTermination END
        ,drvHCorLPFSAElecAmt = dbo.dsi_fnPadZero(CASE WHEN DedCode_FSA = 'FSA' THEN EedEEGoalAmt_FSA *100 WHEN DedCode_FSAL = 'FSAL' THEN EedEEGoalAmt_FSAL*100 END, 7,0)
        ,drvHCorLPFSAEffDate = CASE WHEN DedCode_FSA ='FSA' THEN EedBenStartDate_FSA WHEN DedCode_FSAL ='FSAL'THEN EedBenStartDate_FSAL END
        ,drvDepCareFSATermDate = CASE WHEN DedCode_FSADC = 'FSADC' THEN eecdateoftermination END
        ,drvDepCareFSAElectDate = CASE WHEN DedCode_FSADC = 'FSADC' THEN EedBenStartDate_FSADC  END
        ,drvDepCareFSAElecAmt = dbo.dsi_fnPadZero(CASE WHEN DedCode_FSADC in ('FSADC') THEN EedEEGoalAmt_FSADC *100 END, 7,0)
    INTO dbo.U_EVENUHCFSA_drvTbl
    FROM dbo.U_EVENUHCFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                   and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                 and EXISTS(select 1 from dbo.U_EVENUHCFSA_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN  dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN (Select EedEEID, EedCoID
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedDedCode END) AS DedCode_FSA 
                        ,MAX(CASE WHEN EedDedCode IN ('FSADC') THEN EedDedCode  END) AS DedCode_FSADC
                        ,MAX(CASE WHEN EedDedCode IN ('FSAL') THEN EedDedCode  END) AS DedCode_FSAL
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSAL 
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedBenStartDate END) AS EedBenStartDate_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedBenStartDate END) AS EedBenStartDate_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedBenStartDate END) AS EedBenStartDate_FSAL 
                        ,MAX(EedBenStartDate) AS EedBenStartDate
                FROM dbo.EmpDed WITH (NOLOCK)
                Where EedDedCode  in ('FSA','FSADC','FSAL')
                GROUP BY EedEEID, EedCoID) FSARECS
                ON EedEEID = xEEID
                AND EedCOID = xCOID
                --select top 10 EedEEID, EedCoID, EedDedCode, EedBenStartDate, EedBenStatus, EedBenStatusDate, EedBenStopDate,  EedBenAmt,  EedEEAmt, EedEEGoalAmt,  EedStartDate, EedStopDate from dbo.EmpDed WITH (NOLOCK)

    --LEFT JOIN (SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId
    --            ,SUM(BdmEEGoalAmt) as BdmEEGoalAmt
    --            ,MAX(BdmBenStartDate) as BdmBenStartDate
    --            ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN BdmDedCode END) AS DedCode_FSA 
    --            ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmDedCode END) AS DedCode_FSADC
    --            ,MAX(CASE WHEN BdmDedCode IN ('FSAL') THEN BdmDedCode END) AS DedCode_FSAL

    --        FROM dbo.U_dsi_BDM_EVENUHCFSA  WITH (NOLOCK)
    --            Where bdmRunID = 'QB' and bdmIsPQB = 'Y' and BdmDedCode in ('FSA','FSADC','FSAL')
    --       GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId ) FSARECS
    --        ON BdmEEID = xEEID
    --        AND BdmCOID = xCOID
    ;

        IF OBJECT_ID('U_EVENUHCFSA_CB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_CB_drvTbl;
        SELECT
                 drvTotalHCandLPFSAAmt2    = SUM(EedEEGoalAmt_FSA) + SUM(EedEEGoalAmt_FSAL) 
                ,drvTotalDCFSAAmt2        = SUM(EedEEGoalAmt_FSADC)
        INTO dbo.U_EVENUHCFSA_CB_drvTbl
        FROM dbo.U_EVENUHCFSA_drvTbl WITH (NOLOCK)
        JOIN (Select EedEEID, EedCoID
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedDedCode END) AS DedCode_FSA 
                        ,MAX(CASE WHEN EedDedCode IN ('FSADC') THEN EedDedCode  END) AS DedCode_FSADC
                        ,MAX(CASE WHEN EedDedCode IN ('FSAL') THEN EedDedCode  END) AS DedCode_FSAL
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSAL  
            FROM dbo.EmpDed WITH (NOLOCK)
                Where EedDedCode  in ('FSA','FSADC','FSAL') 
                GROUP BY EedEEID, EedCoID) FSARECS
                ON EedEEID = drvEEID
                AND EedCOID = drvCOID
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENUHCFSA_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_HDR_drvTbl;
    SELECT DISTINCT
         drvHeaderFill = '0000000000000000000'
        ,drvVersionNumber = '001'
        ,drvDate = max(prgpaydate)
        --- prgpaydate for contribution file
        ,drvCustSpecID = '925515111'
        ,drvCycle = CASE    WHEN MAX(PgrPayFrequency) = 'S' and substring(MAX(PrgPerControl),9,1) = '1' THEN 'T01'
                            --If PgrPayFrequency = S and PrgPerControl ends in 1 and PrgPerControl is 2nd payroll of month send T02
                            WHEN  substring(MAX(PrgPerControl),9,1) = '2' THEN 'X01'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '3' THEN 'X02'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '4' THEN 'X03'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '5' THEN 'X04'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '6' THEN 'X05'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '7' THEN 'X06'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '8' THEN 'X07'
                            WHEN  substring(MAX(PrgPerControl),9,1) = '9' THEN 'X08'
                            END
        ,drvPolicyNumber = '0925515'
        ,drvTypeofFeed = 'PROD'
    INTO dbo.U_EVENUHCFSA_HDR_drvTbl
    FROM dbo.U_EVENUHCFSA_PEarHist WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENUHCFSA_TR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_TR_drvTbl;
    SELECT DISTINCT
         drvFiller9s = '99999999999999999999'
        ,drvRecordCount = (Select count(*) from dbo.U_EVENUHCFSA_drvTbl WITH (NOLOCK))
        --Right Justify, prefill with zeros
        ,drvTotalHCandLPFSAContSign = CASE    WHEN (Select SUM(PdhSource3)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ) > 0 THEN '+' 
                                            WHEN (Select SUM(PdhSource3)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ) < 0 THEN '-' 
                                            END
        ,drvTotalHCandLPFSAContAmt = dbo.dsi_fnPadZero((Select SUM(PdhSource3)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ),10,0)
        ,drvTotalDCFSAContAmtSign = CASE    WHEN (Select SUM(PdhSource1)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ) > 0 THEN '+' 
                                            WHEN (Select SUM(PdhSource1)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ) < 0 THEN '-' 
                                            END
        ,drvTotalDCFSAContAmt = dbo.dsi_fnPadZero((Select SUM(PdhSource1)*100 FROM dbo.U_EVENUHCFSA_PDedHist WITH (NOLOCK) ),10,0)
        ,drvTotalHCandLPFSAAmt = dbo.dsi_fnPadZero((Select Sum(drvTotalHCandLPFSAAmt2) *100 FROM dbo.U_EVENUHCFSA_CB_drvTbl  WITH (NOLOCK) ),10,0)
        ,drvTotalDCFSAAmt = dbo.dsi_fnPadZero((Select Sum(drvTotalDCFSAAmt2)*100  FROM dbo.U_EVENUHCFSA_CB_drvTbl  WITH (NOLOCK) ),10,0)
    INTO dbo.U_EVENUHCFSA_TR_drvTbl
    FROM dbo.U_EVENUHCFSA_drvTbl WITH (NOLOCK)
    ;
    END
    ------------------------------------------------------------------------------------------------------------
    ----Open Enrollment File
    IF @ExportCode  LIKE 'ONDEM_XOE%' or @ExportCode  LIKE 'SCH_XOE%'
    BEGIN

        IF OBJECT_ID('U_EVENUHCFSA_OE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_OE_drvTbl;
        SELECT
                 drvTotalHCandLPFSAAmt2    = SUM(EedEEGoalAmt_FSA) + SUM(EedEEGoalAmt_FSAL) 
                ,drvTotalDCFSAAmt2        = SUM(EedEEGoalAmt_FSADC)
        INTO dbo.U_EVENUHCFSA_OE_drvTbl
        FROM dbo.U_EVENUHCFSA_EEList WITH (NOLOCK)
        JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
            AND EecDateOfTermination is null
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        JOIN (Select EedEEID, EedCoID
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedDedCode END) AS DedCode_FSA 
                        ,MAX(CASE WHEN EedDedCode IN ('FSADC') THEN EedDedCode  END) AS DedCode_FSADC
                        ,MAX(CASE WHEN EedDedCode IN ('FSAL') THEN EedDedCode  END) AS DedCode_FSAL
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSAL  
            FROM dbo.EmpDed WITH (NOLOCK)
                Where EedDedCode  in ('FSA','FSADC','FSAL') AND EedBenStopDate is null
                GROUP BY EedEEID, EedCoID) FSARECS
                ON EedEEID = xEEID
                AND EedCOID = xCOID
    --------------------------------------
    -- DETAIL RECORD - U_EVENUHCFSA_drvTbl
    --------------------------------------
    IF OBJECT_ID('U_EVENUHCFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployerID = '000000000'
        ,drvMemberLastName = EepNameLast
        ,drvMemberFirstName = EepNameFirst
        ,drvMemberMiddleName = LEFT(EepNameMiddle,1)
        ,drvPermStreetAddr1 = eepAddressLine1
        ,drvPermStreetAddr2 = eepAddressLine2
        ,drvPermCity = EepAddressCity
        ,drvPermState = EepAddressState
        ,drvPermZip = EepAddressZipCode
        ,dmvMembBirth = EepDateOfBirth
        ,dlvPolicyNumber = '0925515'
        ,dlvPlanCode =  CASE    WHEN DedCode_FSA ='FSA' AND DedCode_FSADC = '' THEN '0001'
                                WHEN DedCode_FSA ='' AND DedCode_FSADC = 'FSADC' AND DedCode_FSAL = '' THEN '0001'
                                WHEN DedCode_FSA ='FSA' AND DedCode_FSADC = 'FSADC' THEN '0001'
                                WHEN DedCode_FSAL = 'FSAL' AND DedCode_FSADC = '' THEN '5001'
                                WHEN DedCode_FSAL = 'FSAL' AND DedCode_FSADC = 'FSADC' THEN '5001'
                                END
        ,davPlanEffective = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) 
        ,dlvEnrollmentDate = EedBenStartDate  
        ,dlvContributionType = '   '
        ,dnvContSourceCode1 = ' '
        ,dlvContributionSign1 = ' '
        ,dlvContributionAmount1 = '       '
        ,dlvContributionType2 = '   '
        ,dnvContSourceCode2 = ' '
        ,dlvContributionSign2 = ' '
        ,dlvContributionAmount2 = '       '
        ,drvHCorLPTermDate = CASE WHEN DedCode_FSA  ='FSA' THEN EecDateOfTermination WHEN DedCode_FSAL ='FSAL' THEN EecDateOfTermination END
        ,drvHCorLPFSAElecAmt = dbo.dsi_fnPadZero(CASE WHEN DedCode_FSA = 'FSA' THEN EedEEGoalAmt_FSA*100 WHEN DedCode_FSAL = 'FSAL' THEN EedEEGoalAmt_FSAL*100 END, 7,0)
        ,drvHCorLPFSAEffDate = CASE WHEN DedCode_FSA ='FSA' THEN EedBenStartDate_FSA WHEN DedCode_FSAL ='FSAL'THEN EedBenStartDate_FSAL END
        ,drvDepCareFSATermDate = CASE WHEN DedCode_FSADC = 'FSADC' THEN eecdateoftermination END
        ,drvDepCareFSAElectDate = CASE WHEN DedCode_FSADC = 'FSADC' THEN EedBenStartDate_FSADC  END
        ,drvDepCareFSAElecAmt = dbo.dsi_fnPadZero(CASE WHEN DedCode_FSADC in ('FSADC') THEN EedEEGoalAmt_FSADC *100 END, 7,0)
    INTO dbo.U_EVENUHCFSA_drvTbl
    FROM dbo.U_EVENUHCFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecDateOfTermination is null
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select EedEEID, EedCoID
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedDedCode END) AS DedCode_FSA 
                        ,MAX(CASE WHEN EedDedCode IN ('FSADC') THEN EedDedCode  END) AS DedCode_FSADC
                        ,MAX(CASE WHEN EedDedCode IN ('FSAL') THEN EedDedCode  END) AS DedCode_FSAL
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedEEGoalAmt END) AS EedEEGoalAmt_FSAL 
                        ,MAX(CASE WHEN EedDedCode in ('FSA') THEN EedBenStartDate END) AS EedBenStartDate_FSA  
                        ,MAX(CASE WHEN EedDedCode in ('FSADC') THEN EedBenStartDate END) AS EedBenStartDate_FSADC 
                        ,MAX(CASE WHEN EedDedCode in ('FSAL') THEN EedBenStartDate END) AS EedBenStartDate_FSAL 
                        ,MAX(EedBenStartDate) AS EedBenStartDate  
            FROM dbo.EmpDed WITH (NOLOCK)
            Where EedDedCode  in ('FSA','FSADC','FSAL') AND EedBenStopDate is null
            GROUP BY EedEEID, EedCoID) FSARECS
            ON EedEEID = xEEID
            AND EedCOID = xCOID

    --JOIN (SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId 
    --            ,SUM(BdmEEGoalAmt) as BdmEEGoalAmt
    --            ,MAX(BdmBenStartDate) as BdmBenStartDate
    --            ,MAX(CASE WHEN BdmDedCode in ('FSA') THEN BdmDedCode END) AS DedCode_FSA 
    --            ,MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN BdmDedCode END) AS DedCode_FSADC
    --            ,MAX(CASE WHEN BdmDedCode IN ('FSAL') THEN BdmDedCode END) AS DedCode_FSAL
    --FROM dbo.U_dsi_BDM_EVENUHCFSA  WITH (NOLOCK)
    --     Where  BdmDedCode in ('FSA','FSADC','FSAL')
    --     GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId ) FSARECS
    --     ON BdmEEID = xEEID
    --     AND BdmCOID = xCOID
    --;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
        IF OBJECT_ID('U_EVENUHCFSA_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_HDR_drvTbl;
    SELECT DISTINCT
         drvHeaderFill = '0000000000000000000'
        ,drvVersionNumber = '001'
        ,drvDate = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) 
        ,drvCustSpecID = '925515111'
        ,drvCycle = 'E01'
        ,drvPolicyNumber = '0925515'
        ,drvTypeofFeed = 'ENRL'
    INTO dbo.U_EVENUHCFSA_HDR_drvTbl
    FROM dbo.U_EVENUHCFSA_OE_drvTbl WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EVENUHCFSA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EVENUHCFSA_TR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVENUHCFSA_TR_drvTbl;
    SELECT DISTINCT
         drvFiller9s = '99999999999999999999'
        ,drvRecordCount =  dbo.dsi_fnPadZero((Select count(*) from dbo.U_EVENUHCFSA_drvTbl WITH (NOLOCK)),6,0)
        ,drvTotalHCandLPFSAContSign = ' '
        ,drvTotalHCandLPFSAContAmt = '          '
        ,drvTotalDCFSAContAmtSign = ' '
        ,drvTotalDCFSAContAmt = '          '
        ,drvTotalHCandLPFSAAmt = dbo.dsi_fnPadZero((Select Sum(drvTotalHCandLPFSAAmt2)*100 FROM dbo.U_EVENUHCFSA_OE_drvTbl WITH (NOLOCK) ),10,0)
        ,drvTotalDCFSAAmt = dbo.dsi_fnPadZero((Select Sum(drvTotalDCFSAAmt2)*100  FROM dbo.U_EVENUHCFSA_OE_drvTbl WITH (NOLOCK) ),10,0)
    INTO dbo.U_EVENUHCFSA_TR_drvTbl
    FROM  dbo.U_EVENUHCFSA_drvTbl WITH (NOLOCK)
    ;
    END
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'VENDOR_Customer_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.HHMMSS'
                                  ELSE 'VENDOR_Customer_Type_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.HHMMSS '
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEVENUHCFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVENUHCFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EVENUHCFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203231'
       ,expStartPerControl     = '202203231'
       ,expLastEndPerControl   = '202203309'
       ,expEndPerControl       = '202203309'
WHERE expFormatCode = 'EVENUHCFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVENUHCFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVENUHCFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EVENUHCFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EVENUHCFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EVENUHCFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENUHCFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EVENUHCFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVENUHCFSA', 'UseFileName', 'V', 'Y'


-- End ripout