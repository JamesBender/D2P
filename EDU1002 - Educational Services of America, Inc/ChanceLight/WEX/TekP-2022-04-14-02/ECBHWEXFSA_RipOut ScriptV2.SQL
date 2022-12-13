/**********************************************************************************

ECBHWEXFSA: WEX FSA, DEP Combined

FormatCode:     ECBHWEXFSA
Project:        WEX FSA, DEP Combined
Client ID:      EDU1002
Date/time:      2022-07-19 08:44:02.360
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E15
Server:         E1SUP5DB03
Database:       ULTIPRO_ESA
Web Filename:   EDU1002_99956_EEHISTORY_ECBHWEXFSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECBHWEXFSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECBHWEXFSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECBHWEXFSA'


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
WHERE FormatCode = 'ECBHWEXFSA'
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
WHERE ExpFormatCode = 'ECBHWEXFSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECBHWEXFSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECBHWEXFSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECBHWEXFSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECBHWEXFSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECBHWEXFSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECBHWEXFSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECBHWEXFSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECBHWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECBHWEXFSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECBHWEXFSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECBHWEXFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECBHWEXFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECBHWEXFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECBHWEXFSA];
GO
IF OBJECT_ID('U_ECBHWEXFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_Trailer];
GO
IF OBJECT_ID('U_ECBHWEXFSA_PT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_PT_drvTbl];
GO
IF OBJECT_ID('U_ECBHWEXFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_PDedHist];
GO
IF OBJECT_ID('U_ECBHWEXFSA_File') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_File];
GO
IF OBJECT_ID('U_ECBHWEXFSA_FH_Header') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_FH_Header];
GO
IF OBJECT_ID('U_ECBHWEXFSA_EN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_EN_drvTbl];
GO
IF OBJECT_ID('U_ECBHWEXFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_EEList];
GO
IF OBJECT_ID('U_ECBHWEXFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_DedList];
GO
IF OBJECT_ID('U_ECBHWEXFSA_CT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_CT_drvTbl];
GO
IF OBJECT_ID('U_ECBHWEXFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_AuditFields];
GO
IF OBJECT_ID('U_ECBHWEXFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECBHWEXFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECBHWEXFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECBHWEXFSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECBHWEXFSA','WEX FSA, DEP Combined','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECBHWEXFSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHWEXFSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL,'"FH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHWEXFSAZ0','3','H','01','4',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHWEXFSAZ0','6','H','01','8',NULL,'Employer Code',NULL,NULL,'"14329"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHWEXFSAZ0','1','H','01','15',NULL,'Synchronize Flag',NULL,NULL,'"N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHWEXFSAZ0','8','H','01','17',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHWEXFSAZ0','6','H','01','26',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UDHMS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHWEXFSAZ0','6','H','01','33',NULL,'File Version',NULL,NULL,'"3.5"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHWEXFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"PT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHWEXFSAZ0','50','D','10','4',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHWEXFSAZ0','20','D','10','55',NULL,'Employer Employee ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHWEXFSAZ0','15','D','10','76',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHWEXFSAZ0','30','D','10','92',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHWEXFSAZ0','30','D','10','123',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHWEXFSAZ0','1','D','10','154',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECBHWEXFSAZ0','1','D','10','156',NULL,'Gender',NULL,NULL,'"drvGenderGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECBHWEXFSAZ0','1','D','10','158',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECBHWEXFSAZ0','50','D','10','160',NULL,'Mothers Maiden Name',NULL,NULL,'"drvMothersName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECBHWEXFSAZ0','8','D','10','211',NULL,'Date Of Birth',NULL,NULL,'"drvDateBirth"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECBHWEXFSAZ0','9','D','10','220',NULL,'SSN',NULL,NULL,'"drvSSNSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECBHWEXFSAZ0','50','D','10','230',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECBHWEXFSAZ0','50','D','10','281',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECBHWEXFSAZ0','50','D','10','332',NULL,'Address Line 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECBHWEXFSAZ0','50','D','10','383',NULL,'Address Line 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECBHWEXFSAZ0','30','D','10','434',NULL,'City',NULL,NULL,'"drvCityCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECBHWEXFSAZ0','2','D','10','465',NULL,'State',NULL,NULL,'"drvStateState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECBHWEXFSAZ0','10','D','10','468',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECBHWEXFSAZ0','2','D','10','479',NULL,'Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECBHWEXFSAZ0','10','D','10','482',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECBHWEXFSAZ0','10','D','10','493',NULL,'Work Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECBHWEXFSAZ0','6','D','10','504',NULL,NULL,NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECBHWEXFSAZ0','125','D','10','511',NULL,NULL,NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECBHWEXFSAZ0','100','D','10','637',NULL,NULL,NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECBHWEXFSAZ0','100','D','10','738',NULL,NULL,NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECBHWEXFSAZ0','8','D','10','839',NULL,NULL,NULL,NULL,'"drvHireDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECBHWEXFSAZ0','100','D','10','848',NULL,'Division',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECBHWEXFSAZ0','2','D','10','949',NULL,'Hours Per Week',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECBHWEXFSAZ0','100','D','10','952',NULL,'Employee Class',NULL,NULL,'"All Eligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECBHWEXFSAZ0','100','D','10','1053',NULL,'Payroll Frequency',NULL,NULL,'"Bi-Weekly (B26)"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECBHWEXFSAZ0','8','D','10','1154',NULL,'Payroll Frequency Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECBHWEXFSAZ0','20','D','10','1163',NULL,'Participant Status',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECBHWEXFSAZ0','8','D','10','1184',NULL,'Status Effective Date',NULL,NULL,'"drvStatusDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECBHWEXFSAZ0','1','D','10','1193',NULL,'Hold Payroll Deductions',NULL,NULL,'"drvHoldPayrollDeductions"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECBHWEXFSAZ0','1','D','10','1195',NULL,'Hold Employer Contributions',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECBHWEXFSAZ0','1','D','10','1197',NULL,'Incur Services',NULL,NULL,'"drvIncurServices"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECBHWEXFSAZ0','8','D','10','1199',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayProcDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECBHWEXFSAZ0','8','D','10','1208',NULL,'Final Contribution Process Date',NULL,NULL,'"drvFinalContribProcDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECBHWEXFSAZ0','1','D','10','1217',NULL,'HAS Custodian',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECBHWEXFSAZ0','50','D','10','1219',NULL,'Medicare Beneficiary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECBHWEXFSAZ0','12','D','10','1270',NULL,'Medicare ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECBHWEXFSAZ0','50','D','10','1283',NULL,'Exchange Integration ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECBHWEXFSAZ0','100','D','10','1334',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECBHWEXFSAZ0','100','D','10','1435',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECBHWEXFSAZ0','100','D','10','1536',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECBHWEXFSAZ0','100','D','10','1637',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECBHWEXFSAZ0','20','D','10','1738',NULL,'CDD_Citizenship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECBHWEXFSAZ0','2','D','10','1759',NULL,'CDD_Country',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECBHWEXFSAZ0','20','D','10','1762',NULL,'CDD_EmploymentStatus',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECBHWEXFSAZ0','30','D','10','1783',NULL,'CDD_Employer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECBHWEXFSAZ0','30','D','10','1814',NULL,'CDD_JobTitle',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECBHWEXFSAZ0','8','D','10','1845',NULL,'Class Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECBHWEXFSAZ0','20','D','10','1854',NULL,'ID_Identification Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECBHWEXFSAZ0','30','D','10','1875',NULL,'ID_Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECBHWEXFSAZ0','2','D','10','1906',NULL,'ID_IssuingState',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECBHWEXFSAZ0','50','D','10','1909',NULL,'ID_Issuer',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECBHWEXFSAZ0','8','D','10','1960',NULL,'ID_IssueDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECBHWEXFSAZ0','8','D','10','1969',NULL,'ID_ExpirationDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECBHWEXFSAZ0','20','D','10','1978',NULL,'Mobile Carrier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECBHWEXFSAZ0','10','D','10','1999',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECBHWEXFSAZ0','15','D','10','2010',NULL,'Time Zone',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHWEXFSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHWEXFSAZ0','50','D','20','4',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHWEXFSAZ0','100','D','20','55',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHWEXFSAZ0','8','D','20','156',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollEffDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHWEXFSAZ0','8','D','20','165',NULL,'Participant Election Amount',NULL,NULL,'"drvParticipantAmount"','(''UNT2''''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHWEXFSAZ0','8','D','20','174',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEnrollTermDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHWEXFSAZ0','10','D','20','183',NULL,'Employer Contribution Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECBHWEXFSAZ0','8','D','20','194',NULL,'Employer Contribution Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECBHWEXFSAZ0','30','D','20','203',NULL,'Primary Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECBHWEXFSAZ0','30','D','20','234',NULL,'Alternate Reimbursement',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECBHWEXFSAZ0','1','D','20','265',NULL,'Enrolled In Claims Exchange',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECBHWEXFSAZ0','8','D','20','267',NULL,'Election Amount Indicator',NULL,NULL,'"drvElectionIndicator"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECBHWEXFSAZ0','6','D','20','276',NULL,'HDHP Coverage Level',NULL,NULL,'"drvHDHPLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECBHWEXFSAZ0','8','D','20','283',NULL,'Plan Year Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECBHWEXFSAZ0','1','D','20','292',NULL,'Terms and Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECBHWEXFSAZ0','8','D','20','294',NULL,'Date Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECBHWEXFSAZ0','6','D','20','303',NULL,'Time Terms Conditions Accepted',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECBHWEXFSAZ0','1','D','20','310',NULL,'Change Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECBHWEXFSAZ0','50','D','20','312',NULL,'Spend Down',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHWEXFSAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL,'"CT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHWEXFSAZ0','50','D','30','4',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHWEXFSAZ0','100','D','30','55',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHWEXFSAZ0','8','D','30','156',NULL,'Contribution Date',NULL,NULL,'"drvContributionDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHWEXFSAZ0','30','D','30','165',NULL,'Contribution Description',NULL,NULL,'"drvContributionDescription"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHWEXFSAZ0','9','D','30','196',NULL,'Contribution Amount',NULL,NULL,'"drvContributionAmount"','(''UNT2''''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHWEXFSAZ0','6','D','30','206',NULL,'Amount Type',NULL,NULL,'"Actual"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECBHWEXFSAZ0','7','D','30','213',NULL,'Tax Year',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHWEXFSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL,'"FF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHWEXFSAZ0','20','T','90','4',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHWEXFSAZ0','50','T','90','25',NULL,'Administrator Code',NULL,NULL,'"DBI"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHWEXFSAZ0','6','T','90','76',NULL,'Employer Code',NULL,NULL,'"14329"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHWEXFSAZ0','8','T','90','80',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHWEXFSAZ0','6','T','90','89',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UDHMS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECBHWEXFSA_20220719.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202206229','EMPEXPORT','OEACTIVE',NULL,'ECBHWEXFSA',NULL,NULL,NULL,'202206229','Jun  6 2022  3:17PM','Jun  6 2022  3:17PM','202205131',NULL,'','','202205131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202206229','EMPEXPORT','OEPASSIVE',NULL,'ECBHWEXFSA',NULL,NULL,NULL,'202206229','Jun  6 2022  3:17PM','Jun  6 2022  3:17PM','202205131',NULL,'','','202205131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA, DEP Combined','202206229','EMPEXPORT','ONDEM_XOE',NULL,'ECBHWEXFSA',NULL,NULL,NULL,'202206229','Jun  6 2022  3:17PM','Jun  6 2022  3:17PM','202205131',NULL,'','','202205131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX FSA, DEP Combined-Sched','202206229','EMPEXPORT','SCH_ECBHWE',NULL,'ECBHWEXFSA',NULL,NULL,NULL,'202206229','Jun  6 2022  3:17PM','Jun  6 2022  3:17PM','202205131',NULL,'','','202205131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','T5MPL,VL4LN,6ZJUE,6ZJZT,OAK08,MZXL6,3LMN2,EPR5N,VHGEP,6ZJYR,SODK4,6ZJXC,9YSCR',NULL,NULL,NULL,'WEX FSA, DEP Combined-Test','202206039','EMPEXPORT','TEST_XOE','Jul 15 2022 12:00AM','ECBHWEXFSA',NULL,NULL,NULL,'202206039','Jun  3 2022 12:00AM','Dec 30 1899 12:00AM','202206031',NULL,'eecPayGroup','ACE,CLIK,CORP,EAP,EDALTE,FLESA,GROW,OESADM,OES,PAYB,RAY,ROSSIE,SCI,SCEAST,WORK,WORKRP','202206031',dbo.fn_GetTimedKey(),NULL,'us3cPeEDU1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHWEXFSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHWEXFSA','H01','dbo.U_ECBHWEXFSA_FH_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHWEXFSA','D10','dbo.U_ECBHWEXFSA_PT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHWEXFSA','D20','dbo.U_ECBHWEXFSA_EN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHWEXFSA','D30','dbo.U_ECBHWEXFSA_CT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHWEXFSA','T90','dbo.U_ECBHWEXFSA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECBHWEXFSA
-----------

IF OBJECT_ID('U_dsi_BDM_ECBHWEXFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECBHWEXFSA] (
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
-- Create table U_ECBHWEXFSA_Audit
-----------

IF OBJECT_ID('U_ECBHWEXFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_Audit] (
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
-- Create table U_ECBHWEXFSA_AuditFields
-----------

IF OBJECT_ID('U_ECBHWEXFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECBHWEXFSA_CT_drvTbl
-----------

IF OBJECT_ID('U_ECBHWEXFSA_CT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_CT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantId] char(9) NULL,
    [drvPlanName] varchar(18) NULL,
    [drvContributionDate] datetime NULL,
    [drvContributionDescription] varchar(17) NULL,
    [drvContributionAmount] numeric NULL
);

-----------
-- Create table U_ECBHWEXFSA_DedList
-----------

IF OBJECT_ID('U_ECBHWEXFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECBHWEXFSA_EEList
-----------

IF OBJECT_ID('U_ECBHWEXFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECBHWEXFSA_EN_drvTbl
-----------

IF OBJECT_ID('U_ECBHWEXFSA_EN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_EN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantID] char(9) NULL,
    [drvPlanName] varchar(18) NULL,
    [drvEnrollEffDate] int NULL,
    [drvParticipantAmount] numeric NULL,
    [drvEnrollTermDate] datetime NULL,
    [drvElectionIndicator] varchar(8) NULL,
    [drvHDHPLevel] varchar(6) NULL
);

-----------
-- Create table U_ECBHWEXFSA_FH_Header
-----------

IF OBJECT_ID('U_ECBHWEXFSA_FH_Header') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_FH_Header] (
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(8000) NULL
);

-----------
-- Create table U_ECBHWEXFSA_File
-----------

IF OBJECT_ID('U_ECBHWEXFSA_File') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECBHWEXFSA_PDedHist
-----------

IF OBJECT_ID('U_ECBHWEXFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_PDedHist] (
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
    [PdhSource6] numeric NULL
);

-----------
-- Create table U_ECBHWEXFSA_PT_drvTbl
-----------

IF OBJECT_ID('U_ECBHWEXFSA_PT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_PT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(13) NULL,
    [drvParticipantID] char(9) NULL,
    [drvEmployeeNum] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGenderGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvMothersName] varchar(1) NOT NULL,
    [drvDateBirth] datetime NULL,
    [drvSSNSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCityCity] varchar(255) NULL,
    [drvStateState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusDate] datetime NULL,
    [drvHoldPayrollDeductions] varchar(1) NOT NULL,
    [drvIncurServices] varchar(1) NOT NULL,
    [drvFinalPayProcDate] datetime NULL,
    [drvFinalContribProcDate] datetime NULL,
    [drvMobileNumber] varchar(16) NULL
);

-----------
-- Create table U_ECBHWEXFSA_Trailer
-----------

IF OBJECT_ID('U_ECBHWEXFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECBHWEXFSA_Trailer] (
    [drvRecordCount] int NULL,
    [drvSubmittedDate] datetime NULL,
    [drvSubmittedTime] varchar(8000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECBHWEXFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChanceLight - Behavioral Health, Therapy & Education

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 06/06/2022
Service Request Number: TekP-2022-04-14-02

Purpose: WEX FSA, DEP Combined

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECBHWEXFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECBHWEXFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECBHWEXFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECBHWEXFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECBHWEXFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHWEXFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHWEXFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHWEXFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHWEXFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHWEXFSA', 'SCH_ECBHWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECBHWEXFSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECBHWEXFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECBHWEXFSA';

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

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECBHWEXFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECBHWEXFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECBHWEXFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_AuditFields;
    CREATE TABLE dbo.U_ECBHWEXFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECBHWEXFSA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECBHWEXFSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ECBHWEXFSA_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECBHWEXFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_Audit;
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
    INTO dbo.U_ECBHWEXFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECBHWEXFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECBHWEXFSA_Audit ON dbo.U_ECBHWEXFSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECBHWEXFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECBHWEXFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MFLEX, DFLEX, TRAN, TRANP, PARK, PARKP';

    IF OBJECT_ID('U_ECBHWEXFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECBHWEXFSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MFLEX, DFLEX, TRAN, TRANP, PARK, PARKP');
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCoID
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts MFLEX, DFLEX, TRAN, TRANP, PARK, PARKP
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('MFLEX') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('DFLEX') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('TRAN') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('TRANP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('PARK') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('PARKP') THEN PdhEECurAmt ELSE 0.00 END)
       
    INTO dbo.U_ECBHWEXFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECBHWEXFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCoID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECBHWEXFSA_PT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_PT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_PT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN + ' 1'
        -- standard fields above and additional driver fields below
        ,drvParticipantID = eecempno
        ,drvEmployeeNum = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGenderGender = CASE WHEN EepGender in ('M','F') THEN EepGender else  '' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus in ('S','M') THEN eepMaritalStatus else '' END
        ,drvMothersName = ''
        ,drvDateBirth = Eepdateofbirth
        ,drvSSNSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = Eepaddressline2
        ,drvCityCity = EepAddressCity
        ,drvStateState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfOriginalHire
        ,drvParticipantStatus = CASE WHEN EecEmplStatus = 'T' THEN 'Terminated' 
                                     WHEN EecEmplStatus = 'L' THEN 'LOA'
                                     ELSE 'Active' 
                                END
        ,drvStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateofTermination 
                              WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                              WHEN EecEmplStatus = 'A' AND EshEmplStatus = 'L' THEN EshStatusStopDate
                              ELSE EecDateOfLastHire END
        ,drvHoldPayrollDeductions = CASE WHEN EecEmplStatus = 'L' THEN 'N' ELSE '' END
        ,drvIncurServices = CASE WHEN EecEmplStatus = 'L' THEN 'Y' ELSE '' END
        ,drvFinalPayProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(Day, 30, EecDateofTermination) END
        ,drvFinalContribProcDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(Day, 30, EecDateofTermination) END
        ,drvMobileNumber = dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL')
    INTO dbo.U_ECBHWEXFSA_PT_drvTbl
    FROM dbo.U_ECBHWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECBHWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
           LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
    LEFT JOIN dbo.U_ECBHWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND AudFieldName  = 'eecemplstatus' 
        AND AudNewValue = 'T'
    LEFT JOIN dbo.U_ECBHWEXFSA_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
            LEFT JOIN (SELECT eshEEID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
            FROM EmpHStat
            WHERE EshEmplStatus = 'L'
            GROUP BY eshEEID, EshEmplStatus) AS esh
        ON eshEEID = xEEID
    WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
            OR (ISNULL(PdhSource1, 0.00) > 0.00
                OR ISNULL(PdhSource2, 0.00) > 0.00
                OR ISNULL(PdhSource3, 0.00) > 0.00
                OR ISNULL(PdhSource4, 0.00) > 0.00
                OR ISNULL(PdhSource5, 0.00) > 0.00
                OR ISNULL(PdhSource6, 0.00) > 0.00
                )

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECBHWEXFSA_EN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_EN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_EN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort =  EepSSN + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticipantID = eecempno
        ,drvPlanName = CASE WHEN BdmDedCode = 'MFLEX' THEN 'Medical FSA'
                            WHEN BdmDedCode = 'DFLEX' THEN 'Dependent Care FSA'
                            WHEn BdmDedCode IN ('TRAN', 'TRANP') THEN 'Mass Transit'
                            WHEN BdmDedCode IN ('PARK',' PARKP') THEN  'Parking'
                        END
        ,drvEnrollEffDate = CASE WHEN BdmDedCode IN ( 'MFLEX', 'DFLEX', 'TRAN', 'TRANP', 'PARK', 'PARKP') THEN  '0101'+ CONVERT(VARCHAR(4), CASE WHEN DATEPART(YEAR, GETDATE() ) < 2022 THEN '2022' ELSE DATEPART(YEAR, GETDATE()) END ) 
                                 WHEN BdmDedCode IN ( 'MFLEX', 'DFLEX') THEN DATEPART(YEAR, GETDATE()) 
                                END

        ,drvParticipantAmount = CASE WHEN BdmDedCode in ('MFLEX', 'DFLEX', 'TRAN', 'TRANP', 'PARK', 'PARKP') THEN BdmEEGoalAmt 
                                     WHEN BdmDedCode in ('TRAN', 'TRANP', 'PARK', 'PARKP') AND (isnull(BdmEEGoalAmt,'') = '' or BdmEEGoalAmt  = 0.00) THEN 1.00 
                                    END
        ,drvEnrollTermDate = CASE WHEN EecEmplStatus <> 'T' and BdmDedCode in ('MFLEX', 'DFLEX', 'TRAN', 'TRANP', 'PARK', 'PARKP') THEN bdmbenstopdate END
        ,drvElectionIndicator = CASE WHEN BdmDedCode in ('TRAN', 'TRANP', 'PARK', 'PARKP') THEN 'PerMonth'
                                     WHEN BdmDedCode IN ( 'MFLEX', 'DFLEX') THEN ''
                                    END
        ,drvHDHPLevel = CASE WHEN BdmDedCode in ('HSACF','HSAF') THEN 'Family' 
                             WHEN BdmDedCode in ('HSA','HSACI', 'HSAI') THEN 'Single' 
                             END
    INTO dbo.U_ECBHWEXFSA_EN_drvTbl
    FROM dbo.U_ECBHWEXFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECBHWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        LEFT JOIN dbo.U_ECBHWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND AudFieldName  = 'eecemplstatus' 
        AND AudNewValue = 'T'
    LEFT JOIN dbo.U_ECBHWEXFSA_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
        OR (ISNULL(PdhSource1, 0.00) > 0.00
                OR ISNULL(PdhSource2, 0.00) > 0.00
                OR ISNULL(PdhSource3, 0.00) > 0.00
                OR ISNULL(PdhSource4, 0.00) > 0.00
                OR ISNULL(PdhSource5, 0.00) > 0.00
                OR ISNULL(PdhSource6, 0.00) > 0.00
               
                )
    ;
   
    ---------------------------------
    -- DETAIL RECORD - U_ECBHWEXFSA_CT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_CT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_CT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN + ' 2'
        -- standard fields above and additional driver fields below
        ,drvParticipantId = eecempno
        ,drvPlanName = CASE WHEN PdhDedCode = 'MFLEX' THEN 'Medical FSA'
                            WHEN PdhDedCode = 'DFLEX' THEN 'Dependent Care FSA'
                            WHEn PdhDedCode IN ('TRAN', 'TRANP') THEN 'Mass Transit'
                            WHEN PdhDedCode IN ('PARK',' PARKP') THEN  'Parking'
                        END
        ,drvContributionDate = @PdhPayDate
        ,drvContributionDescription = CASE WHEN PdhDedCode IN ( 'MFLEX', 'DFLEX', 'TRAN', 'TRANP', 'PARK', 'PARKP') THEN 'Payroll Deduction' END
        ,drvContributionAmount =  CASE WHEN PdhDedCode = 'MFLEX' AND PdhSource1 > 0 THEN PdhSource1  
                                       WHEN PdhDedCode = 'DFLEX' AND PdhSource2 > 0 THEN PdhSource2  
                                       WHEN PdhDedCode = 'TRAN'  AND PdhSource3 > 0 THEN PdhSource3  
                                       WHEN PdhDedCode = 'TRANP' AND PdhSource4 > 0 THEN PdhSource4  
                                       WHEN PdhDedCode = 'PARK'  AND PdhSource5 > 0 THEN PdhSource5 
                                       WHEN PdhDedCode = 'PARKP' AND PdhSource6 > 0 THEN PdhSource6
                                      END
    INTO dbo.U_ECBHWEXFSA_CT_drvTbl
    FROM dbo.U_ECBHWEXFSA_EEList WITH (NOLOCK)
   JOIN dbo.U_ECBHWEXFSA_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = pdhEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECBHWEXFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECBHWEXFSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND AudFieldName  = 'eecemplstatus' 
        AND AudNewValue = 'T'    
    WHERE (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL))
        OR (ISNULL(PdhSource1, 0.00) > 0.00
                OR ISNULL(PdhSource2, 0.00) > 0.00
                OR ISNULL(PdhSource3, 0.00) > 0.00
                OR ISNULL(PdhSource4, 0.00) > 0.00
                OR ISNULL(PdhSource5, 0.00) > 0.00
                OR ISNULL(PdhSource6, 0.00) > 0.00
                )
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_FH_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_FH_Header;
    SELECT DISTINCT
         drvSubmittedDate = @RunDate
        ,drvSubmittedTime = REPLACE(CONVERT(VARCHAR(8),@RunDate,108),':',SPACE(0))
    INTO dbo.U_ECBHWEXFSA_FH_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECBHWEXFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHWEXFSA_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM  dbo.U_ECBHWEXFSA_PT_drvTbl) + (SELECT COUNT(*) FROM dbo.U_ECBHWEXFSA_EN_drvTbl) + (SELECT COUNT(*) FROM dbo.U_ECBHWEXFSA_CT_drvTbl)
        ,drvSubmittedDate =  @RunDate
        ,drvSubmittedTime = REPLACE(CONVERT(VARCHAR(8),@RunDate,108),':',SPACE(0))
    INTO dbo.U_ECBHWEXFSA_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
   IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_14329_ChanceLight.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_14329_ChanceLight.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECBHWEXFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECBHWEXFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECBHWEXFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202205131'
       ,expStartPerControl     = '202205131'
       ,expLastEndPerControl   = '202206229'
       ,expEndPerControl       = '202206229'
WHERE expFormatCode = 'ECBHWEXFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECBHWEXFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECBHWEXFSA_File WITH (NOLOCK)
  ORDER BY CASE WHEN InitialSort = '1' THEN '1' WHEN InitialSort = '9999' THEN '3' ELSE '2' END,  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECBHWEXFSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECBHWEXFSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECBHWEXFSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECBHWEXFSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECBHWEXFSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECBHWEXFSA', 'UseFileName', 'V', 'Y'


-- End ripout