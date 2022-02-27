/**********************************************************************************

EUHCFSA: UHC FSA

FormatCode:     EUHCFSA
Project:        UHC FSA
Client ID:      FLA1000
Date/time:      2021-12-03 13:45:38.963
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP1DB02
Database:       ULTIPRO_WPFLTRN
Web Filename:   FLA1000_C954E_EEHISTORY_EUHCFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUHCFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EUHCFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUHCFSA'


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
WHERE FormatCode = 'EUHCFSA'
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
WHERE ExpFormatCode = 'EUHCFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUHCFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUHCFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUHCFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUHCFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUHCFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUHCFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUHCFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUHCFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUHCFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUHCFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFSA];
GO
IF OBJECT_ID('U_EUHCFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_Trailer];
GO
IF OBJECT_ID('U_EUHCFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_PEarHist];
GO
IF OBJECT_ID('U_EUHCFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_PDedHist];
GO
IF OBJECT_ID('U_EUHCFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_Header];
GO
IF OBJECT_ID('U_EUHCFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_File];
GO
IF OBJECT_ID('U_EUHCFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_EEList];
GO
IF OBJECT_ID('U_EUHCFSA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_drvTbl];
GO
IF OBJECT_ID('U_EUHCFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUHCFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUHCFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUHCFSA','UHC FSA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EUHCFSA000Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFSA000Z0','19','H','01','1',NULL,'Header Filler',NULL,NULL,'"0000000000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFSA000Z0','1','H','01','2',NULL,'Header Master Layout',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFSA000Z0','3','H','01','3',NULL,'System Name',NULL,NULL,'"FSA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFSA000Z0','4','H','01','4',NULL,'System Number',NULL,NULL,'"5426"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFSA000Z0','8','H','01','5',NULL,'Client Code',NULL,NULL,'"FLATIRON"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFSA000Z0','3','H','01','6',NULL,'Version Number',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFSA000Z0','8','H','01','7',NULL,'Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUHCFSA000Z0','9','H','01','8',NULL,'Customer Specific ID',NULL,NULL,'"922327111"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUHCFSA000Z0','30','H','01','9',NULL,'Customer Name',NULL,NULL,'"Flatiron Health Inc"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUHCFSA000Z0','3','H','01','10',NULL,'Cycle',NULL,NULL,'"drvWeekOfYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUHCFSA000Z0','7','H','01','11',NULL,'Policy Number',NULL,NULL,'"0922327"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUHCFSA000Z0','4','H','01','12',NULL,'Type of Feed',NULL,NULL,'"PROD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUHCFSA000Z0','1','H','01','13',NULL,'Multi-Coverage Data Indicator',NULL,NULL,'"drvIsDependentCareElection"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUHCFSA000Z0','400','H','01','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFSA000Z0','1','D','10','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFSA000Z0','9','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFSA000Z0','9','D','10','3',NULL,'Employer ID/Employer Alt ID',NULL,NULL,'"0000000000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFSA000Z0','30','D','10','4',NULL,'Member Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFSA000Z0','14','D','10','5',NULL,'Member First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFSA000Z0','1','D','10','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFSA000Z0','1','D','10','7',NULL,'Member Middle Initial',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUHCFSA000Z0','4','D','10','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUHCFSA000Z0','4','D','10','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUHCFSA000Z0','30','D','10','10',NULL,'Permanent Street Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUHCFSA000Z0','30','D','10','11',NULL,'Permanent Street Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUHCFSA000Z0','15','D','10','12',NULL,'Permanent City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUHCFSA000Z0','2','D','10','13',NULL,'Permanent State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUHCFSA000Z0','15','D','10','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUHCFSA000Z0','9','D','10','15',NULL,'Permanent Zip Code',NULL,NULL,'"drvAddressZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUHCFSA000Z0','1','D','10','16',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUHCFSA000Z0','8','D','10','17',NULL,'Member Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUHCFSA000Z0','7','D','10','18',NULL,'Policy Number',NULL,NULL,'"drvPolicyNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUHCFSA000Z0','4','D','10','19',NULL,'Plan Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUHCFSA000Z0','8','D','10','20',NULL,'Plan Effective Date',NULL,NULL,'"drvBenStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUHCFSA000Z0','6','D','10','21',NULL,'Reporting Code 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUHCFSA000Z0','2','D','10','22',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUHCFSA000Z0','6','D','10','23',NULL,'Reporting Code 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUHCFSA000Z0','2','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUHCFSA000Z0','8','D','10','25',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUHCFSA000Z0','11','D','10','26',NULL,'Numeric Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUHCFSA000Z0','3','D','10','27',NULL,'Contribution Type 1',NULL,NULL,'"drvContributionType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUHCFSA000Z0','1','D','10','28',NULL,'Contribution Source Code 1',NULL,NULL,'"drvContributionSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUHCFSA000Z0','1','D','10','29',NULL,'Contribution Sign 1',NULL,NULL,'"drvContributionSign1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUHCFSA000Z0','7','D','10','30',NULL,'Contribution Amount 1',NULL,NULL,'"drvContributionAmount1"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUHCFSA000Z0','3','D','10','31',NULL,'Contribution Type 2',NULL,NULL,'"drvContributionType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUHCFSA000Z0','1','D','10','32',NULL,'Contribution Source Code 2',NULL,NULL,'"drvContributionSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUHCFSA000Z0','1','D','10','33',NULL,'Contribution Sign 2',NULL,NULL,'"drvContributionSign2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUHCFSA000Z0','7','D','10','34',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUHCFSA000Z0','3','D','10','35',NULL,'Contribution Type 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUHCFSA000Z0','1','D','10','36',NULL,'Contribution Source Code 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUHCFSA000Z0','1','D','10','37',NULL,'Contribution Sign 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUHCFSA000Z0','7','D','10','38',NULL,'Contribution Amount 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUHCFSA000Z0','3','D','10','39',NULL,'Contribution Type 4: ',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUHCFSA000Z0','1','D','10','40',NULL,'Contribution Source Code 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUHCFSA000Z0','1','D','10','41',NULL,'Contribution Sign 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUHCFSA000Z0','7','D','10','42',NULL,'Contribution Amount 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUHCFSA000Z0','1','D','10','43',NULL,'Automatic Submission Indicator/Coordinate Payment',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUHCFSA000Z0','7','D','10','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUHCFSA000Z0','8','D','10','45',NULL,'Healthcare or Limited Purpose FSA Termination Date',NULL,NULL,'"drvHlthTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUHCFSA000Z0','1','D','10','46',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUHCFSA000Z0','7','D','10','47',NULL,'Healthcare or Limited Purpose FSA Election Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUHCFSA000Z0','8','D','10','48',NULL,'Healthcare or Limited Purpose FSA Election Effecti',NULL,NULL,'"drvHlthElectionDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUHCFSA000Z0','2','D','10','49',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUHCFSA000Z0','1','D','10','50',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUHCFSA000Z0','9','D','10','51',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUHCFSA000Z0','17','D','10','52',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUHCFSA000Z0','2','D','10','53',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUHCFSA000Z0','112','D','10','54',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUHCFSA000Z0','1','D','10','55',NULL,'Payroll Frequency (Assumed Contributions only)',NULL,NULL,'"drvPayFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUHCFSA000Z0','8','D','10','56',NULL,'Payroll Frequency Effective Date (Assumed Contribu',NULL,NULL,'"drvPayFreqEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUHCFSA000Z0','1','D','10','57',NULL,'Prefund Sign',NULL,NULL,'"drvPrefundSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUHCFSA000Z0','7','D','10','58',NULL,'Prefund Amount',NULL,NULL,'"drvPrefundAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUHCFSA000Z0','8','D','10','59',NULL,'Dependent Care FSA Termination Date',NULL,NULL,'"drvFSATermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUHCFSA000Z0','8','D','10','60',NULL,'Dependent Care FSA Election Effective Date',NULL,NULL,'"drvFSABenStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUHCFSA000Z0','7','D','10','61',NULL,'Dependent Care FSA Election Amount',NULL,NULL,'"drvFSAElectionAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFSA000Z0','20','T','90','1',NULL,'Filler',NULL,NULL,'"99999999999999999999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFSA000Z0','6','T','90','2',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFSA000Z0','1','T','90','3',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvLimitedContSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFSA000Z0','10','T','90','4',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL,'"drvLimitedContAmt"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFSA000Z0','1','T','90','5',NULL,'Total Dependent Care FSA Contribution Amount Sign',NULL,NULL,'"drvDependentContSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFSA000Z0','10','T','90','6',NULL,'Total Dependent Care FSA Contribution Amount',NULL,NULL,'"drvDependentContAmt"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFSA000Z0','10','T','90','7',NULL,'Total Healthcare and Limited Purpose FSA Election',NULL,NULL,'"drvLimitedElectionAmt"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUHCFSA000Z0','10','T','90','8',NULL,'Total Dependent Care FSA Election Amount',NULL,NULL,'"drvDependentElectionAmt"','(''UNP0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUHCFSA000Z0','432','T','90','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUHCFSA_20211203.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UHC FSA Export','202106199','EMPEXPORT','ONDEM_XOE','Aug 25 2021  7:49PM','EUHCFSA',NULL,NULL,NULL,'202106199','Jun 19 2021  1:18PM','Jun 19 2021  1:18PM','202106191','373','','','202103191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FSA-Sched Export','202106199','EMPEXPORT','SCH_EUHCFS',NULL,'EUHCFSA',NULL,NULL,NULL,'202106199','Jun 19 2021  1:18PM','Jun 19 2021  1:18PM','202106191',NULL,'','','202103191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'UHC FSA-Test Export','202108319','EMPEXPORT','TEST_XOE','Sep 14 2021 11:20AM','EUHCFSA',NULL,NULL,NULL,'202108319','Aug 31 2021 12:00AM','Dec 30 1899 12:00AM','202108311','331','','','202108311',dbo.fn_GetTimedKey(),NULL,'us3rVaFLA1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFSA','H01','dbo.U_EUHCFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFSA','D10','dbo.U_EUHCFSA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFSA','T90','dbo.U_EUHCFSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUHCFSA
-----------

IF OBJECT_ID('U_dsi_BDM_EUHCFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUHCFSA] (
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
-- Create table U_EUHCFSA_DedList
-----------

IF OBJECT_ID('U_EUHCFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUHCFSA_drvTbl
-----------

IF OBJECT_ID('U_EUHCFSA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZip] varchar(1) NOT NULL,
    [drvDateOfBirth] varchar(1) NOT NULL,
    [drvPolicyNum] varchar(1) NOT NULL,
    [drvBenStartDate] varchar(1) NOT NULL,
    [drvEnrollmentDate] varchar(1) NOT NULL,
    [drvContributionType1] varchar(3) NULL,
    [drvContributionSource1] varchar(1) NULL,
    [drvContributionSign1] varchar(1) NOT NULL,
    [drvContributionAmount1] numeric NULL,
    [drvContributionType2] varchar(3) NULL,
    [drvContributionSource2] varchar(1) NULL,
    [drvContributionSign2] varchar(1) NOT NULL,
    [drvContributionAmount2] numeric NULL,
    [drvHlthTermDate] int NULL,
    [drvHlthElectionDate] int NULL,
    [drvPayFreq] varchar(1) NOT NULL,
    [drvPayFreqEffDate] int NULL,
    [drvPrefundSign] varchar(1) NOT NULL,
    [drvPrefundAmt] varchar(1) NOT NULL,
    [drvFSATermDate] int NULL,
    [drvFSABenStartDate] int NULL,
    [drvFSAElectionAmt] varchar(1) NOT NULL
);

-----------
-- Create table U_EUHCFSA_EEList
-----------

IF OBJECT_ID('U_EUHCFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUHCFSA_File
-----------

IF OBJECT_ID('U_EUHCFSA_File') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EUHCFSA_Header
-----------

IF OBJECT_ID('U_EUHCFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_Header] (
    [drvPayDate] datetime NULL,
    [drvWeekOfYear] varchar(3) NULL,
    [drvIsDependentCareElection] varchar(1) NOT NULL
);

-----------
-- Create table U_EUHCFSA_PDedHist
-----------

IF OBJECT_ID('U_EUHCFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PdhFSAMDContAmt] numeric NULL,
    [PdhFSADCContAmt] numeric NULL,
    [PdhFSAIContAmt] numeric NULL
);

-----------
-- Create table U_EUHCFSA_PEarHist
-----------

IF OBJECT_ID('U_EUHCFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_PEarHist] (
    [PrgPayDate] datetime NULL,
    [PrgPayDateNo] bigint NULL
);

-----------
-- Create table U_EUHCFSA_Trailer
-----------

IF OBJECT_ID('U_EUHCFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUHCFSA_Trailer] (
    [drvRecordCount] int NULL,
    [drvLimitedContSign] varchar(1) NULL,
    [drvLimitedContAmt] numeric NULL,
    [drvDependentContSign] varchar(1) NULL,
    [drvDependentContAmt] numeric NULL,
    [drvLimitedElectionAmt] numeric NULL,
    [drvDependentElectionAmt] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Flatiron

Created By: Keary McCutchen
Business Analyst: Richard Vars
Create Date: 06/18/2021
Service Request Number: TekP-2021-03-29-0003

Purpose: UHC FSA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUHCFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFSA', 'SCH_EUHCFS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUHCFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EUHCFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '20210101'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAMD, FSAI, FSADC';

    IF OBJECT_ID('U_EUHCFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUHCFSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
         

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
    EXEC dbo.dsi_bdm_sp_BuildConsolidatedTable @FormatCode, 'Standard';

    
    --==========================================
    -- Build Working Tables
    --==========================================
     -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUHCFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_PEarHist;
    SELECT DISTINCT
         PrgPayDate             = PrgPayDate
        ,PrgPayDateNo = ROW_NUMBER() OVER(ORDER BY PrgPayDate ASC)
    INTO dbo.U_EUHCFSA_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    WHERE LEFT(PrgPerControl,4) = LEFT(@EndPerControl,4)
    AND PrgPerControl <= @EndPerControl
    AND RIGHT(PrgPerControl,1) = '1'
    GROUP BY PrgPayDate
    ;

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUHCFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PrgPayDate
        -- Categorize Payroll Amounts
        ,PdhFSAMDContAmt   = SUM(CASE WHEN PdhDedCode IN ('FSAMD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSADCContAmt   = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAIContAmt  = SUM(CASE WHEN PdhDedCode IN ('FSAI') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EUHCFSA_PDedHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhGenNumber = PrgGenNumber
    JOIN dbo.U_EUHCFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, PrgPayDate
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUHCFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE EepNameFirst END
        ,drvAddressLine1 = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAddressState = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZip = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvDateOfBirth = ''--CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvPolicyNum = '' --'0922327'
        ,drvBenStartDate =  ''--dbo.dsi_fnGetMinMaxDates('MAX',CASE WHEN ISNULL(BdmFSADCStartDate,'19000101') > ISNULL(BdmFSAMDStartDate,'19000101') THEN BdmFSAMDStartDate ELSE BdmFSADCStartDate END,  @FileMinCovDate) 
        ,drvEnrollmentDate = ''--CASE WHEN EecDateOfLastHire < CAST(@FileMinCovDate AS DATE) THEN CAST(@FileMinCovDate AS DATE) ELSE EecDateOfLastHire END
        ,drvContributionType1 = CASE WHEN  BdmHasFSAMD = 'Y' THEN  'MED' END
        ,drvContributionSource1 = CASE WHEN BdmRecType = 'EMP' THEN 'E' END
        ,drvContributionSign1 = CASE WHEN SIGN(PdhFSAMDContAmt) < 0 THEN '-'
                                     ELSE '+'
                                END
        ,drvContributionAmount1 = PdhFSAMDContAmt
        ,drvContributionType2 = CASE WHEN BdmHasFSADC = 'Y' THEN  'DEP' END
        ,drvContributionSource2 = CASE WHEN BdmRecType = 'EMP' THEN 'E' END
        ,drvContributionSign2 = CASE WHEN SIGN(PdhFSADCContAmt) < 0 THEN '-'
                                     ELSE '+'
                                END
        ,drvContributionAmount2 = PdhFSADCContAmt
        ,drvHlthTermDate =  NULL--BdmFSAMDStopDate
        ,drvHlthElectionDate = NULL--dbo.dsi_fnGetMinMaxDates('MAX',BdmFSAMDStartDate,  @FileMinCovDate) 
        ,drvPayFreq = ''/*CASE EecPayGroup 
                            WHEN 'REG' THEN 'Bi-Weekly'
                            WHEN '1099' THEN 'Monthly'
                            WHEN 'PT' THEN 'Weekly'
                            WHEN 'ABS' THEN 'Weekly'
                      END*/
        ,drvPayFreqEffDate = NULL--CASE WHEN ISNULL(BdmFSADCStartDate,'19000101') > ISNULL(BdmFSAMDStartDate,'19000101') THEN BdmFSAMDStartDate ELSE BdmFSADCStartDate END
        ,drvPrefundSign = ''--CASE WHEN SIGN(0) = '1' THEN '+' END
        ,drvPrefundAmt = ''--Wait for email from richard.
        ,drvFSATermDate =NULL-- BdmFSADCStopDate
        ,drvFSABenStartDate = NULL--BdmFSADCStartDate
        ,drvFSAElectionAmt = ''--PdhFSADCContAmt
    INTO dbo.U_EUHCFSA_drvTbl
    FROM dbo.U_EUHCFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (SELECT BdmEEID
                ,BdmCOID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmHasFSADC = MAX(CASE WHEN BdmDedCode = 'FSADC' THEN 'Y' END)
                ,BdmHasFSAMD = MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN 'Y' END)
                ,BdmFSADCStartDate = MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStartDate END)
                ,BdmFSADCStopDate = MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStopDate END)
                ,BdmFSAMDStartDate = MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStartDate END)
                ,BdmFSAMDStopDate = MAX(CASE WHEN BdmDedCode = 'FSAMD' THEN BdmBenStopDate END)
            FROM dbo.u_dsi_bdm_EUHCFSA WITH (NOLOCK)
            GROUP BY BdmEEID
                    ,BdmCOID
                    ,BdmDepRecID
                    ,BdmRecType
        ) Bdm
        ON BdmEEID = xEEID 
       AND BdmCoID = xCoID
    LEFT
    JOIN dbo.U_EUHCFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConSystemID = BdmDepRecID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_Header;
    SELECT DISTINCT
         drvPayDate = MAX(PrgPayDate)
        ,drvWeekOfYear = 'T' + RIGHT('00'+CAST(MAX(PrgPayDateNo) AS VARCHAR(2)),2)
        ,drvIsDependentCareElection = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR  @ExportCode LIKE 'TEST%' THEN ' ' ELSE 'A'END
    INTO dbo.U_EUHCFSA_Header
    FROM dbo.U_EUHCFSA_PEarHist WITH (NOLOCK)
    ;
    
    --------------------------------
    -- TRAILER RECORD --
    ---------------------------------
    IF OBJECT_ID('U_EUHCFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFSA_Trailer;
    SELECT DISTINCT 
        drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EUHCFSA_drvTbl WITH (NOLOCK))
        ,drvLimitedContSign = CASE SIGN(SUM(PdhFSAIContAmt))
                                             WHEN -1 THEN '-'
                                             WHEN  1 THEN '+'
                                          END
        ,drvLimitedContAmt = SUM(PdhFSAIContAmt) 
        ,drvDependentContSign = CASE SIGN(SUM(PdhFSADCContAmt))
                                    WHEN -1 THEN '-'
                                    WHEN  1 THEN '+'
                                END
        ,drvDependentContAmt = SUM(PdhFSADCContAmt) 
        ,drvLimitedElectionAmt = SUM(PdhFSAIContAmt) + SUM(PdhFSAMDContAmt) 
        ,drvDependentElectionAmt = SUM(PdhFSADCContAmt) 
    INTO dbo.U_EUHCFSA_Trailer
    FROM dbo.U_EUHCFSA_PDedHist WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEUHCFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUHCFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101111'
       ,expStartPerControl     = '202101111'
       ,expLastEndPerControl   = '202106189'
       ,expEndPerControl       = '202106189'
WHERE expFormatCode = 'EUHCFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUHCFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUHCFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUHCFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUHCFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUHCFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCFSA', 'UseFileName', 'V', 'Y'


-- End ripout