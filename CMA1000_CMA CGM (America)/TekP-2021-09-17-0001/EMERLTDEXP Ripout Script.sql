/**********************************************************************************

EMERLTDEXP: Mercer Pension Export

FormatCode:     EMERLTDEXP
Project:        Mercer Pension Export
Client ID:      CMA1000
Date/time:      2022-03-03 21:29:02.167
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB01
Database:       ULTIPRO_WPCCG
Web Filename:   CMA1000_33984_EEHISTORY_EMERLTDEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMERLTDEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMERLTDEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMERLTDEXP'


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
WHERE FormatCode = 'EMERLTDEXP'
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
WHERE ExpFormatCode = 'EMERLTDEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMERLTDEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMERLTDEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMERLTDEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMERLTDEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMERLTDEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMERLTDEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMERLTDEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMERLTDEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMERLTDEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMERLTDEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMERLTDEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMERLTDEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMERLTDEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERLTDEXP];
GO
IF OBJECT_ID('U_EMERLTDEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_PEarHist];
GO
IF OBJECT_ID('U_EMERLTDEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_PDedHist];
GO
IF OBJECT_ID('U_EMERLTDEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_File];
GO
IF OBJECT_ID('U_EMERLTDEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_EEList];
GO
IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_drvTblTrailer];
GO
IF OBJECT_ID('U_EMERLTDEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_drvTbl];
GO
IF OBJECT_ID('U_EMERLTDEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_DedList];
GO
IF OBJECT_ID('U_EMERLTDEXP_AuditMEBA') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_AuditMEBA];
GO
IF OBJECT_ID('U_EMERLTDEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_AuditFields];
GO
IF OBJECT_ID('U_EMERLTDEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMERLTDEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMERLTDEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMERLTDEXP','Mercer Pension Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMERLTDEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','H','01','52',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMERLTDEXPZ0','50','H','01','103',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMERLTDEXPZ0','50','H','01','154',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMERLTDEXPZ0','50','H','01','205',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMERLTDEXPZ0','50','H','01','256',NULL,'Address1',NULL,NULL,'"Address1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMERLTDEXPZ0','50','H','01','307',NULL,'Address2',NULL,NULL,'"Address2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMERLTDEXPZ0','50','H','01','358',NULL,'City',NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMERLTDEXPZ0','50','H','01','409',NULL,'State',NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMERLTDEXPZ0','50','H','01','460',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMERLTDEXPZ0','50','H','01','511',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMERLTDEXPZ0','50','H','01','562',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMERLTDEXPZ0','50','H','01','613',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMERLTDEXPZ0','50','H','01','664',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMERLTDEXPZ0','50','H','01','715',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMERLTDEXPZ0','50','H','01','766',NULL,'Disability Date',NULL,NULL,'"Disability Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMERLTDEXPZ0','50','H','01','817',NULL,'Transfer Date',NULL,NULL,'"Transfer Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMERLTDEXPZ0','50','H','01','868',NULL,'Pension Status',NULL,NULL,'"Pension Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMERLTDEXPZ0','50','H','01','919',NULL,'Pension Accrual End Date',NULL,NULL,'"Pension Accrual End Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMERLTDEXPZ0','50','H','01','970',NULL,'Reason Code',NULL,NULL,'"Reason Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMERLTDEXPZ0','50','H','01','1021',NULL,'Union Code',NULL,NULL,'"Union Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMERLTDEXPZ0','50','H','01','1072',NULL,'FTE Status',NULL,NULL,'"FTE Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMERLTDEXPZ0','50','H','01','1123',NULL,'Period Plan Year',NULL,NULL,'"Period Plan Year"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMERLTDEXPZ0','50','H','01','1174',NULL,'Period Plan Month',NULL,NULL,'"Period Plan Month"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMERLTDEXPZ0','50','H','01','1225',NULL,'Plan Hours',NULL,NULL,'"Plan Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMERLTDEXPZ0','50','H','01','1276',NULL,'Plan Earnings',NULL,NULL,'"Plan Earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMERLTDEXPZ0','50','H','01','1327',NULL,'Plan Earnings Effective Date',NULL,NULL,'"Plan Earnings Effective Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMERLTDEXPZ0','50','H','01','1378',NULL,'Final Term Flag',NULL,NULL,'"Final Term Flag"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMERLTDEXPZ0','50','H','01','1429',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMERLTDEXPZ0','50','H','01','1480',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMERLTDEXPZ0','50','H','01','1531',NULL,'Spouse First Name',NULL,NULL,'"Spouse First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMERLTDEXPZ0','50','H','01','1582',NULL,'Spouse Middle Name',NULL,NULL,'"Spouse Middle Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMERLTDEXPZ0','50','H','01','1633',NULL,'Spouse Last Name',NULL,NULL,'"Spouse Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMERLTDEXPZ0','50','H','01','1684',NULL,'MEBA',NULL,NULL,'"MEBA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMERLTDEXPZ0','50','H','01','1735',NULL,'MEBA Start Date',NULL,NULL,'"MEBA Start Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMERLTDEXPZ0','50','H','01','1786',NULL,'MEBA End Date',NULL,NULL,'"MEBA End Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','D','10','52',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMERLTDEXPZ0','50','D','10','103',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMERLTDEXPZ0','50','D','10','154',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMERLTDEXPZ0','50','D','10','205',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMERLTDEXPZ0','50','D','10','256',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMERLTDEXPZ0','50','D','10','307',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMERLTDEXPZ0','50','D','10','358',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMERLTDEXPZ0','50','D','10','409',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMERLTDEXPZ0','50','D','10','460',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMERLTDEXPZ0','50','D','10','511',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMERLTDEXPZ0','50','D','10','562',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMERLTDEXPZ0','50','D','10','613',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMERLTDEXPZ0','50','D','10','664',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMERLTDEXPZ0','50','D','10','715',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMERLTDEXPZ0','50','D','10','766',NULL,'Disability Date',NULL,NULL,'"drvDisabilityDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMERLTDEXPZ0','50','D','10','817',NULL,'Transfer Date',NULL,NULL,'"drvTransferDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMERLTDEXPZ0','50','D','10','868',NULL,'Pension Status',NULL,NULL,'"drvPensionStatus"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMERLTDEXPZ0','50','D','10','919',NULL,'Pension Accrual End Date',NULL,NULL,'"drvPensionAccEndDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMERLTDEXPZ0','50','D','10','970',NULL,'Reason Code',NULL,NULL,'"drvReasonCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMERLTDEXPZ0','50','D','10','1021',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMERLTDEXPZ0','50','D','10','1072',NULL,'FTE Status',NULL,NULL,'"drvFTEStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMERLTDEXPZ0','50','D','10','1123',NULL,'Period Plan Year',NULL,NULL,'"drvPeriodPlanYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMERLTDEXPZ0','50','D','10','1174',NULL,'Period Plan Month',NULL,NULL,'"drvPeriodPlanMonth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMERLTDEXPZ0','50','D','10','1225',NULL,'Plan Hours',NULL,NULL,'"drvPlanHours"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMERLTDEXPZ0','50','D','10','1276',NULL,'Plan Earnings',NULL,NULL,'"drvPlanEarnings"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMERLTDEXPZ0','50','D','10','1327',NULL,'Plan Earnings Effective Date',NULL,NULL,'"drvPlanEarningEffectiveDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMERLTDEXPZ0','50','D','10','1378',NULL,'Final Term Flag',NULL,NULL,'"drvFinalTermFlag"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMERLTDEXPZ0','50','D','10','1429',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMERLTDEXPZ0','50','D','10','1480',NULL,'Spouse Date of Birth',NULL,NULL,'"drvSpouseDateOfBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMERLTDEXPZ0','50','D','10','1531',NULL,'Spouse First Name',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMERLTDEXPZ0','50','D','10','1582',NULL,'Spouse Middle Name',NULL,NULL,'"drvSpouseMiddleName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMERLTDEXPZ0','50','D','10','1633',NULL,'Spouse Last Name',NULL,NULL,'"drvSpouseLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMERLTDEXPZ0','50','D','10','1684',NULL,'MEBA',NULL,NULL,'"drvMEBA"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMERLTDEXPZ0','50','D','10','1735',NULL,'MEBA Start Date',NULL,NULL,'"drvMEBAStartDate"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMERLTDEXPZ0','50','D','10','1786',NULL,'MEBA End Date',NULL,NULL,'"drvMEBAEndDate"','(''UD101''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','T','90','1',NULL,'Counts of Active',NULL,NULL,'"Counts of Active"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','T','90','50',NULL,'Counts of Active',NULL,NULL,'"drvCountsofActive"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','T','91','1',NULL,'Counts of Terminated',NULL,NULL,'"Counts of Terminated"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','T','91','50',NULL,'Counts of Terminated',NULL,NULL,'"drvCountsofTerminated"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','T','92','1',NULL,'Counts of Deceased',NULL,NULL,'"Counts of Deceased"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','T','92','50',NULL,'Counts of Deceased',NULL,NULL,'"drvCountsofDeceased"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','T','93','1',NULL,'Sum of Hours',NULL,NULL,'"Sum of Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','T','93','50',NULL,'Sum of Hours',NULL,NULL,'"drvSumOfHours"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMERLTDEXPZ0','50','T','94','1',NULL,'Sum of Earnings',NULL,NULL,'"Sum of Earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMERLTDEXPZ0','50','T','94','50',NULL,'Sum of Earnings',NULL,NULL,'"drvSumOfEarnings"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMERLTDEXP_20220303.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Active Open Enrollment Export','202002059','EMPEXPORT','OEACTIVE','Feb 10 2020 12:00AM','EMERLTDEXP',NULL,NULL,NULL,'202002059','Feb  5 2020 12:00AM','Dec 30 1899 12:00AM','202001211',NULL,'','','202001211',dbo.fn_GetTimedKey(),NULL,'us3tKiCMA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201912319','EMPEXPORT','OEPASSIVE',NULL,'EMERLTDEXP',NULL,NULL,NULL,'201912319','Dec 31 2019  5:03PM','Dec 31 2019  5:03PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Merce Pension Export','201912319','EMPEXPORT','ONDEMAND',NULL,'EMERLTDEXP',NULL,NULL,NULL,'201912319','Dec 31 2019  5:03PM','Dec 31 2019  5:03PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','MLMTS,MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Mercer Data File Monthly 15th','202002269','EMPEXPORT','SCH_MERS','Feb 26 2020  3:42PM','EMERLTDEXP',NULL,NULL,NULL,'202201319','Feb 26 2020 12:00AM','Dec 30 1899 12:00AM','202201011','1206','','','201912311',dbo.fn_GetTimedKey(),NULL,'us3mLaCMA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','MLMTS,MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Test Purposes Only','202112109','EMPEXPORT','TEST','May 29 2020  9:26AM','EMERLTDEXP',NULL,NULL,NULL,'202112109','Apr 30 2020 12:00AM','Dec 30 1899 12:00AM','202111011','815','','','202111011',dbo.fn_GetTimedKey(),NULL,'us3lKiCMA1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','D10','dbo.U_EMERLTDEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T90','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T91','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T92','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T93','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T94','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMERLTDEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EMERLTDEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMERLTDEXP] (
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
-- Create table U_EMERLTDEXP_Audit
-----------

IF OBJECT_ID('U_EMERLTDEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_Audit] (
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
-- Create table U_EMERLTDEXP_AuditFields
-----------

IF OBJECT_ID('U_EMERLTDEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EMERLTDEXP_AuditMEBA
-----------

IF OBJECT_ID('U_EMERLTDEXP_AuditMEBA') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_AuditMEBA] (
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
-- Create table U_EMERLTDEXP_DedList
-----------

IF OBJECT_ID('U_EMERLTDEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMERLTDEXP_drvTbl
-----------

IF OBJECT_ID('U_EMERLTDEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(101) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvDisabilityDate] datetime NULL,
    [drvTransferDate] datetime NULL,
    [drvPensionStatus] varchar(1) NOT NULL,
    [drvPensionAccEndDate] datetime NULL,
    [drvReasonCode] varchar(25) NULL,
    [drvUnionCode] varchar(10) NULL,
    [drvFTEStatus] varchar(4) NOT NULL,
    [drvPeriodPlanYear] int NULL,
    [drvPeriodPlanMonth] int NULL,
    [drvPlanHours] varchar(12) NULL,
    [drvPlanHoursRaw] decimal NULL,
    [drvPlanEarnings] varchar(12) NULL,
    [drvPlanEarningsRaw] decimal NULL,
    [drvPlanEarningEffectiveDate] datetime NULL,
    [drvFinalTermFlag] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseMiddleName] varchar(50) NULL,
    [drvSpouseLastName] varchar(100) NULL,
    [drvMEBA] varchar(4) NULL,
    [drvMEBAStartDate] datetime NULL,
    [drvMEBAEndDate] datetime NULL,
    [drvInitialSort] char(11) NULL,
    [drvDateofLastHire] datetime NULL
);

-----------
-- Create table U_EMERLTDEXP_drvTblTrailer
-----------

IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_drvTblTrailer] (
    [drvCountsofActive] varchar(12) NULL,
    [drvCountsofTerminated] varchar(12) NULL,
    [drvCountsofDeceased] varchar(12) NULL,
    [drvSumOfHours] varchar(15) NULL,
    [drvSumOfEarnings] varchar(15) NULL
);

-----------
-- Create table U_EMERLTDEXP_EEList
-----------

IF OBJECT_ID('U_EMERLTDEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMERLTDEXP_File
-----------

IF OBJECT_ID('U_EMERLTDEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);

-----------
-- Create table U_EMERLTDEXP_PDedHist
-----------

IF OBJECT_ID('U_EMERLTDEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
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
-- Create table U_EMERLTDEXP_PEarHist
-----------

IF OBJECT_ID('U_EMERLTDEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERLTDEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CMA CGM (America) LLC

Created By: Marco Lagrosa
Business Analyst: Trena King
Create Date: 12/31/2019
Service Request Number: SR-2019-00223916

Purpose: Mercer Pension Export

Revision History
----------------
Update By             Date           Request Num           Desc
Darren Collard        12/08/2021     TekP-2021-09-17-0001  Add MEBA Start and End Date

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMERLTDEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMERLTDEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMERLTDEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMERLTDEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMERLTDEXP';

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

    -- Cleans EE List of employee not in the following company.
    --APL America LLC - MLWSW
    --APL GUAM LTD -  Y0SOB
    --APL Maritime Limited - MLWA8
    --Delete from U_EMERLTDEXP_EEList where xcoid not in ('MLWSW','Y0SOB','MLWA8')


    DELETE FROM dbo.U_EMERLTDEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMERLTDEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (Select eeceeid from vw_int_EmpComp where EecEEType = 'TES')


    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (    Select eeceeid from vw_int_EmpComp where eecempno in ('0003','2525','2717','0004','4228','2723','4929')
    )


    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (        Select distinct eeceeid from vw_int_EmpComp where EecJobCode  = 'APLDW01'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD';

    IF OBJECT_ID('U_EMERLTDEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMERLTDEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');



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



    IF OBJECT_ID('U_EMERLTDEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_AuditFields;
    CREATE TABLE dbo.U_EMERLTDEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EMERLTDEXP_AuditFields 
    VALUES ('empcomp','eecemplstatus')
          ,('empcomp','eecUnionLocal')
          ,('empcomp','eecorglvl4');    
    
    
    -- Create audit table
    IF OBJECT_ID('U_EMERLTDEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_Audit;
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
    INTO dbo.U_EMERLTDEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EMERLTDEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EMERLTDEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN DateAdd(year,-2,@StartDate)  AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMERLTDEXP_Audit ON dbo.U_EMERLTDEXP_Audit (audKey1Value, audKey2Value);

    -- Create audit table
    IF OBJECT_ID('U_EMERLTDEXP_AuditMEBA','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_AuditMEBA;
    SELECT
         audTableName 
        ,audFieldName 
        ,audKey1Value 
        ,audKey2Value 
        ,audKey3Value 
        ,audDateTime  
        ,audOldValue  
        ,audNewValue  
        ,audRowNo 
    INTO dbo.U_EMERLTDEXP_AuditMEBA
    FROM dbo.U_EMERLTDEXP_Audit 
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND (audOldValue IN (SELECT uniCode FROM LabUnion WHERE uniLongDesc LIKE '%MEBA%') 
      OR audNewValue IN (SELECT uniCode FROM LabUnion WHERE uniLongDesc LIKE '%MEBA%')
        )
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMERLTDEXP_AuditMEBA ON dbo.U_EMERLTDEXP_AuditMEBA (audKey1Value, audKey2Value);

    --Only keep the last change to/from MEBA
    DELETE MEBA
    FROM dbo.U_EMERLTDEXP_AuditMEBA MEBA
    WHERE EXISTS( SELECT 1 FROM dbo.U_EMERLTDEXP_AuditMEBA WHERE audKey1Value = MEBA.audKey1Value AND audKey2Value = MEBA.audKey2Value AND audDateTime > MEBA.audDateTime)
    
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMERLTDEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EMERLTDEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMERLTDEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EMERLTDEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_PEarHist;
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
    INTO dbo.U_EMERLTDEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EARNCODE WITH (NOLOCK)
        on ErnEarncode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND erncalcrule = '01'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMERLTDEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMERLTDEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = ISNULL(eepSSN,EinNationalID)
        ,drvEmpId = eecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = Left(Isnull(eepnameLast,''),1) + Lower(SUBSTRING(eepnamelast, 2, len(eepnamelast)))
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <>  EecDateOfLastHire THEN EecDateOfLastHire END 
        ,drvDisabilityDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvTransferDate = CASE WHEN EecJobChangeReason = 'TRI' THEN EecDateInJob  END
        ,drvPensionStatus = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'D'
                                                 ELSE 'T'
                                            END
                                WHEN  EecEmplStatus = 'A' THEN 'A'
                                WHEN  EecEmplStatus = 'L' THEN 'L'
                                ELSE 'A'
                            END
        ,drvPensionAccEndDate = EecDateOfTermination
        ,drvReasonCode = (select top 1 tchDesc from TrmReasn where tchcode =  EecTermReason)
        ,drvUnionCode = CASE WHEN eecorglvl4 = 'U' THEN eecorglvl4 ELSE '' END
        ,drvFTEStatus = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1.00' ELSE '0.50' END
        ,drvPeriodPlanYear = YEAR(GETDATE())
        ,drvPeriodPlanMonth = MONTH(GETDATE())
        ,drvPlanHours = CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as varchar(12))
        ,drvPlanHoursRaw = CONVERT(DECIMAL(10,2),PehCurHrsYTD)
        ,drvPlanEarnings =  CAST(CONVERT(DECIMAL(10,2),EecAnnSalary) as varchar(12))
        ,drvPlanEarningsRaw = CONVERT(DECIMAL(10,2),EecAnnSalary)
        ,drvPlanEarningEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xeeid, xcoid, GetDate(),EecDateOfLastHire)  
        ,drvFinalTermFlag = CASE WHEN (Select Max(prgpaydate) from vw_int_PayReg where prgEEID = xeeid) > EecDateOfTermination THEN 'Y' ELSE 'N' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END 
        ,drvSpouseDateOfBirth =  CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 condateofbirth from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseFirstName =   CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 ConNameFirst from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseMiddleName =  CASE WHEN eepMaritalStatus = 'M' THEN  (select top 1 ConNameMiddle from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseLastName =   CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 ConNameLast from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvMEBA          = IIF(ISNULL(UniLongDesc,'') LIKE '%MEBA%', 'MEBA', NULL)
        ,drvMEBAStartDate = IIF(ISNULL(UniLongDesc,'') LIKE '%MEBA%', eecDateOfOriginalHire, NULL)
        ,drvMEBAEndDate   = IIF(    ISNULL(MEBA.audOldValue,'') IN (SELECT uniCode FROM LabUnion WHERE uniLongDesc LIKE '%MEBA%') --FROM MEBA 
                                AND ISNULL(MEBA.audNewValue,'') NOT IN (SELECT uniCode FROM LabUnion WHERE uniLongDesc LIKE '%MEBA%') --TO NON-MEBA
                                ,MEBA.audDateTime, NULL)
        ,drvInitialSort = eepSSN
        ,drvDateofLastHire = EecDateOfLastHire
    INTO dbo.U_EMERLTDEXP_drvTbl
    FROM dbo.U_EMERLTDEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EMERLTDEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EMERLTDEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.EmpIntl WITH (NOLOCK)
        ON eineeid = xeeid
    LEFT JOIN dbo.LabUnion WITH (NOLOCK)
        ON UniCode = EecUnionLocal
    LEFT JOIN dbo.U_EMERLTDEXP_AuditMEBA MEBA  WITH (NOLOCK)
        ON xEEID = MEBA.audKey1Value AND xCOID=MEBA.audKey2Value

    
    Delete from U_EMERLTDEXP_drvTbl
    where drvDateofLastHire >=  CAST( EOMONTH(dateadd( month, -1, (@StartDate))) as datetime)



    Update U_EMERLTDEXP_drvTbl set drvMaritalStatus = '' where drvMaritalStatus is null or drvMaritalStatus in ('','Z')  
    Delete from U_EMERLTDEXP_drvTbl where YEAR(drvPensionAccEndDate) <= YEAR(DATEADD(YY, - 2, @EndDate)) 

     IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_drvTblTrailer;
    SELECT DISTINCT
            drvCountsofActive = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus IN('A','L')) as varchar(12))
            ,drvCountsofTerminated = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus = 'T' ) as varchar(12))
            ,drvCountsofDeceased = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus = 'D' ) as varchar(12))
            ,drvSumOfHours = CAST(CONVERT(DECIMAL(13,2),(Select Sum(drvPlanHoursRaw) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)))as varchar(15))
            ,drvSumOfEarnings = CAST(CONVERT(DECIMAL(13,2),(Select Sum(drvPlanEarningsRaw) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK))) as varchar(15))
    INTO dbo.U_EMERLTDEXP_drvTblTrailer

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
ALTER VIEW dbo.dsi_vwEMERLTDEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMERLTDEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMERLTDEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912241'
       ,expStartPerControl     = '201912241'
       ,expLastEndPerControl   = '201912319'
       ,expEndPerControl       = '201912319'
WHERE expFormatCode = 'EMERLTDEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMERLTDEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMERLTDEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMERLTDEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMERLTDEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMERLTDEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMERLTDEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMERLTDEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMERLTDEXP', 'UseFileName', 'V', 'Y'


-- End ripout