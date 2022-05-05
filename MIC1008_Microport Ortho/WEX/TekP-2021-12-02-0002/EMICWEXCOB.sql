/**********************************************************************************

EMICWEXCOB: WEX COBRA

FormatCode:     EMICWEXCOB
Project:        WEX COBRA
Client ID:      MIC1008
Date/time:      2022-05-05 09:03:53.583
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB02
Database:       ULTIPRO_WPMICPT
Web Filename:   MIC1008_57A0E_EEHISTORY_EMICWEXCOB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMICWEXCOB_SavePath') IS NOT NULL DROP TABLE dbo.U_EMICWEXCOB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMICWEXCOB'


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
WHERE FormatCode = 'EMICWEXCOB'
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
WHERE ExpFormatCode = 'EMICWEXCOB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMICWEXCOB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMICWEXCOB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMICWEXCOB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMICWEXCOB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMICWEXCOB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMICWEXCOB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMICWEXCOB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMICWEXCOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMICWEXCOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMICWEXCOB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMICWEXCOB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMICWEXCOB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMICWEXCOB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMICWEXCOB];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBPLANMEMSP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBPLANMEMSP_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBPLAN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBPLAN_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBINSERTS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBINSERTS_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBEVENT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBEVENT_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBDEPPLAN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBDEPPLAN_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QBDEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QBDEP_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_QB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_QB_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_PDedHist];
GO
IF OBJECT_ID('U_EMICWEXCOB_NPM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_NPM_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_hdrTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_File') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_File];
GO
IF OBJECT_ID('U_EMICWEXCOB_FH_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_FH_hdrTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_EEList];
GO
IF OBJECT_ID('U_EMICWEXCOB_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_drvTbl_NPM];
GO
IF OBJECT_ID('U_EMICWEXCOB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_DedList];
GO
IF OBJECT_ID('U_EMICWEXCOB_CT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_CT_drvTbl];
GO
IF OBJECT_ID('U_EMICWEXCOB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_AuditFields];
GO
IF OBJECT_ID('U_EMICWEXCOB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMICWEXCOB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMICWEXCOB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMICWEXCOB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMICWEXCOB','WEX COBRA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EMICWEXCOBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL,'"drvEmployerCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXCOBZ0','50','H','01','7',NULL,'File Version',NULL,NULL,'"drvFileVersion"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','10','2',NULL,'Client Name',NULL,NULL,'"MicroPort Orthopedics Inc 41875"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"drvClientDivName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXCOBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXCOBZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXCOBZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXCOBZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXCOBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMICWEXCOBZ0','50','D','10','9',NULL,'Individual ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMICWEXCOBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMICWEXCOBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMICWEXCOBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMICWEXCOBZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMICWEXCOBZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMICWEXCOBZ0','50','D','10','17',NULL,'City',NULL,NULL,'"drvCityCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMICWEXCOBZ0','50','D','10','18',NULL,'State',NULL,NULL,'"drvStateState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMICWEXCOBZ0','50','D','10','19',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMICWEXCOBZ0','50','D','10','20',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMICWEXCOBZ0','50','D','10','21',NULL,'Home Phone',NULL,NULL,'"True"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMICWEXCOBZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMICWEXCOBZ0','50','D','10','23',NULL,'Work Phone Extension',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMICWEXCOBZ0','50','D','10','24',NULL,'Email Address',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMICWEXCOBZ0','50','D','10','25',NULL,'Username',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMICWEXCOBZ0','50','D','10','26',NULL,'Password',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMICWEXCOBZ0','50','D','10','27',NULL,'Hire Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMICWEXCOBZ0','50','D','10','28',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMICWEXCOBZ0','50','D','10','29',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMICWEXCOBZ0','50','D','10','30',NULL,'Tobacco Use',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMICWEXCOBZ0','50','D','10','31',NULL,'Payroll Frequency',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMICWEXCOBZ0','50','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMICWEXCOBZ0','50','D','10','33',NULL,'Participant Status',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMICWEXCOBZ0','50','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMICWEXCOBZ0','50','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMICWEXCOBZ0','50','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMICWEXCOBZ0','50','D','10','37',NULL,'Incur Services',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMICWEXCOBZ0','50','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMICWEXCOBZ0','50','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMICWEXCOBZ0','50','D','10','40',NULL,'HAS Custodian',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','20','3',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXCOBZ0','50','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXCOBZ0','50','D','20','5',NULL,'Employee SSN',NULL,NULL,'"drvEmpSSN"','(''UA''''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXCOBZ0','50','D','20','6',NULL,'Employee Name',NULL,NULL,'"drvEmpName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXCOBZ0','50','D','20','7',NULL,'Second Event',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXCOBZ0','50','D','30','4',NULL,'Number of Units',NULL,NULL,'""','(''SS''''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXCOBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXCOBZ0','50','D','40','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXCOBZ0','50','D','40','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXCOBZ0','50','D','40','7',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXCOBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMICWEXCOBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMICWEXCOBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMICWEXCOBZ0','50','D','40','11',NULL,'Add same as QB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMICWEXCOBZ0','50','D','40','13',NULL,'Address Line 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMICWEXCOBZ0','50','D','40','14',NULL,'Address Line 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMICWEXCOBZ0','50','D','40','17',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMICWEXCOBZ0','50','D','40','18',NULL,'State',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMICWEXCOBZ0','50','D','40','19',NULL,'Zip Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMICWEXCOBZ0','50','D','40','20',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMICWEXCOBZ0','50','D','40','21',NULL,'Enrollment Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMICWEXCOBZ0','50','D','40','22',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMICWEXCOBZ0','50','D','40','23',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMICWEXCOBZ0','50','D','40','24',NULL,'Is QMCSO',NULL,NULL,'"False"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"[QBSTATEINSERTS]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','60','2',NULL,'State Specific Doc',NULL,NULL,'"drvStateSpecific"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','70','1',NULL,'Record Type',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','70','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','70','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UNT2''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMICWEXCOBZ0','50','D','80','1',NULL,'Version Identifier',NULL,NULL,'"drvVersionLineIdentifier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMICWEXCOBZ0','50','D','80','2',NULL,'SSN"',NULL,NULL,'"drvSSN""','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMICWEXCOBZ0','50','D','80','3',NULL,'Individual Identifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMICWEXCOBZ0','50','D','80','4',NULL,'Client Name',NULL,NULL,'"MicroPort Orthopedics Inc 41875"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMICWEXCOBZ0','50','D','80','5',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMICWEXCOBZ0','50','D','80','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMICWEXCOBZ0','50','D','80','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMICWEXCOBZ0','50','D','80','8',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMICWEXCOBZ0','50','D','80','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMICWEXCOBZ0','50','D','80','10',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMICWEXCOBZ0','50','D','80','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMICWEXCOBZ0','50','D','80','12',NULL,'Phone 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMICWEXCOBZ0','50','D','80','13',NULL,'Address Line 1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMICWEXCOBZ0','50','D','80','14',NULL,'Address Line 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMICWEXCOBZ0','50','D','80','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMICWEXCOBZ0','50','D','80','16',NULL,'State',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMICWEXCOBZ0','50','D','80','17',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMICWEXCOBZ0','50','D','80','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMICWEXCOBZ0','50','D','80','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMICWEXCOBZ0','50','D','80','20',NULL,'UsesFamilyInAddress',NULL,NULL,'"drvUsesFamilyInAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMICWEXCOBZ0','50','D','80','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"drvHasWaivedAllCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMICWEXCOBZ0','50','D','80','22',NULL,'SendGRNotice',NULL,NULL,'"drvSendGRNotice"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMICWEXCOBZ0','50','D','80','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMICWEXCOB_20220505.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202112299','EMPEXPORT','OEACTIVE',NULL,'EMICWEXCOB',NULL,NULL,NULL,'202112299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202109011',NULL,'','','202109011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202112299','EMPEXPORT','OEPASSIVE',NULL,'EMICWEXCOB',NULL,NULL,NULL,'202112299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202109011',NULL,'','','202109011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX COBRA','202112299','EMPEXPORT','ONDEM_XOE',NULL,'EMICWEXCOB',NULL,NULL,NULL,'202112299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202109011',NULL,'','','202109011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX COBRA-Sched','202112299','EMPEXPORT','SCH_EMICWE',NULL,'EMICWEXCOB',NULL,NULL,NULL,'202112299','Dec 22 2021 12:57PM','Dec 22 2021 12:57PM','202109011',NULL,'','','202109011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','73Y89,7S10A,M5E06,70IXB',NULL,NULL,NULL,'WEX COBRA-Test','202112299','EMPEXPORT','TEST_XOE','Apr 20 2022 10:40AM','EMICWEXCOB',NULL,NULL,NULL,'202112299','Mar 29 2022 12:00AM','Dec 30 1899 12:00AM','202109011','70','','','202109011',dbo.fn_GetTimedKey(),NULL,'us3cPeMIC1008',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMICWEXCOB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','H01','dbo.U_EMICWEXCOB_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D10','dbo.U_EMICWEXCOB_QB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D20','dbo.U_EMICWEXCOB_QBEVENT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D30','dbo.U_EMICWEXCOB_QBPLAN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D40','dbo.U_EMICWEXCOB_QBDEP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D50','dbo.U_EMICWEXCOB_QBDEPPLAN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D60','dbo.U_EMICWEXCOB_QBINSERTS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D70','dbo.U_EMICWEXCOB_QBPLANMEMSP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMICWEXCOB','D80','dbo.U_EMICWEXCOB_NPM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMICWEXCOB
-----------

IF OBJECT_ID('U_dsi_BDM_EMICWEXCOB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMICWEXCOB] (
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
-- Create table U_EMICWEXCOB_Audit
-----------

IF OBJECT_ID('U_EMICWEXCOB_Audit') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_Audit] (
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
-- Create table U_EMICWEXCOB_AuditFields
-----------

IF OBJECT_ID('U_EMICWEXCOB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMICWEXCOB_CT_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_CT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_CT_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantId] char(11) NULL,
    [drvPlanName] varchar(22) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] varchar(21) NULL,
    [drvContributionAmount] numeric NULL,
    [drvTaxYear] varchar(7) NULL
);

-----------
-- Create table U_EMICWEXCOB_DedList
-----------

IF OBJECT_ID('U_EMICWEXCOB_DedList') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMICWEXCOB_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvActionCode] varchar(2) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvDependentSSN] varchar(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCobraEligible] varchar(1) NULL,
    [drvPhoneNumber] varchar(12) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvInitialNotificationCobra] varchar(1) NULL,
    [drvWaitingStartDate] datetime NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvQuallifingEventDate] datetime NULL,
    [drvLastPreCobraCovered] datetime NULL,
    [drvQuallifingEventType] varchar(2) NULL,
    [drvPlanName1] varchar(31) NULL,
    [drvPlanCovCode1] varchar(2) NULL,
    [drvPlanCovStart1] datetime NULL,
    [drvPlanName2] varchar(26) NULL,
    [drvPlanCovCode2] varchar(2) NULL,
    [drvPlanCovStart2] datetime NULL,
    [drvPlanName3] varchar(15) NULL,
    [drvPlanCovCode3] varchar(2) NULL,
    [drvPlanCovStart3] datetime NULL
);

-----------
-- Create table U_EMICWEXCOB_drvTbl_NPM
-----------

IF OBJECT_ID('U_EMICWEXCOB_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(12) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvVersionLineIdentifier] varchar(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(3) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddress1] nvarchar(258) NULL,
    [drvAddress2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvStateOrProvince] nvarchar(258) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvUsesFamilyInAddress] varchar(4) NOT NULL,
    [drvHasWaivedAllCoverage] varchar(5) NOT NULL,
    [drvSendGRNotice] varchar(4) NOT NULL,
    [drvHireDate] varchar(30) NULL
);

-----------
-- Create table U_EMICWEXCOB_EEList
-----------

IF OBJECT_ID('U_EMICWEXCOB_EEList') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMICWEXCOB_FH_hdrTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_FH_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_FH_hdrTbl] (
    [drvEmployerCode] varchar(9) NOT NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EMICWEXCOB_File
-----------

IF OBJECT_ID('U_EMICWEXCOB_File') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EMICWEXCOB_hdrTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_hdrTbl] (
    [drvEmployerCode] varchar(9) NOT NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_EMICWEXCOB_NPM_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_NPM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_NPM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] varchar(14) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvVersionLineIdentifier] varchar(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(3) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddress1] nvarchar(258) NULL,
    [drvAddress2] nvarchar(258) NULL,
    [drvCity] nvarchar(258) NULL,
    [drvStateOrProvince] nvarchar(258) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvUsesFamilyInAddress] varchar(4) NOT NULL,
    [drvHasWaivedAllCoverage] varchar(5) NOT NULL,
    [drvSendGRNotice] varchar(4) NOT NULL,
    [drvHireDate] varchar(30) NULL
);

-----------
-- Create table U_EMICWEXCOB_PDedHist
-----------

IF OBJECT_ID('U_EMICWEXCOB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCoID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
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
    [PdhSource8] numeric NULL
);

-----------
-- Create table U_EMICWEXCOB_QB_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] varchar(16) NULL,
    [drvClientDivName] varchar(3) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCityCity] varchar(255) NULL,
    [drvStateState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EMICWEXCOB_QBDEP_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBDEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBDEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(33) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSex] varchar(1) NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EMICWEXCOB_QBDEPPLAN_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBDEPPLAN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBDEPPLAN_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(33) NULL,
    [drvPlanName] varchar(41) NULL
);

-----------
-- Create table U_EMICWEXCOB_QBEVENT_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBEVENT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBEVENT_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvEmpNoSort] varchar(16) NOT NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollEffDate] datetime NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpName] varchar(201) NULL
);

-----------
-- Create table U_EMICWEXCOB_QBINSERTS_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBINSERTS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBINSERTS_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(16) NOT NULL,
    [drvStateSpecific] varchar(13) NULL
);

-----------
-- Create table U_EMICWEXCOB_QBPLAN_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBPLAN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBPLAN_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(16) NOT NULL,
    [drvPlanName] varchar(41) NULL,
    [drvCoverageLevel] varchar(11) NULL
);

-----------
-- Create table U_EMICWEXCOB_QBPLANMEMSP_drvTbl
-----------

IF OBJECT_ID('U_EMICWEXCOB_QBPLANMEMSP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMICWEXCOB_QBPLANMEMSP_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(16) NULL,
    [drvPlanName] varchar(7) NULL,
    [drvRate] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMICWEXCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Microport Orthopedics, Inc

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 12/22/2021
Service Request Number: TekP-2021-12-02-0002

Purpose: WEX COBRA

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMICWEXCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMICWEXCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMICWEXCOB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMICWEXCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMICWEXCOB' ORDER BY RunID DESC;

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108011'
       ,expStartPerControl     = '202108011'
       ,expLastEndPerControl   = '202112299'
       ,expEndPerControl       = '202112299'
WHERE expFormatCode = 'EMICWEXCOB';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXCOB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXCOB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXCOB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMICWEXCOB', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMICWEXCOB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMICWEXCOB', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate            DATETIME
            ,@PdhPayDate         DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMICWEXCOB';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

     -- Set @PdhPayDate to MAX Pay Date for File Header
    SET @PdhPayDate = (SELECT MAX(PrgPayDate) FROM dbo.PayReg WITH (NOLOCK) WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

     --Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMICWEXCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMICWEXCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMICWEXCOB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXCOB_AuditFields;
    CREATE TABLE dbo.U_EMICWEXCOB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpDed','eedBenStartDate');
    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpDed','eedBenOption');
    INSERT INTO dbo.U_EMICWEXCOB_AuditFields VALUES ('EmpDed','eedDedCode');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMICWEXCOB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXCOB_Audit;
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
    INTO dbo.U_EMICWEXCOB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMICWEXCOB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -10, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMICWEXCOB_Audit ON dbo.U_EMICWEXCOB_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EMICWEXCOB_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMICWEXCOB_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DNTAL, FSA, MED10, MED20, MEDHD, VIS, VISBU';

    IF OBJECT_ID('U_EMICWEXCOB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMICWEXCOB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMICWEXCOB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','DNTAL, FSA, MED10, MED20, MEDHD, VIS, VISBU');
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

        --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  --only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203,DEA'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS, DPC,STC'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

---====================================================
 --   -- Insert into BDM Reason code 200/203/DEA (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
		INSERT INTO [dbo].[U_dsi_BDM_EMICWEXCOB]
		(	[BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
		)
		Select Distinct 
            rectype = CASE WHEN ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, EdhDedCode, ConRelationship desc) = 1 THEN 'EMP' ELSE 'DEP' END
            ,EdhCoid
            ,EdhEEID
            ,consystemID
            ,consystemID
            ,'QB'
            ,'Data Inserted for 200/203 (Death)'
            ,ConRelationship
            ,ConDateOfBirth
            ,EdhDedCode
            ,EdhBenOption
            ,EdhBenStatus
            ,EdhBenStartDate
            ,EdhBenStopDate
            ,EdhBenStatusDate
            ,EecDateofTermination
            ,edhChangeReason
            ,EecTermReason
            ,EdhStartDate 
            ,EdhStopDate
            ,'Y'
            ,'Y'
            , ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, EdhDedCode, ConRelationship desc)
        FROM dbo.EmpHDed WITH (NOLOCK)  
        LEFT JOIN dbo.EmpComp WITH (NoLOCK)
			ON EecEEID = edheeid 
			AND EdhBenOption in ('EE1', 'EE2', 'EEC','EECH','EEF','EEF1', 'EES', 'EESPC', 'EESPCH')
			and EdhBenStopDate BETWEEN @startdate AND @enddate
        JOIN dbo.contacts WITH (NOLOCK)
			ON ConEEID = edheeid 
			AND ConRelationship in ('CHL','DIS', 'DPC','STC','DP','SPS')
        LEFT JOIN dbo.BenChRsn WITH (NOLOCK)
			ON EdhChangeReason = BchCode
			Where EdhChangeReason = '200' and EecTermReason in ('DEA','203') 
			AND EdhDedCode IN ('DNTAL', 'FSA', 'MED10', 'MED20', 'MEDHD', 'VIS', 'VISBU') 
			and EdhBenStatus = 'T'
        Order by dbo.EmpHDed.EdhEEID, dbo.EmpHDed.EdhDedCode, dbo.contacts.ConRelationship desc


 ---=======================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 ----======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EMICWEXCOB]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    SELECT Distinct 
			rectype = 'EMP'
			,EdhCoid
			,EdhEEID
			,DbnDepRecID
			,DbnDepRecID
			,'QB'
			,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
			,DbnRelationship
			,DbnDateOfBirth
			,EdhDedCode
			,DbnBenOption
			,DbnBenStatus
			,EdhBenStartDate
			--,EdhBenStopDate
			,DbnBenStopDate
			,EdhBenStatusDate
			,EdhEffDate
			,edhChangeReason
			,edhChangeReason
			,EdhStartDate
			,EdhStopDate
			,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
			,'Y'
			,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'EMICWEXCOB'
			WHERE edhChangeReason in ('204','LEVNT4') 
			AND DbnRelationShip = 'SPS'
			AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
			AND dbnValidForExport = 'N'
			AND DbnDedCode in ('DNTAL', 'FSA', 'MED10', 'MED20', 'MEDHD', 'VIS', 'VISBU')
			;
  ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 -- --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EMICWEXCOB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    Select distinct
        'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,'EE'
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
         ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EMICWEXCOB'
    WHERE edhChangeReason IN ('201','LEVNT3') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T'

----====================================================
 --   Insert into BDM Reason code 302 (Remove Dependent)
----====================================================

    INSERT INTO [dbo].[U_dsi_BDM_EMICWEXCOB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmSessionID]
    )
    Select Distinct rectype = 'EMP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 302 (Remove Dependent)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,edhEffDate
        ,edhEffDate
        ,edhChangeReason
        ,'302'
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
        ,'Y'
        ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EMICWEXCOB'
        WHERE edhChangeReason IN ('302') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND DbnBenStatus = 'T';

	 DELETE FROM dbo.U_dsi_BDM_EMICWEXCOB where bdmdedcode not in (Select dedcode from U_EMICWEXCOB_DedList)

    --==========================================
    -- Build Driver Tables
    --==========================================

        --------------------------------------------------------------------------------------------------------
        -- HEADER RECORD
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_hdrTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_hdrTbl;
        SELECT DISTINCT
             drvEmployerCode = '[Version]'
            ,drvFileVersion = '1.1'
        INTO dbo.U_EMICWEXCOB_hdrTbl
        FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
                ;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QB_drvTbl
        --    Note: For each QB record there must be a [QB], [QBEVENT], and [QBPLAN] record. 
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QB_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QB_drvTbl;
        SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + xEEID + ' 1'
            -- standard fields above and additional driver fields below
            ,drvClientDivName = CASE WHEN xCoID IN ('73Y89')    THEN 'MPI'
                                     WHEN xCoID IN ('70IXB')    THEN 'MPO'
                                     WHEN xCoID IN ('M5E06')    THEN 'CRM'
                                END   
            ,drvFirstName =		CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConNameFirst ELSE EepNameFirst END
            ,drvMiddleInitial = CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN LEFT(ConNameMiddle,1) else LEFT(EepNameMiddle,1) END
            ,drvLastName =		CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4')THEN ConNameLast ELSE EepNameLast END
            ,drvSSN =			CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConSSN ELSE eepSSN END
            ,drvAddressLine1 =	CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN REPLACE(conaddressline1,'PO Box', 'Post Office Box') else REPLACE(Eepaddressline1,'PO Box', 'Post Office Box') END
            ,drvAddressLine2 =	CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN Conaddressline2 ELSE Eepaddressline2 END
            ,drvCityCity =		CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConAddressCity ELSE  EepAddressCity END
            ,drvStateState =	CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConAddressState else EepAddressState END
            ,drvZipCode =		CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConAddressZipCode else EepAddressZipCode END
            ,drvSex =			CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN CASE WHEN ConGender in ('M','F') THEN ConGender ELSE 'U' END else CASE WHEN EepGender in ('M','F') THEN EepGender ELSE 'U' END END
            ,drvDOB =			CASE WHEN BdmCobraReason in ('201','203','204','210','DEA','LEVNT3','LEVNT4') THEN ConDateofBirth else EepDateofBirth END
        INTO dbo.U_EMICWEXCOB_QB_drvTbl
        FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                -- And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                --and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
			JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                AND bdmRunID = 'QB'
                AND BdmRecType = 'EMP'
            LEFT JOIN dbo.Contacts WITH (NOLOCK)
                ON consystemID = BdmSystemID
                ;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QBEVENT_drvTbl
        --    [QBEVENT] Record type used to identify QB’s qualifying event information
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBEVENT_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBEVENT_drvTbl;
        SELECT DISTINCT
             drvEEID = EecEEID
            ,drvCoID = EecCoID
            --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort ='1 ' + EecEEID + ' 2'
            -- standard fields above and additional driver fields below
            ,drvEventType = CASE    WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203','DEA') and EecTermType = 'V' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203','DEA') and EecTermType = '' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' and EecTermReason in ('203','DEA') THEN 'DEATH'
                                    WHEN EecEmplStatus = 'T' and EecTermReason in ('202','RET') THEN 'RETIREMENT'
                                    WHEN EecEmplStatus = 'T' and EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                                    WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                    WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                    WHEN BdmCobraReason in ( '204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN BdmCobraReason in ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN BdmCobraReason in ('203','202' ) THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN BdmCobraReason in ('206') THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                            END
            ,drvEventDate = CASE    WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203','DEA') THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'T' and EecTermReason in ('202','203','DEA')and BdmDateOfCOBRAEvent is null THEN EecDateOfTermination
                                    WHEN BdmCobraReason in ('LEVNT3', 'LEVNT4', '204', '210', '201') THEN BdmBenStatusDate
                                    else BdmDateOfCOBRAEvent
                             END
            ,drvEnrollEffDate =  Bdmbenstartdate
            ,drvEmpSSN =         EepSSN
            ,drvEmpName = EepNameFirst + ' ' + EepNameLast
        INTO dbo.U_EMICWEXCOB_QBEVENT_drvTbl
        FROM dbo.U_EMICWEXCOB_QB_drvTbl WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = drvEEID 
            AND EecCoID = drvCoID
        JOIN EmpPers WITH (NOLOCK)
            ON eepEEID = drvEEID
            JOIN (
                SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
                    ,MAX(BdmBenStartDate) AS BdmBenStartDate
                    ,MAX(BdmBenStopDate) AS BdmBenStopDate
                    ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
                    ,MAX(BdmDateOFCobraEvent) AS BdmDateOFCobraEvent
                    ,MAX(BdmCobraReason) AS BdmCobraReason
                    ,MAX(BdmChangeReason) AS BdmChangeReason
                    ,MAX(BdmIsPQB) AS BdmIsPQB
                    ,MAX(CASE WHEN BdmDedCode in ('DNTAL')  THEN BdmDedCode END) AS DedCode_DNTAL  
                    ,MAX(CASE WHEN BdmDedCode IN ('DNTAL')  THEN BdmBenStatusDate END) AS BdmBenStatusDate_DNTAL
                    ,MAX(CASE WHEN BdmDedCode in ('FSA')    THEN BdmDedCode END) AS DedCode_FSA
                    ,MAX(CASE WHEN BdmDedCode IN ('FSA')    THEN BdmBenStatusDate END) AS BdmBenStatusDate_FSA
                    ,MAX(CASE WHEN BdmDedCode in ('MED10')  THEN BdmDedCode END) AS DedCode_MED10
                    ,MAX(CASE WHEN BdmDedCode IN ('MED10')  THEN BdmBenStatusDate END) AS BdmBenStatusDate_MED10
                    ,MAX(CASE WHEN BdmDedCode in ('MED20')  THEN BdmDedCode END) AS DedCode_MED20
                    ,MAX(CASE WHEN BdmDedCode IN ('MED20')  THEN BdmBenStatusDate END) AS BdmBenStatusDate_MED20
                    ,MAX(CASE WHEN BdmDedCode in ('MEDHD')  THEN BdmDedCode END) AS DedCode_MEDHD
                    ,MAX(CASE WHEN BdmDedCode IN ('MEDHD')  THEN BdmBenStatusDate END) AS BdmBenStatusDate_MEDHD
                    ,MAX(CASE WHEN BdmDedCode in ('VIS')    THEN BdmDedCode END) AS DedCode_VIS
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS')    THEN BdmBenStatusDate END) AS BdmBenStatusDate_VIS
                    ,MAX(CASE WHEN BdmDedCode in ('VISBU')  THEN BdmDedCode END) AS DedCode_VISBU
                    ,MAX(CASE WHEN BdmDedCode IN ('VISBU')  THEN BdmBenStatusDate END) AS BdmBenStatusDate_VISBU
                FROM dbo.U_dsi_BDM_EMICWEXCOB  WITH (NOLOCK)
                    Where bdmRunID = 'QB' and bdmIsPQB = 'Y'
                GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
            )	AS BDM
				ON BdmEEID = drvEEID 
				AND BdmCoID = drvCoID
				;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QBPLAN_drvTbl
        --    [QBPLANINITIAL] Simplified record used to enter the plan and coverage level tied to the QB. 
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBPLAN_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBPLAN_drvTbl;
        SELECT DISTINCT
             drvEEID = bdmEEID
            ,drvCoID = BdmCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + EepEEID + ' 3'
            -- standard fields above and additional driver fields below
            --,drvParticipantId = EepSSN
            ,drvPlanName = CASE WHEN BdmDedCode = 'DNTAL' THEN 'Cigna Dental'
                                WHEN BdmDedCode = 'MED10' THEN 'Cigna Medical 1000 PPO'
                                WHEN BdmDedCode in ('MED20') THEN 'Cigna Medical 2000 PPO'
                                WHEN BdmDedCode in ('MEDHD') THEN 'Cigna Medical High Deductible Health Plan'
                                WHEN BdmDedCode in ('VIS') THEN 'Vision Base'
                                WHEN BdmDedCode in ('VISBU') THEN 'Vision Base & BuyUp'
                                WHEN DedCode_VISBU ='VISBU' AND DedCode_VIS = 'VIS' THEN 'Vision Base & BuyUp'
                                WHEN BdmDedCode in ('FSA') THEN 'WEX FSA'
                                END
            ,drvCoverageLevel = CASE	WHEN BdmCobraReason in ('203','DEA','204','LEVNT4','302') AND BdmBenOption in ('EE2','EESPCH','EEF') THEN 'EE+CHILDREN' 
										WHEN BdmCobraReason in ('203','DEA','204','LEVNT4','302') AND BdmBenOption in ('EE1') THEN 'EE+CHILD'
										ELSE
                                        CASE    WHEN BdmDedCode in ('DNTAL') and BdmBenOption = 'EE' THEN 'EE'
                                                WHEN BdmDedCode in ('DNTAL') and BdmBenOption ='EE1' THEN 'EE+1'
                                                WHEN BdmDedCode in ('DNTAL') and BdmBenOption ='EE2' THEN 'EE+FAMILY'

                                                WHEN BdmDedCode in ('VIS','VISBU') and BdmBenOption = 'EE' THEN 'EE'
                                                WHEN BdmDedCode in ('VIS','VISBU') and BdmBenOption in ('EE1','EES','EEC') THEN 'EE+1'
                                                WHEN BdmDedCode in ('VIS','VISBU') and BdmBenOption in ('EE2','EEF') THEN 'EE+FAMILY'

                                                WHEN BdmDedCode in ('MED10','MED20','MEDHD') and BdmBenOption = 'EE' THEN 'EE'
                                                WHEN BdmDedCode in ('MED10','MED20','MEDHD') and BdmBenOption = 'EEC' THEN 'EE+CHILD'
                                                WHEN BdmDedCode in ('MED10','MED20','MEDHD') and BdmBenOption = 'EECH' THEN 'EE+CHILDREN'
                                                WHEN BdmDedCode in ('MED10','MED20','MEDHD') and BdmBenOption in ( 'EES','EEDP') THEN 'EE+SPOUSE'
                                                WHEN BdmDedCode in ('MED10','MED20','MEDHD') and BdmBenOption in ( 'EEF','EEDPF','EESPCH','EESPC') THEN 'EE+FAMILY'
                                                WHEN BdmDedCode in ('FSA') THEN 'EE'
                                 END
                                 END
                    --Important Note
                    --When reporting Divorce, Death and Dep at Max Age Events use the logic below to send the correct value on the file for the dependent that is the QB
                    --If edhChangeReason = 204, LEVNT4, 201, LEVNT3 or 210 and 
                    --If bdmrelationship = DP, SPS, and 1 CHL, DIS, DPC, STC send EE+CHILD
                    --If bdmrelationship = DP, SPS and more than 1 CHL, DIS, DPC, STC send EE+CHILDREN
                    --If bdmrelationship = more than 1 CHL, DIS, DPC, STC send EE+CHILDREN
                    --else send EE  
            INTO dbo.U_EMICWEXCOB_QBPLAN_drvTbl
                FROM dbo.U_EMICWEXCOB_QB_drvTbl WITH (NOLOCK)
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = drvEEID
            LEFT JOIN (SELECT RecTypd = BdmRecType, EEID = BdmEEID, COID = BdmCOID, RECID = BdmDepRecId 
                    ,MAX(CASE WHEN BdmDedCode in ('VISBU') THEN BdmDedCode END) AS DedCode_VISBU  
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmDedCode END) AS DedCode_VIS
                FROM dbo.U_dsi_BDM_EMICWEXCOB  WITH (NOLOCK)
                    Where bdmRunID = 'QB' and bdmIsPQB = 'Y' and BdmDedCode in ('VISBU','VIS')
               GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId ) VISRECS
                ON EEID = drvEEID
                AND COID = drvCOID
			JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON bdmEEID = drvEEID
                AND bdmCOID = drvCOID
            LEFT JOIN (SELECT  NdpEEID    = BdmEEID
                            ,NdpDedCode = BdmDedCode
                            ,NdpNumDeps = COUNT(1)
                        FROM (SELECT DISTINCT BdmEEID, BdmDepRecID, BdmDedCode
                                FROM dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                                WHERE BdmIsPQB = 'N') NDEP
                        GROUP BY BdmEEID, BdmDedCode) NDP
                ON NdpEEID = BdmEEID
                AND NdpDedCode = BdmDedCode
                WHERE bdmRunID = 'QB' and bdmIsPQB = 'Y'
                ;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QBDEP_drvTbl
        --    [QBDEPENDENT] 
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBDEP_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBDEP_drvTbl;
        SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + xEEID + ' 4 ' + CASE WHEN  conrelationship in ('CHL', 'DIS', 'DPC', 'STC') THEN' 2' ELSE ' 1' END + BdmDepRecID + ' 1'  
            -- standard fields above and additional driver fields below
            ,drvSSN = conSSN
            ,drvRelationship = CASE WHEN conrelationship in ('CHL', 'DIS', 'DPC', 'STC') THEN 'CHILD'
                                    WHEN conrelationship ='SPS' THEN 'SPOUSE'
                                    WHEN conrelationship = 'DP' THEN 'DOMESTICPARTNER'
                                    END
            ,drvFirstName = conNameFirst
            ,drvMiddleInitial = LEFT(conNameMiddle,1)
            ,drvLastName = conNameLast
            ,drvSex = CASE WHEN conGender in ('M','F') THEN conGender ELSE 'U' END
            ,drvDOB = conDateofBirth
        INTO dbo.U_EMICWEXCOB_QBDEP_drvTbl
        FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                -- And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                --and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
           --JOIN dbo.EmpPers WITH (NOLOCK)
           --     ON EepEEID = xEEID
           JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                 AND bdmRunID = 'QB'
                 AND BdmRecType = 'DEP'
            LEFT JOIN dbo.CONTACTS WITH (NOLOCK)
                ON ConEEID = xEEID
                      AND ConSystemID = BdmDepRecID
                ;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QBDEPPLAN_drvTbl
        --    [QBDEPENDENTPLANINITIAL] Simplified record used to enter the QB’s dependent onto the applicable plan.
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBDEPPLAN_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBDEPPLAN_drvTbl;
        SELECT DISTINCT
             drvEEID = bdmEEID
            ,drvCoID = BdmCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + xEEID + ' 4 ' + CASE WHEN  conrelationship in ('CHL', 'DIS', 'DPC', 'STC') THEN' 2' ELSE ' 1' END + BdmDepRecID + ' 2'  
            -- standard fields above and additional driver fields below
            ,drvPlanName = CASE WHEN BdmDedCode = 'DNTAL' THEN 'Cigna Dental'
                                WHEN BdmDedCode = 'MED10' THEN 'Cigna Medical 1000 PPO'
                                WHEN BdmDedCode = 'MED20' THEN 'Cigna Medical 2000 PPO'
                                WHEN BdmDedCode = 'MEDHD' THEN 'Cigna Medical High Deductible Health Plan'
                                WHEN BdmDedCode = 'VIS'   THEN 'Vision Base'
                                WHEN BdmDedCode = 'VISBU' THEN 'Vision Base & BuyUp'
                                WHEN DedCode_VISBU ='VISBU' AND DedCode_VIS = 'VIS' THEN 'Vision Base & BuyUp'
                                --WHEN BdmDedCode in ('FSA') THEN 'WEX FSA'
                                END
            INTO dbo.U_EMICWEXCOB_QBDEPPLAN_drvTbl
            FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                -- And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                --and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
           --JOIN dbo.EmpPers WITH (NOLOCK)
           --     ON EepEEID = xEEID
            LEFT JOIN (SELECT RecTypd = BdmRecType, EEID = BdmEEID, COID = BdmCOID, RECID = BdmDepRecId 
                    ,MAX(CASE WHEN BdmDedCode in ('VISBU') THEN BdmDedCode END) AS DedCode_VISBU  
                    ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmDedCode END) AS DedCode_VIS
                FROM dbo.U_dsi_BDM_EMICWEXCOB  WITH (NOLOCK)
                    Where bdmRunID = 'QB' and bdmIsPQB = 'Y' and BdmRecType = 'DEP' AND BdmDedCode in ('VISBU','VIS')
               GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId ) VISRECS
                ON EEID =  EecEEID
           JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
				AND BdmCoID = xCoID
                AND bdmRunID = 'QB'
                AND BdmRecType = 'DEP'
            LEFT JOIN dbo.CONTACTS WITH (NOLOCK)
                ON ConEEID = xEEID
                AND ConSystemID = BdmDepRecID
                ;

        --------------------------------------------------------------------------------------------------------
            --    DETAIL RECORD - U_EMICWEXCOB_QBINSERTS_drvTbl
            --    [QBSTATEINSERTS] Record used to indicate a state that requires state specific documents 
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBINSERTS_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBINSERTS_drvTbl;
        SELECT DISTINCT
             drvEEID = bdmEEID
            ,drvCoID = BdmCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + EecEEID + ' 5'
            -- standard fields above and additional driver fields below
            ,drvStateSpecific = CASE    WHEN EepAddressState = 'CA' THEN 'CA-SRINSERT'
                                        WHEN EepAddressState = 'OR' THEN 'OR-SRINSERT'
                                        WHEN EepAddressState = 'NY' THEN 'NY-SR INSERT'
                                        WHEN EepAddressState = 'IL' THEN 'ILSRINSERT'
                                        WHEN EepAddressState = 'CT' THEN 'CT-SRINSERT'
                                        WHEN EepAddressState = 'TX' THEN 'TX-SRINSERT'
                                        WHEN EepAddressState = 'RI' THEN 'RI-SRINSERT'
                                        WHEN EepAddressState = 'GA' THEN 'GA-SRINSERT'
                                        WHEN EepAddressState = 'VA' THEN 'VA-SRINSERT'
                                        WHEN EepAddressState = 'MN' THEN 'MN-LIFEINSERT'
                                END
            INTO dbo.U_EMICWEXCOB_QBINSERTS_drvTbl
            FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
           JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
                AND EepAddressState in ('CA','OR','NY','IL','CT','TX','RI','GA','VA','MN')
           JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                AND bdmRunID = 'QB'
                AND BdmRecType = 'EMP'
                ;
         --------------------------------------------------------------------------------------------------------
            --    DETAIL RECORD - U_EMICWEXCOB_QBINSERTS_drvTbl
            --    [QBSTATEINSERTS] Record used to indicate a state that requires state specific documents 

            --NOTES:    If EE lives in MN 2 QBSTATEINSERTS records will be required on the file
            --            Else do not include the [QBSTATEINSERTS] line on employee record
         --------------------------------------------------------------------------------------------------------

            INSERT INTO dbo.U_EMICWEXCOB_QBINSERTS_drvTbl     
            SELECT DISTINCT
                 drvEEID = bdmEEID
                ,drvCoID = BdmCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvEmpNoSort = '1 ' + EecEEID + ' 5'
                -- standard fields above and additional driver fields below
                ,drvStateSpecific = CASE   WHEN EepAddressState = 'MN' THEN 'MN-CONTINSERT'
                                    END
            FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
           JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
                AND EepAddressState in ('MN')
           JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                AND bdmRunID = 'QB'
                AND BdmRecType = 'EMP'
                 ; 
        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_QBPLANMEMSP_drvTbl
        --    [QBPLANMEMBERSPECIFICRATEINITIAL] Simplified record used to enter a member specific rate for a plan.  
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_QBPLANMEMSP_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_QBPLANMEMSP_drvTbl;
        SELECT DISTINCT
             drvEEID = bdmEEID
            ,drvCoID = BdmCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvEmpNoSort = '1 ' + xEEID + ' 6'
            -- standard fields above and additional driver fields below
            ,drvPlanName = CASE When BdmDedCode = 'FSA' then 'WEX FSA' END
            ,drvRate = CASE When BdmDedCode = 'FSA' then (BdmEEAmt*26)/12 END
            --If eeddedcode = FSA, send EedEEAmt multiplied by 52 (weeks) and divided by 12 (months) 
        INTO dbo.U_EMICWEXCOB_QBPLANMEMSP_drvTbl
        FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
                And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
                and EXISTS (Select 1 from dbo.U_EMICWEXCOB_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
           JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
           JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                AND bdmRunID = 'QB'
                AND BdmRecType = 'EMP'
                AND BdmDedCode = 'FSA'
                ;

        --------------------------------------------------------------------------------------------------------
        --    DETAIL RECORD - U_EMICWEXCOB_NPM_drvTbl
        --    [NPM] New Plan Member
        --------------------------------------------------------------------------------------------------------

        IF OBJECT_ID('U_EMICWEXCOB_NPM_drvTbl','U') IS NOT NULL
            DROP TABLE dbo.U_EMICWEXCOB_NPM_drvTbl;
        SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvEmpNoSort = '2 ' + xEEID 
            --,drvSubSort = '1'+ eepSSN--'2' + eepSSN
            --,drvSubSort2 = ''
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            -- standard fields above and additional driver fields below
            ,drvVersionLineIdentifier = '[NPM]'
            ,drvSSN =				CASE	WHEN bdmRecType = 'EMP'		THEN eepSSN
											WHEN bdmRecType = 'DEP'		THEN conSSN
											END
            ,drvClientDivisionName = CASE	WHEN EecCoID IN ('73Y89')	THEN 'MPI'
                                            WHEN EecCoID IN ('70IXB')   THEN 'MPO'
                                            WHEN EecCoID IN ('M5E06')   THEN 'CRM'
											END     
            ,drvFirstName =			CASE	WHEN bdmRecType = 'EMP'		THEN EepNameFirst
											WHEN bdmRecType = 'DEP'		THEN ConNameFirst 
											END
            ,drvMiddleInitial =		CASE	WHEN bdmRecType = 'EMP'		THEN LEFT(EepNameMiddle,1)
											WHEN bdmRecType = 'DEP'		THEN LEFT(conNameMiddle,1) 
											END 
            ,drvLastName =			CASE	WHEN bdmRecType = 'EMP'		THEN EepNameLast
											WHEN bdmRecType = 'DEP'		THEN ConNameLast 
											END  
            ,drvAddress1 = QUOTENAME(CASE	WHEN bdmRecType = 'EMP'		THEN EepAddressLine1
											WHEN bdmRecType = 'DEP'		THEN ConAddressLine1  
											END,'"')
            ,drvAddress2 = QUOTENAME(CASE	WHEN bdmRecType = 'EMP'		THEN EepAddressLine2
											WHEN bdmRecType = 'DEP'		THEN ConAddressLine2  
											END,'"')
            ,drvCity =		QUOTENAME(CASE	WHEN bdmRecType = 'EMP'		THEN EepAddressCity
											WHEN bdmRecType = 'DEP'		THEN ConAddressCity  
											END ,'"')
            ,drvStateOrProvince = QUOTENAME(CASE WHEN bdmRecType = 'EMP'THEN EepAddressState
											WHEN bdmRecType = 'DEP'		THEN ConAddressState   
											END  ,'"')
            ,drvPostalCode =		CASE	WHEN bdmRecType = 'EMP' 	THEN EepAddressZipCode
											WHEN bdmRecType = 'DEP'		THEN ConAddressZipCode   
											END    
            ,drvSex =				CASE	WHEN bdmRecType = 'EMP'		THEN CASE WHEN EepGender in ('M','F') THEN EepGender ELSE 'U' END
											WHEN bdmRecType = 'DEP' THEN ConGender   
											END  
            ,drvUsesFamilyInAddress =  'TRUE'
            ,drvHasWaivedAllCoverage = 'FALSE'
            ,drvSendGRNotice = 'TRUE'
            ,drvHireDate = CONVERT(VARCHAR,EecDateOfLastHire,101)
        INTO dbo.U_EMICWEXCOB_NPM_drvTbl
        FROM dbo.U_EMICWEXCOB_EEList WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
        JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
        JOIN dbo.U_dsi_BDM_EMICWEXCOB WITH (NOLOCK)
            ON bdmEEID = xEEID
            AND bdmCOID = xCOID
        LEFT JOIN dbo.CONTACTS WITH (NOLOCK)
            ON ConEEID = xEEID
            AND ConSystemID = BdmDepRecID
            WHERE bdmRunID = 'NPM';
            ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_41875_MicroPort.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_41875_MicroPort.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMICWEXCOB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMICWEXCOB_File (NOLOCK)
    ORDER BY CASE WHEN InitialSort = '1' THEN '1' WHEN InitialSort = '9999' THEN '3' ELSE '2' END,  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMICWEXCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202201299'
       ,expEndPerControl       = '202201299'
WHERE expFormatCode = 'EMICWEXCOB';

--202201281    202201289
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMICWEXCOB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMICWEXCOB_File (NOLOCK)
    ORDER BY InitialSort;
    --ORDER BY CASE WHEN InitialSort = '1' THEN '1' WHEN InitialSort = '9999' THEN '3' ELSE '2' END,  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMICWEXCOB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMICWEXCOB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMICWEXCOB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXCOB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXCOB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMICWEXCOB', 'UseFileName', 'V', 'Y'


-- End ripout