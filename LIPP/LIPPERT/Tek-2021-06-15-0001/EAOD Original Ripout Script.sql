/**********************************************************************************

EAOD: AOD Changes Export

FormatCode:     EAOD
Project:        AOD Changes Export
Client ID:      LIP1000
Date/time:      2021-12-16 06:06:05.867
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N12
Server:         N1SUP2DB51
Database:       ULTIPRO_LIPP
Web Filename:   LIP1000_VT9GM_EEHISTORY_EAOD_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAOD_SavePath') IS NOT NULL DROP TABLE dbo.U_EAOD_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAOD'


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
WHERE FormatCode = 'EAOD'
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
WHERE ExpFormatCode = 'EAOD'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAOD')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAOD'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAOD'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAOD'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAOD'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAOD'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAOD'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAOD'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAOD'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAOD'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAOD_V2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAOD_V2_Export];
GO
IF OBJECT_ID('dsi_vwEAOD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAOD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAOD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAOD];
GO
IF OBJECT_ID('U_EAOD_V2_File') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_File];
GO
IF OBJECT_ID('U_EAOD_V2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_EEList];
GO
IF OBJECT_ID('U_EAOD_V2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_drvTbl];
GO
IF OBJECT_ID('U_EAOD_V2_drvJobDt') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_drvJobDt];
GO
IF OBJECT_ID('U_EAOD_V2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_AuditFields];
GO
IF OBJECT_ID('U_EAOD_V2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAOD_V2_Audit];
GO
IF OBJECT_ID('U_EAOD_File') IS NOT NULL DROP TABLE [dbo].[U_EAOD_File];
GO
IF OBJECT_ID('U_EAOD_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAOD_EEList];
GO
IF OBJECT_ID('U_EAOD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAOD_drvTbl];
GO
IF OBJECT_ID('U_EAOD_drvJobDt') IS NOT NULL DROP TABLE [dbo].[U_EAOD_drvJobDt];
GO
IF OBJECT_ID('U_EAOD_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAOD_AuditFields];
GO
IF OBJECT_ID('U_EAOD_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAOD_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAOD','AOD Changes Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EAOD000000Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAOD000000Z0','50','H','01','1',NULL,'Last',NULL,NULL,'"Last"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAOD000000Z0','50','H','01','2',NULL,'First',NULL,NULL,'"First"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAOD000000Z0','50','H','01','3',NULL,'Emplid',NULL,NULL,'"Emplid"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAOD000000Z0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAOD000000Z0','50','H','01','5',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAOD000000Z0','50','H','01','6',NULL,'Active Stat',NULL,NULL,'"Active Stat"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAOD000000Z0','50','H','01','7',NULL,'Hire Date or Rehire',NULL,NULL,'"Hire Date or Rehire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAOD000000Z0','50','H','01','8',NULL,'Street',NULL,NULL,'"Street"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAOD000000Z0','50','H','01','9',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAOD000000Z0','50','H','01','10',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAOD000000Z0','50','H','01','11',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAOD000000Z0','50','H','01','12',NULL,'Paygroup',NULL,NULL,'"Paygroup"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAOD000000Z0','50','H','01','13',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAOD000000Z0','50','H','01','14',NULL,'Badge',NULL,NULL,'"Badge"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAOD000000Z0','50','H','01','15',NULL,'Home phone',NULL,NULL,'"Home phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAOD000000Z0','50','H','01','16',NULL,'WG3',NULL,NULL,'"WG3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAOD000000Z0','50','H','01','17',NULL,'Labor',NULL,NULL,'"Labor"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAOD000000Z0','50','H','01','18',NULL,'Shift',NULL,NULL,'"Shift"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAOD000000Z0','50','H','01','19',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAOD000000Z0','50','H','01','20',NULL,'Rate Date',NULL,NULL,'"Rate Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAOD000000Z0','50','H','01','21',NULL,'Birthdate',NULL,NULL,'"Birthdate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAOD000000Z0','50','H','01','22',NULL,'Production Line',NULL,NULL,'"Production Line"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAOD000000Z0','50','H','01','23',NULL,'File Number',NULL,NULL,'"File Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAOD000000Z0','50','H','01','24',NULL,'Plant/conf',NULL,NULL,'"Plant/conf"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAOD000000Z0','50','H','01','25',NULL,'Employee Classification',NULL,NULL,'"Employee Classification"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAOD000000Z0','50','H','01','26',NULL,'Work Group Date',NULL,NULL,'"Work Group Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAOD000000Z0','50','H','01','27',NULL,'DOC',NULL,NULL,'"DOC"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAOD000000Z0','50','H','01','28',NULL,'Seniority Date',NULL,NULL,'"Seniority Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAOD000000Z0','50','H','01','29',NULL,'Agency',NULL,NULL,'"Agency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAOD000000Z0','50','H','01','30',NULL,'Pay Type',NULL,NULL,'"Pay Type "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAOD000000Z0','50','H','01','31',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAOD000000Z0','50','D','10','1',NULL,'Last',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAOD000000Z0','50','D','10','2',NULL,'First',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAOD000000Z0','50','D','10','3',NULL,'Emplid',NULL,NULL,'"drvEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAOD000000Z0','50','D','10','4',NULL,'SSN',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAOD000000Z0','50','D','10','5',NULL,'Department',NULL,NULL,'"drvOrgLvl1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAOD000000Z0','50','D','10','6',NULL,'Active Stat',NULL,NULL,'"drvEmplStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAOD000000Z0','50','D','10','7',NULL,'Hire Date or Rehire',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAOD000000Z0','50','D','10','8',NULL,'Street',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAOD000000Z0','50','D','10','9',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAOD000000Z0','50','D','10','10',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAOD000000Z0','50','D','10','11',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAOD000000Z0','50','D','10','12',NULL,'Paygroup',NULL,NULL,'"drvCompanyCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAOD000000Z0','50','D','10','13',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAOD000000Z0','50','D','10','14',NULL,'Badge',NULL,NULL,'"drvTimeclockID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAOD000000Z0','50','D','10','15',NULL,'Home phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAOD000000Z0','50','D','10','16',NULL,'WG3',NULL,NULL,'"drvJobCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAOD000000Z0','50','D','10','17',NULL,'Labor',NULL,NULL,'"drvOrgLvl2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAOD000000Z0','50','D','10','18',NULL,'Shift',NULL,NULL,'"drvShift"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAOD000000Z0','50','D','10','19',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyPayRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAOD000000Z0','50','D','10','20',NULL,'Rate Date',NULL,NULL,'"drvJobEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAOD000000Z0','50','D','10','21',NULL,'Birthdate',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAOD000000Z0','50','D','10','22',NULL,'Production Line',NULL,NULL,'"drvOrgLvl3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAOD000000Z0','50','D','10','23',NULL,'File Number',NULL,NULL,'"drvEecEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAOD000000Z0','50','D','10','24',NULL,'Plant/conf',NULL,NULL,'"drvPayGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAOD000000Z0','50','D','10','25',NULL,'Employee Classification',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAOD000000Z0','50','D','10','26',NULL,'Work Group Date',NULL,NULL,'"drvEjhJobEffDate "','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAOD000000Z0','50','D','10','27',NULL,'DOC',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAOD000000Z0','50','D','10','28',NULL,'Seniority Date',NULL,NULL,'"drvDateOfSeniority"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAOD000000Z0','50','D','10','29',NULL,'Agency',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAOD000000Z0','50','D','10','30',NULL,'Pay Type',NULL,NULL,'"drvEecSalaryOrHourly"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAOD000000Z0','50','D','10','31',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAOD_20211216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Changes Only','202107249','EMPEXPORT','CHGS_XOE','Jul 24 2021 12:03AM','EAOD',NULL,NULL,NULL,'202107249','Jul 24 2021 12:00AM','Dec 30 1899 12:00AM','202107231','125','','','202107231',dbo.fn_GetTimedKey(),NULL,'us3jReLIP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',8Z3ZJ,DAJY5,9QTBK,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Full File','202008139','EMPEXPORT','FULL_XOE',NULL,'EAOD',NULL,NULL,NULL,'202008139','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',8Z3ZJ,DAJY5,9QTBK,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Test Full File','202008139','EMPEXPORT','TEST_XOE',NULL,'EAOD',NULL,NULL,NULL,'202008139','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 8AM','202008139','EMPEXPORT','SCHEDU8AM',NULL,'EAOD',NULL,NULL,NULL,'202112159','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202112141',NULL,'','','202008131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 11AM','202008139','EMPEXPORT','SCHEDUL11A',NULL,'EAOD',NULL,NULL,NULL,'202112159','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202112141',NULL,'','','202008131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 2PM','202008139','EMPEXPORT','SCHEDUL2PM',NULL,'EAOD',NULL,NULL,NULL,'202112159','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202112141',NULL,'','','202008131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 5PM','202008139','EMPEXPORT','SCHEDUL5PM',NULL,'EAOD',NULL,NULL,NULL,'202112159','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202112141',NULL,'','','202008131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 9PM','202008139','EMPEXPORT','SCHEDULED',NULL,'EAOD',NULL,NULL,NULL,'202112159','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202112141',NULL,'','','202008131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAOD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAOD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAOD','InitialSort','C','drvEmpNo');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAOD','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAOD','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAOD','D10','dbo.U_EAOD_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EAOD_Audit
-----------

IF OBJECT_ID('U_EAOD_Audit') IS NULL
CREATE TABLE [dbo].[U_EAOD_Audit] (
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
-- Create table U_EAOD_AuditFields
-----------

IF OBJECT_ID('U_EAOD_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAOD_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAOD_drvJobDt
-----------

IF OBJECT_ID('U_EAOD_drvJobDt') IS NULL
CREATE TABLE [dbo].[U_EAOD_drvJobDt] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [JobDt] datetime NULL
);

-----------
-- Create table U_EAOD_drvTbl
-----------

IF OBJECT_ID('U_EAOD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAOD_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvEmpNo] char(9) NULL,
    [drvOrgLvl1] varchar(8000) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCompanyCode] varchar(8000) NULL,
    [drvLocation] varchar(8000) NULL,
    [drvTimeclockID] char(12) NULL,
    [drvPhoneHomeNumber] varchar(14) NULL,
    [drvJobCode] varchar(8000) NULL,
    [drvOrgLvl2] varchar(8000) NULL,
    [drvShift] varchar(8000) NULL,
    [drvHourlyPayRate] varchar(20) NULL,
    [drvJobEffDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvOrgLvl3] varchar(8000) NULL,
    [drvEecEmpNo] char(9) NULL,
    [drvPayGroup] varchar(8000) NULL,
    [drvEjhJobEffDate] datetime NULL,
    [drvDateOfSeniority] datetime NULL,
    [drvEecSalaryOrHourly] char(1) NULL,
    [drvNameMiddle] varchar(1) NULL
);

-----------
-- Create table U_EAOD_EEList
-----------

IF OBJECT_ID('U_EAOD_EEList') IS NULL
CREATE TABLE [dbo].[U_EAOD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAOD_File
-----------

IF OBJECT_ID('U_EAOD_File') IS NULL
CREATE TABLE [dbo].[U_EAOD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAOD_V2_Audit
-----------

IF OBJECT_ID('U_EAOD_V2_Audit') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EAOD_V2_AuditFields
-----------

IF OBJECT_ID('U_EAOD_V2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAOD_V2_drvJobDt
-----------

IF OBJECT_ID('U_EAOD_V2_drvJobDt') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_drvJobDt] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [JobDt] datetime NULL
);

-----------
-- Create table U_EAOD_V2_drvTbl
-----------

IF OBJECT_ID('U_EAOD_V2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvEmpNo] char(9) NULL,
    [drvOrgLvl1] varchar(8000) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCompanyCode] varchar(8000) NULL,
    [drvLocation] varchar(8000) NULL,
    [drvTimeclockID] char(12) NULL,
    [drvPhoneHomeNumber] varchar(14) NULL,
    [drvJobCode] varchar(8000) NULL,
    [drvOrgLvl2] varchar(8000) NULL,
    [drvShift] varchar(8000) NULL,
    [drvHourlyPayRate] varchar(20) NULL,
    [drvJobEffDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvOrgLvl3] varchar(8000) NULL,
    [drvEecEmpNo] char(9) NULL,
    [drvPayGroup] varchar(8000) NULL,
    [drvEjhJobEffDate] datetime NULL,
    [drvDateOfSeniority] datetime NULL,
    [drvEecSalaryOrHourly] char(1) NULL,
    [drvNameMiddle] varchar(1) NULL
);

-----------
-- Create table U_EAOD_V2_EEList
-----------

IF OBJECT_ID('U_EAOD_V2_EEList') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAOD_V2_File
-----------

IF OBJECT_ID('U_EAOD_V2_File') IS NULL
CREATE TABLE [dbo].[U_EAOD_V2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAOD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lippert Components, Inc.

Created By: Cyndi Diaz
Business Analyst: Karen Formicone
Create Date: 08/13/2020
Service Request Number: SR-2020-00277352

Purpose: AOD Changes Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAOD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAOD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAOD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAOD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAOD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAOD', 'FULL_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAOD', 'CHGS_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAOD', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAOD', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAOD';

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
    DELETE FROM dbo.U_EAOD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAOD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAOD_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAOD_AuditFields;
    CREATE TABLE dbo.U_EAOD_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepAddressLine1');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepAddressLine2');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepAddressCity');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepAddressState');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepAddressZipCode');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepDateOfBirth');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepPhoneHomeNumber');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepNameFirst');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepNameMiddle');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepNameLast');
    insert into dbo.U_EAOD_AuditFields values ('emppers','EepSSN');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecCOID');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecDateOfLastHire');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecDateOfSeniority');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecEmplStatus');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecEmpNo');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecJobCode');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecHourlyPayRate');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecLocation');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecOrgLvl1');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecOrgLvl2');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecOrgLvl3');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecPayGroup');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecSalaryOrHourly');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecShift');
    insert into dbo.U_EAOD_AuditFields values ('empcomp','EecTimeclockID');
    insert into dbo.U_EAOD_AuditFields values ('emphjob','EjhJobEffDate');    
    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAOD_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAOD_Audit;
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
    INTO dbo.U_EAOD_Audit                    --select * from U_EAOD_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAOD_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAOD_Audit ON dbo.U_EAOD_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    IF @ExportCode <> 'FULL_XOE'
    BEGIN
        DELETE FROM dbo.U_EAOD_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EAOD_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END

    --==========================================
    -- Build Driver Tables
    --==========================================

    --Most recent EjhJobEffDate where there is a change in Audit to: Item 5/E, 12/L, 13/M, 17/Q, 18/R, 22/V or 24/X
    IF OBJECT_ID('U_EAOD_drvJobDt','U') IS NOT NULL
        DROP TABLE dbo.U_EAOD_drvJobDt;
    SELECT EjhEEID EEID,EjhCOID COID, MAX(EjhJobEffDate) JobDt
    INTO dbo.U_EAOD_drvJobDt                --SELECT * FROM U_EAOD_drvJobDt
    FROM dbo.U_EAOD_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.vw_int_EmpHJob WHERE EjhEEID = xEEID AND EjhCOID = xCOID)
    JOIN dbo.U_EAOD_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName IN ('EecOrgLvl1','CmpCompanyCode','EecLocation','EecOrgLvl2','EecShift','EecOrgLvl3','EecPayGroup')
    GROUP BY EjhEEID,EjhCOID

    ---------------------------------
    -- DETAIL RECORD - U_EAOD_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAOD_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAOD_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvNameLast = REPLACE(EepNameLast, ',', '')
        ,drvNameFirst = REPLACE(EepNameFirst, ',', '')
        ,drvEmpNo = EecEmpNo
        ,drvOrgLvl1 = REPLACE(RIGHT('0000' + RTRIM(EecOrgLvl1), 4), ',', '')
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' then '1' Else '0' END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '') + ' ' + ISNULL(REPLACE(EepAddressLine2, ',', ''), '')
        ,drvAddressCity = REPLACE(EepAddressCity, ',', '')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvCompanyCode = REPLACE(SUBSTRING(CmpCompanyCode, 1, 3), ',', '') 
        ,drvLocation = REPLACE(EecLocation, ',', '')
        ,drvTimeclockID = EecTimeclockID
        ,drvPhoneHomeNumber = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN '(' + LEFT(EepPhoneHomeNumber, 3)  + ') ' + SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + RIGHT(RTRIM(EepPhoneHomeNumber), 4) END
        ,drvJobCode = REPLACE(EecJobCode, ',', '')
        ,drvOrgLvl2 = REPLACE(EecOrgLvl2, ',', '')
        ,drvShift = CASE WHEN EecShift <> 'Z' THEN REPLACE(EecShift, ',', '') END
        ,drvHourlyPayRate = CONVERT(VARCHAR(20),EecHourlyPayRate)
        ,drvJobEffDate = CASE WHEN ISNULL(EjhJobEffDate,'') <> '' THEN EjhJobEffDate ELSE EecDateOfLastHire END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvOrgLvl3 = REPLACE(EecOrgLvl3, ',', '')
        ,drvEecEmpNo = EecEmpNo
        ,drvPayGroup = REPLACE(SUBSTRING(EecPayGroup, 1, 1), ',', '')
        ,drvEjhJobEffDate = JobDt
        ,drvDateOfSeniority = EecDateOfSeniority
        ,drvEecSalaryOrHourly = EecSalaryOrHourly
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
    INTO dbo.U_EAOD_drvTbl                    --SELECT DISTINCT drvOrgLvl1 FROM U_EAOD_drvTbl
    FROM dbo.U_EAOD_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEmplStatus <> 'T'
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.vw_int_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.vw_int_EmpHJob WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND (EjhPctChange <> 0 OR EjhIsRateChange = 'Y' OR EjhReason = 'CONV'))
        AND (EjhPctChange <> 0 
        OR EjhIsRateChange = 'Y' 
        OR EjhReason = 'CONV')
    LEFT JOIN dbo.U_EAOD_drvJobDt WITH (NOLOCK)
        ON EEID = xEEID
        AND COID = xCOID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'B4TIMEEECHANGES_TEST.csv'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'B4TIMEEECHANGES_TEST.csv'
                                  ELSE 'B4TIMEEECHANGES.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAOD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAOD_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAOD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008061'
       ,expStartPerControl     = '202008061'
       ,expLastEndPerControl   = '202008139'
       ,expEndPerControl       = '202008139'
WHERE expFormatCode = 'EAOD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAOD_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAOD_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO
CREATE VIEW dbo.dsi_vwEAOD_V2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAOD_V2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAOD' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAOD'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAOD'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAOD', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAOD', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAOD', 'UseFileName', 'V', 'Y'


-- End ripout