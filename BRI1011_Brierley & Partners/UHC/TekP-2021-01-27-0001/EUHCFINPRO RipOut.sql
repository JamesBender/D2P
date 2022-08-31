/**********************************************************************************

EUHCFINPRO: United Health Care Financial Protection

FormatCode:     EUHCFINPRO
Project:        United Health Care Financial Protection
Client ID:      BRI1011
Date/time:      2022-08-29 05:34:57.707
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP4DB03
Database:       ULTIPRO_WPBPART
Web Filename:   BRI1011_35EEE_EEHISTORY_EUHCFINPRO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUHCFINPRO_SavePath') IS NOT NULL DROP TABLE dbo.U_EUHCFINPRO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUHCFINPRO'


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
WHERE FormatCode = 'EUHCFINPRO'
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
WHERE ExpFormatCode = 'EUHCFINPRO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUHCFINPRO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUHCFINPRO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUHCFINPRO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUHCFINPRO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUHCFINPRO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUHCFINPRO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUHCFINPRO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUHCFINPRO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUHCFINPRO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUHCFINPRO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUHCFINPRO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCFINPRO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCFINPRO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFINPRO];
GO
IF OBJECT_ID('U_EUHCFINPRO_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Trailer];
GO
IF OBJECT_ID('U_EUHCFINPRO_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_PDedHist];
GO
IF OBJECT_ID('U_EUHCFINPRO_Header') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Header];
GO
IF OBJECT_ID('U_EUHCFINPRO_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_File];
GO
IF OBJECT_ID('U_EUHCFINPRO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_EEList];
GO
IF OBJECT_ID('U_EUHCFINPRO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_drvTbl];
GO
IF OBJECT_ID('U_EUHCFINPRO_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_DedList];
GO
IF OBJECT_ID('U_EUHCFINPRO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_AuditFields];
GO
IF OBJECT_ID('U_EUHCFINPRO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EUHCFINPRO','United Health Care Financial Protection','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','495','S','N','EUHCFINPROZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFINPROZ0','48','H','01','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFINPROZ0','13','H','01','49',NULL,'Record Type',NULL,NULL,'"HEADER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFINPROZ0','1','H','01','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFINPROZ0','8','H','01','63',NULL,'Client Job Number',NULL,NULL,'"TBD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFINPROZ0','1','H','01','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFINPROZ0','8','H','01','72',NULL,'File Creation Date',NULL,NULL,'"drvDateCreated"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFINPROZ0','355','H','01','80',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFINPROZ0','9','D','10','1',NULL,'Subscriber ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFINPROZ0','2','D','10','10',NULL,'Member Indicator',NULL,NULL,'"drvMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFINPROZ0','35','D','10','12',NULL,'Member Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFINPROZ0','15','D','10','47',NULL,'Member First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFINPROZ0','2','D','10','62',NULL,'Member Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFINPROZ0','1','D','10','64',NULL,'Member Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFINPROZ0','40','D','10','65',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUHCFINPROZ0','40','D','10','105',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUHCFINPROZ0','19','D','10','145',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUHCFINPROZ0','2','D','10','164',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUHCFINPROZ0','5','D','10','166',NULL,'Zip',NULL,NULL,'"drvAddressZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUHCFINPROZ0','4','D','10','171',NULL,'Zip Suffix',NULL,NULL,'"drvAddressZipSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUHCFINPROZ0','12','D','10','175',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUHCFINPROZ0','12','D','10','187',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUHCFINPROZ0','1','D','10','199',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUHCFINPROZ0','8','D','10','200',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUHCFINPROZ0','30','D','10','208',NULL,'Group Policy Number',NULL,NULL,'"0909812"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUHCFINPROZ0','30','D','10','238',NULL,'Subgrp Policy Number',NULL,NULL,'"2001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUHCFINPROZ0','8','D','10','268',NULL,'Emp Sub-Grp Eff Date',NULL,NULL,'"drvBenStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUHCFINPROZ0','10','D','10','276',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUHCFINPROZ0','8','D','10','286',NULL,'Plan Code Eff Date',NULL,NULL,'"drvBenStartDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUHCFINPROZ0','2','D','10','294',NULL,'Tier Code',NULL,NULL,'"drvTierCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUHCFINPROZ0','8','D','10','296',NULL,'Member Original Eff Date',NULL,NULL,'"drvMemberOrigEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUHCFINPROZ0','8','D','10','304',NULL,'Term Date',NULL,NULL,'"drvDateOfTermination"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUHCFINPROZ0','9','D','10','312',NULL,'ALT-ID',NULL,NULL,'"drvAlternateID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUHCFINPROZ0','1','D','10','321',NULL,'Student Status',NULL,NULL,'"drvStudentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUHCFINPROZ0','1','D','10','322',NULL,'Handicapped',NULL,NULL,'"drvHandicapped"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUHCFINPROZ0','3','D','10','323',NULL,'Written Preference Language',NULL,NULL,'"drvLanguageWritten"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUHCFINPROZ0','8','D','10','326',NULL,'Written Preference Effective Date',NULL,NULL,'"drvLanguageWrittenEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUHCFINPROZ0','3','D','10','334',NULL,'Spoken Preference Language',NULL,NULL,'"drvLanguageSpoken"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUHCFINPROZ0','8','D','10','337',NULL,'Spoken Preference Effective Date',NULL,NULL,'"drvLanguageSpokenEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUHCFINPROZ0','1','D','10','345',NULL,'CALAP Eligibility Indicator',NULL,NULL,'"drvIndicatorCALAP"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUHCFINPROZ0','8','D','10','346',NULL,'Hire Date',NULL,NULL,'"drvDateOfOriginalHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUHCFINPROZ0','4','D','10','354',NULL,'Subscriber Class Id',NULL,NULL,'"drvSubscriberClassID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUHCFINPROZ0','8','D','10','358',NULL,'Subscriber Class Effective date',NULL,NULL,'"drvSubClassEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUHCFINPROZ0','1','D','10','366',NULL,'Salary Type',NULL,NULL,'"drvSalaryType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUHCFINPROZ0','10','D','10','367',NULL,'Salary Amount',NULL,NULL,'"drvAnnSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUHCFINPROZ0','8','D','10','377',NULL,'Salary Effective date',NULL,NULL,'"drvSalaryEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUHCFINPROZ0','10','D','10','385',NULL,'Plan Coverage Amount',NULL,NULL,'"drvCoverageAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUHCFINPROZ0','8','D','10','395',NULL,'Plan Coverage Amount Effective Date',NULL,NULL,'"drvCoverageAmountEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUHCFINPROZ0','8','D','10','403',NULL,'Student Status Effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUHCFINPROZ0','8','D','10','411',NULL,'Student Status Term date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUHCFINPROZ0','8','D','10','419',NULL,'Handicap Effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUHCFINPROZ0','8','D','10','427',NULL,'Handicap Term date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUHCFINPROZ0','11','D','10','435',NULL,'ALT Member Indicator',NULL,NULL,'"drvALTMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUHCFINPROZ0','49','D','10','446',NULL,'Email Address',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUHCFINPROZ0','48','T','90','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUHCFINPROZ0','14','T','90','49',NULL,'Record Type',NULL,NULL,'"TRAILER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUHCFINPROZ0','1','T','90','63',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUHCFINPROZ0','8','T','90','64',NULL,'Client Job Number',NULL,NULL,'"drvClientJobNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUHCFINPROZ0','1','T','90','72',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUHCFINPROZ0','9','T','90','73',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUHCFINPROZ0','353','T','90','82',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUHCFINPRO_20220829.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202206309','EMPEXPORT','OEACTIVE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202206309','May  3 2021  1:27PM','May  3 2021  1:27PM','202206301',NULL,'','','202206301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202206309','EMPEXPORT','OEPASSIVE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202206309','May  3 2021  1:27PM','May  3 2021  1:27PM','202206301',NULL,'','','202206301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Financial Protection','202206309','EMPEXPORT','ONDEM_XOE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202206309','May  3 2021  1:27PM','May  3 2021  1:27PM','202206301',NULL,'','','202206301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Financial Protection-Sched','202206309','EMPEXPORT','SCH_EUHCFI',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202206309','May  3 2021  1:27PM','May  3 2021  1:27PM','202206301',NULL,'','','202206301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',HWJHQ',NULL,NULL,NULL,'UHC Financial Protection-Test','202206309','EMPEXPORT','TEST_XOE','Jul  5 2022 12:00AM','EUHCFINPRO',NULL,NULL,NULL,'202206309','Jun 30 2022 12:00AM','Dec 30 1899 12:00AM','202206301','682','','','202206301',dbo.fn_GetTimedKey(),NULL,'us3cBeBRI1011',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','H01','dbo.U_EUHCFINPRO_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','D10','dbo.U_EUHCFINPRO_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','T90','dbo.U_EUHCFINPRO_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EUHCFINPRO_Audit
-----------

IF OBJECT_ID('U_EUHCFINPRO_Audit') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audDateTime] datetime NULL
);

-----------
-- Create table U_EUHCFINPRO_AuditFields
-----------

IF OBJECT_ID('U_EUHCFINPRO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EUHCFINPRO_DedList
-----------

IF OBJECT_ID('U_EUHCFINPRO_DedList') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUHCFINPRO_drvTbl
-----------

IF OBJECT_ID('U_EUHCFINPRO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvDedGroupCode] varchar(5) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] char(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvMemberIndicator] varchar(2) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvRelationship] varchar(2) NOT NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvAddressZipSuffix] varchar(1) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvBenStartDate] datetime NULL,
    [drvPlanCode] varchar(8) NULL,
    [drvTierCode] varchar(1) NULL,
    [drvMemberOrigEffDate] varchar(30) NOT NULL,
    [drvDateOfTermination] datetime NULL,
    [drvAlternateID] varchar(1) NOT NULL,
    [drvStudentStatus] varchar(1) NOT NULL,
    [drvHandicapped] varchar(1) NOT NULL,
    [drvLanguageWritten] char(2) NOT NULL,
    [drvLanguageWrittenEffDate] datetime NULL,
    [drvLanguageSpoken] char(2) NOT NULL,
    [drvLanguageSpokenEffDate] datetime NULL,
    [drvIndicatorCALAP] varchar(1) NOT NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvSubscriberClassID] varchar(4) NULL,
    [drvSubClassEffDate] datetime NULL,
    [drvSalaryType] varchar(1) NOT NULL,
    [drvAnnSalary] nvarchar(4000) NULL,
    [drvSalaryEffDate] varchar(30) NULL,
    [drvCoverageAmount] nvarchar(4000) NULL,
    [drvCoverageAmountEffDate] datetime NULL,
    [drvALTMemberIndicator] varchar(11) NOT NULL,
    [drvDedCode] char(5) NOT NULL
);

-----------
-- Create table U_EUHCFINPRO_EEList
-----------

IF OBJECT_ID('U_EUHCFINPRO_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUHCFINPRO_File
-----------

IF OBJECT_ID('U_EUHCFINPRO_File') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(495) NULL
);

-----------
-- Create table U_EUHCFINPRO_Header
-----------

IF OBJECT_ID('U_EUHCFINPRO_Header') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Header] (
    [drvDateCreated] date NULL
);

-----------
-- Create table U_EUHCFINPRO_PDedHist
-----------

IF OBJECT_ID('U_EUHCFINPRO_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [STDER_DedCalcBasisAmt] numeric NULL,
    [LTDEX_DedCalcBasisAmt] numeric NULL,
    [LTD_DedCalcBasisAmt] numeric NULL
);

-----------
-- Create table U_EUHCFINPRO_Trailer
-----------

IF OBJECT_ID('U_EUHCFINPRO_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Trailer] (
    [drvClientJobNumber] varchar(1) NOT NULL,
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFINPRO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Brierley & Partners

Created By: Keary McCutchen
Business Analyst: Richard Vars
Create Date: 05/03/2021
Service Request Number: SR-2020-00300150

Purpose: United Health Care Financial Protection

Revision History
----------------
09/29/2021 by AP:
        - Adjusted amounts calculation as per Richard Vars spec update.

10/07/2021 by AP:
        - Adjusted plan coverage amount logic and salary amount logic.

12/06/2021 by AP:
        - Adjusted salary effective date to clean up missing values.
        - Added DbnBenStartDate to member original effective date to the dependent record.
        - Salary type logic updated.
        - Salary amount logic updated.

12/16/2021 by AP:
        - Added STDER, LTD and LTDEX to the Salary Type field.
        - Salary Type, Salary Amount and Salary Effective Date updated for dependents.
        - Updated where values are >= logic for Plan Coverage Amount.
        - Updated Plan Coverage Amount logic for LIFEE, LIFES, CIE20 and CIS10.

01/13/2022 by AP:
    - Fixed added 0's to coverage amount.
    - Updated dependent section to show dependents with EE records associated to them.

02/03/2022 by AP:
    - Updated date fields minimum date.
    - Updated logic for DT23 field.

02/16/2022 by AP:
    - Removed plan codes that only apply to EE from dependent dataset.

03/01/2022 by AP:
    - Added ded code to filter children and spouse properly on secondary loads.
    - Updated DT23 Member Original Eff Date with new deduction codes.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCFINPRO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCFINPRO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'SCH_EUHCFI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCFINPRO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUHCFINPRO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUHCFINPRO';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('02/01/2022' AS DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCFINPRO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCFINPRO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE List of Employees Where EecEmpType = TES
    DELETE EEList
    FROM dbo.U_EUHCFINPRO_EEList EEList
    INNER 
     JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCoID = xCoID
     AND EecEEType = 'TES';

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUHCFINPRO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_AuditFields;
    CREATE TABLE dbo.U_EUHCFINPRO_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('Contacts','ConIsStudent');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpComp','EecLanguageCode');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpPers','EepIsDisabled');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUHCFINPRO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Audit;
    SELECT 
         audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        --,audAction
        ,audDateTime = MAX(audDateTime)
        --,audOldValue
        --,audNewValue
        --,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EUHCFINPRO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUHCFINPRO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
        AND audAction <> 'Delete'
    WHERE audDateTime <= @EndDate
    GROUP BY audKey1Value
            ,audKey2Value
            ,audKey3Value
            ,audTableName
            ,audFieldName
    ;
    -- Create Index

    CREATE CLUSTERED INDEX CDX_U_EUHCFINPRO_Audit ON dbo.U_EUHCFINPRO_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTLEX,ADDCX,CIE20,CIS10,CIS5,ACC,HSPL,HSPH,STDER,LTDEX,GTLEE,ADDCE,LIFEE,LIFES,LIFEC,CIE20,CIS5,ACCL,LTD,CIC2,CIC5';

    IF OBJECT_ID('U_EUHCFINPRO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUHCFINPRO_DedList
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



    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUHCFINPRO_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        --,Max(PdhDedCalcBasisAmt) as PdhDedCalcBasisAmt
        ,STDER_DedCalcBasisAmt = SUM(CASE WHEN PdhDedCode IN ('STDER') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,LTDEX_DedCalcBasisAmt = SUM(CASE WHEN PdhDedCode IN ('LTDEX') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,LTD_DedCalcBasisAmt = SUM(CASE WHEN PdhDedCode IN ('LTD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
     INTO dbo.U_EUHCFINPRO_PDedHist
    FROM dbo.U_EUHCFINPRO_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EUHCFINPRO_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_drvTbl
    -- Employee Data
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvDedGroupCode = RTRIM(LTRIM(EecDedGroupCode))
        ,drvSort = xEEID
        ,drvSubSort = '00'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvMemberIndicator = '  '
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelationship = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvAddressZipSuffix = ''
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate)
        ,drvPlanCode = CASE
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'GTLEX' THEN 'LE000886'
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'ADDCX' THEN 'LE000887'
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 7500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 10000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL)  AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'STDER' THEN 'LE000379'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) IN ('LTDEX') THEN 'LE000770'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) IN ('LTD') THEN 'LE000016'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'GTLEE' THEN 'LE001502'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'ADDCE' THEN 'LE001503'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 7500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 10000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'STDER' THEN 'LE000379'
                        END
        ,drvTierCode = CASE
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EEF' THEN 'A'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EES' THEN 'B'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EE' THEN 'C'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('GTLEX','ADDCX','LIFEE','CIE20','STDER','LTDEX','LTD','GTLEE','ADDCE') THEN 'C'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EEC' THEN 'D'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('LIFES','CIS10') THEN 'F'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('LIFEC','CIS5') THEN 'G'
                        END
        ,drvMemberOrigEffDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode IN ('GTLEX', 'ADDCX', 'CIE20', 'CIS10', 'CIS5',
                                            'ACC', 'HSPL', 'HSPH', 'STDER', 'LTDEX', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'LIFEC', 'LTD', 'ACCL','CIC2','CIC5') THEN
                                    dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) END), 112), '')
        --dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, @FileMinCovDate) 
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAlternateID = ''
        ,drvStudentStatus = ''
        ,drvHandicapped = '' --CASE WHEN EepIsDisabled = 'Y' THEN 'P' END
        ,drvLanguageWritten =  EecLanguageCode
        ,drvLanguageWrittenEffDate = (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecLanguageCode')
        ,drvLanguageSpoken = EecLanguageCode
        ,drvLanguageSpokenEffDate = (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecLanguageCode')
        ,drvIndicatorCALAP = ''
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvSubscriberClassID = CASE WHEN EecDedGroupCode = 'EXEC' THEN '2001'
                                     WHEN EecDedGroupCode IN ('FT','PT') THEN '2002'
                                 END
        ,drvSubClassEffDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate,@FileMinCovDate) 
        ,drvSalaryType = CASE WHEN EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'CIE20', 'CIS10', 'STDER', 'LTD', 'LTDEX') AND EecDedGroupCode IN ('EXEC', 'FT') THEN 'A' ELSE '' END
        --CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN 'A' END 
        -- DT37
        ,drvAnnSalary = FORMAT(EecAnnSalary + EecUDField20, '#0.00')
                        /*ISNULL(
                                CASE WHEN EedDedCode IN ('STDER', 'LTDEX', 'LTD') THEN CAST(CAST(ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '') AS DECIMAL(10,2)) AS VARCHAR)
                                WHEN EecDedGroupCode = 'EXEC' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, 00) AS DECIMAL(10,2)) AS VARCHAR)
                                WHEN EecDedGroupCode = 'FT' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, 00) AS DECIMAL(10,2)) AS VARCHAR)
                                WHEN EedDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(CAST(DedEEBenAmt AS DECIMAL(10,2)) AS VARCHAR) 
                                END, '') */
        --CONVERT(VARCHAR(10), CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN EecAnnSalary END)
        ,drvSalaryEffDate = CONVERT(VARCHAR, dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate,@FileMinCovDate), 112)
        --CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN  dbo.dsi_fnGetMinMaxDates('MAX', (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecAnnSalary') , @FileMinCovDate) END 
        -- DT39
        ,drvCoverageAmount = FORMAT(
                                CASE WHEN EedDedCode IN ('GTLEX','ADDCX') AND EecDedGroupCode = 'EXEC' THEN
                                    CASE WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 <= 65 THEN
                                        CASE WHEN EecAnnSalary + EecUDField20 > 500000 THEN 500000 ELSE EecAnnSalary + EecUDField20 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 65 AND 69 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.65 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.65 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 70 AND 74 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.40 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.40 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 >= 75 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.25 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.25 END                                        
                                    END                                    
                                WHEN EedDedCode IN ('GTLEE','ADDCE') AND EecDedGroupCode = 'FT' THEN
                                    CASE WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 <= 65 THEN
                                        CASE WHEN EecAnnSalary + EecUDField20 > 500000 THEN 500000 ELSE EecAnnSalary + EecUDField20 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 65 AND 69 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.65 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.65 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 70 AND 74 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.40 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.40 END
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 >= 75 THEN
                                        CASE WHEN (EecAnnSalary + EecUDField20)*.25 > 500000 THEN 500000 ELSE (EecAnnSalary + EecUDField20)*.25 END                                        
                                    END        
                                WHEN EedDedCode IN ('LIFEC','CIE20','CIS10','CIC5') THEN EedBenAmt
                                WHEN EedDedCode IN ('LIFEE','LIFES') THEN
                                    CASE WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 65 AND 69 THEN EedBenAmt*.65
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 BETWEEN 70 AND 74 THEN EedBenAmt*.40
                                    WHEN DATEDIFF(HOUR ,EepDateOfBirth, GETDATE())/8766 >= 75 THEN EedBenAmt*.25
                                    END
                                END, '#0.000')
                                /*LEFT(REPLACE(
                                            CASE WHEN EedDedCode = 'STDER' AND STDER_DedCalcBasisAmt/52 > 1500 THEN '1500'
                                            WHEN EedDedCode = 'STDER' AND STDER_DedCalcBasisAmt/52 <= 1500 THEN FORMAT(FLOOR(STDER_DedCalcBasisAmt/52), '#0.00')

                                            WHEN EedDedCode = 'LTDEX' AND LTDEX_DedCalcBasisAmt/12 > 13000 THEN '13000'
                                            WHEN EedDedCode = 'LTDEX' AND LTDEX_DedCalcBasisAmt/12 <= 13000 THEN FORMAT(FLOOR(LTDEX_DedCalcBasisAmt/12), '#0.00')

                                            WHEN EedDedCode = 'LTD' AND LTD_DedCalcBasisAmt/52 > 10000 THEN '10000'
                                            WHEN EedDedCode = 'LTD' AND LTD_DedCalcBasisAmt/52 <= 10000 THEN FORMAT(FLOOR(LTD_DedCalcBasisAmt/52), '#0.00')


                                            WHEN EecDedGroupCode = 'EXEC' THEN
                                                CASE WHEN EedDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 > '500000.000' THEN '500000'
                                                WHEN EedDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 <= '500000.000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, '.00', '')
                                                WHEN EedDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(EedBenAmt, '.00', '')
                                                    --WHEN EedDedCode IN ('STDER', 'LTDEX', 'LTD') THEN REPLACE(PdhDedCalcBasisAmt, '.00', '')
                                                    --DedEEBenAmt
                                                END
                                            WHEN EecDedGroupCode = 'FT' THEN
                                                CASE WHEN EedDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 > '400000.000' THEN '400000'
                                                WHEN EedDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 <= '400000.000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, '.00', '')
                                                WHEN EedDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(EedBenAmt, '.00', '')
                                                    --WHEN EedDedCode IN ('STDER', 'LTDEX', 'LTD') THEN REPLACE(PdhDedCalcBasisAmt, '.00', '')
                                                    --DedEEBenAmt
                                                END
                                            END , '.00', ''), 6)*/
        --LEFT(REPLACE(CASE WHEN EecDedGroupCode = 'EXEC' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 > EedBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 2, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'EXEC' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 < EedBenAmt THEN CAST(ROUND(EedBenAmt, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5 > EedBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND EedDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20,'0')) * 1.5 < EedBenAmt THEN CAST(ROUND(EedBenAmt, -3) AS VARCHAR)
  --                                  WHEN EedDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(ROUND(EedBenAmt, -3) AS VARCHAR) END, '.00', ''), 6)
         --CASE WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'EXEC' THEN CAST((EecAnnSalary + EecUDField20) * 2 AS VARCHAR)
   --                             WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'FT' THEN CAST((EecAnnSalary + EecUDField20) * 1.5 AS VARCHAR) END
        --CASE WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') THEN EedBenAmt END
        ,drvCoverageAmountEffDate = CASE WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE', 'HSPH', 'STDER', 'LIFEC', 'LTDEX', 'HSPL', 'ACCL', 'ACC','LTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate,@FileMinCovDate) END
        ,drvALTMemberIndicator = '00000      '
        ,drvDedCode = EedDedCode -- Use for dependent table load
    INTO dbo.U_EUHCFINPRO_drvTbl
    FROM dbo.U_EUHCFINPRO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.PDedHist WITH (NOLOCK)
 --       ON pdhEEID = xEEID
    LEFT JOIN dbo.U_EUHCFINPRO_PDedHist WITH (NOLOCK)
        ON xEEID = PdhEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
        AND EedBenStatus = 'A'
    ;
      ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_drvTbl
    -- Dependents Data -- SPOUSE
    ---------------------------------
    INSERT INTO dbo.U_EUHCFINPRO_drvTbl
    SELECT DISTINCT
         drvEEID
        ,drvCoID
        ,drvDepRecID = CONVERT(varchar(12),DbnDepRecID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvDedGroupCode
        ,drvSort = drvEEID
        ,drvSubSort = '01'
        -- standard fields above and additional driver fields below
        ,drvSSN 
        ,drvMemberIndicator = '  '/*CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN '01'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN '99'
                              END*/
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelationship = CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN 'SP'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN 'CH'
                              END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZip = ConAddressZipCode
        ,drvAddressZipSuffix = ''
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate,@FileMinCovDate)
        ,drvPlanCode
        --CASE
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'GTLEX' THEN 'LE000886'
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'ADDCX' THEN 'LE000887'
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL)  AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LTDEX' THEN 'LE000770'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'GTLEE' THEN 'LE001502'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'ADDCE' THEN 'LE001503'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LTD' THEN 'LE000016'
  --                      END
        ,drvTierCode = CASE
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEF' THEN 'A'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EES' THEN 'B'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EE' THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('GTLEX','ADDCX','LIFEE','CIE20','STDER','LTDEX','LTD','GTLEE','ADDCE') THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEC' THEN 'D'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFES','CIS10') THEN 'F'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFEC','CIS5') THEN 'G'
                        END
        ,drvMemberOrigEffDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN DbnDedCode IN ('STDER', 'LTDEX', 'LTD', 'GTLEX',
                                                    'ADDCX', 'CIE20', 'CIS10', 'CIS5', 'ACC', 'HSPL',
                                                    'HSPH', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'LIFEC', 'ACCL','CIC2','CIC5') THEN
                                        dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate) END), 112), '')
        ,drvDateOfTermination 
        ,drvAlternateID 
        ,drvStudentStatus
        ,drvHandicapped = ''  --CASE WHEN ConIsDisabled = 'Y' THEN 'P' END
        ,drvLanguageWritten 
        ,drvLanguageWrittenEffDate
        ,drvLanguageSpoken 
        ,drvLanguageSpokenEffDate
        ,drvIndicatorCALAP 
        ,drvDateOfOriginalHire
        ,drvSubscriberClassID 
        ,drvSubClassEffDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate)
        ,drvSalaryType 
        --= CASE WHEN DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'CIE20', 'CIS10', 'STDER', 'LTD', 'LTDEX') AND EecDedGroupCode IN ('EXEC', 'FT') THEN 'A' ELSE '' END
        ,drvAnnSalary
        --ISNULL(CASE WHEN DbnDedCode IN ('STDER', 'LTDEX', 'LTD') THEN CAST(CAST(ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '') AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, 0) AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, 0) AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(CAST(DedEEBenAmt AS DECIMAL(10,2)) AS VARCHAR) END, '')
        ,drvSalaryEffDate
        ,drvCoverageAmount
        --LEFT(REPLACE(CASE WHEN EecDedGroupCode = 'EXEC' THEN
  --                                          CASE WHEN DbnDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 > '5000.00000' THEN '5000'
  --                                                  WHEN DbnDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 <= '5000.00000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, '.00', '')
  --                                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(DedEEBenAmt, '.00', '')
  --                                                  --DedEEBenAmt
  --                                      END
  --                                          WHEN EecDedGroupCode = 'FT' THEN
  --                                              CASE WHEN DbnDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 > '4000.00000' THEN '4000'
  --                                                  WHEN DbnDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 <= '4000.00000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, '.00', '')
  --                                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(DedEEBenAmt, '.00', '')
  --                                                  --DedEEBenAmt
  --                                      END
  --                                  END, '.00', ''), 6)
        --LEFT(REPLACE(CASE WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 > DedEEBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 2, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 < DedEEBenAmt THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5 > DedEEBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20,'0')) * 1.5 < DedEEBenAmt THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR)
  --                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR) END, '.00', ''), 6)
        --CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'EXEC' THEN CAST((EecAnnSalary + EecUDField20) * 2 AS VARCHAR)
  --                              WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'FT' THEN CAST((EecAnnSalary + EecUDField20) * 1.5 AS VARCHAR) END
        --CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') THEN DedEEBenAmt END
        ,drvCoverageAmountEffDate = CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE','HSPH','STDER','LIFEC','LTDEX','HSPL','ACCL','ACC','LTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate) END
        ,drvALTMemberIndicator = RTRIM(LTRIM(ConSSN))+'00'
        ,drvDedCode
    FROM dbo.U_EUHCFINPRO_drvTbl
    JOIN dbo.Contacts WITH (NOLOCK)
        On ConEEID = drvEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = drvEEID 
        AND DbnCoID = drvCoID
        AND DbnDepRecID = ConSystemID
        AND drvDedCode = DbnDedCode
        AND DbnFormatCode = 'EUHCFINPRO'--@FormatCode 
        AND DbnValidForExport = 'Y'
        AND DbnBenStatus = 'A'
        AND DbnRelationship IN ('SP', 'DP')
    --JOIN dbo.EmpComp WITH(NOLOCK) 
    --    ON EecEEID = DbnEEID
    --    AND EecCOID = DbnCOID
    WHERE DrvAnnSalary IS NOT NULL
    AND drvPlanCode NOT IN ('LE000886', 'LE000887', 'LE000019', 'LE000137', 'LE002232', 'LE002236', 'LE001924',
                                'LE001928', 'LE000379', 'LE000770', 'LE001502', 'LE001503', 'LE000019', 'LE000137', 'LE002232',
                                'LE002236', 'LE001924', 'LE001928', 'LE000379', 'LE000016') -- EE ONLY PLAN CODES
--    AND 

    -- CHILD LOAD
     INSERT INTO dbo.U_EUHCFINPRO_drvTbl
    SELECT DISTINCT
         drvEEID
        ,drvCoID
        ,drvDepRecID = CONVERT(varchar(12),DbnDepRecID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvDedGroupCode
        ,drvSort = drvEEID
        ,drvSubSort = '01'
        -- standard fields above and additional driver fields below
        ,drvSSN 
        ,drvMemberIndicator = '  '/*CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN '01'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN '99'
                              END*/
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelationship = CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN 'SP'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN 'CH'
                              END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZip = ConAddressZipCode
        ,drvAddressZipSuffix = ''
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate,@FileMinCovDate)
        ,drvPlanCode
        --CASE
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'GTLEX' THEN 'LE000886'
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'ADDCX' THEN 'LE000887'
  --                          WHEN RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
  --                          WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL)  AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
  --                          WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
  --                          WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LTDEX' THEN 'LE000770'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'GTLEE' THEN 'LE001502'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'ADDCE' THEN 'LE001503'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
  --                          WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LTD' THEN 'LE000016'
  --                      END
        ,drvTierCode = CASE
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEF' THEN 'A'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EES' THEN 'B'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EE' THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('GTLEX','ADDCX','LIFEE','CIE20','STDER','LTDEX','LTD','GTLEE','ADDCE') THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEC' THEN 'D'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFES','CIS10') THEN 'F'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFEC','CIS5') THEN 'G'
                        END
        ,drvMemberOrigEffDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN DbnDedCode IN ('STDER', 'LTDEX', 'LTD', 'GTLEX',
                                                    'ADDCX', 'CIE20', 'CIS10', 'CIS5', 'ACC', 'HSPL',
                                                    'HSPH', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'LIFEC', 'ACCL','CIC2','CIC5') THEN
                                        dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate) END), 112), '')
        ,drvDateOfTermination 
        ,drvAlternateID 
        ,drvStudentStatus
        ,drvHandicapped = '' --CASE WHEN ConIsDisabled = 'Y' THEN 'P' END
        ,drvLanguageWritten 
        ,drvLanguageWrittenEffDate
        ,drvLanguageSpoken 
        ,drvLanguageSpokenEffDate
        ,drvIndicatorCALAP 
        ,drvDateOfOriginalHire
        ,drvSubscriberClassID 
        ,drvSubClassEffDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate)
        ,drvSalaryType 
        --= CASE WHEN DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE', 'LIFEE', 'LIFES', 'CIE20', 'CIS10', 'STDER', 'LTD', 'LTDEX') AND EecDedGroupCode IN ('EXEC', 'FT') THEN 'A' ELSE '' END
        ,drvAnnSalary
        --ISNULL(CASE WHEN DbnDedCode IN ('STDER', 'LTDEX', 'LTD') THEN CAST(CAST(ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '') AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, 0) AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') THEN CAST(CAST(ROUND((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, 0) AS DECIMAL(10,2)) AS VARCHAR)
  --                          WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(CAST(DedEEBenAmt AS DECIMAL(10,2)) AS VARCHAR) END, '')
        ,drvSalaryEffDate
        ,drvCoverageAmount
        --LEFT(REPLACE(CASE WHEN EecDedGroupCode = 'EXEC' THEN
  --                                          CASE WHEN DbnDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 > '5000.00000' THEN '5000'
  --                                                  WHEN DbnDedCode IN ('GTLEX', 'ADDCX') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2 <= '5000.00000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 2, '.00', '')
  --                                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(DedEEBenAmt, '.00', '')
  --                                                  --DedEEBenAmt
  --                                      END
  --                                          WHEN EecDedGroupCode = 'FT' THEN
  --                                              CASE WHEN DbnDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 > '4000.00000' THEN '4000'
  --                                                  WHEN DbnDedCode IN ('GTLEE', 'ADDCE') AND (ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5 <= '4000.00000' THEN REPLACE((ISNULL(EecAnnSalary, '') + ISNULL(EecUDField20, '')) * 1.5, '.00', '')
  --                                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN REPLACE(DedEEBenAmt, '.00', '')
  --                                                  --DedEEBenAmt
  --                                      END
  --                                  END, '.00', ''), 6)
        --LEFT(REPLACE(CASE WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 > DedEEBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 2, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'EXEC' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 2 < DedEEBenAmt THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5 > DedEEBenAmt THEN CAST(ROUND((EecAnnSalary + ISNULL(EecUDField20, '0')) * 1.5, -3) AS VARCHAR)
  --                                  WHEN EecDedGroupCode = 'FT' AND DbnDedCode IN ('GTLEX', 'ADDCX', 'GTLEE', 'ADDCE') AND (EecAnnSalary + ISNULL(EecUDField20,'0')) * 1.5 < DedEEBenAmt THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR)
  --                                  WHEN DbnDedCode IN ('LIFEE', 'LIFES', 'CIE20', 'CIS10') THEN CAST(ROUND(DedEEBenAmt, -3) AS VARCHAR) END, '.00', ''), 6)
        --CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'EXEC' THEN CAST((EecAnnSalary + EecUDField20) * 2 AS VARCHAR)
  --                              WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') AND EecDedGroupCode = 'FT' THEN CAST((EecAnnSalary + EecUDField20) * 1.5 AS VARCHAR) END
        --CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') THEN DedEEBenAmt END
        ,drvCoverageAmountEffDate = CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE','HSPH','STDER','LIFEC','LTDEX','HSPL','ACCL','ACC','LTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, @FileMinCovDate) END
        ,drvALTMemberIndicator = RTRIM(LTRIM(ConSSN))+'00'
        ,drvDedCode
    FROM dbo.U_EUHCFINPRO_drvTbl
    JOIN dbo.Contacts WITH (NOLOCK)
        On ConEEID = drvEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = drvEEID 
        AND DbnCoID = drvCoID
        AND DbnDepRecID = ConSystemID
        AND drvDedCode = DbnDedCode
        AND DbnFormatCode = 'EUHCFINPRO'--@FormatCode 
        AND DbnValidForExport = 'Y'
        AND DbnBenStatus = 'A'
        AND DbnRelationship IN ('CHL', 'DPC', 'STC', 'CH')
    --JOIN dbo.EmpComp WITH(NOLOCK) 
    --    ON EecEEID = DbnEEID
    --    AND EecCOID = DbnCOID
    WHERE DrvAnnSalary IS NOT NULL
    AND drvPlanCode NOT IN ('LE000886', 'LE000887', 'LE000019', 'LE000137', 'LE002232', 'LE002236', 'LE001924',
                                'LE001928', 'LE000379', 'LE000770', 'LE001502', 'LE001503', 'LE000019', 'LE000137', 'LE002232',
                                'LE002236', 'LE001924', 'LE001928', 'LE000379', 'LE000016') -- EE ONLY PLAN CODES

    --UPDATE dbo.U_EUHCFINPRO_drvTbl
    --SET drvCoverageAmount = floor((drvCoverageAmount + 999) / 1000) * 1000
    
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_MemberID_drvTbl
    -- This calculates the Child's Member ID and Updates the Driver Tables
    ---------------------------------
    UPDATE dbo.U_EUHCFINPRO_drvTbl
            SET drvMemberIndicator = '  '--RIGHT('00' + CAST(tmpMemberIndicator AS VARCHAR(2)),2)
               ,drvSubSort = RIGHT('00' + CAST(tmpMemberIndicator AS VARCHAR(2)),2)
    FROM dbo.U_EUHCFINPRO_drvTbl
    INNER JOIN (SELECT tmpEEID = drvEEID
                      ,tmpDepRecID = drvDepRecID
                      ,tmpMemberIndicator = ROW_NUMBER() OVER (PARTITION BY DRVEEID ORDER BY drvDepRecID)  + 1
                  FROM dbo.U_EUHCFINPRO_drvTbl 
                  WHERE drvRelationship = 'CH' 
               GROUP BY drvEEID, drvDepRecID) TMP
            ON drvEEID = tmpEEID
           AND drvDepRecID = tmpDepRecID

    ---- UPDATE SALARY EFFECTIVE DATE = BLANK IF SALARY AMOUNT IS BLANK ----
    UPDATE dbo.U_EUHCFINPRO_drvTbl
    SET drvSalaryEffDate = ''
    WHERE drvAnnSalary = ''
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Header;
    SELECT DISTINCT
         drvDateCreated = CAST(getdate() AS DATE)
    INTO dbo.U_EUHCFINPRO_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Trailer;
    SELECT DISTINCT
         drvClientJobNumber = ''
        ,drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EUHCFINPRO_drvTbl WITH (NOLOCK))
    INTO dbo.U_EUHCFINPRO_Trailer
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
ALTER VIEW dbo.dsi_vwEUHCFINPRO_Export AS
    SELECT TOP 20000000 *, Data FROM dbo.U_EUHCFINPRO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefh
SELECT * FROM dbo.AscDefh where adhformatcode = 'EUHCFINPRO'

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCFINPRO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202206301'
       ,expStartPerControl     = '202206301'
       ,expLastEndPerControl   = '202206309'
       ,expEndPerControl       = '202206309'
WHERE expFormatCode = 'EUHCFINPRO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCFINPRO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUHCFINPRO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUHCFINPRO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUHCFINPRO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUHCFINPRO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCFINPRO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUHCFINPRO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUHCFINPRO', 'UseFileName', 'V', 'Y'


-- End ripout