/**********************************************************************************

EOPTFSAGRA: Optum FSA

FormatCode:     EOPTFSAGRA
Project:        Optum FSA
Client ID:      GRA1009
Date/time:      2022-01-04 09:33:05.573
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E12
Server:         E1SUP2DB53
Database:       ULTIPRO_GMC
Web Filename:   GRA1009_86360_EEHISTORY_EOPTFSAGRA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EOPTFSAGRA_SavePath') IS NOT NULL DROP TABLE dbo.U_EOPTFSAGRA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EOPTFSAGRA'


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
WHERE FormatCode = 'EOPTFSAGRA'
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
WHERE ExpFormatCode = 'EOPTFSAGRA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EOPTFSAGRA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EOPTFSAGRA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EOPTFSAGRA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EOPTFSAGRA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EOPTFSAGRA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EOPTFSAGRA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EOPTFSAGRA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EOPTFSAGRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EOPTFSAGRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EOPTFSAGRA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEOPTFSAGRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTFSAGRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTFSAGRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTFSAGRA];
GO
IF OBJECT_ID('U_EOPTFSAGRA_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_trlTbl];
GO
IF OBJECT_ID('U_EOPTFSAGRA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_PEarHist];
GO
IF OBJECT_ID('U_EOPTFSAGRA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_PDedHist];
GO
IF OBJECT_ID('U_EOPTFSAGRA_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_hdrTbl];
GO
IF OBJECT_ID('U_EOPTFSAGRA_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_File];
GO
IF OBJECT_ID('U_EOPTFSAGRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_EEList];
GO
IF OBJECT_ID('U_EOPTFSAGRA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_drvTbl];
GO
IF OBJECT_ID('U_EOPTFSAGRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_DedList];
GO
IF OBJECT_ID('U_EOPTFSAGRA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_AuditFields];
GO
IF OBJECT_ID('U_EOPTFSAGRA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EOPTFSAGRA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EOPTFSAGRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOPTFSAGRA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EOPTFSAGRA','Optum FSA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EOPTFSAGRAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOPTFSAGRAZ0','19','H','01','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOPTFSAGRAZ0','1','H','01','20',NULL,'Header Master Layout',NULL,NULL,'"hdrHeadMastLay"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOPTFSAGRAZ0','3','H','01','21',NULL,'System Name',NULL,NULL,'"hdrSysName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOPTFSAGRAZ0','4','H','01','24',NULL,'System Number',NULL,NULL,'"hdrSysNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOPTFSAGRAZ0','8','H','01','28',NULL,'Client Code',NULL,NULL,'"hdrClientCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOPTFSAGRAZ0','3','H','01','36',NULL,'Version Number',NULL,NULL,'"hdrVersNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOPTFSAGRAZ0','8','H','01','39',NULL,'Date',NULL,NULL,'"hdrDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOPTFSAGRAZ0','9','H','01','47',NULL,'Customer Specific ID',NULL,NULL,'"hdrCustSpecId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOPTFSAGRAZ0','30','H','01','56',NULL,'Customer Name',NULL,NULL,'"hdrCustName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EOPTFSAGRAZ0','3','H','01','86',NULL,'Cycle',NULL,NULL,'"hdrCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EOPTFSAGRAZ0','7','H','01','89',NULL,'Policy Number',NULL,NULL,'"hdrPolNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EOPTFSAGRAZ0','4','H','01','96',NULL,'Type of Feed',NULL,NULL,'"hdrTypeFeed"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EOPTFSAGRAZ0','1','H','01','100',NULL,'Multi-Coverage Data Indicator',NULL,NULL,'"hdrMultCovDataIndic"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EOPTFSAGRAZ0','400','H','01','101',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOPTFSAGRAZ0','1','D','10','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOPTFSAGRAZ0','9','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOPTFSAGRAZ0','9','D','10','11',NULL,'Employer ID/Employer Alt ID',NULL,NULL,'"drvEmpIdEmpAltId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOPTFSAGRAZ0','30','D','10','20',NULL,'Member Last Name',NULL,NULL,'"drvMemLName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOPTFSAGRAZ0','14','D','10','50',NULL,'Member First Name',NULL,NULL,'"drvMemFName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOPTFSAGRAZ0','1','D','10','64',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOPTFSAGRAZ0','1','D','10','65',NULL,'Member Middle Initial',NULL,NULL,'"drvMI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOPTFSAGRAZ0','4','D','10','66',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOPTFSAGRAZ0','4','D','10','70',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EOPTFSAGRAZ0','30','D','10','74',NULL,'Perm Street Address 1',NULL,NULL,'"drvPermAdd1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EOPTFSAGRAZ0','30','D','10','104',NULL,'Perm Street Address 2',NULL,NULL,'"drvPermAdd2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EOPTFSAGRAZ0','15','D','10','134',NULL,'Perm City',NULL,NULL,'"drvPermCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EOPTFSAGRAZ0','2','D','10','149',NULL,'Perm State',NULL,NULL,'"drvPermState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EOPTFSAGRAZ0','15','D','10','151',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EOPTFSAGRAZ0','9','D','10','166',NULL,'Perm Zip Code',NULL,NULL,'"drvPermZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EOPTFSAGRAZ0','1','D','10','175',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EOPTFSAGRAZ0','8','D','10','176',NULL,'Member Birth Date',NULL,NULL,'"drvMemDOB"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EOPTFSAGRAZ0','7','D','10','184',NULL,'Policy Num',NULL,NULL,'"drvPolNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EOPTFSAGRAZ0','4','D','10','191',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EOPTFSAGRAZ0','8','D','10','195',NULL,'Plan Eff Date',NULL,NULL,'"drvPlanEffDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EOPTFSAGRAZ0','6','D','10','203',NULL,'Reporting Code 1',NULL,NULL,'"drvRepCode1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EOPTFSAGRAZ0','2','D','10','209',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EOPTFSAGRAZ0','6','D','10','211',NULL,'Reporting Code 2',NULL,NULL,'"drvRepCode2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EOPTFSAGRAZ0','2','D','10','217',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EOPTFSAGRAZ0','8','D','10','219',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EOPTFSAGRAZ0','11','D','10','227',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EOPTFSAGRAZ0','3','D','10','238',NULL,'Contrib Type 1',NULL,NULL,'"drvContribType1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EOPTFSAGRAZ0','1','D','10','241',NULL,'Contrib Source Code 1',NULL,NULL,'"drvContribSC1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EOPTFSAGRAZ0','1','D','10','242',NULL,'Cont Sign 1',NULL,NULL,'"drvContribSign1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EOPTFSAGRAZ0','7','D','10','243',NULL,'Cont Amt 1',NULL,NULL,'"drvContribAmt1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EOPTFSAGRAZ0','3','D','10','250',NULL,'Cont Type 2',NULL,NULL,'"drvContribType2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EOPTFSAGRAZ0','1','D','10','253',NULL,'Cont Source Code 2',NULL,NULL,'"drvContribSC2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EOPTFSAGRAZ0','1','D','10','254',NULL,'Cont Sign 2',NULL,NULL,'"drvContribSign2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EOPTFSAGRAZ0','7','D','10','255',NULL,'Cont Amt 2',NULL,NULL,'"drvContribAmt2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EOPTFSAGRAZ0','3','D','10','262',NULL,'Cont Type 3',NULL,NULL,'"drvContribType3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EOPTFSAGRAZ0','1','D','10','265',NULL,'Cont Source Code 3',NULL,NULL,'"drvContribSC3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EOPTFSAGRAZ0','1','D','10','266',NULL,'Cont Sign 3',NULL,NULL,'"drvContribSign3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EOPTFSAGRAZ0','7','D','10','267',NULL,'Cont Amt 3',NULL,NULL,'"drvContribAmt3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EOPTFSAGRAZ0','3','D','10','274',NULL,'Cont Type 4',NULL,NULL,'"drvContribType4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EOPTFSAGRAZ0','1','D','10','277',NULL,'Cont Source Code 4',NULL,NULL,'"drvContribSC4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EOPTFSAGRAZ0','1','D','10','278',NULL,'Cont Sign 4',NULL,NULL,'"drvContribSign4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EOPTFSAGRAZ0','7','D','10','279',NULL,'Cont Amt 4',NULL,NULL,'"drvContribAmt4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EOPTFSAGRAZ0','1','D','10','286',NULL,'Auto Submission Indic',NULL,NULL,'"drvAutoSubIndic"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EOPTFSAGRAZ0','7','D','10','287',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EOPTFSAGRAZ0','8','D','10','294',NULL,'Healthcare or Limited Purp FSA Term Date',NULL,NULL,'"drvHealthLPFSATermDt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EOPTFSAGRAZ0','1','D','10','302',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EOPTFSAGRAZ0','7','D','10','303',NULL,'Healthcare or Limited Purp FSA Elect Amt',NULL,NULL,'"drvHealthLPFSAElectAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EOPTFSAGRAZ0','8','D','10','310',NULL,'Healthcare or Limited Purp FSA Elect Eff Date',NULL,NULL,'"drvHealthLPFSAElectEffDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EOPTFSAGRAZ0','2','D','10','318',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EOPTFSAGRAZ0','1','D','10','320',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EOPTFSAGRAZ0','9','D','10','321',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EOPTFSAGRAZ0','17','D','10','330',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EOPTFSAGRAZ0','2','D','10','347',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EOPTFSAGRAZ0','121','D','10','349',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EOPTFSAGRAZ0','1','D','10','470',NULL,'Prefund Sign',NULL,NULL,'"drvPrefundSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EOPTFSAGRAZ0','7','D','10','471',NULL,'Prefund Amount',NULL,NULL,'"drvPrefundAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EOPTFSAGRAZ0','8','D','10','478',NULL,'Dependent Care FSA Term Date',NULL,NULL,'"drvDepCareFSATermDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EOPTFSAGRAZ0','8','D','10','486',NULL,'Dependent Care FSA Elect Eff Date',NULL,NULL,'"drvDepCareFSAElectEffDt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EOPTFSAGRAZ0','7','D','10','494',NULL,'Dependent Care FSA Elect Amt',NULL,NULL,'"drvDepCareFSAElectAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EOPTFSAGRAZ0','20','T','90','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EOPTFSAGRAZ0','6','T','90','21',NULL,'Record Count',NULL,NULL,'"drvRecCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EOPTFSAGRAZ0','1','T','90','27',NULL,'Total Health Lim FSA Contrib Amt Sign',NULL,NULL,'"drvTotHealthLFSAContAmtSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EOPTFSAGRAZ0','10','T','90','28',NULL,'Total Health Lim FSA Contrib Amt',NULL,NULL,'"drvTotHealthLFSAContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EOPTFSAGRAZ0','1','T','90','38',NULL,'Total Dependent Care FSA Contrib Amt Sign',NULL,NULL,'"drvTotDepCareFSAContAmtSign"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EOPTFSAGRAZ0','10','T','90','39',NULL,'Total Dependent Care FSA Contrib Amt',NULL,NULL,'"drvTotDepCareFSAContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EOPTFSAGRAZ0','10','T','90','49',NULL,'Total Health and Lim FSA Elect Amt',NULL,NULL,'"drvTotHealthLFSAElectAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EOPTFSAGRAZ0','10','T','90','59',NULL,'Total Dependent Care FSA Elect Amt',NULL,NULL,'"drvTotDepCareFSAElectAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EOPTFSAGRAZ0','432','T','90','69',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EOPTFSAGRA_20220104.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum FSA Export','202112219','EMPEXPORT','ONDEM_XOE',NULL,'EOPTFSAGRA',NULL,NULL,NULL,'202112219','Dec 21 2021  4:29PM','Dec 21 2021  4:29PM','202112211',NULL,'','','202112211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Optum FSA Export-Sched','202112219','EMPEXPORT','SCH_EOPTFS',NULL,'EOPTFSAGRA',NULL,NULL,NULL,'202112219','Dec 21 2021  4:29PM','Dec 21 2021  4:29PM','202112211',NULL,'','','202112211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Optum FSA Export-Test','202112219','EMPEXPORT','TEST_XOE',NULL,'EOPTFSAGRA',NULL,NULL,NULL,'202112219','Dec 21 2021  4:29PM','Dec 21 2021  4:29PM','202112211',NULL,'','','202112211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTFSAGRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTFSAGRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTFSAGRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTFSAGRA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTFSAGRA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTFSAGRA','H01','dbo.U_EOPTFSAGRA_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTFSAGRA','D10','dbo.U_EOPTFSAGRA_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTFSAGRA','T90','dbo.U_EOPTFSAGRA_trlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EOPTFSAGRA
-----------

IF OBJECT_ID('U_dsi_BDM_EOPTFSAGRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOPTFSAGRA] (
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
-- Create table U_EOPTFSAGRA_Audit
-----------

IF OBJECT_ID('U_EOPTFSAGRA_Audit') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EOPTFSAGRA_AuditFields
-----------

IF OBJECT_ID('U_EOPTFSAGRA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EOPTFSAGRA_DedList
-----------

IF OBJECT_ID('U_EOPTFSAGRA_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EOPTFSAGRA_drvTbl
-----------

IF OBJECT_ID('U_EOPTFSAGRA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpId] char(11) NULL,
    [drvEmpIdEmpAltId] varchar(9) NOT NULL,
    [drvMemLName] varchar(100) NULL,
    [drvMemFName] varchar(100) NULL,
    [drvMI] varchar(1) NOT NULL,
    [drvPermAdd1] varchar(255) NULL,
    [drvPermAdd2] varchar(255) NULL,
    [drvPermCity] varchar(255) NULL,
    [drvPermState] varchar(255) NULL,
    [drvPermZip] varchar(50) NULL,
    [drvMemDOB] datetime NULL,
    [drvPolNum] varchar(7) NOT NULL,
    [drvPlanCode] varchar(4) NOT NULL,
    [drvPlanEffDt] datetime NULL,
    [drvRepCode1] varchar(1) NOT NULL,
    [drvRepCode2] varchar(1) NOT NULL,
    [drvEnrollDt] datetime NULL,
    [drvContribType1] varchar(3) NOT NULL,
    [drvContribSC1] varchar(1) NOT NULL,
    [drvContribSign1] varchar(1) NOT NULL,
    [drvContribAmt1] varchar(7) NOT NULL,
    [drvContribType2] varchar(3) NOT NULL,
    [drvContribSC2] varchar(1) NOT NULL,
    [drvContribSign2] varchar(1) NOT NULL,
    [drvContribAmt2] varchar(7) NOT NULL,
    [drvContribType3] varchar(3) NOT NULL,
    [drvContribSC3] varchar(1) NOT NULL,
    [drvContribSign3] varchar(1) NOT NULL,
    [drvContribAmt3] varchar(7) NOT NULL,
    [drvContribType4] varchar(3) NOT NULL,
    [drvContribSC4] varchar(1) NOT NULL,
    [drvContribSign4] varchar(1) NOT NULL,
    [drvContribAmt4] varchar(7) NOT NULL,
    [drvAutoSubIndic] varchar(1) NOT NULL,
    [drvHealthLPFSATermDt] varchar(30) NOT NULL,
    [drvHealthLPFSAElectAmt] varchar(7) NOT NULL,
    [drvHealthLPFSAElectEffDt] datetime NULL,
    [drvPrefundSign] varchar(1) NOT NULL,
    [drvPrefundAmt] varchar(7) NOT NULL,
    [drvDepCareFSATermDt] varchar(30) NOT NULL,
    [drvDepCareFSAElectEffDt] datetime NULL,
    [drvDepCareFSAElectAmt] varchar(7) NOT NULL
);

-----------
-- Create table U_EOPTFSAGRA_EEList
-----------

IF OBJECT_ID('U_EOPTFSAGRA_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EOPTFSAGRA_File
-----------

IF OBJECT_ID('U_EOPTFSAGRA_File') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EOPTFSAGRA_hdrTbl
-----------

IF OBJECT_ID('U_EOPTFSAGRA_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_hdrTbl] (
    [hdrHeadMastLay] varchar(1) NOT NULL,
    [hdrSysName] varchar(3) NOT NULL,
    [hdrSysNum] varchar(4) NOT NULL,
    [hdrClientCode] varchar(9) NOT NULL,
    [hdrVersNum] varchar(3) NOT NULL,
    [hdrDate] datetime NULL,
    [hdrCustSpecId] varchar(9) NOT NULL,
    [hdrCustName] varchar(6) NOT NULL,
    [hdrCycle] varchar(31) NULL,
    [hdrPolNum] varchar(7) NOT NULL,
    [hdrTypeFeed] varchar(4) NOT NULL,
    [hdrMultCovDataIndic] varchar(1) NOT NULL
);

-----------
-- Create table U_EOPTFSAGRA_PDedHist
-----------

IF OBJECT_ID('U_EOPTFSAGRA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
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
-- Create table U_EOPTFSAGRA_PEarHist
-----------

IF OBJECT_ID('U_EOPTFSAGRA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgOrigPayPeriod] char(1) NULL,
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
-- Create table U_EOPTFSAGRA_trlTbl
-----------

IF OBJECT_ID('U_EOPTFSAGRA_trlTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTFSAGRA_trlTbl] (
    [drvRecCount] varchar(6) NULL,
    [drvTotHealthLFSAContAmtSign] varchar(1) NOT NULL,
    [drvTotHealthLFSAContAmt] varchar(10) NOT NULL,
    [drvTotDepCareFSAContAmtSign] varchar(1) NOT NULL,
    [drvTotDepCareFSAContAmt] varchar(30) NULL,
    [drvTotHealthLFSAElectAmt] varchar(10) NOT NULL,
    [drvTotDepCareFSAElectAmt] varchar(10) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTFSAGRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Grange Insurance

Created By: Andy Pineda
Business Analyst: Richard Vars
Create Date: 12/21/2021
Service Request Number: TekP-2021-08-23-0001

Purpose: Optum FSA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTFSAGRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTFSAGRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTFSAGRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTFSAGRA', 'SCH_EOPTFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTFSAGRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EOPTFSAGRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTFSAGRA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2022' AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EOPTFSAGRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTFSAGRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FLXDG' -- 'FLXBG';

    IF OBJECT_ID('U_EOPTFSAGRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTFSAGRA_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EOPTFSAGRA_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EOPTFSAGRA_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    ,PdhCOID
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
    --INTO dbo.U_EOPTFSAGRA_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EOPTFSAGRA_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID, PdhCOID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgOrigPayPeriod        = MAX(PrgOrigPayPeriod)
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
    INTO dbo.U_EOPTFSAGRA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;

    --Code for "terminations sent one time only". One time means sent one time during the per control range.

    --Audit Table
    IF OBJECT_ID('U_EOPTFSAGRA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_AuditFields;
    CREATE TABLE dbo.U_EOPTFSAGRA_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EOPTFSAGRA_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EOPTFSAGRA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_Audit;

    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EOPTFSAGRA_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EOPTFSAGRA_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EOPTFSAGRA_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EOPTFSAGRA_Audit ON dbo.U_EOPTFSAGRA_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTFSAGRA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpId = CASE WHEN BdmRecType = 'EMP' THEN EepSSN ELSE ConSSN END
        ,drvEmpIdEmpAltId = '000000000'
        ,drvMemLName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemFName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMI = ''
        ,drvPermAdd1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvPermAdd2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvPermCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvPermState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvPermZip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvMemDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvPolNum = '0925268'
        ,drvPlanCode = '0001'
        ,drvPlanEffDt = BdmBenStartDate
        ,drvRepCode1 = ''
        ,drvRepCode2 = ''
        ,drvEnrollDt = EecDateOfOriginalHire
        ,drvContribType1 = 'MED' 
        ,drvContribSC1 = 'E'
        ,drvContribSign1 = '+'
        ,drvContribAmt1 = '0000000'
        ,drvContribType2 = 'DEP'
        ,drvContribSC2 = 'E'
        ,drvContribSign2 = '+'
        ,drvContribAmt2 = '0000000'
        ,drvContribType3 = 'MED'
        ,drvContribSC3 = 'P'
        ,drvContribSign3 = '+'
        ,drvContribAmt3 = '0000000'
        ,drvContribType4 = 'DEP'
        ,drvContribSC4 = 'P'
        ,drvContribSign4 = '+'
        ,drvContribAmt4 = '0000000'
        ,drvAutoSubIndic = ''
        ,drvHealthLPFSATermDt = ISNULL(CONVERT(VARCHAR, BdmBenStopDate, 112), '')
        ,drvHealthLPFSAElectAmt = '0000000'
        ,drvHealthLPFSAElectEffDt = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvPrefundSign = '+'
        ,drvPrefundAmt = '0000000'
        ,drvDepCareFSATermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN BdmRecType = 'DEP' THEN BdmBenStopDate END), 112), '')
        ,drvDepCareFSAElectEffDt = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvDepCareFSAElectAmt = '0000000'
    INTO dbo.U_EOPTFSAGRA_drvTbl
    FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EOPTFSAGRA_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_dsi_BDM_EOPTFSAGRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK)
        ON PehEEID = xEEID
        AND PehCOID = xCOID
    LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_hdrTbl;
    SELECT DISTINCT
         hdrHeadMastLay = '6'
        ,hdrSysName = 'FSA'
        ,hdrSysNum = '5426'
        ,hdrClientCode = '925268111'
        ,hdrVersNum = '001'
        ,hdrDate = (SELECT MAX(PrgPayDate) FROM dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK))
        ,hdrCustSpecId = '925268111'
        ,hdrCustName = 'Grange'
        ,hdrCycle = (SELECT MAX(PrgOrigPayPeriod + CAST(DATEPART(WEEK, PrgPayDate) AS VARCHAR)) FROM dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK))
        ,hdrPolNum = '0925268'
        ,hdrTypeFeed = 'PROD'
        ,hdrMultCovDataIndic = 'A'
    INTO dbo.U_EOPTFSAGRA_hdrTbl
 --   FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTFSAGRA_trlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTFSAGRA_trlTbl;
    SELECT DISTINCT
         drvRecCount = RIGHT('000000' + (SELECT COUNT(1) FROM dbo.U_EOPTFSAGRA_drvTbl WITH(NOLOCK)), 6)
        ,drvTotHealthLFSAContAmtSign = '+'
        ,drvTotHealthLFSAContAmt = '0000000000'
        ,drvTotDepCareFSAContAmtSign = '+'
        ,drvTotDepCareFSAContAmt = CAST(ROUND((SELECT SUM(PehCurAmtYTD) FROM dbo.U_EOPTFSAGRA_PEarHist WITH(NOLOCK)), 0) AS VARCHAR)
        ,drvTotHealthLFSAElectAmt = '0000000000'
        ,drvTotDepCareFSAElectAmt = '0000000000'
    INTO dbo.U_EOPTFSAGRA_trlTbl
   -- FROM dbo.U_EOPTFSAGRA_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEOPTFSAGRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTFSAGRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTFSAGRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112141'
       ,expStartPerControl     = '202112141'
       ,expLastEndPerControl   = '202112219'
       ,expEndPerControl       = '202112219'
WHERE expFormatCode = 'EOPTFSAGRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTFSAGRA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTFSAGRA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EOPTFSAGRA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EOPTFSAGRA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EOPTFSAGRA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOPTFSAGRA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EOPTFSAGRA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EOPTFSAGRA', 'UseFileName', 'V', 'Y'


-- End ripout