/**********************************************************************************

EUHCLFLSTD: UHC Life LTD STD GenNotic TEST

FormatCode:     EUHCLFLSTD
Project:        UHC Life LTD STD GenNotic TEST
Client ID:      OHI1002
Date/time:      2021-12-16 10:19:36.110
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    E32
Server:         E3SUP2DB01
Database:       ULTIPRO_OHIVA
Web Filename:   OHI1002_2C8AB_EEHISTORY_EUHCLFLSTD_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUHCLFLSTD_SavePath') IS NOT NULL DROP TABLE dbo.U_EUHCLFLSTD_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUHCLFLSTD'


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
WHERE FormatCode = 'EUHCLFLSTD'
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
WHERE ExpFormatCode = 'EUHCLFLSTD'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUHCLFLSTD')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUHCLFLSTD'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUHCLFLSTD'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUHCLFLSTD'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUHCLFLSTD'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUHCLFLSTD'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUHCLFLSTD'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUHCLFLSTD'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUHCLFLSTD'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUHCLFLSTD'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUHCLFLSTD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCLFLSTD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCLFLSTD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCLFLSTD];
GO
IF OBJECT_ID('U_EUHCLFLSTD_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_Trailer];
GO
IF OBJECT_ID('U_EUHCLFLSTD_Header') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_Header];
GO
IF OBJECT_ID('U_EUHCLFLSTD_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_File];
GO
IF OBJECT_ID('U_EUHCLFLSTD_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_EEList];
GO
IF OBJECT_ID('U_EUHCLFLSTD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_drvTbl];
GO
IF OBJECT_ID('U_EUHCLFLSTD_DepNum') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_DepNum];
GO
IF OBJECT_ID('U_EUHCLFLSTD_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_AuditFields];
GO
IF OBJECT_ID('U_EUHCLFLSTD_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUHCLFLSTD_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EUHCLFLSTD','UHC Life LTD STD GenNotic','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','434','S','N','EUHCLFLSTDZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCLFLSTDZ0','48','H','01','1',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCLFLSTDZ0','13','H','01','49',NULL,'Record Type',NULL,NULL,'"HEADER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCLFLSTDZ0','1','H','01','62',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCLFLSTDZ0','8','H','01','63',NULL,'Client Job Number',NULL,NULL,'"drvRunDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCLFLSTDZ0','1','H','01','71',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCLFLSTDZ0','8','H','01','72',NULL,'File Creation Date',NULL,NULL,'"drvFileDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCLFLSTDZ0','355','H','01','80',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCLFLSTDZ0','9','D','10','1',NULL,'Subscriber ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCLFLSTDZ0','2','D','10','10',NULL,'Member Indicator',NULL,NULL,'"drvRelationShip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCLFLSTDZ0','35','D','10','12',NULL,'Member Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCLFLSTDZ0','15','D','10','47',NULL,'Member First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCLFLSTDZ0','2','D','10','62',NULL,'Member Relationship',NULL,NULL,'"drvRelation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCLFLSTDZ0','1','D','10','64',NULL,'Member Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCLFLSTDZ0','40','D','10','65',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUHCLFLSTDZ0','40','D','10','105',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUHCLFLSTDZ0','19','D','10','145',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUHCLFLSTDZ0','2','D','10','164',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUHCLFLSTDZ0','5','D','10','166',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUHCLFLSTDZ0','4','D','10','171',NULL,'Zip Suffix',NULL,NULL,'"drvAddressZipExt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUHCLFLSTDZ0','12','D','10','175',NULL,'Home Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUHCLFLSTDZ0','12','D','10','187',NULL,'Work Phone',NULL,NULL,'"drvPhoneBusinessNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUHCLFLSTDZ0','1','D','10','199',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUHCLFLSTDZ0','8','D','10','200',NULL,'Birth Date',NULL,NULL,'"drvDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUHCLFLSTDZ0','30','D','10','208',NULL,'Group Policy Number',NULL,NULL,'"729805"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUHCLFLSTDZ0','30','D','10','238',NULL,'Subgrp Policy Number',NULL,NULL,'"1001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUHCLFLSTDZ0','8','D','10','268',NULL,'Emp Sub-Grp Eff Date',NULL,NULL,'"drvBenStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUHCLFLSTDZ0','10','D','10','276',NULL,'Plan Code',NULL,NULL,'"drvDedCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUHCLFLSTDZ0','8','D','10','286',NULL,'Plan Code Eff Date',NULL,NULL,'"drvStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUHCLFLSTDZ0','2','D','10','294',NULL,'Tier Code',NULL,NULL,'"drvEedDedCode "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUHCLFLSTDZ0','8','D','10','296',NULL,'Eff Date',NULL,NULL,'"drvBenStrtDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUHCLFLSTDZ0','8','D','10','304',NULL,'Term Date',NULL,NULL,'"drvBenStopDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUHCLFLSTDZ0','9','D','10','312',NULL,'ALT-ID',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUHCLFLSTDZ0','1','D','10','321',NULL,'Student Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUHCLFLSTDZ0','1','D','10','322',NULL,'Handicapped',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUHCLFLSTDZ0','3','D','10','323',NULL,'Written Preference Language',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUHCLFLSTDZ0','8','D','10','326',NULL,'Written Preference Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUHCLFLSTDZ0','3','D','10','334',NULL,'Spoken Preference Language',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUHCLFLSTDZ0','8','D','10','337',NULL,'Spoken Preference Effective Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUHCLFLSTDZ0','1','D','10','345',NULL,'CALAP Eligibility Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUHCLFLSTDZ0','8','D','10','346',NULL,'Hire Date',NULL,NULL,'"drvDateOfLastHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUHCLFLSTDZ0','4','D','10','354',NULL,'Subscriber Class Id',NULL,NULL,'"0002"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUHCLFLSTDZ0','8','D','10','358',NULL,'Subscriber Class Effective date',NULL,NULL,'"drvDateStart"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUHCLFLSTDZ0','1','D','10','366',NULL,'Salary Type',NULL,NULL,'"drvSalaryType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUHCLFLSTDZ0','10','D','10','367',NULL,'Salary Amount',NULL,NULL,'"drvAnnSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUHCLFLSTDZ0','8','D','10','377',NULL,'Salary Effective date',NULL,NULL,'"drvJobEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUHCLFLSTDZ0','10','D','10','385',NULL,'Plan Coverage Amount',NULL,NULL,'"drvPlan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUHCLFLSTDZ0','8','D','10','395',NULL,'Rating Premium Override Effective Date',NULL,NULL,'"drvBeginDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUHCLFLSTDZ0','8','D','10','403',NULL,'Student Status Effective date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUHCLFLSTDZ0','8','D','10','411',NULL,'Student Status Term date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUHCLFLSTDZ0','8','D','10','419',NULL,'Handicap Effective date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUHCLFLSTDZ0','8','D','10','427',NULL,'Handicap Term date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCLFLSTDZ0','48','T','90','1',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCLFLSTDZ0','14','T','90','49',NULL,'Record Type',NULL,NULL,'"TRAILER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCLFLSTDZ0','1','T','90','63',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCLFLSTDZ0','8','T','90','64',NULL,'Client Job Number',NULL,NULL,'"drvRunDt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCLFLSTDZ0','1','T','90','72',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCLFLSTDZ0','9','T','90','73',NULL,'Record Count',NULL,NULL,'"drvCount"','(''UN0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCLFLSTDZ0','353','T','90','82',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUHCLFLSTD_20211216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201509309','EMPEXPORT','OEACTIVE','Oct 28 2016 12:29PM','EUHCLFLSTD',NULL,NULL,NULL,'201509309','Sep 30 2015 12:00AM','Dec 30 1899 12:00AM','201509011','2','','','201509011',dbo.fn_GetTimedKey(),NULL,'MGROM01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201509259','EMPEXPORT','OEPASSIVE',NULL,'EUHCLFLSTD',NULL,NULL,NULL,'201509259','Sep 25 2015  5:39PM','Sep 25 2015  5:39PM','201509251',NULL,'','','201509251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'ODQ5S',NULL,NULL,NULL,'UHC Life LTD STD GenNotic Exp','201701101','EMPEXPORT','ONDEMAND','Jan 10 2017 10:34AM','EUHCLFLSTD',NULL,NULL,NULL,'201701101','Jan 10 2017 12:00AM','Dec 30 1899 12:00AM','201701011','2691','','','201701011',dbo.fn_GetTimedKey(),NULL,'MGROM01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'ODQ5S',NULL,NULL,NULL,'Scheduled Session','201509259','EMPEXPORT','SCHEDULED','Nov 12 2021  7:00AM','EUHCLFLSTD',NULL,NULL,NULL,'202111119','Sep 25 2015 12:00AM','Dec 30 1899 12:00AM','202111051','2327','','','201509251',dbo.fn_GetTimedKey(),NULL,'MGROM01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','ODQ5S',NULL,NULL,NULL,'Test Purposes Only','202111309','EMPEXPORT','TEST','Nov 30 2021 11:55AM','EUHCLFLSTD',NULL,NULL,NULL,'202111309','Nov 30 2021 12:00AM','Dec 30 1899 12:00AM','202111161','4440','','','202111161',dbo.fn_GetTimedKey(),NULL,'us3jReOHI1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','SubSort','C','drvRelationShip');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','UDESPath','V','\\us.saas\e0\data_exchange\OHI1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCLFLSTD','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCLFLSTD','H01','dbo.U_EUHCLFLSTD_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCLFLSTD','D10','dbo.U_EUHCLFLSTD_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCLFLSTD','T90','dbo.U_EUHCLFLSTD_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EUHCLFLSTD_Audit
-----------

IF OBJECT_ID('U_EUHCLFLSTD_Audit') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_Audit] (
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
-- Create table U_EUHCLFLSTD_AuditFields
-----------

IF OBJECT_ID('U_EUHCLFLSTD_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EUHCLFLSTD_DepNum
-----------

IF OBJECT_ID('U_EUHCLFLSTD_DepNum') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_DepNum] (
    [drvSSN] varchar(9) NULL,
    [drvDepID] varchar(20) NULL,
    [drvRelationShip] varchar(10) NULL,
    [drvPersonCode] int NULL
);

-----------
-- Create table U_EUHCLFLSTD_drvTbl
-----------

IF OBJECT_ID('U_EUHCLFLSTD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_drvTbl] (
    [drvSSN] char(11) NULL,
    [drvRelationShip] varchar(2) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvRelation] varchar(2) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvAddressZipExt] varchar(4) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvBenStartDate] datetime NULL,
    [drvDedCode] varchar(8) NULL,
    [drvStartDate] datetime NULL,
    [drvEedDedCode] varchar(1) NULL,
    [drvBenStrtDate] datetime NULL,
    [drvBenStopDate] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateStart] datetime NULL,
    [drvSalaryType] varchar(1) NULL,
    [drvAnnSalary] varchar(10) NULL,
    [drvJobEffDate] datetime NULL,
    [drvPlan] varchar(20) NULL,
    [drvBeginDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepID] varchar(12) NOT NULL
);

-----------
-- Create table U_EUHCLFLSTD_EEList
-----------

IF OBJECT_ID('U_EUHCLFLSTD_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUHCLFLSTD_File
-----------

IF OBJECT_ID('U_EUHCLFLSTD_File') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(434) NULL
);

-----------
-- Create table U_EUHCLFLSTD_Header
-----------

IF OBJECT_ID('U_EUHCLFLSTD_Header') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_Header] (
    [drvRunDate] varchar(8000) NULL,
    [drvFileDate] datetime NOT NULL
);

-----------
-- Create table U_EUHCLFLSTD_Trailer
-----------

IF OBJECT_ID('U_EUHCLFLSTD_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUHCLFLSTD_Trailer] (
    [drvRunDt] varchar(8000) NULL,
    [drvCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCLFLSTD]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Ohio Virtual Academy

Created By: Cyndi Diaz
Business Analyst: Fernando Gutierrez
Create Date: 09/25/2015
Service Request Number: SR-2015-00099290

Purpose: UHC Life LTD STD GenNotic Exp TEST

Revision History
----------------
Update By            Date           Request Num                 Desc        
Sean Hawkins        09/23/2016        SR-2016-132100                Updated for logic from field 38 to apply to field 23 if STD/LTD
                    09/26/2016                                    Updates for fields 19, 21, 23, 35, 38 and 40 for minimum cov value of 11/1/2016
                    10/06/2016                                    Updates for stop logic if prior to 11/1/2016 plan year - remove stops if stop date < 11/1/2016 from file per UHC request
Matt Magid            08/23/2017        09498505                    Updated the minimum coverage value to work for terminated employees
Ryan Denzer-King    08/02/2018      SR-2018-199537              Update plan names
Patrick Bresnahan    05/20/2019        SF14209694                    Adjusted ERSTD logic to use translated plan code

11/12/2021 by AP:
    - Added new deduction codes per updated spec by Julie Reardon.
    - Added modifications for each new deduction code.

11/16/2021 by AP:    
    - Updated ben start date to use min coverage date for drv start date.
    - Restructured data to include inserts for new values requested.

11/17/2021 by AP:
    - Updated MAX start date just for drvStartDate and drvBeginDate.

11/29/2021 by AP:
    - Updated code BACK to MAX start date to all EedBenStartDate fields for new ded codes including ERSTD.
    - Inserted dependent records for all new ded codes where available.

12/16/2021 by AP:
	- Added minimum effective date back to 08/01/2021.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCLFLSTD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCLFLSTD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCLFLSTD';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EUHCLFLSTD';


--now able to switch to I drive or J drive path on the fly without hardcoding:

I: drive:
update U_dsi_configuration
set cfgvalue = dbo.dsi_fnVariable('EUHCLFLSTD','TestPath') 
where FormatCode = 'EUHCLFLSTD'
and cfgname = 'ExportPath'

J: drive:
update U_dsi_configuration
set cfgvalue = dbo.dsi_fnVariable('EUHCLFLSTD','UDESPath') 
where FormatCode = 'EUHCLFLSTD'
and cfgname = 'ExportPath'


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCLFLSTD', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCLFLSTD', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCLFLSTD', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCLFLSTD', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCLFLSTD', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCLFLSTD';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUHCLFLSTD', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9)
            ,@FileMinCovDate     DATETIME

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('08/01/2021' AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EUHCLFLSTD';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCLFLSTD_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;
    --select deddedcode, dedeeviewplandesc from dedcode where deddedcode in ('ERSTD','LTD','LIFEB','ADD','VLIF','LIFSP','LIFCH')
    -- Required parameters
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', 'ERSTD,LIFEB,ADD,VLIF,LIFSP,LIFCH,ACCIL,ACCIH,HOSPL,HOSPH')
   -- INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', 'ACCIH,ACCIL,HOSPH,HOSPL,ERSTD') 
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END
    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END

    -- Run BDM Module
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --Code for "terminations sent one time only". One time means sent one time during the per control range.

    --Audit Table
    IF OBJECT_ID('U_EUHCLFLSTD_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCLFLSTD_AuditFields;
    CREATE TABLE dbo.U_EUHCLFLSTD_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EUHCLFLSTD_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EUHCLFLSTD_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCLFLSTD_Audit;
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
    INTO dbo.U_EUHCLFLSTD_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EUHCLFLSTD_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EUHCLFLSTD_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUHCLFLSTD_Audit ON dbo.U_EUHCLFLSTD_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ------------------
    -- HEADER RECORD
    ------------------
    IF OBJECT_ID('U_EUHCLFLSTD_Header') IS NOT NULL
        DROP TABLE dbo.U_EUHCLFLSTD_Header;
    SELECT DISTINCT
        drvRunDate = REPLACE(CONVERT(VARCHAR(10),GETDATE(), 101), '/', '')
        ,drvFileDate = GETDATE()
    INTO dbo.U_EUHCLFLSTD_Header
    ;

    ------------------
    -- DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EUHCLFLSTD_drvTbl') IS NOT NULL
        DROP TABLE dbo.U_EUHCLFLSTD_drvTbl;
    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = CASE WHEN EedDedCode = 'ERSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
                                ELSE EedBenStartDate END
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                                WHEN EedDedCode = 'LIFEB' then 'LE000187'
                                WHEN EedDedCode = 'ADD' then 'LE000188'
                                WHEN EedDedCode = 'VLIF' then 'LE000428'
                                WHEN EedDedCode = 'LIFSP' then 'LE000190'
                                --WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEONLY' THEN 'LE001772'
                                --WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEONLY' THEN 'LE001776'
                                --WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEONLY' THEN 'LE001924'
                                --WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEONLY' THEN 'LE001928'
                                WHEN EedDedCode = 'LIFCH' THEN
                                    CASE WHEN  EedBenAmt = 1000 then 'LE000125'
                                        WHEN  EedBenAmt = 2000 then 'LE000192'
                                        WHEN  EedBenAmt = 3000 then 'LE000193'
                                        WHEN  EedBenAmt = 4000 then 'LE000194'
                                        WHEN  EedBenAmt = 5000 then 'LE000007'
                                        WHEN  EedBenAmt = 6000 then 'LE000195'
                                        WHEN  EedBenAmt = 7000 then 'LE000196'
                                        WHEN  EedBenAmt = 8000 then 'LE000197'
                                        WHEN  EedBenAmt = 9000 then 'LE000198'
                                        WHEN EedBenAmt = 10000 then 'LE000009'
                                    END
                            END
        ,drvStartDate = CASE WHEN EedDedCode = 'ERSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
                                ELSE EedBenStartDate END
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvEedDedCode  = CASE WHEN EedDedCode = 'ERSTD' then 'C'
                                WHEN EedDedCode = 'LIFEB' then 'C'
                                WHEN EedDedCode = 'ADD' then 'C'
                                WHEN EedDedCode = 'VLIF' then 'C'
                                WHEN EedDedCode = 'LIFSP' then 'F'
                                WHEN EedDedCode = 'LIFCH' then 'G'
                                --WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEONLY' THEN 'C'
                                --WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEONLY' THEN 'C'
                                --WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEONLY' THEN 'C'
                                --WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEONLY' THEN 'C'
                        END
        ,drvBenStrtDate = CASE WHEN EedDedCode = 'ERSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
                                ELSE EedBenStartDate END
        --CASE
  --                              WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
  --                                  WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvBenStopDate = CASE WHEN EedDedCode in ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStopDate ELSE NULL END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = CASE WHEN EedDedCode = 'ERSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
                                ELSE EedBenStartDate END
                                   -- WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD') and eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD') and eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = CASE WHEN EedDedCode = 'ERSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
                            ELSE EedBenStartDate END
        --CASE
                            --    WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH', 'ERSTD') THEN EedBenStartDate END
                                  --  WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedDedCode IN ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH')
--    WHERE EedBenOption = 'EEONLY'
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEONLY' THEN 'LE001772'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEONLY' THEN 'LE001776'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEONLY' THEN 'LE001924'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEONLY' THEN 'LE001928'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'C'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EEONLY'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EMPLOYEE + SPOUSE RECORD (EMPLOYEE)

    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'LE001773'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001777'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'LE001925'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'LE001929'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'B'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EESPOU'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EMPLOYEE + SPOUSE RECORD (SPOUSE)

     SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelation = 'SP'
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = Substring(ConAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(ConAddressZipCode,6,4)
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvPhoneBusinessNumber = ''
        ,drvGender = ConGender
        ,drvDateofBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'LE001773'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001777'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'LE001925'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'LE001929'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'B'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ConSystemID
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
        AND ConRelationship = 'SPS'
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EESPOU'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,ConNameLast,ConNameFirst,ConNameMiddle,ConAddressLine1,ConAddressLine2,ConAddressCity,ConAddressState,ConAddressZipCode,ConPhoneHomeNumber,
    ConGender,ConSystemID,ConDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EPLOYEE + CHILD RECORD (EMPLOYEE)

    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'LE001774'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EECHIL' THEN 'LE001778'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'LE001926'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'LE001930'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'D'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EECHIL'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EMPLOYEE + CHILD RECORD (CHILD)

     SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelation = 'CH'
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = Substring(ConAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(ConAddressZipCode,6,4)
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvPhoneBusinessNumber = ''
        ,drvGender = ConGender
        ,drvDateofBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                        CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'LE001774'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EECHIL' THEN 'LE001778'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'LE001926'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'LE001930'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'D'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ConSystemID
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
        AND ConRelationship IN ('CHL', 'STC')
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EECHIL'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,ConNameLast,ConNameFirst,ConNameMiddle,ConAddressLine1,ConAddressLine2,ConAddressCity,ConAddressState,ConAddressZipCode,ConPhoneHomeNumber,
    ConGender,ConSystemID,ConDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EMPLOYEE + FAM RECORD (EMPLOYEE)

    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'LE001775'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'LE001779'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'LE001927'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'LE001931'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'A'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EEFAM'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    -- EMPLOYEE + FAM RECORD (FAMILY)

      SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelation = CASE WHEN ConRelationship = 'SPS' THEN 'SP'
                            WHEN ConRelationship IN ('CHL', 'STC') THEN 'CH'
                            END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = Substring(ConAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(ConAddressZipCode,6,4)
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvPhoneBusinessNumber = ''
        ,drvGender = ConGender
        ,drvDateofBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = --CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                         CASE       WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'LE001775'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'LE001779'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'LE001927'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'LE001931'
                                END
                            
        ,drvStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEedDedCode  = 'A'
        ,drvBenStrtDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvBenStopDate = EedBenStopDate 
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) 
        ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        --Basic Life and Basic AD&D
        ,drvBeginDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ConSystemID
--select * from U_dsi_bdm_EmpDeductions  where eedformatcode = 'EUHCLFLSTD'
    --INTO dbo.U_EUHCLFLSTD_drvTbl
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
        AND ConRelationship IN ('CHL', 'STC', 'SPS')
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedBenOption = 'EEFAM'
    AND EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH')
    GROUP BY eepSSN,ConNameLast,ConNameFirst,ConNameMiddle,ConAddressLine1,ConAddressLine2,ConAddressCity,ConAddressState,ConAddressZipCode,ConPhoneHomeNumber,
    ConGender,ConDateOfBirth,ConRelationship,ConSystemID,EedBenStartDate,EedBenStopDate,EedDedCode, EedBenOption, EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

  --  --emloyee AD&D, if emp has VLIF, they automatically get AD&D
    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = EedBenStartDate
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = CASE WHEN EedDedCode = 'VLIF' then 'LE000004'    END
        ,drvStartDate = CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvEedDedCode  = CASE WHEN EedDedCode = 'ERSTD' then 'C'
                                WHEN EedDedCode = 'LIFEB' then 'C'
                                WHEN EedDedCode = 'ADD' then 'C'
                                WHEN EedDedCode = 'VLIF' then 'C'
                                WHEN EedDedCode = 'LIFSP' then 'F'
                                WHEN EedDedCode = 'LIFCH' then 'G'
                                WHEN EedDedCode = 'ACCIL' THEN 'C'
                                WHEN EedDedCode = 'ACCIH' THEN 'C'
                                WHEN EedDedCode = 'HOSPL' THEN 'C'
                                WHEN EedDedCode = 'HOSPH' THEN 'C'
                        END
        ,drvBenStrtDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvBenStopDate = CASE WHEN EedDedCode in ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH', 'ACCIL', 'ACCIH', 'HOSPL', 'HOSPH') THEN EedBenStopDate ELSE NULL END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD', 'ACCIL', 'ACCIH', 'HOSPL', 'HOSPH') and eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD', 'ACCIL', 'ACCIH', 'HOSPL', 'HOSPH') and eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        ,drvBeginDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedDedCode = 'VLIF'
--    AND EedBenOption = 'EEONLY'
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode,EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION
    --get dependent life records on employee records
    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = '00'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelation = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = Substring(EepAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(EepAddressZipCode,6,4)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvBenStartDate = EedBenStartDate
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = CASE WHEN EedBenAmt = 1000 then 'LE000126'
                                    WHEN  EedBenAmt = 2000 then 'LE000199'
                                    WHEN  EedBenAmt = 3000 then 'LE000200'
                                    WHEN  EedBenAmt = 4000 then 'LE000201'
                                    WHEN  EedBenAmt = 5000 then 'LE000086'
                                    WHEN  EedBenAmt = 6000 then 'LE000202'
                                    WHEN  EedBenAmt = 7000 then 'LE000203'
                                    WHEN  EedBenAmt = 8000 then 'LE000204'
                                    WHEN  EedBenAmt = 9000 then 'LE000205'
                                    WHEN  EedBenAmt = 10000 then 'LE000024'
                                END
        ,drvStartDate = CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvEedDedCode  = CASE WHEN EedDedCode = 'ERSTD' then 'C'
                                WHEN EedDedCode = 'LIFEB' then 'C'
                                WHEN EedDedCode = 'ADD' then 'C'
                                WHEN EedDedCode = 'VLIF' then 'C'
                                WHEN EedDedCode = 'LIFSP' then 'F'
                                WHEN EedDedCode = 'LIFCH' then 'G'
                                WHEN EedDedCode = 'ACCIL' then 'C'
                                WHEN EedDedCode = 'ACCIH' then 'C'
                                WHEN EedDedCode = 'HOSPL' then 'C'
                                WHEN EedDedCode = 'HOSPH' THEN 'C'
                        END
       ,drvBenStrtDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvBenStopDate = CASE WHEN EedDedCode in ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH', 'ACCIL', 'ACCIH', 'HOSPL', 'HOSPH') THEN EedBenStopDate ELSE NULL END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        ,drvBeginDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ''
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE EedDedCode = 'LIFCH'
--    AND EedBenOption = 'EEONLY'
    GROUP BY eepSSN,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode,EepPhoneHomeNumber,EecPhoneBusinessNumber,
    EepGender,EepDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode,EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID
                    
    UNION
    
    --dependent records
    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = SPACE(2)
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelation = CASE WHEN ConRelationship = 'SPS' Then 'SP'
                            WHEN ConRelationship in ('CHL','STC') Then 'CH'
                            Else 'OT' END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = Substring(ConAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(ConAddressZipCode,6,4)
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvPhoneBusinessNumber = ''
        ,drvGender = ConGender
        ,drvDateofBirth = ConDateOfBirth
        ,drvBenStartDate = EedBenStartDate
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = CASE WHEN EedDedCode = 'ERSTD' then 'LE001133'
                                WHEN EedDedCode = 'LIFEB' then 'LE000187'
                                WHEN EedDedCode = 'ADD' then 'LE000188'
                                WHEN EedDedCode = 'VLIF' then 'LE000428'
                                WHEN EedDedCode = 'LIFSP' then 'LE000190'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'LE001773'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'LE001774'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'LE001775'
                                WHEN EedDedcode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001777'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001778'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'LE001779'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'LE001925'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'LE001926'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'LE001927'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'LE001929'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'LE001930'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'LE001931'
                                WHEN EedDedCode = 'LIFCH' THEN 
                                    CASE WHEN  EedBenAmt = 1000 then 'LE000125'
                                        WHEN  EedBenAmt = 2000 then 'LE000192'
                                        WHEN  EedBenAmt = 3000 then 'LE000193'
                                        WHEN  EedBenAmt = 4000 then 'LE000194'
                                        WHEN  EedBenAmt = 5000 then 'LE000007'
                                        WHEN  EedBenAmt = 6000 then 'LE000195'
                                        WHEN  EedBenAmt = 7000 then 'LE000196'
                                        WHEN  EedBenAmt = 8000 then 'LE000197'
                                        WHEN  EedBenAmt = 9000 then 'LE000198'
                                        WHEN EedBenAmt = 10000 then 'LE000009'
                                    END
                        END
        ,drvStartDate = CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvEedDedCode  = CASE WHEN EedDedCode = 'ERSTD' then 'C'
                                WHEN EedDedCode = 'LIFEB' then 'C'
                                WHEN EedDedCode = 'ADD' then 'C'
                                WHEN EedDedCode = 'VLIF' then 'C'
                                WHEN EedDedCode = 'LIFSP' then 'F'
                                WHEN EedDedCode = 'LIFCH' then 'G'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedcode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'D'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'A'
                        END
        ,drvBenStrtDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvBenStopDate = CASE WHEN EedDedCode in ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH', 'ACCIL', 'ACCIH', 'HOSPL', 'HOSPH') THEN EedBenStopDate ELSE NULL END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        ,drvBeginDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ConSystemID
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
        AND ConRelationship in ('SPS','CHL','STC')
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID)
    WHERE (EedDedCode = 'LIFSP' AND ConRelationship = 'SPS' OR EedDedCode = 'LIFCH' AND ConRelationship in ('CHL','STC'))
--    AND EedBenOption IN ('EESPOU', 'EECHIL')
    GROUP BY eepSSN,ConNameLast,ConNameFirst,ConNameMiddle,ConAddressLine1,ConAddressLine2,ConAddressCity,ConAddressState,ConAddressZipCode,ConPhoneHomeNumber,ConRelationship,
    ConSystemID,ConGender,ConDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode,EedBenOption,EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID

    UNION

    SELECT DISTINCT
        drvSSN = eepSSN
        ,drvRelationShip = SPACE(2)
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelation = CASE WHEN ConRelationship = 'SPS' Then 'SP'
                            WHEN ConRelationship in ('CHL','STC') Then 'CH'
                            Else 'OT' END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZipCode = Substring(ConAddressZipCode,1,5)
        ,drvAddressZipExt = Substring(ConAddressZipCode,6,4)
        ,drvPhoneHomeNumber = ConPhoneHomeNumber
        ,drvPhoneBusinessNumber = ''
        ,drvGender = ConGender
        ,drvDateofBirth = ConDateOfBirth
        ,drvBenStartDate = EedBenStartDate
        --CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvDedCode = CASE WHEN EedDedCode = 'ERSTD' then 'LE000206'
                                WHEN EedDedCode = 'LIFEB' then 'LE000187'
                                WHEN EedDedCode = 'ADD' then 'LE000188'
                                WHEN EedDedCode = 'VLIF' then 'LE000428'
                                WHEN EedDedCode = 'LIFSP' then 'LE000191'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'LE001773'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'LE001774'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'LE001775'
                                WHEN EedDedcode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001777'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'LE001778'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'LE001779'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'LE001925'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'LE001926'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'LE001927'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'LE001929'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'LE001930'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'LE001931'
                            WHEN EedDedCode = 'LIFCH' then
                                CASE WHEN EedBenAmt = 1000 then 'LE000126'
                                    WHEN  EedBenAmt = 2000 then 'LE000199'
                                    WHEN  EedBenAmt = 3000 then 'LE000200'
                                    WHEN  EedBenAmt = 4000 then 'LE000201'
                                    WHEN  EedBenAmt = 5000 then 'LE000086'
                                    WHEN  EedBenAmt = 6000 then 'LE000202'
                                    WHEN  EedBenAmt = 7000 then 'LE000203'
                                    WHEN  EedBenAmt = 8000 then 'LE000204'
                                    WHEN  EedBenAmt = 9000 then 'LE000205'
                                    WHEN  EedBenAmt = 10000 then 'LE000024'
                                END
                            END
        ,drvStartDate = CASE WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE EedBenStartDate END
        ,drvEedDedCode  = CASE WHEN EedDedCode = 'ERSTD' then 'C'
                                WHEN EedDedCode = 'LIFEB' then 'C'
                                WHEN EedDedCode = 'ADD' then 'C'
                                WHEN EedDedCode = 'VLIF' then 'C'
                                WHEN EedDedCode = 'LIFSP' then 'F'
                                WHEN EedDedCode = 'LIFCH' then 'G'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'ACCIL' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedcode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EESPOU' THEN 'D'
                                WHEN EedDedCode = 'ACCIH' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'HOSPL' AND EedBenOption = 'EEFAM' THEN 'A'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EESPOU' THEN 'B'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EECHIL' THEN 'D'
                                WHEN EedDedCode = 'HOSPH' AND EedBenOption = 'EEFAM' THEN 'A'
                        END
        ,drvBenStrtDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvBenStopDate = CASE WHEN EedDedCode in ('ERSTD','LIFEB','ADD','VLIF','LIFSP','LIFCH','ACCIL','ACCIH','HOSPL','HOSPH') THEN EedBenStopDate ELSE NULL END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateStart = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvSalaryType = CASE WHEN EedDedCode = 'ERSTD' Then 'A' END
        ,drvAnnSalary = CASE WHEN EedDedCode = 'ERSTD' AND EecAnnSalary <> 0 Then RIGHT('0000000000' + CONVERT(VARCHAR(20),EecAnnSalary), 10) ELSE '' END
        ,drvJobEffDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN Max(EjhJobEffDate) ELSE EecDateOfLastHire END
        ,drvPlan = CASE WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt <> 0 THEN CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
        WHEN EedDedCode IN ('LIFCH','VLIF','LIFSP','LIFEB','ADD','ACCIL','ACCIH','HOSPL','HOSPH') and eedbenamt = 0 THEN CONVERT(VARCHAR(20),CAST(DedEEBenAmt AS INT))
        END
        ,drvBeginDate = CASE
                                WHEN EedDedCode in ('LIFEB','ADD','VLIF','LIFSP','LIFCH') THEN EedBenStartDate 
                                    WHEN EedDedCode IN ('ACCIL', 'ACCIH', 'HOSPL', 'HOSPH', 'ERSTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) ELSE NULL END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepID = ConSystemID
    FROM dbo.U_EUHCLFLSTD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EUHCLFLSTD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID 
        AND ConRelationship in ('SPS','CHL','STC')
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = 'EUHCLFLSTD'
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCoID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) WHERE EjhEEID = xEEID AND EjhCoID = xCOID AND EjhIsRateChange = 'Y')
    WHERE (EedDedCode = 'LIFSP' AND ConRelationship = 'SPS' OR EedDedCode = 'LIFCH' AND ConRelationship in ('CHL','STC'))
--    AND EedBenOption IN ('EESPOU', 'EECHIL')
    GROUP BY eepSSN,ConNameLast,ConNameFirst,ConNameMiddle,ConAddressLine1,ConAddressLine2,ConAddressCity,ConAddressState,ConAddressZipCode,ConPhoneHomeNumber,ConRelationship,
    ConSystemID,ConGender,ConDateOfBirth,EedBenStartDate,EedBenStopDate,EedDedCode,EedBenOption,EedBenAmt,DedEEBenAmt,EecDateOfLastHire,EecAnnSalary,EjhIsRateChange,xEEID,xCOID
    ;
    
    --add spouse AD&D record to employee records
    INSERT INTO dbo.U_EUHCLFLSTD_drvTbl 
    SELECT drvSSN,drvRelationShip,drvNameLast,drvNameFirst,drvRelation,drvNameMiddle,drvAddressLine1,drvAddressLine2,drvAddressCity,drvAddressState,drvAddressZipCode,drvAddressZipExt,
    drvPhoneHomeNumber,drvPhoneBusinessNumber,drvGender,drvDateofBirth,drvBenStartDate,drvDedCode,drvStartDate,drvEedDedCode,drvBenstrtDate,drvBenStopDate,drvDateOfLastHire,
    drvDateStart,drvSalaryType,drvAnnSalary,drvJobEffDate,drvPlan,drvBeginDate,drvEEID,drvCOID,drvDepID 
    FROM dbo.U_EUHCLFLSTD_drvTbl A WITH (NOLOCK) 
    WHERE drvRelation = 'EE' AND drvDedCode = 'LE000004'
    AND EXISTS(SELECT * FROM dbo.U_EUHCLFLSTD_drvTbl WITH (NOLOCK) WHERE drvRelation = 'SP' AND drvDedCode = 'LE000191' AND drvEEID = A.drvEEID)

    ;WITH cte AS
    (
      SELECT
          ROW_NUMBER() OVER(PARTITION BY drveeid  ORDER BY drvdedcode ) AS rno,
          drvDedCode,drvEedDedCode 
      FROM dbo.U_EUHCLFLSTD_drvTbl A WITH (NOLOCK) 
    WHERE drvRelation = 'EE' AND drvDedCode = 'LE000004'
    AND EXISTS(SELECT * FROM dbo.U_EUHCLFLSTD_drvTbl WITH (NOLOCK) WHERE drvRelation = 'SP' AND drvDedCode = 'LE000191' AND drvEEID = A.drvEEID)
    )

    UPDATE cte SET drvDedCode = 'LE000191',drvEedDedCode = 'F'
    WHERE rno=2

    update dbo.U_EUHCLFLSTD_drvTbl 
    --set drvBenStrtDate = CASE WHEN EedDedCode = 'ERSTD' AND EjhIsRateChange = 'Y' THEN EjhJobEffDate
    set drvBenStrtDate = CASE WHEN drvDedCode = 'LE000206'AND EjhIsRateChange = 'Y' THEN EjhJobEffDate -- PB 14209694 
    else drvbenstrtdate
    end
    from dbo.U_EUHCLFLSTD_drvTbl
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
        and EedDedCode = 'ERSTD'
    JOIN dbo.EmpHJob WITH (NOLOCK)
        ON EjhEEID = drvEEID
        AND EjhCoID = drvCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.EmpHJob WITH (NOLOCK) 
        WHERE EjhEEID = drvEEID AND EjhCoID = drvCOID AND EjhIsRateChange = 'Y')

    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvJobEffDate = '11/01/2016' WHERE drvJobEffDate is not null and drvJobEffDate < '11/01/2016'
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvBenStartDate = '11/01/2016' WHERE drvBenStartDate is not null and drvBenStartDate < '11/01/2016'
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvStartDate = '11/01/2016' WHERE drvStartDate is not null and drvStartDate < '11/01/2016'
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvBenStrtDate = '11/01/2016' WHERE drvBenStrtDate is not null and drvBenStrtDate < '11/01/2016'
     
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvBenStopDate = '11/01/2016' WHERE drvBenStopDate < '11/01/2016' and drvbenstopdate is not null and @enddate >= '11/01/2016'
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvDateStart = '11/01/2016' WHERE drvDateStart is not null and drvDateStart < '11/01/2016'
    UPDATE dbo.U_EUHCLFLSTD_drvTbl SET drvBeginDate = '11/01/2016' WHERE drvBeginDate is not null and drvBeginDate < '11/01/2016'
    
    delete from dbo.U_EUHCLFLSTD_drvTbl
    where drvbenstopdate is not null and drvbenstopdate < '11/01/2016'
    

    



    --update dependents unique person code
    declare @drvEmpSSN varchar(9),
            @drvDepID varchar(20),
            @drvRelation varchar(10),
            @drvPersonCode int,
            @DepNum int,
            @Spouse char,
            @LastNumUsed int
            

    DECLARE empcursor CURSOR FOR 
    SELECT drvSSN,drvDepID,drvRelation FROM u_EUHCLFLSTD_drvTbl
    where drvRelation <> 'EE'
    GROUP BY drvSSN,drvDepID,drvRelation

    OPEN empcursor

    FETCH NEXT FROM empcursor 
    INTO @drvEmpSSN, @drvDepID, @drvRelation
    --select * from u_EUHCLFLSTD_DepNum
    WHILE @@FETCH_STATUS = 0
    BEGIN
    PRINT 'RELATION' +  @drvRelation
            IF @drvRelation = 'SP'
            BEGIN
            PRINT 'INTO SPOUSE'
                --select from table to see if spouse exists, if so get number from table
                SELECT @DepNum = ''
                SELECT @DepNum = drvPersonCode FROM dbo.u_EUHCLFLSTD_DepNum 
                WHERE drvSSN = @drvEmpSSN and drvDepID = @drvDepID

                --if number doesn't exist get next number for child and update table
                IF @DepNum = '' OR @DepNum IS NULL
                BEGIN
                    SELECT @LastNumUsed = 0
                    SELECT @LastNumUsed = MAX(drvPersonCode) FROM dbo.u_EUHCLFLSTD_DepNum WHERE drvSSN = @drvEmpSSN AND @drvRelation = 'SP'
                    IF @LastNumUsed IS NULL SELECT @LastNumUsed = 0
                    IF @LastNumUsed = 1 SELECT @LastNumUsed = 89
                    SELECT @DepNum = @LastNumUsed + 1
                    INSERT INTO dbo.u_EUHCLFLSTD_DepNum (drvSSN,drvDepID,drvPersonCode) VALUES(@drvEmpSSN,@drvDepID,@DepNum)
                PRINT CONVERT(VARCHAR(2),@DepNum)
                END

                --update driver table
                IF @DepNum <> '' and @DepNum IS NOT NULL
                    UPDATE u_EUHCLFLSTD_drvTbl set drvRelationShip = RIGHT('00' + CONVERT(VARCHAR(2),@DepNum), 2) WHERE drvSSN = @drvEmpSSN AND drvDepID = @drvDepID 
            END
            
            IF @drvRelation <> 'SP'
            BEGIN
                --select from table to see if child exists, if so get number from table
                SELECT @DepNum = ''
                SELECT @DepNum = drvPersonCode FROM dbo.u_EUHCLFLSTD_DepNum 
                WHERE drvSSN = @drvEmpSSN and drvDepID = @drvDepID

                --if number doesn't exist get next number for child and update table
                IF @DepNum = '' OR @DepNum IS NULL
                BEGIN
                    SELECT @LastNumUsed = 1
                    SELECT @LastNumUsed = MAX(drvPersonCode) FROM dbo.u_EUHCLFLSTD_DepNum WHERE drvSSN = @drvEmpSSN AND @drvRelation <> 'SP'
                    IF @LastNumUsed IS NULL SELECT @LastNumUsed = 1
                    SELECT @DepNum = @LastNumUsed + 1
                    INSERT INTO dbo.u_EUHCLFLSTD_DepNum (drvSSN,drvDepID,drvPersonCode) VALUES(@drvEmpSSN,@drvDepID,@DepNum)
                END

                --update driver table
                IF @DepNum <> '' and @DepNum IS NOT NULL
                    UPDATE u_EUHCLFLSTD_drvTbl set drvRelationShip = RIGHT('00' + CONVERT(VARCHAR(2),@DepNum), 2) WHERE drvSSN = @drvEmpSSN AND drvDepID = @drvDepID
            END

    NextDep:
      FETCH NEXT FROM empcursor 
      INTO  @drvEmpSSN, @drvDepID, @drvRelation
    END 
    CLOSE empcursor
    DEALLOCATE empcursor

    --select * from u_EUHCLFLSTD_drvTbl
    update dbo.u_EUHCLFLSTD_drvTbl
    set drvrelationship= case when drvrelation = 'SP' and drvrelationship not in ('01','90','91','92','93','94','95','96','97','98','99') 
    then '01'
    else drvrelationship
    end
    from dbo.u_EUHCLFLSTD_drvTbl
    where  drvrelation = 'SP' and drvrelationship not in ('01','90','91','92','93','94','95','96','97','98','99') 

    update dbo.u_EUHCLFLSTD_drvTbl
    set drvrelation= case when drvrelation = 'OT' then 'CH'
    else drvrelation
    end
    from dbo.u_EUHCLFLSTD_drvTbl
    where  drvrelation = 'OT'
    
    --select * from u_EUHCLFLSTD_drvTbl where drvrelationship >='90'
    update dbo.u_EUHCLFLSTD_drvTbl
    set drvrelation= case when drvrelation = 'SP' and drvrelationship in ('91','92','93','94','95','96','97','98','99') 
    then 'CH'
    else drvrelation
    end
    from dbo.u_EUHCLFLSTD_drvTbl
    where  drvrelation = 'SP' and drvrelationship in ('91','92','93','94','95','96','97','98','99') 

    --now update drvrelationships for children codes still in the 90's:
    update dbo.u_EUHCLFLSTD_drvTbl
    set drvrelationship= case when drvrelation = 'CH' and drvrelationship in ('91') then '02'
    when drvrelation = 'CH' and drvrelationship in ('92') then '03'
    when drvrelation = 'CH' and drvrelationship in ('93') then '04'
    when drvrelation = 'CH' and drvrelationship in ('94') then '05'
    when drvrelation = 'CH' and drvrelationship in ('95') then '06'
    when drvrelation = 'CH' and drvrelationship in ('96') then '07'
    when drvrelation = 'CH' and drvrelationship in ('97') then '08'
    when drvrelation = 'CH' and drvrelationship in ('98') then '09'
    when drvrelation = 'CH' and drvrelationship in ('99') then '10'
    else drvrelation
    end
    from dbo.u_EUHCLFLSTD_drvTbl
    where  drvrelation = 'CH' and drvrelationship in ('91','92','93','94','95','96','97','98','99') 


    
--correct for LIFSP:
update dbo.U_EUHCLFLSTD_drvTbl
set drvplan = CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) 
from  dbo.U_EUHCLFLSTD_drvTbl
join dbo.u_dsi_bdm_empdeductions on eedeeid = drveeid and eedcoid = drvcoid 
and eeddedcode = 'LIFSP' 
where drvdedcode = 'LE000191' 
and eedvalidforexport = 'Y'
and drvplan <> CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT))  
and CONVERT(VARCHAR(20),CAST(EedBenAmt AS INT)) <> 0

--update to clear out job eff date if no sal type or ann sal:
update dbo.U_EUHCLFLSTD_drvTbl
set drvjobeffdate = case when drvsalarytype IS NULL then NULL else drvjobeffdate end

    ------------------
    -- TRAILER RECORD
    ------------------
    IF OBJECT_ID('U_EUHCLFLSTD_Trailer') IS NOT NULL
        DROP TABLE dbo.U_EUHCLFLSTD_Trailer;
    SELECT DISTINCT
        drvRunDt = REPLACE(CONVERT(VARCHAR(10),GETDATE(), 101), '/', '')
        ,drvCount = (SELECT COUNT(*) + 2 FROM dbo.U_EUHCLFLSTD_drvTbl)
    INTO dbo.U_EUHCLFLSTD_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EUHCLFLSTD','UseFileName') = 'N')
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'OHVA_UHC_729805_' + CONVERT(char(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EUHCLFLSTD';

END

/*

--Alter the View
ALTER VIEW dbo.dsi_vwEUHCLFLSTD_Export as
    SELECT TOP 20000000 Data FROM dbo.U_EUHCLFLSTD_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SUBSTRING(Data, 10, 2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCLFLSTD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201509181'
       ,ExpStartPerControl     = '201509181'
       ,ExpLastEndPerControl   = '201509259'
       ,ExpEndPerControl       = '201509259'
WHERE ExpFormatCode = 'EUHCLFLSTD';

*/
GO
CREATE VIEW dbo.dsi_vwEUHCLFLSTD_Export as
    SELECT TOP 20000000 Data FROM dbo.U_EUHCLFLSTD_File (NOLOCK)
    ORDER BY SUBSTRING(RecordSet,2,2), InitialSort, SUBSTRING(Data, 10, 2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUHCLFLSTD' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUHCLFLSTD'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUHCLFLSTD'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCLFLSTD', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUHCLFLSTD', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCLFLSTD', 'UseFileName', 'V', 'Y'


-- End ripout