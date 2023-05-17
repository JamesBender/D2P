/**********************************************************************************

ENPAUHCEXP: UHC STD LTD Life AD&D Export

FormatCode:     ENPAUHCEXP
Project:        UHC STD LTD Life AD&D Export
Client ID:      USG1000
Date/time:      2023-05-10 07:16:53.787
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ENPAUHCEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENPAUHCEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ENPAUHCEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENPAUHCEXP'


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
WHERE FormatCode = 'ENPAUHCEXP'
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
WHERE ExpFormatCode = 'ENPAUHCEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENPAUHCEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENPAUHCEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENPAUHCEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENPAUHCEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENPAUHCEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENPAUHCEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENPAUHCEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENPAUHCEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENPAUHCEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENPAUHCEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENPAUHCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENPAUHCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENPAUHCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENPAUHCEXP];
GO
IF OBJECT_ID('U_ENPAUHCEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_Trailer];
GO
IF OBJECT_ID('U_ENPAUHCEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_Header];
GO
IF OBJECT_ID('U_ENPAUHCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_File];
GO
IF OBJECT_ID('U_ENPAUHCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_EEList];
GO
IF OBJECT_ID('U_ENPAUHCEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_drvTbl];
GO
IF OBJECT_ID('U_ENPAUHCEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_DedList];
GO
IF OBJECT_ID('U_ENPAUHCEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_AuditFields];
GO
IF OBJECT_ID('U_ENPAUHCEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENPAUHCEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENPAUHCEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENPAUHCEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENPAUHCEXP','UHC STD LTD Life AD&D Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ENPAUHCEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENPAUHCEXPZ0','48','H','01','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENPAUHCEXPZ0','13','H','01','2',NULL,'Record Type',NULL,NULL,'"HEADER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENPAUHCEXPZ0','1','H','01','3',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENPAUHCEXPZ0','8','H','01','4',NULL,'Client Job Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENPAUHCEXPZ0','1','H','01','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENPAUHCEXPZ0','8','H','01','6',NULL,'File Creation Date',NULL,NULL,'"drvDatefilecreated"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENPAUHCEXPZ0','355','H','01','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENPAUHCEXPZ0','9','D','10','1',NULL,'Subscriber ID',NULL,NULL,'"drvSubscriberID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENPAUHCEXPZ0','2','D','10','2',NULL,'Member Indicator',NULL,NULL,'"drvMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENPAUHCEXPZ0','35','D','10','3',NULL,'Member Last Name',NULL,NULL,'"drvMembeLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENPAUHCEXPZ0','15','D','10','4',NULL,'Member First Name',NULL,NULL,'"drvMembeFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENPAUHCEXPZ0','2','D','10','5',NULL,'Member Relationship',NULL,NULL,'"drvMemberRelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENPAUHCEXPZ0','1','D','10','6',NULL,'Member Middle Initial',NULL,NULL,'"drvMemberMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENPAUHCEXPZ0','40','D','10','7',NULL,'Address Line 1',NULL,NULL,'"drvAddreAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENPAUHCEXPZ0','40','D','10','8',NULL,'Address Line 2',NULL,NULL,'"drvAddreAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENPAUHCEXPZ0','19','D','10','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENPAUHCEXPZ0','2','D','10','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENPAUHCEXPZ0','5','D','10','11',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENPAUHCEXPZ0','4','D','10','12',NULL,'Zip Suffix',NULL,NULL,'"drvZipSuffix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENPAUHCEXPZ0','12','D','10','13',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENPAUHCEXPZ0','12','D','10','14',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENPAUHCEXPZ0','1','D','10','15',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENPAUHCEXPZ0','8','D','10','16',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENPAUHCEXPZ0','30','D','10','17',NULL,'Group Policy Number',NULL,NULL,'"drvGroupPolicyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENPAUHCEXPZ0','30','D','10','18',NULL,'Subgrp Policy Number',NULL,NULL,'"drvSubgrPolicyNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENPAUHCEXPZ0','8','D','10','19',NULL,'Emp Sub-Grp Eff Date',NULL,NULL,'"drvEmpSGrpEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENPAUHCEXPZ0','10','D','10','20',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENPAUHCEXPZ0','8','D','10','21',NULL,'Plan Code Eff Date',NULL,NULL,'"drvPlanCodeEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENPAUHCEXPZ0','2','D','10','22',NULL,'Tier Code',NULL,NULL,'"drvTierCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENPAUHCEXPZ0','8','D','10','23',NULL,'Member Original Eff Date',NULL,NULL,'"drvMemberOrigEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENPAUHCEXPZ0','8','D','10','24',NULL,'Term Date',NULL,NULL,'"drvTermDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENPAUHCEXPZ0','9','D','10','25',NULL,'ALT-ID',NULL,NULL,'"drvALTID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENPAUHCEXPZ0','1','D','10','26',NULL,'Student Status',NULL,NULL,'"drvStudentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENPAUHCEXPZ0','1','D','10','27',NULL,'Handicapped',NULL,NULL,'"drvHandicapped"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENPAUHCEXPZ0','3','D','10','28',NULL,'Written Preference Language',NULL,NULL,'"drvWrittPreferenceLanguage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENPAUHCEXPZ0','8','D','10','29',NULL,'Written Preference Effective Date',NULL,NULL,'"drvWrittenPfecEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENPAUHCEXPZ0','3','D','10','30',NULL,'Spoken Preference Language',NULL,NULL,'"drvSpokePreferenceLanguage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENPAUHCEXPZ0','8','D','10','31',NULL,'Spoken Preference Effective Date',NULL,NULL,'"drvSpokenPfecEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENPAUHCEXPZ0','1','D','10','32',NULL,'CALAP Eligibility Indicator',NULL,NULL,'"drvCALAPEligibilityIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENPAUHCEXPZ0','8','D','10','33',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENPAUHCEXPZ0','4','D','10','34',NULL,'Subscriber Class Id',NULL,NULL,'"drvSubscClassId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENPAUHCEXPZ0','8','D','10','35',NULL,'Subscriber Class Effective date',NULL,NULL,'"drvSubscEffectivedate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENPAUHCEXPZ0','1','D','10','36',NULL,'Salary Type',NULL,NULL,'"drvSalaryType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENPAUHCEXPZ0','10','D','10','37',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENPAUHCEXPZ0','8','D','10','38',NULL,'Salary Effective date',NULL,NULL,'"drvSalaryEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENPAUHCEXPZ0','10','D','10','39',NULL,'Plan Coverage Amount',NULL,NULL,'"drvPlanCoverageAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENPAUHCEXPZ0','8','D','10','40',NULL,'Plan Coverage Amount Effective Date',NULL,NULL,'"drvPlanCfecEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENPAUHCEXPZ0','8','D','10','41',NULL,'Student Status Effective date',NULL,NULL,'"drvStudeEffectivedate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENPAUHCEXPZ0','8','D','10','42',NULL,'Student Status Term date',NULL,NULL,'"drvStudeTermdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENPAUHCEXPZ0','8','D','10','43',NULL,'Handicap Effective date',NULL,NULL,'"drvHandicapEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENPAUHCEXPZ0','8','D','10','44',NULL,'Handicap Term date',NULL,NULL,'"drvHandicapTermDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENPAUHCEXPZ0','11','D','10','45',NULL,'ADP Member Indicator',NULL,NULL,'"drvADPMMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENPAUHCEXPZ0','11','D','10','46',NULL,'ALT Member Indicator',NULL,NULL,'"drvALTMMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENPAUHCEXPZ0','8','D','10','47',NULL,'AON Member Indicator',NULL,NULL,'"drvAONMMemberIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENPAUHCEXPZ0','50','D','10','48',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENPAUHCEXPZ0','48','T','90','1',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENPAUHCEXPZ0','14','T','90','2',NULL,'Record Type',NULL,NULL,'"TRAILER RECORD"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENPAUHCEXPZ0','1','T','90','3',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENPAUHCEXPZ0','8','T','90','4',NULL,'Client Job Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENPAUHCEXPZ0','1','T','90','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENPAUHCEXPZ0','9','T','90','6',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENPAUHCEXPZ0','353','T','90','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENPAUHCEXP_20230510.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202305109','EMPEXPORT','OEACTIVE',NULL,'ENPAUHCEXP',NULL,NULL,NULL,'202305109','May 10 2023  6:43AM','May 10 2023  6:43AM','202305101',NULL,'','','202305101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202305109','EMPEXPORT','OEPASSIVE',NULL,'ENPAUHCEXP',NULL,NULL,NULL,'202305109','May 10 2023  6:43AM','May 10 2023  6:43AM','202305101',NULL,'','','202305101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC STD LTD Life AD&D Export','202305109','EMPEXPORT','ONDEM_XOE',NULL,'ENPAUHCEXP',NULL,NULL,NULL,'202305109','May 10 2023  6:43AM','May 10 2023  6:43AM','202305101',NULL,'','','202305101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC STD LTD Life AD&D Ex-Sched','202305109','EMPEXPORT','SCH_ENPAUH',NULL,'ENPAUHCEXP',NULL,NULL,NULL,'202305109','May 10 2023  6:43AM','May 10 2023  6:43AM','202305101',NULL,'','','202305101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC STD LTD Life AD&D Ex-Test','202305109','EMPEXPORT','TEST_XOE',NULL,'ENPAUHCEXP',NULL,NULL,NULL,'202305109','May 10 2023  6:43AM','May 10 2023  6:43AM','202305101',NULL,'','','202305101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENPAUHCEXP','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENPAUHCEXP','H01','dbo.U_ENPAUHCEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENPAUHCEXP','D10','dbo.U_ENPAUHCEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENPAUHCEXP','T90','dbo.U_ENPAUHCEXP_Trailer',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ENPAUHCEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ENPAUHCEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENPAUHCEXP] (
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
-- Create table U_ENPAUHCEXP_Audit
-----------

IF OBJECT_ID('U_ENPAUHCEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_Audit] (
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
-- Create table U_ENPAUHCEXP_AuditFields
-----------

IF OBJECT_ID('U_ENPAUHCEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ENPAUHCEXP_DedList
-----------

IF OBJECT_ID('U_ENPAUHCEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENPAUHCEXP_drvTbl
-----------

IF OBJECT_ID('U_ENPAUHCEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubscriberID] char(11) NULL,
    [drvMemberIndicator] bigint NULL,
    [drvMembeLastName] varchar(100) NULL,
    [drvMembeFirstName] varchar(100) NULL,
    [drvMemberRelationship] varchar(2) NULL,
    [drvMemberMiddleInitial] varchar(1) NULL,
    [drvAddreAddressLine1] varchar(255) NULL,
    [drvAddreAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(5) NULL,
    [drvZipSuffix] varchar(4) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvGroupPolicyNumber] varchar(7) NOT NULL,
    [drvSubgrPolicyNumber] varchar(4) NOT NULL,
    [drvEmpSGrpEffDate] datetime NULL,
    [drvPlanCode] varchar(1) NOT NULL,
    [drvPlanCodeEffDate] datetime NULL,
    [drvTierCode] varchar(1) NOT NULL,
    [drvMemberOrigEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvALTID] varchar(10) NULL,
    [drvStudentStatus] varchar(1) NOT NULL,
    [drvHandicapped] varchar(1) NOT NULL,
    [drvWrittPreferenceLanguage] varchar(1) NOT NULL,
    [drvWrittenPfecEffectiveDate] varchar(1) NOT NULL,
    [drvSpokePreferenceLanguage] varchar(1) NOT NULL,
    [drvSpokenPfecEffectiveDate] varchar(1) NOT NULL,
    [drvCALAPEligibilityIndicator] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvSubscClassId] varchar(4) NULL,
    [drvSubscEffectivedate] datetime NULL,
    [drvSalaryType] varchar(1) NOT NULL,
    [drvSalaryAmount] varchar(1) NOT NULL,
    [drvSalaryEffDate] varchar(1) NOT NULL,
    [drvPlanCoverageAmount] money NULL,
    [drvPlanCfecEffectiveDate] datetime NULL,
    [drvStudeEffectivedate] varchar(1) NOT NULL,
    [drvStudeTermdate] varchar(1) NOT NULL,
    [drvHandicapEffDate] varchar(1) NOT NULL,
    [drvHandicapTermDate] varchar(1) NOT NULL,
    [drvADPMMemberIndicator] varchar(1) NOT NULL,
    [drvALTMMemberIndicator] varchar(1) NOT NULL,
    [drvAONMMemberIndicator] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_ENPAUHCEXP_EEList
-----------

IF OBJECT_ID('U_ENPAUHCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENPAUHCEXP_File
-----------

IF OBJECT_ID('U_ENPAUHCEXP_File') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ENPAUHCEXP_Header
-----------

IF OBJECT_ID('U_ENPAUHCEXP_Header') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_Header] (
    [drvDatefilecreated] varchar(8) NULL
);

-----------
-- Create table U_ENPAUHCEXP_Trailer
-----------

IF OBJECT_ID('U_ENPAUHCEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_ENPAUHCEXP_Trailer] (
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENPAUHCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NPA Coatings

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 05/10/2023
Service Request Number: TekP-2023-03-01-04

Purpose: UHC STD LTD Life AD&D Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENPAUHCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENPAUHCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENPAUHCEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENPAUHCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENPAUHCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENPAUHCEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENPAUHCEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENPAUHCEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENPAUHCEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENPAUHCEXP', 'SCH_ENPAUH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENPAUHCEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENPAUHCEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENPAUHCEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@FileMinCovDate  = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENPAUHCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENPAUHCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ENPAUHCEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_AuditFields;
    CREATE TABLE dbo.U_ENPAUHCEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ENPAUHCEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_Audit;
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
    INTO dbo.U_ENPAUHCEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ENPAUHCEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ENPAUHCEXP_Audit ON dbo.U_ENPAUHCEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ENPAUHCEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ENPAUHCEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LFEER,LFEEX,VLC1S,VLC2S,VOLAC,VOLC1,VOLC2,VOLCH,VOLEE,VOLSP';

    IF OBJECT_ID('U_ENPAUHCEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENPAUHCEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENPAUHCEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENPAUHCEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSubscriberID = eepssn
        ,drvMemberIndicator = CASE WHEN BdmRecType = 'EMP' THEN '00'
                                   WHEN BdmRecType = 'DEP' and conrelationship IN ( 'SPS','DP') THEN '01'
                                   WHEN BdmRecType = 'DEP' and conrelationship IN ('CHL', 'DCH', 'DPC', 'STC') THEN  Con_RN END
        ,drvMembeLastName = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMembeFirstName = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        
        ,drvMemberRelationship = CASE WHEN BdmRecType = 'EMP' THEN 'EE'
                                      WHEN conrelationship IN ( 'SPS','DP') THEN 'SP'
                                      WHEN conrelationship IN ('CHL', 'DCH', 'DPC', 'STC')  THEN 'CH'
                                    END
        ,drvMemberMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN Left(EepNameMiddle,1) ELSE Left(ConNameMiddle,1) END
        ,drvAddreAddressLine1 = EepAddressLine1
        ,drvAddreAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = LEFT(EepAddressZipCode, 5)
        ,drvZipSuffix = CASE WHEN LEN(EepAddressZipCode) > 5  THEN Right(EepAddressZipCode, 4) END
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvBirthDate = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateofBirth END
        ,drvGroupPolicyNumber = '0922318'
        ,drvSubgrPolicyNumber = '2001'
        ,drvEmpSGrpEffDate =  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvPlanCode = ''
        ,drvPlanCodeEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvTierCode = ''
        ,drvMemberOrigEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvTermDate = BdmBenStopDate  -- CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvALTID = 'A' + eecempno
        ,drvStudentStatus = ''
        ,drvHandicapped = ''
        ,drvWrittPreferenceLanguage = ''
        ,drvWrittenPfecEffectiveDate = ''
        ,drvSpokePreferenceLanguage = ''
        ,drvSpokenPfecEffectiveDate = ''
        ,drvCALAPEligibilityIndicator = ''
        ,drvHireDate = EecDateOfLastHire
        ,drvSubscClassId = CASE WHEN Bdmdedcode = 'LFEER' THEN '2001'
                                WHEN Bdmdedcode  = 'LFEEX' THEN '2002'
                            END
        ,drvSubscEffectivedate = CASE WHEN Bdmdedcode  IN ('LFEER', 'LFEEX') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
        ,drvSalaryType = ''
        ,drvSalaryAmount = ''
        ,drvSalaryEffDate = ''
        ,drvPlanCoverageAmount = CASE WHEN Bdmdedcode  IN ( 'VOLC1' , 'VLC1S') THEN  '0001000000'
                                       WHEN Bdmdedcode  IN ( 'VOLC2' , 'VLC2S') THEN '0002000000'
                                      WHEN Bdmdedcode  IN ( 'LFEER' , 'LFEEX') THEN BcaEEBenAmt 
                                      WHEN Bdmdedcode  IN ( 'VOLE' , 'VOLSP') THEN BdmEEamt
                                    END
        ,drvPlanCfecEffectiveDate = CASE WHEN Bdmdedcode  IN ( 'VOLC1' , 'VLC1S', 'VOLC2' , 'VLC2S','LFEER' , 'LFEEX','VOLE' , 'VOLSP') THEN  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
        ,drvStudeEffectivedate = ''
        ,drvStudeTermdate = ''
        ,drvHandicapEffDate = ''
        ,drvHandicapTermDate = ''
        ,drvADPMMemberIndicator = ''
        ,drvALTMMemberIndicator = ''
        ,drvAONMMemberIndicator = ''
        ,drvEmailAddress = eepaddressemailalternate
    INTO dbo.U_ENPAUHCEXP_drvTbl
    FROM dbo.U_ENPAUHCEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ENPAUHCEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
      LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH(NOLOCK)
            ON BcaEEID = BdmEEID
            and BcaCoID = BdmCoID
            and BcaDedCode = bdmdedcode
     LEFT JOIN (
            SELECT ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConEEID, /*ConSystemID*/ CASE WHEN ConRelationship IN ('SPS') THEN 1 ELSE 2 END) AS Con_RN, * 
            FROM dbo.Contacts WITH (NOLOCK)
            /*JOIN dbo.U_dsi_BDM_EOPTMRXEXP A WITH (NOLOCK)
                ON ConSystemID = A.BdmDepRecID*/
        ) AS Con
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENPAUHCEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_Header;
    SELECT DISTINCT
         drvDatefilecreated = @RunDate 
    INTO dbo.U_ENPAUHCEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ENPAUHCEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ENPAUHCEXP_Trailer;
    SELECT DISTINCT
         drvRecordCount = (Select count (*) from dbo.U_ENPAUHCEXP_drvTbl WITH (NOLOCK))
    INTO dbo.U_ENPAUHCEXP_Trailer
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
ALTER VIEW dbo.dsi_vwENPAUHCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENPAUHCEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENPAUHCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202305031'
       ,expStartPerControl     = '202305031'
       ,expLastEndPerControl   = '202305109'
       ,expEndPerControl       = '202305109'
WHERE expFormatCode = 'ENPAUHCEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENPAUHCEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENPAUHCEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENPAUHCEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENPAUHCEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENPAUHCEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENPAUHCEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENPAUHCEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENPAUHCEXP', 'UseFileName', 'V', 'Y'


-- End ripout