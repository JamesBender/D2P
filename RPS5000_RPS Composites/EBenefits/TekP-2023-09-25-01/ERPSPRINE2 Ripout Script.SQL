/**********************************************************************************

ERPSPRINE2: Principal Ebenefits Census TEST

FormatCode:     ERPSPRINE2
Project:        Principal Ebenefits Census TEST
Client ID:      RPS5000
Date/time:      2023-11-20 12:59:29.940
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    TWP
Server:         TW1WUP1DB02
Database:       ULTIPRO_WPRPSCO
Web Filename:   RPS5000_C1ORZ_EEHISTORY_ERPSPRINE2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ERPSPRINE2_SavePath') IS NOT NULL DROP TABLE dbo.U_ERPSPRINE2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ERPSPRINE2'


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
WHERE FormatCode = 'ERPSPRINE2'
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
WHERE ExpFormatCode = 'ERPSPRINE2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ERPSPRINE2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ERPSPRINE2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ERPSPRINE2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ERPSPRINE2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ERPSPRINE2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ERPSPRINE2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ERPSPRINE2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ERPSPRINE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ERPSPRINE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ERPSPRINE2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwERPSPRINE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERPSPRINE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERPSPRINE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERPSPRINE2];
GO
IF OBJECT_ID('U_ERPSPRINE2_WorkingTbl') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_WorkingTbl];
GO
IF OBJECT_ID('U_ERPSPRINE2_Header') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_Header];
GO
IF OBJECT_ID('U_ERPSPRINE2_File') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_File];
GO
IF OBJECT_ID('U_ERPSPRINE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_EEList];
GO
IF OBJECT_ID('U_ERPSPRINE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_drvTbl];
GO
IF OBJECT_ID('U_ERPSPRINE2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_AuditFields];
GO
IF OBJECT_ID('U_ERPSPRINE2_Audit') IS NOT NULL DROP TABLE [dbo].[U_ERPSPRINE2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERPSPRINE2','Principal Ebenefits Census TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ERPSPRINE2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERPSPRINE2Z0','50','H','01','1',NULL,'member.1.personal.ssn',NULL,NULL,'"member.1.personal.ssn"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERPSPRINE2Z0','50','H','01','2',NULL,'member.1.lname',NULL,NULL,'"member.1.lname"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERPSPRINE2Z0','50','H','01','3',NULL,'member.1.fname',NULL,NULL,'"member.1.fname"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERPSPRINE2Z0','50','H','01','4',NULL,'member.1.mname',NULL,NULL,'"member.1.mname"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERPSPRINE2Z0','50','H','01','5',NULL,'member.1.personal.dob',NULL,NULL,'"member.1.personal.dob"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERPSPRINE2Z0','50','H','01','6',NULL,'member.1.personal.gender',NULL,NULL,'"member.1.personal.gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERPSPRINE2Z0','50','H','01','7',NULL,'member.1.email',NULL,NULL,'"member.1.email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERPSPRINE2Z0','50','H','01','8',NULL,'member.1.personal_email',NULL,NULL,'"member.1.personal_email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERPSPRINE2Z0','50','H','01','9',NULL,'member.1.personal.address1',NULL,NULL,'"member.1.personal.address1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERPSPRINE2Z0','50','H','01','10',NULL,'member.1.personal.address2',NULL,NULL,'"member.1.personal.address2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERPSPRINE2Z0','50','H','01','11',NULL,'member.1.personal.city',NULL,NULL,'"member.1.personal.city"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERPSPRINE2Z0','50','H','01','12',NULL,'member.1.personal.state',NULL,NULL,'"member.1.personal.state"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERPSPRINE2Z0','50','H','01','13',NULL,'member.1.personal.zip',NULL,NULL,'"member.1.personal.zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERPSPRINE2Z0','50','H','01','14',NULL,'member.1.employment.rehire date',NULL,NULL,'"member.1.employment.rehire date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERPSPRINE2Z0','50','H','01','15',NULL,'member.1.employment.doh',NULL,NULL,'"member.1.employment.doh"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERPSPRINE2Z0','50','H','01','16',NULL,'member.1.employment.dot',NULL,NULL,'"member.1.employment.dot"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERPSPRINE2Z0','50','H','01','17',NULL,'member.1.employment.termreason',NULL,NULL,'"drvtermreason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERPSPRINE2Z0','50','H','01','18',NULL,'member.1.employment.title',NULL,NULL,'"member.1.employment.title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERPSPRINE2Z0','50','H','01','19',NULL,'member.1.employment.status',NULL,NULL,'"member.1.employment.status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERPSPRINE2Z0','50','H','01','20',NULL,'member.1.employment.group',NULL,NULL,'"member.1.employment.group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERPSPRINE2Z0','50','H','01','21',NULL,'member.1.employment.dept',NULL,NULL,'"member.1.employment.dept"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERPSPRINE2Z0','50','H','01','22',NULL,'member.1.employment.comp1',NULL,NULL,'"member.1.employment.comp1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERPSPRINE2Z0','50','H','01','23',NULL,'member.1.employment.payfrequency',NULL,NULL,'"drvpayfrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERPSPRINE2Z0','50','H','01','24',NULL,'member.1.relation',NULL,NULL,'"member.1.relation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERPSPRINE2Z0','50','H','01','25',NULL,'member.1.personal.benefit_status',NULL,NULL,'"drvbenefit_status"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERPSPRINE2Z0','50','H','01','26',NULL,'member.1.employment.file',NULL,NULL,'"member.1.employment.file"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ERPSPRINE2Z0','50','H','01','27',NULL,'member.1.employment.benefit_classification',NULL,NULL,'"drvbenefit_classification"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ERPSPRINE2Z0','50','D','10','1',NULL,'member.1.personal.ssn',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ERPSPRINE2Z0','50','D','10','2',NULL,'member.1.lname',NULL,NULL,'"drvLNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ERPSPRINE2Z0','50','D','10','3',NULL,'member.1.fname',NULL,NULL,'"drvFNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ERPSPRINE2Z0','50','D','10','4',NULL,'member.1.mname',NULL,NULL,'"drvMNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ERPSPRINE2Z0','50','D','10','5',NULL,'member.1.personal.dob',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ERPSPRINE2Z0','50','D','10','6',NULL,'member.1.personal.gender',NULL,NULL,'"drvGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ERPSPRINE2Z0','50','D','10','7',NULL,'member.1.email',NULL,NULL,'"drvEMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ERPSPRINE2Z0','50','D','10','8',NULL,'member.1.personal_email',NULL,NULL,'"drvPERSONAL_EMAIL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ERPSPRINE2Z0','50','D','10','9',NULL,'member.1.personal.address1',NULL,NULL,'"drvADDRESS1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ERPSPRINE2Z0','50','D','10','10',NULL,'member.1.personal.address2',NULL,NULL,'"drvADDRESS2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ERPSPRINE2Z0','50','D','10','11',NULL,'member.1.personal.city',NULL,NULL,'"drvCITY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ERPSPRINE2Z0','50','D','10','12',NULL,'member.1.personal.state',NULL,NULL,'"drvSTATE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ERPSPRINE2Z0','50','D','10','13',NULL,'member.1.personal.zip',NULL,NULL,'"drvZIP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ERPSPRINE2Z0','50','D','10','14',NULL,'member.1.employment.rehire date',NULL,NULL,'"drvrehiredate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ERPSPRINE2Z0','50','D','10','15',NULL,'member.1.employment.doh',NULL,NULL,'"drvDOH"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ERPSPRINE2Z0','50','D','10','16',NULL,'member.1.employment.dot',NULL,NULL,'"drvDOT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ERPSPRINE2Z0','50','D','10','17',NULL,'member.1.employment.termreason',NULL,NULL,'"drvTERMREASON"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ERPSPRINE2Z0','50','D','10','18',NULL,'member.1.employment.title',NULL,NULL,'"drvTITLE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ERPSPRINE2Z0','50','D','10','19',NULL,'member.1.employment.status',NULL,NULL,'"drvSTATUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ERPSPRINE2Z0','50','D','10','20',NULL,'member.1.employment.group',NULL,NULL,'"drvGROUP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ERPSPRINE2Z0','50','D','10','21',NULL,'member.1.employment.dept',NULL,NULL,'"drvDEPT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ERPSPRINE2Z0','50','D','10','22',NULL,'member.1.employment.comp1',NULL,NULL,'"drvCOMP1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ERPSPRINE2Z0','50','D','10','23',NULL,'member.1.employment.payfrequency',NULL,NULL,'"drvPAYFREQUENCY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ERPSPRINE2Z0','50','D','10','24',NULL,'member.1.relation',NULL,NULL,'"drvRELATION"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ERPSPRINE2Z0','50','D','10','25',NULL,'member.1.personal.benefit_status',NULL,NULL,'"drvBENEFIT_STATUS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ERPSPRINE2Z0','50','D','10','26',NULL,'member.1.employment.file',NULL,NULL,'"drvFILE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ERPSPRINE2Z0','50','D','10','27',NULL,'member.1.employment.benefit_classification',NULL,NULL,'"drvbenefit_classification"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ERPSPRINE2_20231120.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',6CU73,6CUOE,6CUX6,6CUTQ',NULL,NULL,NULL,'Principal Eben Census OnDemand','202305179','EMPEXPORT','ONDEM_XOE',NULL,'ERPSPRINE2',NULL,NULL,NULL,'202305179','Mar 16 2023  8:54AM','Mar 16 2023  8:54AM','202305111',NULL,'','','202305111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','6CU73,6CUOE,6CUX6,6CUTQ',NULL,NULL,NULL,'Principal Ebenefits Wed 6AM','207303319','EMPEXPORT','SCH_ERPSPR',NULL,'ERPSPRINE2',NULL,NULL,NULL,'202311159','Mar 16 2023  8:54AM','Mar 16 2023  8:54AM','202311081',NULL,'','','202212011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','6CU73,6CUOE,6CUX6,6CUTQ',NULL,NULL,NULL,'Principal Ebenefits Cens-Test','202305089','EMPEXPORT','TEST_XOE','May 15 2023 12:00AM','ERPSPRINE2',NULL,NULL,NULL,'202305089','May  8 2023 12:00AM','Dec 30 1899 12:00AM','202305081',NULL,'','','202305081',dbo.fn_GetTimedKey(),NULL,'us3mWaRPS5000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERPSPRINE2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERPSPRINE2','H01','dbo.U_ERPSPRINE2_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERPSPRINE2','D10','dbo.U_ERPSPRINE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ERPSPRINE2_Audit
-----------

IF OBJECT_ID('U_ERPSPRINE2_Audit') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audTerm] varchar(1) NOT NULL,
    [audTermdate] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_ERPSPRINE2_AuditFields
-----------

IF OBJECT_ID('U_ERPSPRINE2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ERPSPRINE2_drvTbl
-----------

IF OBJECT_ID('U_ERPSPRINE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLNAME] varchar(8000) NULL,
    [drvFNAME] varchar(100) NULL,
    [drvMNAME] varchar(1) NULL,
    [drvDOB] varchar(30) NULL,
    [drvGENDER] char(1) NULL,
    [drvEMAIL] varchar(50) NULL,
    [drvPERSONAL_EMAIL] varchar(50) NULL,
    [drvADDRESS1] varchar(8000) NULL,
    [drvADDRESS2] varchar(8000) NULL,
    [drvCITY] varchar(8000) NULL,
    [drvSTATE] varchar(8000) NULL,
    [drvZIP] varchar(8000) NULL,
    [drvrehiredate] varchar(30) NULL,
    [drvDOH] varchar(30) NULL,
    [drvDOT] varchar(30) NULL,
    [drvTERMREASON] varchar(11) NULL,
    [drvTITLE] varchar(8000) NULL,
    [drvSTATUS] char(1) NULL,
    [drvGROUP] varchar(8000) NULL,
    [drvDEPT] varchar(8000) NULL,
    [drvCOMP1] money NULL,
    [drvPAYFREQUENCY] varchar(8) NULL,
    [drvRELATION] varchar(1) NOT NULL,
    [drvBENEFIT_STATUS] varchar(1) NOT NULL,
    [drvFILE] char(9) NULL,
    [drvbenefit_classification] varchar(45) NULL
);

-----------
-- Create table U_ERPSPRINE2_EEList
-----------

IF OBJECT_ID('U_ERPSPRINE2_EEList') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ERPSPRINE2_File
-----------

IF OBJECT_ID('U_ERPSPRINE2_File') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ERPSPRINE2_Header
-----------

IF OBJECT_ID('U_ERPSPRINE2_Header') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_Header] (
    [drvtermreason] varchar(30) NOT NULL,
    [drvpayfrequency] varchar(32) NOT NULL,
    [drvbenefit_status] varchar(32) NOT NULL,
    [drvbenefit_classification] varchar(42) NOT NULL
);

-----------
-- Create table U_ERPSPRINE2_WorkingTbl
-----------

IF OBJECT_ID('U_ERPSPRINE2_WorkingTbl') IS NULL
CREATE TABLE [dbo].[U_ERPSPRINE2_WorkingTbl] (
    [PcfEEID] char(12) NULL,
    [PcfCode] nvarchar(4000) NULL,
    [PcfDesc] varchar(45) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERPSPRINE2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: RPSComposites

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 03/16/2023
Service Request Number: TekP-2023-01-20-01

Purpose: Principal Ebenefits Census TEST

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters		11/20/2023	   TekP-2023-09-25-01  Added Benefit calssification field that uses PCF field
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERPSPRINE2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERPSPRINE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERPSPRINE2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERPSPRINE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERPSPRINE2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERPSPRINE2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERPSPRINE2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERPSPRINE2', 'SCH_ERPSPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERPSPRINE2';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ERPSPRINE2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERPSPRINE2';

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
    DELETE FROM dbo.U_ERPSPRINE2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERPSPRINE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ERPSPRINE2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ERPSPRINE2_AuditFields;
    CREATE TABLE dbo.U_ERPSPRINE2_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ERPSPRINE2_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ERPSPRINE2_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ERPSPRINE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ERPSPRINE2_Audit;
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
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audTermdate = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecDateofTermination' AND ISNULL(audNewValue,'') = '' THEN audNewValue  END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ERPSPRINE2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ERPSPRINE2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN Dateadd(d, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ERPSPRINE2_Audit ON dbo.U_ERPSPRINE2_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ERPSPRINE2_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ERPSPRINE2_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_ERPSPRINE2_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_ERPSPRINE2_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_ERPSPRINE2_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    ---- Insert working PCF Table

        -- MW added 11/20/2023

    --- IF OBJECT_ID('U_ERPSPRINE2_WorkingTbl','U') IS NOT NULL
       
     DROP TABLE dbo.U_ERPSPRINE2_WorkingTbl;         SELECT DISTINCT         PcfEEID = EecEEID       ,PcfCode = Employment_BenefitClassification       ,PcfDesc = CASE WHEN CodDesc = 'Not Eligible for Benefits' THEN NULL ELSE CodDesc END         INTO dbo.U_ERPSPRINE2_WorkingTbl        FROM dbo.fn_MP_CustomFields_Empcomp_Export (NULL, NULL, NULL, NULL)       JOIN dbo.Codes WITH (NOLOCK)             ON CodCode = Employment_BenefitClassification             AND CodTable = 'CO_EXECUTIVEBENEFITS'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERPSPRINE2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERPSPRINE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERPSPRINE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eecempno
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvLNAME = Replace(EepNameLast,',', '')
        ,drvFNAME = EepNameFirst
        ,drvMNAME = Left(EepNameMiddle, 1)
        ,drvDOB = CONVERT(VARCHAR,EepDateOfBirth,101)--= Convert(varchar, EepDateOfBirth, 112)
        ,drvGENDER = EepGender
        ,drvEMAIL = EepAddressEMail
        ,drvPERSONAL_EMAIL = EepAddressEMailAlternate
        ,drvADDRESS1 = Replace(EepAddressLine1,',', '')
        ,drvADDRESS2 = Replace(EepAddressLine2,',', '')
        ,drvCITY = Replace(EepAddressCity,',', '')
        ,drvSTATE = Replace(EepAddressState,',', '')
        ,drvZIP = Replace(EepAddressZipCode,',', '')
        ,drvrehiredate = CASE WHEN EecDateofOriginalHire <> EecDateOfLastHire THEN CONVERT(VARCHAR,eecdateoflasthire,101) END
        ,drvDOH = CONVERT(VARCHAR,eecdateoflasthire,101)  --= Convert(varchar,eecdateoflasthire, 112)
        ,drvDOT = CONVERT(VARCHAR,eecdateoftermination,101)  --= Convert(varchar,eecdateoftermination, 112)
        ,drvTERMREASON = CASE WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'Involuntary' 
                              WHEN EecEmplStatus = 'T' AND EecTermType <> 'I' THEN 'Voluntary' END -- CASE WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN Replace (EecTermType,',','Involuntary') ELSE Replace (EecTermType,',','Voluntary') END --THEN Replace(TchDesc,',', '') END
        ,drvTITLE = Replace(JbcDesc,',', '')
        ,drvSTATUS = eecemplstatus
        ,drvGROUP = Replace(cmpcompanyname,',', '') ---'Full Structure Group'
        ,drvDEPT = Replace(OrgDesc,',', '')  --'Employee Department'
        ,drvCOMP1 = eecannsalary
        ,drvPAYFREQUENCY = CASE WHEN PgrPayFrequency = 'B' THEN 'Biweekly' 
                                WHEN PgrPayFrequency = 'W' THEN 'Weekly'
                            END
        ,drvRELATION = ''
        ,drvBENEFIT_STATUS = ''
        ,drvFILE = eecempno
        ,drvbenefit_classification = PcfDesc  --PfcDesc--'SEmployment'
    INTO dbo.U_ERPSPRINE2_drvTbl
    FROM dbo.U_ERPSPRINE2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    --JOIN dbo.U_dsi_BDM_ERPSPRINE2 WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON eeccoid = cmpcoid
    JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
     LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
     LEFT JOIN dbo.U_ERPSPRINE2_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    LEFT JOIN dbo.U_ERPSPRINE2_WorkingTbl WITH (NOLOCK) -- MW added 11/24/2023
        ON PcfEEID = XEEID
     WHERE  EecEEType = 'REG'
     AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audterm  = 'Y' ))
     and XCoID IN ('6CU73', '6CUOE', '6CUX6', '6CUTQ' )    
     and EepNameLast <> 'TEST9'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ERPSPRINE2_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ERPSPRINE2_Header;
    SELECT DISTINCT
         drvtermreason = 'member.1.employment.termreason'
        ,drvpayfrequency = 'member.1.employment.payfrequency'
        ,drvbenefit_status = 'member.1.personal.benefit_status'
        ,drvbenefit_classification = 'member.1.employment.benefit_classification'
    INTO dbo.U_ERPSPRINE2_Header
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
ALTER VIEW dbo.dsi_vwERPSPRINE2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ERPSPRINE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ERPSPRINE2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212011'
       ,expStartPerControl     = '202212011'
       ,expLastEndPerControl   = '202303169'
       ,expEndPerControl       = '202303169'
WHERE expFormatCode = 'ERPSPRINE2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERPSPRINE2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERPSPRINE2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ERPSPRINE2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ERPSPRINE2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ERPSPRINE2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERPSPRINE2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ERPSPRINE2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ERPSPRINE2', 'UseFileName', 'V', 'Y'


-- End ripout