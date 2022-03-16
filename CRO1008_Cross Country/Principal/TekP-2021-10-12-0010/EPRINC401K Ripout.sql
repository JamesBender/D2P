/**********************************************************************************

EPRINC401K: Principal 401K Export

FormatCode:     EPRINC401K
Project:        Principal 401K Export
Client ID:      CRO1008
Date/time:      2021-12-29 20:27:11.850
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPCROS
Web Filename:   CRO1008_7QAC2_EEHISTORY_EPRINC401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRINC401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRINC401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRINC401K'


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
WHERE FormatCode = 'EPRINC401K'
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
WHERE ExpFormatCode = 'EPRINC401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRINC401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRINC401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRINC401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRINC401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRINC401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRINC401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRINC401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRINC401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRINC401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRINC401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPRINC401K_OLD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRINC401K_OLD_Export];
GO
IF OBJECT_ID('dsi_vwEPRINC401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRINC401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRINC401K_OLD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRINC401K_OLD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRINC401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRINC401K];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EPRINC401K_OLD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRINC401K_OLD];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EPRINC401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRINC401K];
GO
IF OBJECT_ID('U_EPRINC401K_T94') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_T94];
GO
IF OBJECT_ID('U_EPRINC401K_T93') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_T93];
GO
IF OBJECT_ID('U_EPRINC401K_T92') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_T92];
GO
IF OBJECT_ID('U_EPRINC401K_T91') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_T91];
GO
IF OBJECT_ID('U_EPRINC401K_T90') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_T90];
GO
IF OBJECT_ID('U_EPRINC401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_PEarHist];
GO
IF OBJECT_ID('U_EPRINC401K_PdhSource') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_PdhSource];
GO
IF OBJECT_ID('U_EPRINC401K_PDedHist2') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_PDedHist2];
GO
IF OBJECT_ID('U_EPRINC401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_PDedHist];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_T94') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_T94];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_T93') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_T93];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_T92') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_T92];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_T91') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_T91];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_T90') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_T90];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_PEarHist];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_PdhSource') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_PdhSource];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_PDedHist];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_File') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_File];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_EEList];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_DedList];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D60') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D60];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D50') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D50];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D40') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D40];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D35') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D35];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D30') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D30];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D20') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D20];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_D10') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_D10];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_AuditFields];
GO
IF OBJECT_ID('U_EPRINC401K_OLD_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_OLD_Audit];
GO
IF OBJECT_ID('U_EPRINC401K_File') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_File];
GO
IF OBJECT_ID('U_EPRINC401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_EEList];
GO
IF OBJECT_ID('U_EPRINC401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_DedList];
GO
IF OBJECT_ID('U_EPRINC401K_D60') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D60];
GO
IF OBJECT_ID('U_EPRINC401K_D50') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D50];
GO
IF OBJECT_ID('U_EPRINC401K_D40') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D40];
GO
IF OBJECT_ID('U_EPRINC401K_D35') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D35];
GO
IF OBJECT_ID('U_EPRINC401K_D30') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D30];
GO
IF OBJECT_ID('U_EPRINC401K_D20') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D20];
GO
IF OBJECT_ID('U_EPRINC401K_D10') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_D10];
GO
IF OBJECT_ID('U_EPRINC401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_AuditFields];
GO
IF OBJECT_ID('U_EPRINC401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRINC401K_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPRINC401K','Principal 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','240','S','N','EPRINC401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"180"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','10','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','10','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','10','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','10','12',NULL,'Social Security Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','1','D','10','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','24','D','10','22',NULL,'Employee Name*',NULL,NULL,'"drvEmployeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','10','D','10','46',NULL,'Date of Birth*',NULL,NULL,'"drvDateofBirth"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','1','D','10','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','10','D','10','57',NULL,'Date of Employment*',NULL,NULL,'"drvDateofEmployment"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','1','D','10','67',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','1','D','10','68',NULL,'Sex*',NULL,NULL,'"drvSex"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRINC401KZ0','7','D','10','69',NULL,'Location Number',NULL,NULL,'"drvLocationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRINC401KZ0','1','D','10','76',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRINC401KZ0','9','D','10','77',NULL,'Social Security Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRINC401KZ0','26','D','10','86',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRINC401KZ0','20','D','10','112',NULL,'Alternate ID',NULL,NULL,'"drvAlternateId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRINC401KZ0','1','D','10','132',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRINC401KZ0','8','D','10','133',NULL,'Eligibility Hours',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRINC401KZ0','1','D','10','141',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRINC401KZ0','10','D','10','142',NULL,'Hours Begin Date',NULL,NULL,'"drvHourBeginDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRINC401KZ0','1','D','10','152',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRINC401KZ0','10','D','10','153',NULL,'Hours End Date',NULL,NULL,'"drvHourEndDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRINC401KZ0','56','D','10','163',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRINC401KZ0','10','D','10','219',NULL,'Benefit Event Date',NULL,NULL,'"drvBenefitEventDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRINC401KZ0','1','D','10','229',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRINC401KZ0','4','D','10','230',NULL,'Vesting Hours',NULL,NULL,'"drvVestingHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRINC401KZ0','4','D','10','234',NULL,'Benefit Event Reason',NULL,NULL,'"drvBenefitEventReason"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRINC401KZ0','3','D','10','238',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"181"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','20','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','20','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','20','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','20','12',NULL,'Employee ID Number',NULL,NULL,'"drvEmployeeIDNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','1','D','20','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','24','D','20','22',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','31','D','20','46',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','9','D','20','77',NULL,'Social Security Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','1','D','20','86',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','10','D','20','87',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','144','D','20','97',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"220"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','30','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','30','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','30','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','30','12',NULL,'Identification Number',NULL,NULL,'"drvIdentificationNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','1','D','30','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','1','D','30','22',NULL,'Foreign Indicator',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','1','D','30','23',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','50','D','30','24',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','50','D','30','74',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','50','D','30','124',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','30','D','30','174',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRINC401KZ0','2','D','30','204',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRINC401KZ0','5','D','30','206',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRINC401KZ0','4','D','30','211',NULL,NULL,NULL,NULL,'"drvZipPlusFour"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRINC401KZ0','26','D','30','215',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','35','1',NULL,'Record Type',NULL,NULL,'"240"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','35','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','35','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','35','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','35','12',NULL,'Social Securiy Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','1','D','35','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','75','D','35','22',NULL,'Work Email',NULL,NULL,'"drvWorkEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','75','D','35','97',NULL,'Personal Email Address',NULL,NULL,'"drvPersonalEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','17','D','35','172',NULL,'Work Phone Number',NULL,NULL,'"drvWorkNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','7','D','35','189',NULL,'Work Phone Number Ext',NULL,NULL,'"drvWorkNumberExt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','17','D','35','196',NULL,'Home Phone Number',NULL,NULL,'"drvHomeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','7','D','35','213',NULL,'Home Phone Number Ext',NULL,NULL,'"drvHomeNumberExt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRINC401KZ0','18','D','35','220',NULL,'Mobile Phone Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRINC401KZ0','3','D','35','238',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"407"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','40','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','40','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','40','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','40','12',NULL,'Social Security Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','9','D','40','21',NULL,'Blank Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','2','D','40','30',NULL,'Investment Type',NULL,NULL,'"00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','4','D','40','32',NULL,'Transaction Type',NULL,NULL,'"0001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','10','D','40','36',NULL,'Pay Period Ending Date/Pay Date',NULL,NULL,'"drvPayPrdEndingDatePayDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','27','D','40','46',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','1','D','40','73',NULL,'Contribution Qualifier Type',NULL,NULL,'"L"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','3','D','40','74',NULL,'Contribution Qualifier',NULL,NULL,'"drvCntbrnQualifier1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRINC401KZ0','10','D','40','77',NULL,'Contribution Amount',NULL,NULL,'"drvCntbrnAmt1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRINC401KZ0','1','D','40','87',NULL,'Contribution Qualifier Type',NULL,NULL,'"L"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRINC401KZ0','3','D','40','88',NULL,'Contribution Qualifier',NULL,NULL,'"drvCntbrnQualifier2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRINC401KZ0','10','D','40','91',NULL,'Contribution Amount',NULL,NULL,'"drvCntbrnAmt2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRINC401KZ0','1','D','40','101',NULL,'Contribution Qualifier Type',NULL,NULL,'"L"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRINC401KZ0','3','D','40','102',NULL,'Contribution Qualifier',NULL,NULL,'"drvCntbrnQualifier3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRINC401KZ0','10','D','40','105',NULL,'Contribution Amount',NULL,NULL,'"drvCntbrnAmt3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRINC401KZ0','1','D','40','115',NULL,'Contribution Qualifier Type',NULL,NULL,'"L"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRINC401KZ0','3','D','40','116',NULL,'Contribution Qualifier',NULL,NULL,'"drvCntbrnQualifier4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRINC401KZ0','10','D','40','119',NULL,'Contribution Amount',NULL,NULL,'"drvCntbrnAmt4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRINC401KZ0','1','D','40','129',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRINC401KZ0','3','D','40','130',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRINC401KZ0','10','D','40','133',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRINC401KZ0','1','D','40','143',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRINC401KZ0','3','D','40','144',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRINC401KZ0','10','D','40','147',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRINC401KZ0','1','D','40','157',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRINC401KZ0','3','D','40','158',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRINC401KZ0','10','D','40','161',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRINC401KZ0','1','D','40','171',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRINC401KZ0','3','D','40','172',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRINC401KZ0','10','D','40','175',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRINC401KZ0','1','D','40','185',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRINC401KZ0','3','D','40','186',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRINC401KZ0','10','D','40','189',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRINC401KZ0','1','D','40','199',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRINC401KZ0','3','D','40','200',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRINC401KZ0','10','D','40','203',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRINC401KZ0','1','D','40','213',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRINC401KZ0','3','D','40','214',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRINC401KZ0','10','D','40','217',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRINC401KZ0','1','D','40','227',NULL,'Contribution Qualifier Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRINC401KZ0','3','D','40','228',NULL,'Contribution Qualifier',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRINC401KZ0','10','D','40','231',NULL,'Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','D','50','1',NULL,'Record Type',NULL,NULL,'"408"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','D','50','4',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','D','50','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','D','50','11',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','D','50','12',NULL,'Social Security Number',NULL,NULL,'"drvSsn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','9','D','50','21',NULL,' Blank Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','2','D','50','30',NULL,' Investment Type',NULL,NULL,'"00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','4','D','50','32',NULL,' Transaction Type',NULL,NULL,'"0031"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRINC401KZ0','10','D','50','36',NULL,' Pay Period Ending Date/Pay Date',NULL,NULL,'"drvPayPrdEndingDatePayDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRINC401KZ0','11','D','50','46',NULL,' Blank Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRINC401KZ0','3','D','50','57',NULL,'Loan Id',NULL,NULL,'"drvLoanId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRINC401KZ0','10','D','50','60',NULL,' Loan Payment Amount',NULL,NULL,'"drvLoanPaymentAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRINC401KZ0','10','D','50','70',NULL,' Loan Principal Payment Amount',NULL,NULL,'"drvLoanPrincPayAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRINC401KZ0','161','D','50','80',NULL,' Blank Spaces',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRINC401KZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"500"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRINC401KZ0','1','T','90','4',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRINC401KZ0','6','T','90','5',NULL,'Contract Number',NULL,NULL,'"818581"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRINC401KZ0','1','T','90','11',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRINC401KZ0','9','T','90','12',NULL,'Identification Number',NULL,NULL,'"000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRINC401KZ0','122','T','90','21',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRINC401KZ0','7','T','90','143',NULL,'EFT Code',NULL,NULL,'"drvEFTCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRINC401KZ0','91','T','90','150',NULL,'Blank Space',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPRINC401K_20211229.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','M8C6I,JE6DL,EV7Z8,EDV92,CJC4Y,EV2EI,JG341',NULL,NULL,NULL,'Principal 401K OnDemand','202106049','EMPEXPORT','ONDEM_XOE','Jun 14 2021  1:20PM','EPRINC401K',NULL,NULL,NULL,'202106049','Jun  4 2021 12:00AM','Dec 30 1899 12:00AM','202106041','632','eecPayGroup','MTSBW','202106041',dbo.fn_GetTimedKey(),NULL,'us3cPeCRO1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','M8C6I,JE6DL,EV7Z8,EDV92,CJC4Y,EV2EI,JG341',NULL,NULL,NULL,'Principal 401K Scheduled','202104279','EMPEXPORT','SCH_PRINOE','Apr 27 2020  3:17PM','EPRINC401K',NULL,NULL,NULL,'202106179','Mar 27 2000 12:00AM','Dec 30 1899 12:00AM','202106101','132','','','202104271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','MultFile','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRINC401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D10','dbo.U_EPRINC401K_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D20','dbo.U_EPRINC401K_D20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D30','dbo.U_EPRINC401K_D30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D35','dbo.U_EPRINC401K_D35',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D40','dbo.U_EPRINC401K_D40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','D50','dbo.U_EPRINC401K_D50',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRINC401K','T90','dbo.U_EPRINC401K_T90',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPRINC401K_Audit
-----------

IF OBJECT_ID('U_EPRINC401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL
);

-----------
-- Create table U_EPRINC401K_AuditFields
-----------

IF OBJECT_ID('U_EPRINC401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPRINC401K_D10
-----------

IF OBJECT_ID('U_EPRINC401K_D10') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] char(1) NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(203) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvDateofEmployment] varchar(30) NULL,
    [drvSex] char(1) NULL,
    [drvLocationNumber] varchar(7) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvAlternateId] char(9) NULL,
    [drvHourBeginDate] varchar(30) NULL,
    [drvHourEndDate] varchar(30) NULL,
    [drvBenefitEventDate] datetime NULL,
    [drvVestingHours] varchar(24) NULL,
    [drvBenefitEventReason] varchar(4) NULL
);

-----------
-- Create table U_EPRINC401K_D20
-----------

IF OBJECT_ID('U_EPRINC401K_D20') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(203) NULL,
    [drvSsn] char(11) NULL,
    [drvRehireDate] varchar(30) NULL
);

-----------
-- Create table U_EPRINC401K_D30
-----------

IF OBJECT_ID('U_EPRINC401K_D30') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvZipPlusFour] varchar(4) NULL
);

-----------
-- Create table U_EPRINC401K_D35
-----------

IF OBJECT_ID('U_EPRINC401K_D35') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D35] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvPersonalEmail] varchar(1) NOT NULL,
    [drvWorkNumber] varchar(50) NOT NULL,
    [drvWorkNumberExt] varchar(10) NOT NULL,
    [drvHomeNumber] varchar(50) NULL,
    [drvHomeNumberExt] varchar(1) NOT NULL,
    [drvMobileNumber] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_D40
-----------

IF OBJECT_ID('U_EPRINC401K_D40') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D40] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvPayPrdEndingDatePayDate] varchar(30) NULL,
    [drvCntbrnQualifier1] varchar(3) NOT NULL,
    [drvCntbrnAmt1] varchar(24) NULL,
    [drvCntbrnQualifier2] varchar(3) NOT NULL,
    [drvCntbrnAmt2] varchar(24) NULL,
    [drvCntbrnQualifier3] varchar(3) NOT NULL,
    [drvCntbrnAmt3] varchar(24) NULL,
    [drvCntbrnQualifier4] varchar(3) NOT NULL,
    [drvCntbrnAmt4] varchar(24) NULL,
    [drvCntbrnAmt1_RAW] decimal NULL,
    [drvCntbrnAmt2_RAW] decimal NULL,
    [drvCntbrnAmt3_RAW] decimal NULL,
    [drvCntbrnAmt4_RAW] decimal NULL
);

-----------
-- Create table U_EPRINC401K_D50
-----------

IF OBJECT_ID('U_EPRINC401K_D50') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D50] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvPayPrdEndingDatePayDate] varchar(30) NULL,
    [drvLoanID] varchar(24) NULL,
    [drvLoanPaymentAmt] varchar(24) NULL,
    [drvLoanPrincPayAmt] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_D60
-----------

IF OBJECT_ID('U_EPRINC401K_D60') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_D60] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NULL
);

-----------
-- Create table U_EPRINC401K_DedList
-----------

IF OBJECT_ID('U_EPRINC401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRINC401K_EEList
-----------

IF OBJECT_ID('U_EPRINC401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRINC401K_File
-----------

IF OBJECT_ID('U_EPRINC401K_File') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(240) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_Audit
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_AuditFields
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D10
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D10') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(203) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvDateofEmployment] varchar(30) NULL,
    [drvSex] char(1) NULL,
    [drvLocationNumber] varchar(7) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvAlternateId] char(9) NULL,
    [drvHourBeginDate] varchar(30) NULL,
    [drvHourEndDate] varchar(30) NULL,
    [drvBenefitEventDate] datetime NULL,
    [drvVestingHours] varchar(24) NULL,
    [drvBenefitEventReason] varchar(4) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D20
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D20') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeIDNumber] char(11) NULL,
    [drvEmployeeName] varchar(203) NULL,
    [drvSsn] char(11) NULL,
    [drvRehireDate] varchar(30) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D30
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D30') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvIdentificationNumber] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvZipPlusFour] varchar(4) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D35
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D35') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D35] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvPersonalEmail] varchar(1) NOT NULL,
    [drvWorkNumber] varchar(50) NOT NULL,
    [drvWorkNumberExt] varchar(10) NOT NULL,
    [drvHomeNumber] varchar(50) NULL,
    [drvHomeNumberExt] varchar(1) NOT NULL,
    [drvMobileNumber] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D40
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D40') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D40] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvPayPrdEndingDatePayDate] varchar(30) NULL,
    [drvCntbrnQualifier1] varchar(3) NOT NULL,
    [drvCntbrnAmt1] varchar(24) NULL,
    [drvCntbrnQualifier2] varchar(3) NOT NULL,
    [drvCntbrnAmt2] varchar(24) NULL,
    [drvCntbrnQualifier3] varchar(3) NOT NULL,
    [drvCntbrnAmt3] varchar(24) NULL,
    [drvCntbrnQualifier4] varchar(3) NOT NULL,
    [drvCntbrnAmt4] varchar(24) NULL,
    [drvCntbrnAmt1_RAW] decimal NULL,
    [drvCntbrnAmt2_RAW] decimal NULL,
    [drvCntbrnAmt3_RAW] decimal NULL,
    [drvCntbrnAmt4_RAW] decimal NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D50
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D50') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D50] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvPayPrdEndingDatePayDate] varchar(30) NULL,
    [drvLoanID] varchar(24) NULL,
    [drvLoanPaymentAmt] varchar(24) NULL,
    [drvLoanPrincPayAmt] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_D60
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_D60') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_D60] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_DedList
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_EEList
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_File
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_File') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(240) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_PDedHist
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [pdhDedCode] char(5) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhPayDate] varchar(8) NULL,
    [PdhSource1] decimal NULL,
    [PdhSource2] decimal NULL,
    [PdhSource3] decimal NULL,
    [PdhSource4] decimal NULL,
    [PdhSource5] decimal NULL
);

-----------
-- Create table U_EPRINC401K_OLD_PdhSource
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_PdhSource') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_PdhSource] (
    [PdhEEID] char(12) NOT NULL,
    [pdhDedCode] char(5) NOT NULL,
    [PdhSource1_VC] varchar(8000) NULL,
    [PdhSource2_VC] varchar(8000) NULL,
    [PdhSource3_VC] varchar(8000) NULL,
    [PdhSource4_VC] varchar(8000) NULL,
    [PdhSource5_VC] varchar(8000) NULL
);

-----------
-- Create table U_EPRINC401K_OLD_PEarHist
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EPRINC401K_OLD_T90
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_T90') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_T90] (
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_T91
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_T91') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_T91] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_T92
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_T92') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_T92] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_T93
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_T93') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_T93] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_OLD_T94
-----------

IF OBJECT_ID('U_EPRINC401K_OLD_T94') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_OLD_T94] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_PDedHist
-----------

IF OBJECT_ID('U_EPRINC401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [pdhDedCode] char(5) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhPayDate] varchar(8) NULL,
    [PdhSource1] decimal NULL,
    [PdhSource2] decimal NULL,
    [PdhSource3] decimal NULL,
    [PdhSource4] decimal NULL,
    [PdhSource5] decimal NULL
);

-----------
-- Create table U_EPRINC401K_PDedHist2
-----------

IF OBJECT_ID('U_EPRINC401K_PDedHist2') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_PDedHist2] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhPayDate] varchar(8) NULL,
    [PdhSource1] decimal NULL,
    [PdhSource2] decimal NULL,
    [PdhSource3] decimal NULL,
    [PdhSource4] decimal NULL,
    [PdhSource5] decimal NULL
);

-----------
-- Create table U_EPRINC401K_PdhSource
-----------

IF OBJECT_ID('U_EPRINC401K_PdhSource') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_PdhSource] (
    [PdhEEID] char(12) NOT NULL,
    [pdhDedCode] char(5) NOT NULL,
    [PdhSource1_VC] varchar(8000) NULL,
    [PdhSource2_VC] varchar(8000) NULL,
    [PdhSource3_VC] varchar(8000) NULL,
    [PdhSource4_VC] varchar(8000) NULL,
    [PdhSource5_VC] varchar(8000) NULL
);

-----------
-- Create table U_EPRINC401K_PEarHist
-----------

IF OBJECT_ID('U_EPRINC401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EPRINC401K_T90
-----------

IF OBJECT_ID('U_EPRINC401K_T90') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_T90] (
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NULL
);

-----------
-- Create table U_EPRINC401K_T91
-----------

IF OBJECT_ID('U_EPRINC401K_T91') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_T91] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_T92
-----------

IF OBJECT_ID('U_EPRINC401K_T92') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_T92] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_T93
-----------

IF OBJECT_ID('U_EPRINC401K_T93') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_T93] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRINC401K_T94
-----------

IF OBJECT_ID('U_EPRINC401K_T94') IS NULL
CREATE TABLE [dbo].[U_EPRINC401K_T94] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEFTCode] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRINC401K]
AS
SET NOCOUNT ON;
/************************************************************
Client: Ferrero

Created By: Dan Bailey
Create Date: 12/07/2020

Purpose: GENERATE MULTIPLE FILES PER COID

Revision History
----------------
Update By    Date    Request Num    Desc


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRINC401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRINC401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K', 'SCH_PRINOE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRINC401K';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRINC401K', @AllObjects = 'Y', @IsWeb = 'Y';

************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT;

    -- Set variables
    SET @FormatCode = 'EPRINC401K';

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'IsUTF8') = 'Y' THEN dbo.dsi_fnVariable(@FormatCode,'UTF8Path') -- If using UTF8 Converter, then use UTF8Path instead of ExportPath
                           WHEN (@ExportCode LIKE '%TEST%' OR @ExportCode LIKE '%TST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y') AND dbo.dsi_fnVariable(@FormatCode,'TestPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'TestPath')
                           WHEN @ExportCode LIKE '%OE%' AND dbo.dsi_fnVariable(@FormatCode,'OEPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OEPath')
                           WHEN @ExportCode IN ('FAUSA_ONDEMAND','FRVLU_ONDEMAND') AND dbo.dsi_fnVariable(@FormatCode,'OnDemandPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OnDemandPath')
                           ELSE dbo.dsi_fnVariable(@FormatCode,'ExportPath')
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================

    DECLARE @FilesOut1 AS TABLE
    (
         RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );


--RecordSet    FromClause
--D10    dbo.U_EPRINC401K_D10
--D20    dbo.U_EPRINC401K_D20
--D30    dbo.U_EPRINC401K_D30
--D35    dbo.U_EPRINC401K_D35
--D40    dbo.U_EPRINC401K_D40
--D50    dbo.U_EPRINC401K_D50
--T90    dbo.U_EPRINC401K_T90


    INSERT INTO @FilesOut1 (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'D11,T91', CustomFileName = 'EPRINC401K_CCFS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv' -- FILE# 1
 --   UNION ALL
 --   SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T91', CustomFileName = 'EPRINC401K_MTS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 2
 --   UNION ALL
 --   SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T92', CustomFileName = 'EPRINC401K_PRIC.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv' -- FILE# 3
 --   UNION ALL
    --SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T93', CustomFileName = 'EPRINC401K_NAS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 1
 --   UNION ALL
    --SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T94', CustomFileName = 'EPRINC401K_NAL.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 1

    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut1);

    -- ==================================================    
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================    
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

    -- Set FileName to Export Based On Record Set Group (Header,Detail Records)

    SELECT 
         @RecordSetGroup = RecordSetGroup
        ,@FileName = CustomFileName
    FROM @FilesOut1
    WHERE RowID = @LoopCount;

    -- Set Query To Be Exported
    SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) '
                        + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                        + 'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

    -- Set Custom BCP Statement
    SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @FileName +'"' + 
              ' -S"' + RTRIM(@@SERVERNAME) + '" -T -c';
    
    IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
    BEGIN
        PRINT 'Custom BCP For File# ' + CONVERT(VARCHAR(2),@LoopCount) + ': ' + ISNULL(@FileName,'');
        PRINT 'Custom BCP Statement: ' + ISNULL(@sCmd,'');
    END;

    -- Get Record Count
    DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
    SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
    EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

    IF @RecordCnt = 0 AND @NoEmpty = 'Y'
    BEGIN
        IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
        BEGIN
            PRINT 'There are no records in the file, so no file will be created.'
        END
    END ELSE BEGIN
        -- Output File
        EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
    END;

    -- Get Next FileName
    SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRINC401K_OLD]
AS
SET NOCOUNT ON;
/************************************************************
Client: Ferrero

Created By: Dan Bailey
Create Date: 12/07/2020

Purpose: GENERATE MULTIPLE FILES PER COID

Revision History
----------------
Update By    Date    Request Num    Desc


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRINC401K_OLD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRINC401K_OLD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K_OLD', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K_OLD', 'SCH_PRINOE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRINC401K_OLD';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRINC401K_OLD', @AllObjects = 'Y', @IsWeb = 'Y';

************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT;

    -- Set variables
    SET @FormatCode = 'EPRINC401K_OLD';

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'IsUTF8') = 'Y' THEN dbo.dsi_fnVariable(@FormatCode,'UTF8Path') -- If using UTF8 Converter, then use UTF8Path instead of ExportPath
                           WHEN (@ExportCode LIKE '%TEST%' OR @ExportCode LIKE '%TST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y') AND dbo.dsi_fnVariable(@FormatCode,'TestPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'TestPath')
                           WHEN @ExportCode LIKE '%OE%' AND dbo.dsi_fnVariable(@FormatCode,'OEPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OEPath')
                           WHEN @ExportCode IN ('FAUSA_ONDEMAND','FRVLU_ONDEMAND') AND dbo.dsi_fnVariable(@FormatCode,'OnDemandPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OnDemandPath')
                           ELSE dbo.dsi_fnVariable(@FormatCode,'ExportPath')
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================

    DECLARE @FilesOut1 AS TABLE
    (
         RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );


--RecordSet    FromClause
--D10    dbo.U_EPRINC401K_OLD_D10
--D20    dbo.U_EPRINC401K_OLD_D20
--D30    dbo.U_EPRINC401K_OLD_D30
--D35    dbo.U_EPRINC401K_OLD_D35
--D40    dbo.U_EPRINC401K_OLD_D40
--D50    dbo.U_EPRINC401K_OLD_D50
--T90    dbo.U_EPRINC401K_OLD_T90


    INSERT INTO @FilesOut1 (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'D11,T91', CustomFileName = 'EPRINC401K_OLD_CCFS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv' -- FILE# 1
 --   UNION ALL
 --   SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T91', CustomFileName = 'EPRINC401K_OLD_MTS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 2
 --   UNION ALL
 --   SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T92', CustomFileName = 'EPRINC401K_OLD_PRIC.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv' -- FILE# 3
 --   UNION ALL
    --SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T93', CustomFileName = 'EPRINC401K_OLD_NAS.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 1
 --   UNION ALL
    --SELECT RecordSetGroup = 'D10,D20,D30,D35,D40,D50,T94', CustomFileName = 'EPRINC401K_OLD_NAL.' + CONVERT(VARCHAR(8),GETDATE(),112) + '_' + replace(convert(varchar, getdate(),108),':','') + '.csv'  -- FILE# 1

    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut1);

    -- ==================================================    
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================    
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

    -- Set FileName to Export Based On Record Set Group (Header,Detail Records)

    SELECT 
         @RecordSetGroup = RecordSetGroup
        ,@FileName = CustomFileName
    FROM @FilesOut1
    WHERE RowID = @LoopCount;

    -- Set Query To Be Exported
    SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) '
                        + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                        + 'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

    -- Set Custom BCP Statement
    SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @FileName +'"' + 
              ' -S"' + RTRIM(@@SERVERNAME) + '" -T -c';
    
    IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
    BEGIN
        PRINT 'Custom BCP For File# ' + CONVERT(VARCHAR(2),@LoopCount) + ': ' + ISNULL(@FileName,'');
        PRINT 'Custom BCP Statement: ' + ISNULL(@sCmd,'');
    END;

    -- Get Record Count
    DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
    SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
    EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

    IF @RecordCnt = 0 AND @NoEmpty = 'Y'
    BEGIN
        IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
        BEGIN
            PRINT 'There are no records in the file, so no file will be created.'
        END
    END ELSE BEGIN
        -- Output File
        EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
    END;

    -- Get Next FileName
    SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRINC401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cross Country

Created By: Sarah Hulcy
Business Analyst: Jessica Young
Create Date: 07/1/2020
Service Request Number: SR-2020-None

Purpose: Principal 401K File Export

Revision History
----------------
Update By        Date            Desc
Dan Bailey        12/04/2020        Add EFT Line
Dan Bailey        12/29/2020        Added Location hardcoding logic
Dan Bailey        02/09/2020        Updates to 407/408 Dates
Darren Collard    12/26/2021        Added USJ16-DATS 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRINC401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRINC401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRINC401K' ORDER BY RunID DESC;

Test Path: \\us.saas\NW1\NW11\Downloads\V10\Exports\CROS\EmployeeHistoryExport\
UDES Path: \\us.saas\n0\DATA_EXCHANGE\CRO1008\exports\UDES

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K', 'SCH_PRINOE';


EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPRINC401K', @AllObjects = 'Y', @IsWeb = 'Y';

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
    SELECT @FormatCode = 'EPRINC401K';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    DECLARE @PayGroupList VARCHAR(255);

    SELECT @PayGroupList = RTRIM(ExpSelectByList)
    FROM dbo.AscExp 
    WHERE expFormatCode = 'EPRINC401K'
    AND ExpExportCode = @ExportCode
    AND ExpSelectbyField = 'EecPayGroup'


    --SELECT @PayGroupList;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPRINC401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRINC401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EPRINC401K_EEList WHERE xEEID IN (
        SELECT DISTINCT EepEEID
        FROM dbo.EmpPers WITH (NOLOCK)
        WHERE EepSSN IN ('999999999','123456789','111119999')
            OR LEFT(EepSSN, 3) IN ('999','123','111')
    );

--    SELECT COUNT(*) AS PreCoount FROM dbo.U_EPRINC401K_EEList;
--    SELECT @PayGroupList AS PayGroups;

    
    IF @PayGroupList IS NOT NULL
        DELETE FROM dbo.U_EPRINC401K_EEList WHERE xEEID NOT IN (
        SELECT DISTINCT EecEEID
        FROM dbo.EmpComp WITH (NOLOCK)
        WHERE EecPayGroup IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@PayGroupList))
            --AND EecEmplStatus <>'T'
        );


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPRINC401K_AuditFields') IS NOT NULL
    DROP TABLE dbo.U_EPRINC401K_AuditFields

    CREATE TABLE dbo.U_EPRINC401K_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30))
    INSERT INTO dbo.U_EPRINC401K_AuditFields VALUES ('empcomp','eecdateoftermination')

-- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPRINC401K_Audit') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_Audit
    SELECT audKey1Value audEEID, audKey2Value audKey2, audKey3Value audKey3,
     audTableName, audFieldName, audAction, audDateTime, audOldValue, audNewValue
      INTO dbo.U_EPRINC401K_Audit
      FROM dbo.vw_AuditData WITH (NOLOCK)         
      JOIN dbo.U_EPRINC401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName 
        AND audFieldName = aFieldName
        AND audDateTime BETWEEN DATEADD(DAY,-30,@StartDate) /*@StartDate*/ AND DATEADD(DAY,30,@EndDate)
      /*FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
      JOIN dbo.U_EPRINC401K_AuditFields WITH (NOLOCK) ON 1 = 1
      JOIN dbo.vw_AuditData WITH (NOLOCK) ON xEEID = audKey1Value AND xcoid = audKey2Value
      --AND audDateTime BETWEEN DATEADD(DAY,-30,@StartDate) /*@StartDate*/ AND DATEADD(DAY,30,@EndDate) -- @EndDate
      AND audTableName = aTableName AND audFieldName = aFieldName*/
 
-- Delete Record if termination is over 2 weeks old
    DELETE a
    FROM dbo.U_EPRINC401K_EELIST a
    INNER JOIN EmpComp b ON b.eeceeid = a.xeeid
    and b.eeccoid = a.xcoid
    WHERE b.EecEmplStatus = 'T' and NOT EXISTS (SELECT 1 FROM U_EPRINC401K_Audit WHERE a.xeeid = audeeid)
    --AND EecTermReason != 'TRO' 

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401L,401LB,401LC,401P,RETF,RETP,RETRF,RETRP,ROTHF,ROTHP,MATCH';

    IF OBJECT_ID('U_EPRINC401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRINC401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

  --  select * from dbo.U_EPRJLN408_Sign
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPRINC401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,pdhDedCode
        ,PdhPerControl  = LEFT(PdhPerControl,8)
        ,PdhPayDate     = MAX(LEFT(PdhPerControl,8))
        -- Categorize Payroll Amounts 
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401F','401P','RETF','RETP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401CF','401CP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('ROTHF','ROTHP','RETRF','RETRP')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('401L','401LB','401LC')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
    INTO dbo.U_EPRINC401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRINC401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8),PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
    );


     IF OBJECT_ID('U_EPRINC401K_PDedHist2','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_PDedHist2;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl  = LEFT(PdhPerControl,8)
        ,PdhPayDate     = MAX(LEFT(PdhPerControl,8))
        -- Categorize Payroll Amounts 
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401F','401P','RETF','RETP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401CF','401CP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('ROTHF','ROTHP','RETRF','RETRP')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('401L','401LB','401LC')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
    INTO dbo.U_EPRINC401K_PDedHist2
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRINC401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
    HAVING (SUM(PdhEECurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPRINC401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPRINC401K_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D10 -- 180
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = EecEmplStatus
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber = EepSSN
        ,drvEmployeeName = rtrim(EepNameLast) + ',' +  rtrim(rtrim(EepNameFirst) + ' ' +   isnull(Substring(rtrim(nullif(EepNameMiddle,'Z')),1,1),''))
        ,drvDateofBirth = CONVERT(VARCHAR,EepDateOfBirth,101)
        ,drvDateofEmployment = CONVERT(VARCHAR,EecDateOfOriginalHire,101)
        ,drvSex = EepGender
        ,drvLocationNumber = CASE
                                    WHEN CmpCompanyCode IN ('CCFS','NAS','NAL') THEN '0000001'
                                    WHEN CmpCompanyCode = 'MTS' THEN '0000002'
                                    WHEN CmpCompanyCode = 'PRIC' THEN '0000003'
                                    WHEN CmpCompanyCode = 'RACP' THEN '0000004'
                                    WHEN CmpCompanyCode = 'DTT' THEN '0000005'
                                    WHEN CmpCompanyCode = 'DATS' THEN '0000006'  --DLC Added 12/26/2021
                                    ELSE 'Blank'
                                END
        ,drvSsn = EepSSN
        ,drvAlternateId = EecEmpNo
        ,drvHourBeginDate = CONVERT(VARCHAR,CAST(LEFT(@EndPerControl,4)+'0101' AS DATE),101)   --issue
        ,drvHourEndDate = CONVERT(VARCHAR,CAST(LEFT(@EndPerControl,8) AS DATE),101)      --issue
        ,drvBenefitEventDate = eecDateOfTermination
        ,drvVestingHours = CASE WHEN EecEmplStatus = 'T' THEN [dbo].[dsi_fnPadZero](isnull(PehInclInDefCompHrsYTD,0),4,0) END
        ,drvBenefitEventReason = CASE 
                                    WHEN eecEmplStatus = 'T'
                                    THEN 
                                        CASE
                                            WHEN eecTermReason = '202'
                                            THEN '0003'
                                            WHEN eecTermReason = '202'
                                            THEN '0005'
                                            ELSE '0001'
                                        END
                                    END
    INTO dbo.U_EPRINC401K_D10
    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN Company WITH (NOLOCK) 
    ON xCoID = cmpCOID
    JOIN dbo.EmpPers WITH (NOLOCK) 
    ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRINC401K_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID;


    IF OBJECT_ID('TEMP_CCFS','U') IS NOT NULL
    DROP TABLE dbo.TEMP_CCFS;

    SELECT * INTO dbo.TEMP_CCFS 
    FROM dbo.u_EPRINC401K_D10 WHERE drvCOID = 'M8C6I'



    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D20  --181
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D20','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D20;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'B'
        ,drvEmployeeIDNumber = EepSSN
        ,drvEmployeeName = rtrim(EepNameLast) +  ',' + rtrim(rtrim(EepNameFirst) + ' ' +  isnull(Substring(rtrim(nullif(EepNameMiddle,'Z')),1,1),''))
        ,drvSsn = eepSsn
        ,drvRehireDate = CASE
                            WHEN (eecDateofLastHire != eecDateofOriginalHire)
                            AND (eecDateofLastHire <= (GETDATE() -60))
                            THEN CONVERT(VARCHAR,eecDateofLastHire,101)
                            ELSE NULL
                         END

    INTO dbo.U_EPRINC401K_D20
    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    Where (eecDateofLastHire != eecDateofOriginalHire) and (eecDateofLastHire <= (GETDATE() -60))
    ;

    Delete from dbo.U_EPRINC401K_D20 where Datediff(day,drvRehireDate,getdate()) > 60


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D30 -- 220
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D30','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D30;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'C'
        -- standard fields above and additional driver fields below
        ,drvIdentificationNumber = EepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressLine3
        ,drvAddressCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = left(EepAddressZipCode,5)
        ,drvZipPlusFour = SUBSTRING(EepAddressZipCode,6,4)
    INTO dbo.U_EPRINC401K_D30
    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D35 -- 240
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D35','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D35;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'D'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvWorkEmail = EepAddressEMail
        ,drvPersonalEmail = ''
        ,drvWorkNumber = isnull(eecPhoneBusinessNumber,'')
        ,drvWorkNumberExt = Case when nullif(eecPhoneBusinessNumber,'') is not null then isnull(EecPhoneBusinessExt,'') 
                            else '' END
        ,drvHomeNumber = eepPhoneHomeNumber
        ,drvHomeNumberExt = ''
        ,drvMobileNumber = ''
    INTO dbo.U_EPRINC401K_D35
    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D40 -- 407 
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D40','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'E'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvPayPrdEndingDatePayDate =  (select CONVERT(VARCHAR,MAX(cast(PdhPayDate as datetime)),101) from U_EPRINC401K_PDedHist)
        ,drvCntbrnQualifier1 = '001'
        ,drvCntbrnAmt1 =  [dbo].[dsi_fnPadZero](replace(isnull(PdhSource1,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier2 = '005'
        ,drvCntbrnAmt2 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource2,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier3 = '017'
        ,drvCntbrnAmt3 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource3,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier4 = '021'
        ,drvCntbrnAmt4 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource4,0)*100,'-',''),10,0)
        ,drvCntbrnAmt1_RAW = PdhSource1
        ,drvCntbrnAmt2_RAW = PdhSource2
        ,drvCntbrnAmt3_RAW = PdhSource3
        ,drvCntbrnAmt4_RAW = PdhSource4
    INTO dbo.U_EPRINC401K_D40
    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    JOIN dbo.U_EPRINC401K_PDedHist2 WITH (NOLOCK)
    ON PdhEEID = xEEID


    Update dbo.U_EPRINC401K_D40
    SET drvCntbrnAmt1 = CASE
                                WHEN LEFT(drvCntbrnAmt1_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt1,9) +        
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt1
                        END

    ,drvCntbrnAmt2 = CASE
                                WHEN LEFT(drvCntbrnAmt2_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt2,9) +     
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt2
                        END
                        

    ,drvCntbrnAmt3 = CASE
                                WHEN LEFT(drvCntbrnAmt3_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt3,9) +      
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt3
                        END
    
    ,drvCntbrnAmt4 = CASE
                                WHEN LEFT(drvCntbrnAmt4_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt4,9) +     
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt4
                        END


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_D50 -- 408
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_D50','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_D50;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'F'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvPayPrdEndingDatePayDate = (select CONVERT(VARCHAR,MAX(cast(PdhPayDate as datetime)),101) from U_EPRINC401K_PDedHist)
        ,drvLoanID = [dbo].[dsi_fnPadZero](isnull(EedNotes,0),3,0)
        ,drvLoanPaymentAmt = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource5,0)*100,'-',''),10,0)
        ,drvLoanPrincPayAmt = ''
    INTO dbo.U_EPRINC401K_D50

    FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    JOIN dbo.U_EPRINC401K_PDedHist WITH (NOLOCK)
    ON PdhEEID = xEEID
    and pdhDedCode IN ('401L','401LB','401LC')
    JOIN dbo.empded  WITH (NOLOCK) on eeddedcode=pdhDedCode and EedEEID = xEEID AND EedCoID = xCoID
    Where PdhSource5 != '0';

    Update dbo.U_EPRINC401K_D50
    SET drvLoanPaymentAmt = CASE
                                WHEN LEFT(drvLoanPaymentAmt,1) = '-'
                                    THEN SUBSTRING(STUFF(replace(dbo.dsi_fnPadZero(isnull(drvLoanPaymentAmt,0),11,2),'.',space(0)), LEN(drvLoanPaymentAmt), 1,     
                                                CASE 
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '9' THEN 'R'
                                                END),2, LEN(drvLoanPaymentAmt))
                                END
    WHERE LEFT(drvLoanPaymentAmt,1) = '-'
    ;


    ---------------------------------
    -- TRAILER RECORD - U_EPRINC401K_T90 -- 500
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_T90','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_T90;
    SELECT DISTINCT
         drvSubSort = 'G'
        ,drvEFTCode = CASE WHEN eeccoid = 'M8C6I' THEN '1'
                          WHEN eeccoid = 'EV7Z8' THEN '2'
                          WHEN eeccoid = 'EV2EI' THEN '3'
                          WHEN eeccoid = 'CJC4Y' THEN '4'
                          WHEN eeccoid = 'EDV92' THEN '5'
                          WHEN eeccoid = 'JE6DL' THEN '6'
                          WHEN eeccoid = 'JG341' THEN '7'
                          WHEN eeccoid = 'USJ16' THEN '8' --DLC Added 12/26/2021
                      END
    INTO dbo.U_EPRINC401K_T90
     FROM dbo.U_EPRINC401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_818581_' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR, GETDATE(), 8),':','') + '.txt'
                                ELSE '818581_' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR, GETDATE(), 8),':','') + '.txt'
                                END
        WHERE FormatCode = @FormatCode;
    END

END;


/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPRINC401K_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRINC401K_File (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRINC401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104231'
       ,expStartPerControl     = '202104231'
       ,expLastEndPerControl   = '202104239'
       ,expEndPerControl       = '202104239'
WHERE expFormatCode = 'EPRINC401K';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRINC401K_OLD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cross Country

Created By: Sarah Hulcy
Business Analyst: Jessica Young
Create Date: 07/1/2020
Service Request Number: SR-2020-None

Purpose: Principal 401K File Export

Revision History
----------------
Update By        Date            Desc
Dan Bailey        12/04/2020        Add EFT Line
Dan Bailey        12/29/2020        Added Location hardcoding logic
Dan Bailey        02/09/2020        Updates to 407/408 Dates


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRINC401K_OLD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRINC401K_OLD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRINC401K_OLD' ORDER BY RunID DESC;

Test Path: \\us.saas\NW1\NW11\Downloads\V10\Exports\CROS\EmployeeHistoryExport\
UDES Path: \\us.saas\n0\DATA_EXCHANGE\CRO1008\exports\UDES

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K_OLD', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRINC401K_OLD', 'SCH_PRINOE';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRINC401K_OLD', @AllObjects = 'Y', @IsWeb = 'Y';

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
    SELECT @FormatCode = 'EPRINC401K_OLD';

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
    DELETE FROM dbo.U_EPRINC401K_OLD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRINC401K_OLD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPRINC401K_OLD_AuditFields') IS NOT NULL
    DROP TABLE dbo.U_EPRINC401K_OLD_AuditFields

    CREATE TABLE dbo.U_EPRINC401K_OLD_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30))
    INSERT INTO dbo.U_EPRINC401K_OLD_AuditFields VALUES ('empcomp','eecdateoftermination')

-- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPRINC401K_OLD_Audit') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_Audit
    SELECT audKey1Value audEEID, audKey2Value audKey2, audKey3Value audKey3,
     audTableName, audFieldName, audAction, audDateTime, audOldValue, audNewValue
      INTO dbo.U_EPRINC401K_OLD_Audit
      FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
      JOIN dbo.U_EPRINC401K_OLD_AuditFields WITH (NOLOCK) ON 1 = 1
      JOIN dbo.vw_AuditData WITH (NOLOCK) ON xEEID = audKey1Value AND xcoid = audKey2Value
      AND audDateTime BETWEEN @StartDate AND @EndDate
      AND audTableName = aTableName AND audFieldName = aFieldName
 
-- Delete Record if termination is over 2 weeks old
    DELETE a
    FROM dbo.U_EPRINC401K_OLD_EELIST a
    INNER JOIN EmpComp b ON b.eeceeid = a.xeeid
    and b.eeccoid = a.xcoid
    WHERE b.EecEmplStatus = 'T' and NOT EXISTS (SELECT 1 FROM U_EPRINC401K_OLD_Audit WHERE a.xeeid = audeeid)
    AND EecTermReason != 'TRO'

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401L,401LB,401LC,401P,RETF,RETP,RETRF,RETRP,ROTHF,ROTHP,MATCH';

    IF OBJECT_ID('U_EPRINC401K_OLD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRINC401K_OLD_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

  --  select * from dbo.U_EPRJLN408_Sign
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,pdhDedCode
        ,PdhPerControl  = LEFT(PdhPerControl,8)
        ,PdhPayDate     = MAX(LEFT(PdhPerControl,8))
        -- Categorize Payroll Amounts 
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401F','401P','RETF','RETP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401CF','401CP') THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('ROTHF','ROTHP','RETRF','RETRP')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('401L','401LB','401LC')  THEN CAST(PdhEECurAmt AS DECIMAL(20,2)) ELSE 0.00 END)
    INTO dbo.U_EPRINC401K_OLD_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRINC401K_OLD_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8),PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_PEarHist;
    SELECT DISTINCT
         PehEEID
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPRINC401K_OLD_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D10 -- 180
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'A'
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber = EepSSN
        ,drvEmployeeName = rtrim(EepNameLast) + ',' +  rtrim(rtrim(EepNameFirst) + ' ' +   isnull(Substring(rtrim(nullif(EepNameMiddle,'Z')),1,1),''))
        ,drvDateofBirth = CONVERT(VARCHAR,EepDateOfBirth,101)
        ,drvDateofEmployment = CONVERT(VARCHAR,EecDateOfOriginalHire,101)
        ,drvSex = EepGender
        ,drvLocationNumber = CASE
                                    WHEN CmpCompanyCode IN ('CCFS','NAS','NAL') THEN '0000001'
                                    WHEN CmpCompanyCode = 'MTS' THEN '0000002'
                                    WHEN CmpCompanyCode = 'PRIC' THEN '0000003'
                                    ELSE '0000003'
                                END
        ,drvSsn = EepSSN
        ,drvAlternateId = EecEmpNo
        ,drvHourBeginDate = CONVERT(VARCHAR,CAST(LEFT(@EndPerControl,4)+'0101' AS DATE),101)   --issue
        ,drvHourEndDate = CONVERT(VARCHAR,CAST(LEFT(@EndPerControl,8) AS DATE),101)      --issue
        ,drvBenefitEventDate = eecDateOfTermination
        ,drvVestingHours = [dbo].[dsi_fnPadZero](isnull(PehInclInDefCompHrsYTD,0),4,0)
        ,drvBenefitEventReason = CASE 
                                    WHEN eecEmplStatus = 'T'
                                    THEN 
                                        CASE
                                            WHEN eecTermReason = '202'
                                            THEN '0003'
                                            WHEN eecTermReason = '202'
                                            THEN '0005'
                                            ELSE '0001'
                                        END
                                    END
    INTO dbo.U_EPRINC401K_OLD_D10
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN Company WITH (NOLOCK) 
    ON xCoID = cmpCOID
    JOIN dbo.EmpPers WITH (NOLOCK) 
    ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRINC401K_OLD_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID;


    IF OBJECT_ID('TEMP_CCFS','U') IS NOT NULL
    DROP TABLE dbo.TEMP_CCFS;

    SELECT * INTO dbo.TEMP_CCFS 
    FROM dbo.u_EPRINC401K_OLD_D10 WHERE drvCOID = 'M8C6I'



    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D20  --181
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D20','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D20;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'B'
        -- standard fields above and additional driver fields below
        ,drvEmployeeIDNumber = EepSSN
        ,drvEmployeeName = rtrim(EepNameLast) +  ',' + rtrim(rtrim(EepNameFirst) + ' ' +  isnull(Substring(rtrim(nullif(EepNameMiddle,'Z')),1,1),''))
        ,drvSsn = eepSsn
        ,drvRehireDate = CASE
                            WHEN (eecDateofLastHire != eecDateofOriginalHire)
                            AND (eecDateofLastHire <= (GETDATE() -60))
                            THEN CONVERT(VARCHAR,eecDateofLastHire,101)
                            ELSE NULL
                         END

    INTO dbo.U_EPRINC401K_OLD_D20
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    Where (eecDateofLastHire != eecDateofOriginalHire)
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D30 -- 220
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D30','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D30;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'C'
        -- standard fields above and additional driver fields below
        ,drvIdentificationNumber = EepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressLine3
        ,drvAddressCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = left(EepAddressZipCode,5)
        ,drvZipPlusFour = SUBSTRING(EepAddressZipCode,6,4)
    INTO dbo.U_EPRINC401K_OLD_D30
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D35 -- 240
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D35','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D35;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'D'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvWorkEmail = EepAddressEMail
        ,drvPersonalEmail = ''
        ,drvWorkNumber = isnull(eecPhoneBusinessNumber,'')
        ,drvWorkNumberExt = Case when nullif(eecPhoneBusinessNumber,'') is not null then isnull(EecPhoneBusinessExt,'') 
                            else '' END
        ,drvHomeNumber = eepPhoneHomeNumber
        ,drvHomeNumberExt = ''
        ,drvMobileNumber = ''
    INTO dbo.U_EPRINC401K_OLD_D35
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D40 -- 407 
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D40','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'E'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvPayPrdEndingDatePayDate =  (select CONVERT(VARCHAR,MAX(cast(PdhPayDate as datetime)),101) from U_EPRINC401K_OLD_PDedHist)
        ,drvCntbrnQualifier1 = CASE 
                                    WHEN PdhDedCode IN ('401F','401P','RETF','RETP') 
                                    THEN '001' ELSE '' 
                               END
        ,drvCntbrnAmt1 =  [dbo].[dsi_fnPadZero](replace(isnull(PdhSource1,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier2 = CASE 
                                    WHEN PdhDedCode IN ('MATCH') 
                                    THEN '005' ELSE '' 
                               END
        ,drvCntbrnAmt2 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource2,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier3 = CASE 
                                    WHEN PdhDedCode IN ('401CF','401CP') 
                                    THEN '017' ELSE '' 
                                END
        ,drvCntbrnAmt3 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource3,0)*100,'-',''),10,0)
        ,drvCntbrnQualifier4 = CASE 
                                    WHEN PdhDedCode IN ('ROTHF','ROTHP','RETRF','RETRP') 
                                    THEN '021' ELSE '' 
                               END
        ,drvCntbrnAmt4 = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource4,0)*100,'-',''),10,0)
        ,drvCntbrnAmt1_RAW = PdhSource1
        ,drvCntbrnAmt2_RAW = PdhSource2
        ,drvCntbrnAmt3_RAW = PdhSource3
        ,drvCntbrnAmt4_RAW = PdhSource4
    INTO dbo.U_EPRINC401K_OLD_D40
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    JOIN dbo.U_EPRINC401K_OLD_PDedHist WITH (NOLOCK)
    ON PdhEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID;

    Update dbo.U_EPRINC401K_OLD_D40
    SET drvCntbrnAmt1 = CASE
                                WHEN LEFT(drvCntbrnAmt1_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt1,9) +        
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt1,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt1
                        END

    ,drvCntbrnAmt2 = CASE
                                WHEN LEFT(drvCntbrnAmt2_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt2,9) +     
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt2,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt2
                        END
                        

    ,drvCntbrnAmt3 = CASE
                                WHEN LEFT(drvCntbrnAmt3_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt3,9) +      
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt3,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt3
                        END
    
    ,drvCntbrnAmt4 = CASE
                                WHEN LEFT(drvCntbrnAmt4_raw,1) = '-'
                                    THEN LEFT(drvCntbrnAmt4,9) +     
                                                CASE 
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvCntbrnAmt4,1) = '9' THEN 'R'
                                                END
                                ELSE drvCntbrnAmt4
                        END


    ---------------------------------
    -- DETAIL RECORD - U_EPRINC401K_OLD_D50 -- 408
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_D50','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_D50;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1')
        ,drvInitialSort = ISNULL(EECEMPNO,'')
        ,drvSubSort = 'F'
        -- standard fields above and additional driver fields below
        ,drvSsn = EepSSN
        ,drvPayPrdEndingDatePayDate = (select CONVERT(VARCHAR,MAX(cast(PdhPayDate as datetime)),101) from U_EPRINC401K_OLD_PDedHist)
        ,drvLoanID = [dbo].[dsi_fnPadZero](isnull(EedNotes,0),3,0)
        ,drvLoanPaymentAmt = [dbo].[dsi_fnPadZero](replace(isnull(PdhSource5,0)*100,'-',''),10,0)
        ,drvLoanPrincPayAmt = ''
    INTO dbo.U_EPRINC401K_OLD_D50
    --select count(*)
    FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID
    JOIN dbo.U_EPRINC401K_OLD_PDedHist WITH (NOLOCK)
    ON PdhEEID = xEEID
    and pdhDedCode IN ('401L','401LB','401LC')
    JOIN dbo.empded  WITH (NOLOCK) on eeddedcode=pdhDedCode and EedEEID = xEEID AND EedCoID = xCoID
    Where PdhSource5 != '0';

    Update dbo.U_EPRINC401K_OLD_D50
    SET drvLoanPaymentAmt = CASE
                                WHEN LEFT(drvLoanPaymentAmt,1) = '-'
                                    THEN SUBSTRING(STUFF(replace(dbo.dsi_fnPadZero(isnull(drvLoanPaymentAmt,0),11,2),'.',space(0)), LEN(drvLoanPaymentAmt), 1,     
                                                CASE 
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '0' THEN '}'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '1' THEN 'J'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '2' THEN 'K'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '3' THEN 'L'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '4' THEN 'M'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '5' THEN 'N'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '6' THEN 'O'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '7' THEN 'P'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '8' THEN 'Q'
                                                    WHEN RIGHT(drvLoanPaymentAmt,1) = '9' THEN 'R'
                                                END),2, LEN(drvLoanPaymentAmt))
                                END
    WHERE LEFT(drvLoanPaymentAmt,1) = '-'
    ;


    ---------------------------------
    -- TRAILER RECORD - U_EPRINC401K_OLD_T90 -- 500
    ---------------------------------
    IF OBJECT_ID('U_EPRINC401K_OLD_T90','U') IS NOT NULL
        DROP TABLE dbo.U_EPRINC401K_OLD_T90;
    SELECT DISTINCT
         drvSubSort = 'G'
        ,drvEFTCode = '4'
    INTO dbo.U_EPRINC401K_OLD_T90
     FROM dbo.U_EPRINC401K_OLD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID 
    AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_EPRINC401K_OLD_D10 WITH (NOLOCK)
    ON drvEEID =xEEID
    AND drvCOID = xCOID;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_818581_' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR, GETDATE(), 8),':','') + '.txt'
                                ELSE '818581_' + CONVERT(VARCHAR(8),GETDATE(),112) + REPLACE(CONVERT(VARCHAR, GETDATE(), 8),':','') + '.txt'
                                END
        WHERE FormatCode = @FormatCode;
    END

END;


/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPRINC401K_OLD_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRINC401K_OLD_File (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRINC401K_OLD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101291'
       ,expStartPerControl     = '202101291'
       ,expLastEndPerControl   = '202101299'
       ,expEndPerControl       = '202101299'
WHERE expFormatCode = 'EPRINC401K_OLD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRINC401K_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRINC401K_File (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2);
GO
CREATE VIEW dbo.dsi_vwEPRINC401K_OLD_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRINC401K_OLD_File (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPRINC401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRINC401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRINC401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRINC401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPRINC401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRINC401K', 'UseFileName', 'V', 'Y'


-- End ripout