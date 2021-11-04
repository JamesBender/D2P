/**********************************************************************************

EAV3: AOD Changes Export V3

FormatCode:     EAV3
Project:        AOD Changes Export V3
Client ID:      LIP1000
Date/time:      2021-11-03 13:34:22.057
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N12
Server:         N1SUP2DB51
Database:       ULTIPRO_LIPP
Web Filename:   LIP1000_VT9GM_EEHISTORY_EAV3_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAV3_SavePath') IS NOT NULL DROP TABLE dbo.U_EAV3_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAV3'


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
WHERE FormatCode = 'EAV3'
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
WHERE ExpFormatCode = 'EAV3'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAV3')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAV3'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAV3'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAV3'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAV3'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAV3'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAV3'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAV3'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAV3'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAV3'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAV3_V2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAV3_V2_Export];
GO
IF OBJECT_ID('dsi_vwEAV3_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAV3_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAV3') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAV3];
GO
IF OBJECT_ID('U_EAV3_V2_File') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_File];
GO
IF OBJECT_ID('U_EAV3_V2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_EEList];
GO
IF OBJECT_ID('U_EAV3_V2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_drvTbl];
GO
IF OBJECT_ID('U_EAV3_V2_drvJobDt') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_drvJobDt];
GO
IF OBJECT_ID('U_EAV3_V2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_AuditFields];
GO
IF OBJECT_ID('U_EAV3_V2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAV3_V2_Audit];
GO
IF OBJECT_ID('U_EAV3_StatusDate_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAV3_StatusDate_Audit];
GO
IF OBJECT_ID('U_EAV3_hrstatusdate') IS NOT NULL DROP TABLE [dbo].[U_EAV3_hrstatusdate];
GO
IF OBJECT_ID('U_EAV3_File') IS NOT NULL DROP TABLE [dbo].[U_EAV3_File];
GO
IF OBJECT_ID('U_EAV3_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAV3_EEList];
GO
IF OBJECT_ID('U_EAV3_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAV3_drvTbl];
GO
IF OBJECT_ID('U_EAV3_drvJobDt') IS NOT NULL DROP TABLE [dbo].[U_EAV3_drvJobDt];
GO
IF OBJECT_ID('U_EAV3_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAV3_AuditFields];
GO
IF OBJECT_ID('U_EAV3_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAV3_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAV3','AOD Changes Export V3','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EAV3000000Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last"','1','(''DA''=''T,'')','EAV3000000Z0','50','H','01','1',NULL,'Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First"','2','(''DA''=''T,'')','EAV3000000Z0','50','H','01','2',NULL,'First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emplid"','3','(''DA''=''T,'')','EAV3000000Z0','50','H','01','3',NULL,'Emplid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','4','(''DA''=''T,'')','EAV3000000Z0','50','H','01','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','5','(''DA''=''T,'')','EAV3000000Z0','50','H','01','5',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Active Stat"','6','(''DA''=''T,'')','EAV3000000Z0','50','H','01','6',NULL,'Active Stat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date or Rehire"','7','(''DA''=''T,'')','EAV3000000Z0','50','H','01','7',NULL,'Hire Date or Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Street"','8','(''DA''=''T,'')','EAV3000000Z0','50','H','01','8',NULL,'Street',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','9','(''DA''=''T,'')','EAV3000000Z0','50','H','01','9',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','10','(''DA''=''T,'')','EAV3000000Z0','50','H','01','10',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','11','(''DA''=''T,'')','EAV3000000Z0','50','H','01','11',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Paygroup"','12','(''DA''=''T,'')','EAV3000000Z0','50','H','01','12',NULL,'Paygroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','13','(''DA''=''T,'')','EAV3000000Z0','50','H','01','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Badge"','14','(''DA''=''T,'')','EAV3000000Z0','50','H','01','14',NULL,'Badge',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home phone"','15','(''DA''=''T,'')','EAV3000000Z0','50','H','01','15',NULL,'Home phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WG3"','16','(''DA''=''T,'')','EAV3000000Z0','50','H','01','16',NULL,'WG3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Labor"','17','(''DA''=''T,'')','EAV3000000Z0','50','H','01','17',NULL,'Labor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift"','18','(''DA''=''T,'')','EAV3000000Z0','50','H','01','18',NULL,'Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Rate"','19','(''DA''=''T,'')','EAV3000000Z0','50','H','01','19',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rate Date"','20','(''DA''=''T,'')','EAV3000000Z0','50','H','01','20',NULL,'Rate Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birthdate"','21','(''DA''=''T,'')','EAV3000000Z0','50','H','01','21',NULL,'Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Production Line"','22','(''DA''=''T,'')','EAV3000000Z0','50','H','01','22',NULL,'Production Line',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"File Number"','23','(''DA''=''T,'')','EAV3000000Z0','50','H','01','23',NULL,'File Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plant/conf"','24','(''DA''=''T,'')','EAV3000000Z0','50','H','01','24',NULL,'Plant/conf',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Classification"','25','(''DA''=''T,'')','EAV3000000Z0','50','H','01','25',NULL,'Employee Classification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Group Date"','26','(''DA''=''T,'')','EAV3000000Z0','50','H','01','26',NULL,'Work Group Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOC"','27','(''DA''=''T,'')','EAV3000000Z0','50','H','01','27',NULL,'DOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Seniority Date "','28','(''DA''=''T,'')','EAV3000000Z0','50','H','01','28',NULL,'Seniority Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Agency"','29','(''DA''=''T,'')','EAV3000000Z0','50','H','01','29',NULL,'Agency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Type "','30','(''DA''=''T,'')','EAV3000000Z0','50','H','01','30',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','31','(''DA''=''T,'')','EAV3000000Z0','50','H','01','31',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Status"','32','(''DA''=''T,'')','EAV3000000Z0','50','H','01','32',NULL,'Hourly Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Status Date"','33','(''DA''=''T,'')','EAV3000000Z0','50','H','01','33',NULL,'Hourly Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Term Date"','34','(''DA''=''T,'')','EAV3000000Z0','50','H','01','34',NULL,'Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Review Date"','35','(''DA''=''T'')','EAV3000000Z0','50','H','01','35',NULL,'Last Review Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','1','(''UA''=''T,'')','EAV3000000Z0','50','D','10','1',NULL,'Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EAV3000000Z0','50','D','10','2',NULL,'First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''T,'')','EAV3000000Z0','50','D','10','3',NULL,'Emplid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','EAV3000000Z0','50','D','10','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl1"','5','(''UA''=''T,'')','EAV3000000Z0','50','D','10','5',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','6','(''UA''=''T,'')','EAV3000000Z0','50','D','10','6',NULL,'Active Stat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','7','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','7',NULL,'Hire Date or Rehire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','EAV3000000Z0','50','D','10','8',NULL,'Street',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','9','(''UA''=''T,'')','EAV3000000Z0','50','D','10','9',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','10','(''UA''=''T,'')','EAV3000000Z0','50','D','10','10',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','11','(''UA''=''T,'')','EAV3000000Z0','50','D','10','11',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode"','12','(''UA''=''T,'')','EAV3000000Z0','50','D','10','12',NULL,'Paygroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','13','(''UA''=''T,'')','EAV3000000Z0','50','D','10','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTimeclockID"','14','(''UA''=''T,'')','EAV3000000Z0','50','D','10','14',NULL,'Badge',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','15','(''UA''=''T,'')','EAV3000000Z0','50','D','10','15',NULL,'Home phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','16','(''UA''=''T,'')','EAV3000000Z0','50','D','10','16',NULL,'WG3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl2"','17','(''UA''=''T,'')','EAV3000000Z0','50','D','10','17',NULL,'Labor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShift"','18','(''UA''=''T,'')','EAV3000000Z0','50','D','10','18',NULL,'Shift',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyPayRate"','19','(''UA''=''T,'')','EAV3000000Z0','50','D','10','19',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobEffDate"','20','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','20',NULL,'Rate Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','21','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','21',NULL,'Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl3"','22','(''UA''=''T,'')','EAV3000000Z0','50','D','10','22',NULL,'Production Line',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEecEmpNo"','23','(''UA''=''T,'')','EAV3000000Z0','50','D','10','23',NULL,'File Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayGroup"','24','(''UA''=''T,'')','EAV3000000Z0','50','D','10','24',NULL,'Plant/conf',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''T,'')','EAV3000000Z0','50','D','10','25',NULL,'Employee Classification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEjhJobEffDate "','26','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','26',NULL,'Work Group Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T,'')','EAV3000000Z0','50','D','10','27',NULL,'DOC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfSeniority"','28','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','28',NULL,'Seniority Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvagency"','29','(''UA''=''T,'')','EAV3000000Z0','50','D','10','29',NULL,'Agency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEecSalaryOrHourly"','30','(''UA''=''T,'')','EAV3000000Z0','50','D','10','30',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','31','(''UA''=''T,'')','EAV3000000Z0','50','D','10','31',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvhourlystatus"','32','(''UA''=''T,'')','EAV3000000Z0','50','D','10','32',NULL,'Hourly Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvhrstatusDate"','33','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','33',NULL,'Hourly Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvtermdate"','34','(''UD101''=''T,'')','EAV3000000Z0','50','D','10','34',NULL,'Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlastreviewdate"','35','(''UD101''=''T'')','EAV3000000Z0','50','D','10','35',NULL,'Last Review Date',NULL,NULL);

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAV3_20211103.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Changes Only','202110059','EMPEXPORT','CHGS_XOE','Sep  3 2021 10:48AM','EAV3',NULL,NULL,NULL,'202110059','Sep  2 2021 12:00AM','Dec 30 1899 12:00AM','202109211','3069','','','202109211',dbo.fn_GetTimedKey(),NULL,'us3jReLIP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Full File','202110209','EMPEXPORT','FULL_XOE','Oct 20 2021  6:04PM','EAV3',NULL,NULL,NULL,'202110209','Oct 20 2021 12:00AM','Dec 30 1899 12:00AM','202110061','43806','','','202110061',dbo.fn_GetTimedKey(),NULL,'us3jReLIP1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 8AM','202110059','EMPEXPORT','SCHEDU8AM',NULL,'EAV3',NULL,NULL,NULL,'202110059','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 11AM','202110059','EMPEXPORT','SCHEDUL11A',NULL,'EAV3',NULL,NULL,NULL,'202110059','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 2PM','202110059','EMPEXPORT','SCHEDUL2PM',NULL,'EAV3',NULL,NULL,NULL,'202110059','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 5PM','202110059','EMPEXPORT','SCHEDUL5PM',NULL,'EAV3',NULL,NULL,NULL,'202110059','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8Z3ZJ,DAJY5,7WA7Y,7W9PY,7WA4Z,7WA1D',NULL,NULL,NULL,'Scheduled Session 9PM','202110059','EMPEXPORT','SCHEDULED',NULL,'EAV3',NULL,NULL,NULL,'202110059','Aug 13 2020  6:13PM','Aug 13 2020  6:13PM','202109211',NULL,'','','202109211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAV3','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAV3','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAV3','InitialSort','C','drvEmpNo');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAV3','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAV3','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAV3','D10','dbo.U_EAV3_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EAV3_Audit
-----------

IF OBJECT_ID('U_EAV3_Audit') IS NULL
CREATE TABLE [dbo].[U_EAV3_Audit] (
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
-- Create table U_EAV3_AuditFields
-----------

IF OBJECT_ID('U_EAV3_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAV3_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAV3_drvJobDt
-----------

IF OBJECT_ID('U_EAV3_drvJobDt') IS NULL
CREATE TABLE [dbo].[U_EAV3_drvJobDt] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [JobDt] datetime NULL
);

-----------
-- Create table U_EAV3_drvTbl
-----------

IF OBJECT_ID('U_EAV3_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAV3_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvEmpNo] char(9) NULL,
    [drvOrgLvl1] varchar(8000) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvCompanyCode] varchar(8000) NULL,
    [drvLocation] varchar(8000) NULL,
    [drvTimeclockID] char(12) NULL,
    [drvPhoneHomeNumber] varchar(14) NULL,
    [drvJobCode] varchar(8000) NULL,
    [drvOrgLvl2] varchar(8000) NULL,
    [drvShift] varchar(8000) NULL,
    [drvHourlyPayRate] varchar(20) NULL,
    [drvJobEffDate] datetime NULL,
    [drvDateOfBirth] varchar(1) NOT NULL,
    [drvOrgLvl3] varchar(8000) NULL,
    [drvEecEmpNo] char(9) NULL,
    [drvPayGroup] varchar(8000) NULL,
    [drvEjhJobEffDate] datetime NULL,
    [drvDateOfSeniority] datetime NULL,
    [drvagency] char(6) NULL,
    [drvEecSalaryOrHourly] char(1) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvhourlystatus] varchar(1) NULL,
    [drvhrstatusDate] datetime NULL,
    [drvtermdate] datetime NULL,
    [drvlastreviewdate] datetime NULL
);

-----------
-- Create table U_EAV3_EEList
-----------

IF OBJECT_ID('U_EAV3_EEList') IS NULL
CREATE TABLE [dbo].[U_EAV3_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAV3_File
-----------

IF OBJECT_ID('U_EAV3_File') IS NULL
CREATE TABLE [dbo].[U_EAV3_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAV3_hrstatusdate
-----------

IF OBJECT_ID('U_EAV3_hrstatusdate') IS NULL
CREATE TABLE [dbo].[U_EAV3_hrstatusdate] (
    [StEEID] char(12) NOT NULL,
    [StCOID] char(5) NOT NULL,
    [StAudFieldName] varchar(128) NOT NULL,
    [StDate] datetime NULL
);

-----------
-- Create table U_EAV3_StatusDate_Audit
-----------

IF OBJECT_ID('U_EAV3_StatusDate_Audit') IS NULL
CREATE TABLE [dbo].[U_EAV3_StatusDate_Audit] (
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
-- Create table U_EAV3_V2_Audit
-----------

IF OBJECT_ID('U_EAV3_V2_Audit') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_Audit] (
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
-- Create table U_EAV3_V2_AuditFields
-----------

IF OBJECT_ID('U_EAV3_V2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAV3_V2_drvJobDt
-----------

IF OBJECT_ID('U_EAV3_V2_drvJobDt') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_drvJobDt] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [JobDt] datetime NULL
);

-----------
-- Create table U_EAV3_V2_drvTbl
-----------

IF OBJECT_ID('U_EAV3_V2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_drvTbl] (
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
    [drvagency] varchar(8000) NULL,
    [drvEecSalaryOrHourly] char(1) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvhourlystatus] varchar(12) NULL,
    [drvhrstatusDate] datetime NULL,
    [drvtermdate] datetime NULL,
    [drvlastreviewdate] datetime NULL
);

-----------
-- Create table U_EAV3_V2_EEList
-----------

IF OBJECT_ID('U_EAV3_V2_EEList') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAV3_V2_File
-----------

IF OBJECT_ID('U_EAV3_V2_File') IS NULL
CREATE TABLE [dbo].[U_EAV3_V2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAV3]
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAV3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAV3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAV3';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAV3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAV3' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAV3', 'FULL_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAV3', 'CHGS_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAV3', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAV3', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAV3';

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
    DELETE FROM dbo.U_EAV3_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAV3_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAV3_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_AuditFields;
    CREATE TABLE dbo.U_EAV3_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepAddressLine1');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepAddressLine2');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepAddressCity');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepAddressState');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepAddressZipCode');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepDateOfBirth');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepPhoneHomeNumber');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepNameFirst');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepNameMiddle');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepNameLast');
    insert into dbo.U_EAV3_AuditFields values ('emppers','EepSSN');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecCOID');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecDateOfLastHire');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecDateOfSeniority');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecEmplStatus');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecEmpNo');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecJobCode');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecHourlyPayRate');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecLocation');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecOrgLvl1');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecOrgLvl2');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecOrgLvl3');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecPayGroup');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecSalaryOrHourly');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecShift');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecFullTimeOrPartTime');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecEEType');
    insert into dbo.U_EAV3_AuditFields values ('empcomp','EecTimeclockID');
    insert into dbo.U_EAV3_AuditFields values ('emphjob','EjhJobEffDate');  
     
    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAV3_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_Audit;
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
    INTO dbo.U_EAV3_Audit                    --select * from U_EAV3_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAV3_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAV3_Audit ON dbo.U_EAV3_Audit (audEEID,audKey2);




    IF OBJECT_ID('U_EAV3_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_AuditFields;
    CREATE TABLE dbo.U_EAV3_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EAV3_AuditFields VALUES ('empcomp','EecEmplStatus');    
    INSERT INTO dbo.U_EAV3_AuditFields VALUES ('empcomp','EecSalaryOrHourly');    
    INSERT INTO dbo.U_EAV3_AuditFields VALUES ('empcomp','EecFullTimeOrPartTime');    
    INSERT INTO dbo.U_EAV3_AuditFields VALUES ('empcomp','EecEEType');


    IF OBJECT_ID('U_EAV3_StatusDate_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_StatusDate_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value /*, audKey3Value, audFieldName*/ ORDER BY audDateTime DESC)
    INTO dbo.U_EAV3_StatusDate_Audit                    --select * from U_EAV3_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAV3_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    JOIN dbo.U_EAV3_EEList WITH (NOLOCK)
        ON xEEID = audKey1Value
        AND xCOID = audKey2Value
    WHERE audAction <> 'DELETE';

    DELETE dbo.U_EAV3_StatusDate_Audit WHERE audRowNo <> 1;







    --================
    -- Changes Only
    --================
    IF @ExportCode <> 'FULL_XOE'
    BEGIN
        DELETE FROM dbo.U_EAV3_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EAV3_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END

    --==========================================
    -- Build Driver Tables
    --==========================================

    --Most recent EjhJobEffDate where there is a change in Audit to: Item 5/E, 12/L, 13/M, 17/Q, 18/R, 22/V or 24/X
    IF OBJECT_ID('U_EAV3_drvJobDt','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_drvJobDt;
    SELECT EjhEEID EEID,EjhCOID COID, MAX(EjhJobEffDate) JobDt
    INTO dbo.U_EAV3_drvJobDt                --SELECT * FROM U_EAV3_drvJobDt
    FROM dbo.U_EAV3_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhDateTimeCreated = (SELECT MAX(EjhDateTimeCreated) FROM dbo.vw_int_EmpHJob WHERE EjhEEID = xEEID AND EjhCOID = xCOID)
    JOIN dbo.U_EAV3_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName IN ('EecOrgLvl1','CmpCompanyCode','EecLocation','EecOrgLvl2','EecShift','EecOrgLvl3','EecPayGroup','EecEmplStatus','EecFullTimeOrPartTime','EecEEType','EecSalaryOrHourly')
    GROUP BY EjhEEID,EjhCOID




    -- Recent EjhJobEffDate for hrstatusdate
    IF OBJECT_ID('U_EAV3_hrstatusdate','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_hrstatusdate;
    SELECT EjhEEID StEEID,EjhCOID StCOID, AudFieldName StAudFieldName,MAX(EjhJobEffDate) StDate
    INTO dbo.U_EAV3_hrstatusdate
    FROM dbo.U_EAV3_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpHJob WITH (NOLOCK)
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    JOIN dbo.U_EAV3_Audit WITH (NOLOCK)
        ON AudEEID = xEEID
        AND AudFieldName IN ('EecEmplStatus','EecFullTimeOrPartTime','EecEEType','EecSalaryOrHourly')
    GROUP BY EjhEEID,EjhCOID,AudFieldName



    ---------------------------------
    -- DETAIL RECORD - U_EAV3_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAV3_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAV3_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvNameLast = REPLACE(EepNameLast, ',', '')
        ,drvNameFirst = REPLACE(EepNameFirst, ',', '')
        ,drvEmpNo = EecEmpNo
        ,drvOrgLvl1 = REPLACE(RIGHT('0000' + RTRIM(EecOrgLvl1), 4), ',', '')
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' then '1' Else '0' END
        ,drvDateOfLastHire = CASE WHEN EecDateOfSeniority < EecDateOfLastHire THEN EecDateOfSeniority
                                  Else EecDateOfLastHire END

        ,drvAddressLine1 = ''-- REPLACE(EepAddressLine1, ',', '') + ' ' + ISNULL(REPLACE(EepAddressLine2, ',', ''), '')
        ,drvAddressCity = '' -- REPLACE(EepAddressCity, ',', '')
        ,drvAddressState = '' --EepAddressState
        ,drvAddressZipCode = '' -- EepAddressZipCode
        ,drvCompanyCode = REPLACE(SUBSTRING(CmpCompanyCode, 1, 3), ',', '') 
        ,drvLocation = REPLACE(EecLocation, ',', '')
        ,drvTimeclockID = EecTimeclockID
        ,drvPhoneHomeNumber = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN '(' + LEFT(EepPhoneHomeNumber, 3)  + ') ' + SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + RIGHT(RTRIM(EepPhoneHomeNumber), 4) END
        ,drvJobCode = REPLACE(EecJobCode, ',', '')
        ,drvOrgLvl2 = REPLACE(EecOrgLvl2, ',', '')
        ,drvShift = CASE WHEN EecShift <> 'Z' THEN REPLACE(EecShift, ',', '') END
        ,drvHourlyPayRate = CONVERT(VARCHAR(20),EecHourlyPayRate)
        ,drvJobEffDate = CASE WHEN ISNULL(EjhJobEffDate,'') <> '' THEN EjhJobEffDate ELSE EecDateOfLastHire END
        ,drvDateOfBirth = '' --EepDateOfBirth
        ,drvOrgLvl3 = REPLACE(EecOrgLvl3, ',', '')
        ,drvEecEmpNo = EecEmpNo
        ,drvPayGroup = REPLACE(SUBSTRING(EecPayGroup, 1, 1), ',', '')
        ,drvEjhJobEffDate = JobDt
        ,drvDateOfSeniority = EecDateOfSeniority
        ,drvagency = EecHireSource
        ,drvEecSalaryOrHourly = EecSalaryOrHourly
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvhourlystatus =  CASE WHEN EecEmplStatus = 'L' then '6'
                                 ELSE (CASE WHEN EecEmplStatus = 'R' then '5'
                                            WHEN EecEmplStatus = 'T' then '8'
                                            ELSE (CASE WHEN EecFullTimeOrPartTime = 'P' then '1'
                                                       ELSE (CASE WHEN EecEEType = 'REG' and EecSalaryOrHourly = 'H' then '0'
                                                                  ELSE (CASE WHEN EecEEType = 'REG' and EecSalaryOrHourly= 'S' then '2'
                                                                             ELSE (CASE WHEN EecEEType = 'SNE' then '3'
                                                                                        ELSE (CASE WHEN EecEEType = 'CON' then '4'
                                                                                                   WHEN EecEEType = 'TMP' then '4'
                                                                                                   ELSE (CASE WHEN EecEEType = 'INT' then '7'
                                                                                                              WHEN EecEEType = 'PRB' then '7'
                                                                                                              WHEN EecEEType = 'STU' then '7'
                                                                                                              WHEN EecEEType = 'SUM' then '7' END)END)END)END)END)END)END)END
                                     
                                    
         ,drvhrstatusDate = StatusDate.StDate 
         
                            --CASE WHEN EecEmplStatus in ('L','R') then EecEmplStatusStartDate
       --                     ELSE ( CASE WHEN EecEmplStatus = 'A' AND EshEmpStat.EshEmplStatus = 'L' THEN EshEmpStat.EshStatusStopDate ELSE EjhJobEffDate END)
                            --END 

        ,drvtermdate = EecDateOfTermination
        ,drvlastreviewdate = EecDateOfLastPerfReview
    INTO dbo.U_EAV3_drvTbl                    --SELECT DISTINCT drvOrgLvl1 FROM U_EAV3_drvTbl
    FROM dbo.U_EAV3_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        --AND EecEmplStatus <> 'T'

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

    LEFT JOIN dbo.U_EAV3_drvJobDt WITH (NOLOCK)
        ON EEID = xEEID
        AND COID = xCOID

    LEFT JOIN (Select EshEEID,EshCOID,EshEmplStatus,EshStatusStopDate 
        FROM dbo.EmpHStat WITh(NOLOCK)
        GROUP BY EshEEID,EshCOID,EshEmplStatus,EshStatusStopDate) AS EshEmpStat
        ON EshEmpStat.EshEEID = xEEID
        AND EshEmpStat.EshCOID = xCOID

    --LEFT JOIN (Select * FROM 
    --          (SELECT EEID,COID,AudFieldName,StatusDate,
    --           ROW_NUMBER() OVER (PARTITION BY AudFieldName ORDER BY StatusDate desc)
    --           FROM dbo.U_EAV3_hrstatusdate WITH (NOLOCK)
    --           ORDER BY AudFieldName,EEID,COID,StatusDate) AS StDate
    --           ON StDate.EEID = xEEID


     LEFT JOIN (Select * from 
               (SELECT StEEID,StCOID,StAudFieldName,StDate,ROW_NUMBER() OVER (PARTITION BY StAudFieldName ORDER BY StDate desc) row_num
               FROM dbo.U_EAV3_hrstatusdate) StatDate
               WHERE StatDate.row_num = 1) AS StatusDate
               ON StatusDate.StEEID = xEEID
               AND StatusDate.StCOID = xCOID
              


--      SELECT EfoEEID, EfoPhoneNumber
       -- FROM (SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN 
     --, ORDER BY Ef
     --FROM dbo.EmpMPhon WITH (NOLOCK)
     --WHERE EfoPhoneType = 'CEL') AS Efo
     --WHERE RN = 1 


          --LEFT JOIN (Select * from (
                  --  Select ejheeid,ejhcoid,ejhReason,ejhJobEffDate,actDesc , ROW_NUMBER() OVER (PARTITION BY ejheeid,ejhcoid ORDER BY ejhJobEffDate desc) row_num 
                    --from dbo.EmpHJob  
                                 --Join dbo.U_EEMPYDEV4_Mapping_Actions 
                                 --on ejhReason = ActCode
                                 -- where ejhReason in ('100', '101', '400', '401', '800', 'TRI', 'TRO')) JobHist
                                 -- Where JobHist.row_num = 1 ) as JobHistMain
                                 -- on JobHistMain.ejheeid = xEEId
                                 -- and JobHistMain.ejhcoid = xcoid



        



  --      SELECT audEEID = audKey1Value ,
        --       audKey2 = audKey2Value,
        --       audKey3 = audKey3Value,
        --       audTableName,
        --       audFieldName,
        --       audAction,
        --       audDateTime,
        --       audOldValue,
        --       audNewValue,
        --       audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        --INTO dbo.U_EANTHEM834_AuditFROM dbo.vw_AuditData WITH (NOLOCK)










        
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
ALTER VIEW dbo.dsi_vwEAV3_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAV3_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAV3%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109211'
       ,expStartPerControl     = '202109211'
       ,expLastEndPerControl   = '202110059'
       ,expEndPerControl       = '202110059'
WHERE expFormatCode = 'EAV3';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAV3_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAV3_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO
CREATE VIEW dbo.dsi_vwEAV3_V2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAV3_V2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAV3' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAV3'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAV3'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAV3', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAV3', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAV3', 'UseFileName', 'V', 'Y'


-- End ripout