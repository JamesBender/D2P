/**********************************************************************************

EGIFTIAAEX: TIAA Deferred Compensation

FormatCode:     EGIFTIAAEX
Project:        TIAA Deferred Compensation
Client ID:      GIF1000
Date/time:      2022-09-13 16:02:54.997
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E31
Server:         E3SUP1DB02
Database:       ULTIPRO_GMCI
Web Filename:   GIF1000_79471_EEHISTORY_EGIFTIAAEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGIFTIAAEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EGIFTIAAEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGIFTIAAEX'


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
WHERE FormatCode = 'EGIFTIAAEX'
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
WHERE ExpFormatCode = 'EGIFTIAAEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGIFTIAAEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGIFTIAAEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGIFTIAAEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGIFTIAAEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGIFTIAAEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGIFTIAAEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGIFTIAAEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGIFTIAAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGIFTIAAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGIFTIAAEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGIFTIAAEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGIFTIAAEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGIFTIAAEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGIFTIAAEX];
GO
IF OBJECT_ID('U_EGIFTIAAEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_PEarHist];
GO
IF OBJECT_ID('U_EGIFTIAAEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_PDedHist];
GO
IF OBJECT_ID('U_EGIFTIAAEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_Header];
GO
IF OBJECT_ID('U_EGIFTIAAEX_File') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_File];
GO
IF OBJECT_ID('U_EGIFTIAAEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_EEList];
GO
IF OBJECT_ID('U_EGIFTIAAEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_drvTbl];
GO
IF OBJECT_ID('U_EGIFTIAAEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_DedList];
GO
IF OBJECT_ID('U_EGIFTIAAEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_AuditFields];
GO
IF OBJECT_ID('U_EGIFTIAAEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EGIFTIAAEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EGIFTIAAEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EGIFTIAAEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGIFTIAAEX','TIAA Deferred Compensation','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EGIFTIAAEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGIFTIAAEXZ0','50','H','01','1',NULL,'Detail Record ID',NULL,NULL,'"Detail Record ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGIFTIAAEXZ0','50','H','01','2',NULL,'EMPLOYER NAME',NULL,NULL,'"EMPLOYER NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGIFTIAAEXZ0','50','H','01','3',NULL,'EMPLOYER EIN',NULL,NULL,'"EMPLOYER EIN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGIFTIAAEXZ0','50','H','01','4',NULL,'EMPLOYER PLAN ID',NULL,NULL,'"EMPLOYER PLAN ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGIFTIAAEXZ0','50','H','01','5',NULL,'EMPLOYER SUB PLAN ID',NULL,NULL,'"EMPLOYER SUB PLAN ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGIFTIAAEXZ0','50','H','01','6',NULL,'ORIGINATING VENDOR PLAN ID',NULL,NULL,'"ORIGINATING VENDOR PLAN ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGIFTIAAEXZ0','50','H','01','7',NULL,'ORIGINATING VENDOR SUB PLAN ID',NULL,NULL,'"drvORIGINATINGVENDORSUBPLANID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGIFTIAAEXZ0','50','H','01','8',NULL,'RECIPIENT VENDOR PLAN ID',NULL,NULL,'"RECIPIENT VENDOR PLAN ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGIFTIAAEXZ0','50','H','01','9',NULL,'RECIPIENT VENDOR SUB PLAN ID',NULL,NULL,'"RECIPIENT VENDOR SUB PLAN ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGIFTIAAEXZ0','50','H','01','10',NULL,'TYPE OF ACCOUNT',NULL,NULL,'"TYPE OF ACCOUNT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGIFTIAAEXZ0','50','H','01','11',NULL,'PAYROLL FREQUENCY',NULL,NULL,'"PAYROLL FREQUENCY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGIFTIAAEXZ0','50','H','01','12',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGIFTIAAEXZ0','50','H','01','13',NULL,'EMPLOYEE ID',NULL,NULL,'"EMPLOYEE ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGIFTIAAEXZ0','50','H','01','14',NULL,'EMPLOYEE TITLE',NULL,NULL,'"EMPLOYEE TITLE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGIFTIAAEXZ0','50','H','01','15',NULL,'EMPLOYEE FIRST NAME',NULL,NULL,'"EMPLOYEE FIRST NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGIFTIAAEXZ0','50','H','01','16',NULL,'EMPLOYEE MIDDLE NAME',NULL,NULL,'"EMPLOYEE MIDDLE NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGIFTIAAEXZ0','50','H','01','17',NULL,'EMPLOYEE LAST NAME',NULL,NULL,'"EMPLOYEE LAST NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGIFTIAAEXZ0','50','H','01','18',NULL,'ADDRESS LINE1',NULL,NULL,'"ADDRESS LINE1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGIFTIAAEXZ0','50','H','01','19',NULL,'ADDRESS LINE2',NULL,NULL,'"ADDRESS LINE2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGIFTIAAEXZ0','50','H','01','20',NULL,'ADDRESS LINE3',NULL,NULL,'"ADDRESS LINE3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGIFTIAAEXZ0','50','H','01','21',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGIFTIAAEXZ0','50','H','01','22',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGIFTIAAEXZ0','50','H','01','23',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGIFTIAAEXZ0','50','H','01','24',NULL,'COUNTRY CODE',NULL,NULL,'"COUNTRY CODE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGIFTIAAEXZ0','50','H','01','25',NULL,'RESIDENCY CODE',NULL,NULL,'"RESIDENCY CODE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGIFTIAAEXZ0','50','H','01','26',NULL,'DATE OF BIRTH',NULL,NULL,'"DATE OF BIRTH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGIFTIAAEXZ0','50','H','01','27',NULL,'GENDER ID',NULL,NULL,'"GENDER ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGIFTIAAEXZ0','50','H','01','28',NULL,'MARITAL STATUS',NULL,NULL,'"MARITAL STATUS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGIFTIAAEXZ0','50','H','01','29',NULL,'PHONE NUMBER1',NULL,NULL,'"PHONE NUMBER1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGIFTIAAEXZ0','50','H','01','30',NULL,'PHONE NUMBER TYPE1',NULL,NULL,'"PHONE NUMBER TYPE1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGIFTIAAEXZ0','50','H','01','31',NULL,'PHONE EXTENSION1',NULL,NULL,'"PHONE EXTENSION1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGIFTIAAEXZ0','50','H','01','32',NULL,'PHONE NUMBER2',NULL,NULL,'"PHONE NUMBER2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGIFTIAAEXZ0','50','H','01','33',NULL,'PHONE NUMBER TYPE2',NULL,NULL,'"PHONE NUMBER TYPE2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGIFTIAAEXZ0','50','H','01','34',NULL,'PHONE EXTENSION2',NULL,NULL,'"PHONE EXTENSION2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGIFTIAAEXZ0','50','H','01','35',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGIFTIAAEXZ0','50','H','01','36',NULL,'HR Area / Location Code',NULL,NULL,'"HR Area / Location Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGIFTIAAEXZ0','50','H','01','37',NULL,'HR SUB AREA',NULL,NULL,'"HR SUB AREA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGIFTIAAEXZ0','50','H','01','38',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGIFTIAAEXZ0','50','H','01','39',NULL,'Adjusted Date of Hire',NULL,NULL,'"Adjusted Date of Hire"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGIFTIAAEXZ0','50','H','01','40',NULL,'EMPLOYMENT STATUS',NULL,NULL,'"EMPLOYMENT STATUS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGIFTIAAEXZ0','50','H','01','41',NULL,'Employment Sub-type',NULL,NULL,'"Employment Sub-type"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGIFTIAAEXZ0','50','H','01','42',NULL,'EMPLOYMENT STATUS DATE',NULL,NULL,'"EMPLOYMENT STATUS DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGIFTIAAEXZ0','50','H','01','43',NULL,'EMPLOYEE TYPE',NULL,NULL,'"EMPLOYEE TYPE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EGIFTIAAEXZ0','50','H','01','44',NULL,'PAYROLL MODE',NULL,NULL,'"PAYROLL MODE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EGIFTIAAEXZ0','50','H','01','45',NULL,'YEARS OF SERVICE',NULL,NULL,'"YEARS OF SERVICE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EGIFTIAAEXZ0','50','H','01','46',NULL,'ANNUAL SALARY',NULL,NULL,'"ANNUAL SALARY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EGIFTIAAEXZ0','50','H','01','47',NULL,'Cash Bonus Amount',NULL,NULL,'"Cash Bonus Amount"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EGIFTIAAEXZ0','50','H','01','48',NULL,'Per Pay Compensation',NULL,NULL,'"Per Pay Compensation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EGIFTIAAEXZ0','50','H','01','49',NULL,'Per Pay Hours Worked',NULL,NULL,'"Per Pay Hours Worked"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EGIFTIAAEXZ0','50','H','01','50',NULL,'YEAR TO DATE TYPE',NULL,NULL,'"YEAR TO DATE TYPE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EGIFTIAAEXZ0','50','H','01','51',NULL,'YEAR TO DATE BASE COMPENSATION',NULL,NULL,'"drvYEARTODATEBASECOMPENSATION"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EGIFTIAAEXZ0','50','H','01','52',NULL,'YEAR TO DATE TOTAL COMPENSATION',NULL,NULL,'"drvYEARTODATTOTALCEMPEN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EGIFTIAAEXZ0','50','H','01','53',NULL,'YEAR TO DATE HOURS WORKED',NULL,NULL,'"YEAR TO DATE HOURS WORKED"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EGIFTIAAEXZ0','50','H','01','54',NULL,'HCE FLAG',NULL,NULL,'"HCE FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EGIFTIAAEXZ0','50','H','01','55',NULL,'KEY EMPLOYEE FLAG',NULL,NULL,'"KEY EMPLOYEE FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EGIFTIAAEXZ0','50','H','01','56',NULL,'UNION EMPLOYEE FLAG',NULL,NULL,'"UNION EMPLOYEE FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EGIFTIAAEXZ0','50','H','01','57',NULL,'EMPLOYEE PLAN STATUS',NULL,NULL,'"EMPLOYEE PLAN STATUS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EGIFTIAAEXZ0','50','H','01','58',NULL,'Plan Entry Date',NULL,NULL,'"Plan Entry Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EGIFTIAAEXZ0','50','H','01','59',NULL,'Vested Date',NULL,NULL,'"Vested Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EGIFTIAAEXZ0','50','H','01','60',NULL,'ALTERNATIVE RETIREMENT VESTING ELIGIBILITY START D',NULL,NULL,'"drvALTRETIREELIGSTARTDATE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EGIFTIAAEXZ0','50','H','01','61',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL,'"CONTRIBUTION SOURCE CODE1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EGIFTIAAEXZ0','50','H','01','62',NULL,'DEFERRAL PERCENTAGE - CS1',NULL,NULL,'"DEFERRAL PERCENTAGE - CS1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EGIFTIAAEXZ0','50','H','01','63',NULL,'PAY PER DEFERRAL AMOUNT - CS1',NULL,NULL,'"PAY PER DEFERRAL AMOUNT - CS1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EGIFTIAAEXZ0','50','H','01','64',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL,'"CONTRIBUTION SOURCE CODE2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EGIFTIAAEXZ0','50','H','01','65',NULL,'DEFERRAL PERCENTAGE - CS2',NULL,NULL,'"DEFERRAL PERCENTAGE - CS2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EGIFTIAAEXZ0','50','H','01','66',NULL,'PAY PER DEFERRAL AMOUNT - CS2',NULL,NULL,'"PAY PER DEFERRAL AMOUNT - CS2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EGIFTIAAEXZ0','50','H','01','67',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL,'"CONTRIBUTION SOURCE CODE3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EGIFTIAAEXZ0','50','H','01','68',NULL,'DEFERRAL PERCENTAGE - CS3',NULL,NULL,'"DEFERRAL PERCENTAGE - CS3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EGIFTIAAEXZ0','50','H','01','69',NULL,'PAY PER DEFERRAL AMOUNT - CS3',NULL,NULL,'"PAY PER DEFERRAL AMOUNT - CS3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EGIFTIAAEXZ0','50','H','01','70',NULL,'PLAN ANNUAL SALARY',NULL,NULL,'"PLAN ANNUAL SALARY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EGIFTIAAEXZ0','50','H','01','71',NULL,'Employer Contribution Eligibility Source1',NULL,NULL,'"drvEmployerContEligSource1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EGIFTIAAEXZ0','50','H','01','72',NULL,'Employer Contribution Eligibility Date1',NULL,NULL,'"drvEmployerContEligDate1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EGIFTIAAEXZ0','50','H','01','73',NULL,'Employer Contribution Eligibility Source2',NULL,NULL,'"drvEmployerContEligSource2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EGIFTIAAEXZ0','50','H','01','74',NULL,'Employer Contribution Eligibility Date2',NULL,NULL,'"drvEmployerContEligDate2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EGIFTIAAEXZ0','50','H','01','75',NULL,'AUTO ENROLLMENT',NULL,NULL,'"AUTO ENROLLMENT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EGIFTIAAEXZ0','50','H','01','76',NULL,'AUTO ENROLLMENT DATE',NULL,NULL,'"AUTO ENROLLMENT DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EGIFTIAAEXZ0','50','H','01','77',NULL,'NEXT AUTOMATIC DEFERRAL INCREASE DATE',NULL,NULL,'"drvNEXTAUTODEFINCREASEDATE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EGIFTIAAEXZ0','50','H','01','78',NULL,'NEXT AUTOMATIC DEFERRAL INCREASE END DATE',NULL,NULL,'"drvNEXTAUTODEFINCREASEENDDATE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EGIFTIAAEXZ0','50','H','01','79',NULL,'AUTOMATIC DEFERRAL INCREASE FREQUENCY',NULL,NULL,'"drvAUTODEFINCREASEFREQUENCY"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EGIFTIAAEXZ0','50','H','01','80',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT',NULL,NULL,'"drvAUTODEFINCREASEAMOUNT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EGIFTIAAEXZ0','50','H','01','81',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT MAXIMUM',NULL,NULL,'"drvAUTODEFINCREASEAMTMAX"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EGIFTIAAEXZ0','50','H','01','82',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE',NULL,NULL,'"drvAUTODEFINCREASEPERCENT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EGIFTIAAEXZ0','50','H','01','83',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE MAXIMUM',NULL,NULL,'"drvAUTODEFINCREASEPERCENTMAX"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EGIFTIAAEXZ0','50','H','01','84',NULL,'MAXDEFERRAL FLAG',NULL,NULL,'"MAXDEFERRAL FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EGIFTIAAEXZ0','50','H','01','85',NULL,'NUMBER OF YEARS HISTORY REPORTED',NULL,NULL,'"drvNUMBEROFYEARSHISTREPORTED"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EGIFTIAAEXZ0','50','H','01','86',NULL,'YEAR',NULL,NULL,'"YEAR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EGIFTIAAEXZ0','50','H','01','87',NULL,'TOTAL CONTRIBUTION YTD',NULL,NULL,'"TOTAL CONTRIBUTION YTD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EGIFTIAAEXZ0','50','H','01','88',NULL,'CONTRIBUTION SOURCE CODE 1',NULL,NULL,'"CONTRIBUTION SOURCE CODE 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EGIFTIAAEXZ0','50','H','01','89',NULL,'TOTAL CONTRIBUTION - SOURCE 1',NULL,NULL,'"TOTAL CONTRIBUTION - SOURCE 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EGIFTIAAEXZ0','50','H','01','90',NULL,'CONTRIBUTION SOURCE CODE 2',NULL,NULL,'"CONTRIBUTION SOURCE CODE 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EGIFTIAAEXZ0','50','H','01','91',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 2',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EGIFTIAAEXZ0','50','H','01','92',NULL,'CONTRIBUTION SOURCE CODE 3',NULL,NULL,'"CONTRIBUTION SOURCE CODE 3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EGIFTIAAEXZ0','50','H','01','93',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 3',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EGIFTIAAEXZ0','50','H','01','94',NULL,'CONTRIBUTION SOURCE CODE 4',NULL,NULL,'"CONTRIBUTION SOURCE CODE 4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EGIFTIAAEXZ0','50','H','01','95',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 4',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE4"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGIFTIAAEXZ0','50','D','10','1',NULL,'Detail Record ID',NULL,NULL,'"drvDetailRecordID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGIFTIAAEXZ0','50','D','10','2',NULL,'EMPLOYER NAME',NULL,NULL,'"drvEMPLOYERNAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGIFTIAAEXZ0','50','D','10','3',NULL,'EMPLOYER EIN',NULL,NULL,'"drvEMPLOYEREIN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGIFTIAAEXZ0','50','D','10','4',NULL,'EMPLOYER PLAN ID',NULL,NULL,'"drvEMPLOYERPLANID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGIFTIAAEXZ0','50','D','10','5',NULL,'EMPLOYER SUB PLAN ID',NULL,NULL,'""','(SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGIFTIAAEXZ0','50','D','10','6',NULL,'ORIGINATING VENDOR PLAN ID',NULL,NULL,'"drvORIGINATINGVENDORPLANID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGIFTIAAEXZ0','50','D','10','7',NULL,'ORIGINATING VENDOR SUB PLAN ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGIFTIAAEXZ0','50','D','10','8',NULL,'RECIPIENT VENDOR PLAN ID',NULL,NULL,'"drvRECIPIENTVENDORPLANID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGIFTIAAEXZ0','50','D','10','9',NULL,'RECIPIENT VENDOR SUB PLAN ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGIFTIAAEXZ0','50','D','10','10',NULL,'TYPE OF ACCOUNT',NULL,NULL,'""','(''ss''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGIFTIAAEXZ0','50','D','10','11',NULL,'PAYROLL FREQUENCY',NULL,NULL,'"drvPAYROLLFREQUENCY"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGIFTIAAEXZ0','50','D','10','12',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGIFTIAAEXZ0','50','D','10','13',NULL,'EMPLOYEE ID',NULL,NULL,'"drvEMPLOYEEID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGIFTIAAEXZ0','50','D','10','14',NULL,'EMPLOYEE TITLE',NULL,NULL,'""','(''ss''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGIFTIAAEXZ0','50','D','10','15',NULL,'EMPLOYEE FIRST NAME',NULL,NULL,'"drvEMPLOYEEFIRSTNAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGIFTIAAEXZ0','50','D','10','16',NULL,'EMPLOYEE MIDDLE NAME',NULL,NULL,'"drvEMPLOYEEMIDDLENAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGIFTIAAEXZ0','50','D','10','17',NULL,'EMPLOYEE LAST NAME',NULL,NULL,'"drvEMPLOYEELASTNAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGIFTIAAEXZ0','50','D','10','18',NULL,'ADDRESS LINE1',NULL,NULL,'"drvADDRESSLINE1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGIFTIAAEXZ0','50','D','10','19',NULL,'ADDRESS LINE2',NULL,NULL,'"drvADDRESSLINE2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGIFTIAAEXZ0','50','D','10','20',NULL,'ADDRESS LINE3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGIFTIAAEXZ0','50','D','10','21',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGIFTIAAEXZ0','50','D','10','22',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGIFTIAAEXZ0','50','D','10','23',NULL,'ZIP',NULL,NULL,'"drvZIPCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGIFTIAAEXZ0','50','D','10','24',NULL,'COUNTRY CODE',NULL,NULL,'"drvCOUNTRYCODE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGIFTIAAEXZ0','50','D','10','25',NULL,'RESIDENCY CODE',NULL,NULL,'"drvRESIDENCYCODE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGIFTIAAEXZ0','50','D','10','26',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDATEOFBIRTH"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGIFTIAAEXZ0','50','D','10','27',NULL,'GENDER ID',NULL,NULL,'"drvGENDER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGIFTIAAEXZ0','50','D','10','28',NULL,'MARITAL STATUS',NULL,NULL,'"drvMARITALSTATUS"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGIFTIAAEXZ0','50','D','10','29',NULL,'PHONE NUMBER1',NULL,NULL,'"drvPHONEHOMENUMBER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGIFTIAAEXZ0','50','D','10','30',NULL,'PHONE NUMBER TYPE1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGIFTIAAEXZ0','50','D','10','31',NULL,'PHONE EXTENSION1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGIFTIAAEXZ0','50','D','10','32',NULL,'PHONE NUMBER2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGIFTIAAEXZ0','50','D','10','33',NULL,'PHONE NUMBER TYPE2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGIFTIAAEXZ0','50','D','10','34',NULL,'PHONE EXTENSION2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGIFTIAAEXZ0','50','D','10','35',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEMAILADDRESS"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGIFTIAAEXZ0','50','D','10','36',NULL,'HR Area / Location Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGIFTIAAEXZ0','50','D','10','37',NULL,'HR SUB AREA',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGIFTIAAEXZ0','50','D','10','38',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGIFTIAAEXZ0','50','D','10','39',NULL,'Adjusted Date of Hire',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGIFTIAAEXZ0','50','D','10','40',NULL,'EMPLOYMENT STATUS',NULL,NULL,'"drvEMPLOYMENTSTATUS"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGIFTIAAEXZ0','50','D','10','41',NULL,'Employment Sub-type',NULL,NULL,'"drvEmploymentSubType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGIFTIAAEXZ0','50','D','10','42',NULL,'EMPLOYMENT STATUS DATE',NULL,NULL,'"drvEMPLOYMENTSTATUSDATE"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGIFTIAAEXZ0','50','D','10','43',NULL,'EMPLOYEE TYPE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EGIFTIAAEXZ0','50','D','10','44',NULL,'PAYROLL MODE',NULL,NULL,'"100"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EGIFTIAAEXZ0','50','D','10','45',NULL,'YEARS OF SERVICE',NULL,NULL,'"drvYEARSOFSERVICE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EGIFTIAAEXZ0','50','D','10','46',NULL,'ANNUAL SALARY',NULL,NULL,'"drvANNUALSALARY"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EGIFTIAAEXZ0','50','D','10','47',NULL,'Cash Bonus Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EGIFTIAAEXZ0','50','D','10','48',NULL,'Per Pay Compensation',NULL,NULL,'"drvPerPayCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EGIFTIAAEXZ0','50','D','10','49',NULL,'Per Pay Hours Worked',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EGIFTIAAEXZ0','50','D','10','50',NULL,'YEAR TO DATE TYPE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EGIFTIAAEXZ0','50','D','10','51',NULL,'YEAR TO DATE BASE COMPENSATION',NULL,NULL,'"drvYEARTODATEBASECOMPENSATION"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EGIFTIAAEXZ0','50','D','10','52',NULL,'YEAR TO DATE TOTAL COMPENSATION',NULL,NULL,'"drvYEARTODATTOTALCEMPEN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EGIFTIAAEXZ0','50','D','10','53',NULL,'YEAR TO DATE HOURS WORKED',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EGIFTIAAEXZ0','50','D','10','54',NULL,'HCE FLAG',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EGIFTIAAEXZ0','50','D','10','55',NULL,'KEY EMPLOYEE FLAG',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EGIFTIAAEXZ0','50','D','10','56',NULL,'UNION EMPLOYEE FLAG',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EGIFTIAAEXZ0','50','D','10','57',NULL,'EMPLOYEE PLAN STATUS',NULL,NULL,'"drvEMPLOYEEPLANSTATUS"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EGIFTIAAEXZ0','50','D','10','58',NULL,'Plan Entry Date',NULL,NULL,'"drvPlanEntryDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EGIFTIAAEXZ0','50','D','10','59',NULL,'Vested Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EGIFTIAAEXZ0','50','D','10','60',NULL,'ALTERNATIVE RETIREMENT VESTING ELIGIBILITY START D',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EGIFTIAAEXZ0','50','D','10','61',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL,'"drvCONTOURCECODE1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EGIFTIAAEXZ0','50','D','10','62',NULL,'DEFERRAL PERCENTAGE - CS1',NULL,NULL,'"drvDEFERRALPERCENTAGECS1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EGIFTIAAEXZ0','50','D','10','63',NULL,'PAY PER DEFERRAL AMOUNT - CS1',NULL,NULL,'"drvPAYPERDEFERRALAMOUNT1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EGIFTIAAEXZ0','50','D','10','64',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL,'"drvCONTRIBUTIONSOURCECODE2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EGIFTIAAEXZ0','50','D','10','65',NULL,'DEFERRAL PERCENTAGE - CS2',NULL,NULL,'"drvDEFERRALPERCENTAGECS2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EGIFTIAAEXZ0','50','D','10','66',NULL,'PAY PER DEFERRAL AMOUNT - CS2',NULL,NULL,'"drvPAYPERDEFERRALAMOUNT2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EGIFTIAAEXZ0','50','D','10','67',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EGIFTIAAEXZ0','50','D','10','68',NULL,'DEFERRAL PERCENTAGE - CS3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EGIFTIAAEXZ0','50','D','10','69',NULL,'PAY PER DEFERRAL AMOUNT - CS3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EGIFTIAAEXZ0','50','D','10','70',NULL,'PLAN ANNUAL SALARY',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EGIFTIAAEXZ0','50','D','10','71',NULL,'Employer Contribution Eligibility Source1',NULL,NULL,'"drvEmployerContEligiSource1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EGIFTIAAEXZ0','50','D','10','72',NULL,'Employer Contribution Eligibility Date1',NULL,NULL,'"drvEmployerContEligDate1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EGIFTIAAEXZ0','50','D','10','73',NULL,'Employer Contribution Eligibility Source2',NULL,NULL,'"drvEmployerContEligiSource2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EGIFTIAAEXZ0','50','D','10','74',NULL,'Employer Contribution Eligibility Date2',NULL,NULL,'"drvEmployerContEligDate2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EGIFTIAAEXZ0','50','D','10','75',NULL,'AUTO ENROLLMENT',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EGIFTIAAEXZ0','50','D','10','76',NULL,'AUTO ENROLLMENT DATE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EGIFTIAAEXZ0','50','D','10','77',NULL,'NEXT AUTOMATIC DEFERRAL INCREASE DATE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EGIFTIAAEXZ0','50','D','10','78',NULL,'NEXT AUTOMATIC DEFERRAL INCREASE END DATE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EGIFTIAAEXZ0','50','D','10','79',NULL,'AUTOMATIC DEFERRAL INCREASE FREQUENCY',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EGIFTIAAEXZ0','50','D','10','80',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EGIFTIAAEXZ0','50','D','10','81',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT MAXIMUM',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EGIFTIAAEXZ0','50','D','10','82',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EGIFTIAAEXZ0','50','D','10','83',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE MAXIMUM',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EGIFTIAAEXZ0','50','D','10','84',NULL,'MAXDEFERRAL FLAG',NULL,NULL,'""','(''ss''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EGIFTIAAEXZ0','50','D','10','85',NULL,'NUMBER OF YEARS HISTORY REPORTED',NULL,NULL,'"1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EGIFTIAAEXZ0','50','D','10','86',NULL,'YEAR',NULL,NULL,'"drvYEAR"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EGIFTIAAEXZ0','50','D','10','87',NULL,'TOTAL CONTRIBUTION YTD',NULL,NULL,'"drvTOTALCONTRIBUTIONYTD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EGIFTIAAEXZ0','50','D','10','88',NULL,'CONTRIBUTION SOURCE CODE 1',NULL,NULL,'"drvCONTRIBSOURCECODE1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EGIFTIAAEXZ0','50','D','10','89',NULL,'TOTAL CONTRIBUTION - SOURCE 1',NULL,NULL,'"drvTOTALCONTRIBSOURCE1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EGIFTIAAEXZ0','50','D','10','90',NULL,'CONTRIBUTION SOURCE CODE 2',NULL,NULL,'"drvCONTRIBSOURCECODE2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EGIFTIAAEXZ0','50','D','10','91',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 2',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EGIFTIAAEXZ0','50','D','10','92',NULL,'CONTRIBUTION SOURCE CODE 3',NULL,NULL,'"drvCONTRIBSOURCECODE3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EGIFTIAAEXZ0','50','D','10','93',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 3',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EGIFTIAAEXZ0','50','D','10','94',NULL,'CONTRIBUTION SOURCE CODE 4',NULL,NULL,'"drvCONTRIBSOURCECODE4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EGIFTIAAEXZ0','50','D','10','95',NULL,'TOTAL CONTRIBUTION YTD –SOURCE 4',NULL,NULL,'"drvTOTALCONTRIBYTDSOURCE4"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EGIFTIAAEX_20220913.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'Active Open Enrollment Export','202209139','EMPEXPORT','OEACTIVE','Aug 26 2022 11:16AM','EGIFTIAAEX',NULL,NULL,NULL,'202209139','Aug 26 2022 12:00AM','Dec 30 1899 12:00AM','202201011','514','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3jReGIF1000','',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202209139','EMPEXPORT','OEPASSIVE',NULL,'EGIFTIAAEX',NULL,NULL,NULL,'202209139','Aug  4 2022  1:01PM','Aug  4 2022  1:01PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'TIAA Deferred Compensation','202209139','EMPEXPORT','ONDEM_XOE',NULL,'EGIFTIAAEX',NULL,NULL,NULL,'202209139','Aug  4 2022  1:01PM','Aug  4 2022  1:01PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'TIAA Deferred Compensati-Sched','202209139','EMPEXPORT','SCH_EGIFTI',NULL,'EGIFTIAAEX',NULL,NULL,NULL,'202209139','Aug  4 2022  1:01PM','Aug  4 2022  1:01PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'TIAA Deferred Compensati-Test','202209139','EMPEXPORT','TEST_XOE','Sep  2 2022  4:44PM','EGIFTIAAEX',NULL,NULL,NULL,'202209139','Sep  1 2022 12:00AM','Dec 30 1899 12:00AM','202201011','624','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3jReGIF1000','',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGIFTIAAEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGIFTIAAEX','H01','dbo.U_EGIFTIAAEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGIFTIAAEX','D10','dbo.U_EGIFTIAAEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EGIFTIAAEX
-----------

IF OBJECT_ID('U_dsi_BDM_EGIFTIAAEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EGIFTIAAEX] (
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
-- Create table U_EGIFTIAAEX_Audit
-----------

IF OBJECT_ID('U_EGIFTIAAEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_Audit] (
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
-- Create table U_EGIFTIAAEX_AuditFields
-----------

IF OBJECT_ID('U_EGIFTIAAEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EGIFTIAAEX_DedList
-----------

IF OBJECT_ID('U_EGIFTIAAEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EGIFTIAAEX_drvTbl
-----------

IF OBJECT_ID('U_EGIFTIAAEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvSubSort] int NOT NULL,
    [drvDetailRecordID] varchar(1) NOT NULL,
    [drvEMPLOYERNAME] varchar(40) NULL,
    [drvEMPLOYEREIN] char(9) NULL,
    [drvEMPLOYERPLANID] varchar(6) NOT NULL,
    [drvORIGINATINGVENDORPLANID] varchar(6) NOT NULL,
    [drvRECIPIENTVENDORPLANID] varchar(6) NOT NULL,
    [drvPAYROLLFREQUENCY] int NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEMPLOYEEID] char(9) NULL,
    [drvEMPLOYEEFIRSTNAME] varchar(100) NULL,
    [drvEMPLOYEEMIDDLENAME] varchar(1) NULL,
    [drvEMPLOYEELASTNAME] varchar(100) NULL,
    [drvADDRESSLINE1] varchar(255) NULL,
    [drvADDRESSLINE2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZIPCode] varchar(50) NULL,
    [drvCOUNTRYCODE] varchar(2) NULL,
    [drvRESIDENCYCODE] varchar(1) NOT NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvGENDER] char(1) NULL,
    [drvMARITALSTATUS] varchar(1) NOT NULL,
    [drvPHONEHOMENUMBER] varchar(50) NULL,
    [drvEMAILADDRESS] varchar(50) NULL,
    [drvDateofHire] datetime NULL,
    [drvEMPLOYMENTSTATUS] varchar(1) NULL,
    [drvEmploymentSubType] varchar(1) NULL,
    [drvEMPLOYMENTSTATUSDATE] datetime NULL,
    [drvYEARSOFSERVICE] int NULL,
    [drvANNUALSALARY] money NULL,
    [drvPerPayCompensation] nvarchar(4000) NULL,
    [drvYEARTODATEBASECOMPENSATION] money NULL,
    [drvYEARTODATTOTALCEMPEN] money NULL,
    [drvEMPLOYEEPLANSTATUS] varchar(1) NULL,
    [drvPlanEntryDate] datetime NULL,
    [drvCONTOURCECODE1] varchar(1) NOT NULL,
    [drvDEFERRALPERCENTAGECS1] nvarchar(4000) NULL,
    [drvPAYPERDEFERRALAMOUNT1] nvarchar(4000) NULL,
    [drvCONTRIBUTIONSOURCECODE2] varchar(1) NULL,
    [drvDEFERRALPERCENTAGECS2] nvarchar(4000) NULL,
    [drvPAYPERDEFERRALAMOUNT2] nvarchar(4000) NULL,
    [drvEmployerContEligiSource1] varchar(1) NULL,
    [drvEmployerContEligDate1] varchar(30) NULL,
    [drvEmployerContEligiSource2] varchar(1) NULL,
    [drvEmployerContEligDate2] varchar(30) NULL,
    [drvYEAR] varchar(4) NOT NULL,
    [drvTOTALCONTRIBUTIONYTD] nvarchar(4000) NULL,
    [drvCONTRIBSOURCECODE1] varchar(1) NULL,
    [drvTOTALCONTRIBSOURCE1] nvarchar(4000) NULL,
    [drvCONTRIBSOURCECODE2] varchar(1) NULL,
    [drvTOTALCONTRIBYTDSOURCE2] nvarchar(4000) NULL,
    [drvCONTRIBSOURCECODE3] varchar(1) NULL,
    [drvTOTALCONTRIBYTDSOURCE3] nvarchar(4000) NULL,
    [drvCONTRIBSOURCECODE4] varchar(1) NULL,
    [drvTOTALCONTRIBYTDSOURCE4] nvarchar(4000) NULL
);

-----------
-- Create table U_EGIFTIAAEX_EEList
-----------

IF OBJECT_ID('U_EGIFTIAAEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGIFTIAAEX_File
-----------

IF OBJECT_ID('U_EGIFTIAAEX_File') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EGIFTIAAEX_Header
-----------

IF OBJECT_ID('U_EGIFTIAAEX_Header') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_Header] (
    [drvORIGINATINGVENDORSUBPLANID] varchar(30) NOT NULL,
    [drvYEARTODATEBASECOMPENSATION] varchar(30) NOT NULL,
    [drvYEARTODATTOTALCEMPEN] varchar(31) NOT NULL,
    [drvALTRETIREELIGSTARTDATE] varchar(53) NOT NULL,
    [drvEmployerContEligSource1] varchar(41) NOT NULL,
    [drvEmployerContEligDate1] varchar(39) NOT NULL,
    [drvEmployerContEligSource2] varchar(41) NOT NULL,
    [drvEmployerContEligDate2] varchar(39) NOT NULL,
    [drvNEXTAUTODEFINCREASEDATE] varchar(37) NOT NULL,
    [drvNEXTAUTODEFINCREASEENDDATE] varchar(41) NOT NULL,
    [drvAUTODEFINCREASEFREQUENCY] varchar(37) NOT NULL,
    [drvAUTODEFINCREASEAMOUNT] varchar(34) NOT NULL,
    [drvAUTODEFINCREASEAMTMAX] varchar(42) NOT NULL,
    [drvAUTODEFINCREASEPERCENT] varchar(38) NOT NULL,
    [drvAUTODEFINCREASEPERCENTMAX] varchar(46) NOT NULL,
    [drvNUMBEROFYEARSHISTREPORTED] varchar(32) NOT NULL,
    [drvTOTALCONTRIBYTDSOURCE2] varchar(32) NOT NULL,
    [drvTOTALCONTRIBYTDSOURCE3] varchar(32) NOT NULL,
    [drvTOTALCONTRIBYTDSOURCE4] varchar(32) NOT NULL
);

-----------
-- Create table U_EGIFTIAAEX_PDedHist
-----------

IF OBJECT_ID('U_EGIFTIAAEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayDate] datetime NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh403] numeric NULL,
    [Pdh457x] numeric NULL,
    [Pdh403x] numeric NULL,
    [Pdh403ER] numeric NULL,
    [PdhROTH] numeric NULL,
    [Pdh403M] numeric NULL
);

-----------
-- Create table U_EGIFTIAAEX_PEarHist
-----------

IF OBJECT_ID('U_EGIFTIAAEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EGIFTIAAEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGIFTIAAEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gifford Medical Center 

Created By: Marie Waters
Business Analyst: Julie Reardon
Create Date: 08/04/2022
Service Request Number: TekP2022-06-15-01

Purpose: TIAA Deferred Compensation

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGIFTIAAEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGIFTIAAEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGIFTIAAEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGIFTIAAEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGIFTIAAEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGIFTIAAEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGIFTIAAEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGIFTIAAEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGIFTIAAEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGIFTIAAEX', 'SCH_EGIFTI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EGIFTIAAEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EGIFTIAAEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EGIFTIAAEX';

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
    DELETE FROM dbo.U_EGIFTIAAEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EGIFTIAAEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EGIFTIAAEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_AuditFields;
    CREATE TABLE dbo.U_EGIFTIAAEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EGIFTIAAEX_AuditFields VALUES ('Empcomp','EecEmplStatus')

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EGIFTIAAEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_Audit;
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
    INTO dbo.U_EGIFTIAAEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EGIFTIAAEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EGIFTIAAEX_Audit ON dbo.U_EGIFTIAAEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EGIFTIAAEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EGIFTIAAEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403,403CU,403M,403PD,457,457CU,ROTH';

    IF OBJECT_ID('U_EGIFTIAAEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EGIFTIAAEX_DedList
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
    IF OBJECT_ID('U_EGIFTIAAEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh403      = SUM(CASE WHEN PdhDedCode IN ('403') THEN PdhERCurAmt ELSE 0.00 END)
        ,Pdh457x     = SUM(CASE WHEN PdhDedCode IN ('457','457CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403x     = SUM(CASE WHEN PdhDedCode IN ('403CU','403M','403PD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403ER    = SUM(CASE WHEN PdhDedCode IN ('403M') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhROTH     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)  
        ,Pdh403M     = SUM(CASE WHEN PdhDedCode IN ('403M') THEN (PdhEECurAmt) ELSE 0.00 END)  
    INTO dbo.U_EGIFTIAAEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EGIFTIAAEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode and dedCode in ('403','403CU','403M','403PD','457','457CU','ROTH')
      WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
   -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EGIFTIAAEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_PEarHist;
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
    INTO dbo.U_EGIFTIAAEX_PEarHist
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
    -- DETAIL RECORD - U_EGIFTIAAEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGIFTIAAEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_drvTbl;
    SELECT * 
    INTO dbo.U_EGIFTIAAEX_drvTbl
        FROM ( 
  
         SELECT DISTINCT
                 drvEEID = xEEID
                ,drvCoID = xCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvSort = EecEmpNo
                ,drvSubSort = 1
                -- standard fields above and additional driver fields below
                ,drvDetailRecordID = 'D'
                ,drvEMPLOYERNAME = (SELECT TOP 1 CmmCompanyName from dbo.CompMast WITH (NOLOCK))
                ,drvEMPLOYEREIN = (SELECT TOP 1 CmmFedtaxId from dbo.CompMast WITH (NOLOCK))
                ,drvEMPLOYERPLANID =  '408326'                                           
                ,drvORIGINATINGVENDORPLANID =  '408326'                                    
                ,drvRECIPIENTVENDORPLANID =  '408326'                             
                ,drvPAYROLLFREQUENCY = CASE WHEN PgrPayFrequency = 'B' THEN 26 END
                ,drvEmployeeSSN = eepSSN
                ,drvEMPLOYEEID = EecEmpNo
                ,drvEMPLOYEEFIRSTNAME = EepNameFirst
                ,drvEMPLOYEEMIDDLENAME = LEFT(EepNameMiddle,1)
                ,drvEMPLOYEELASTNAME = EepNameLast
                ,drvADDRESSLINE1 = EepAddressLine1
                ,drvADDRESSLINE2 = EepAddressLine2
                ,drvCITY = EepAddressCity
                ,drvSTATE = EepAddressState
                ,drvZIPCode = EepAddressZipCode
                ,drvCOUNTRYCODE = CASE WHEN EepAddressCountry = 'USA' then 'US' END
                ,drvRESIDENCYCODE = CASE WHEN EepI9WorkAuth in ('U', 'P', 'C') then 'U'  else 'N' END
                ,drvDATEOFBIRTH = EepDateOfBirth
                ,drvGENDER = EepGender
                ,drvMARITALSTATUS = CASE WHEN EepMaritalStatus in ('C', 'M', 'P') then 'M' else 'S' END
                ,drvPHONEHOMENUMBER = EepPhoneHomeNumber
                ,drvEMAILADDRESS = EepAddressEMail
                ,drvDateofHire = EecDateOfOriginalHire
                ,drvEMPLOYMENTSTATUS = CASE WHEN EecEmplStatus = 'A' then 'E'  else EecEmplStatus END
                ,drvEmploymentSubType = CASE WHEN EecEmplStatus = 'A' and EecDateOfLastHire = EecDateOfOriginalHire then 'O'
                                             WHEN EecEmplStatus = 'A' and EecDateOfLastHire <> EecDateOfOriginalHire then 'R'
                                             WHEN EecEmplStatus  = 'T' then ''
                                             WHEN EecEmplStatus  = 'L' then 'A'
                                            END
                ,drvEMPLOYMENTSTATUSDATE = EecEmplStatusStartDate
                ,drvYEARSOFSERVICE =  DATEDIFF(YEAR, EecDateOfBenefitSeniority,GETDATE())
                ,drvANNUALSALARY = EecAnnSalary
                ,drvPerPayCompensation =  Format(EecPeriodPayRate,'#0.0000')
                ,drvYEARTODATEBASECOMPENSATION = PehInclInDefCompYTD 
                ,drvYEARTODATTOTALCEMPEN = PehCurAmtYTD
                ,drvEMPLOYEEPLANSTATUS =  CASE WHEN (DedCode_403x IS NOT NULL OR DedCode_ROTH IS NOT NULL) AND DedCode_403x_StopDate IS NULL THEN 'P'
                                            WHEN (DedCode_403x IS NOT NULL OR DedCode_ROTH IS NOT NULL) AND DedCode_403x_StopDate IS NOT NULL THEN 'E'
                                            ELSE 'E'
                                            END
                ,drvPlanEntryDate = EecDateOfLastHire
                ,drvCONTOURCECODE1 = CASE WHEN (DedCode_403x IS NOT NULL and isnull(BdmEECalcRateOrPct_403x,'0.00') > '0.00') or isnull(BdmEECalcRateOrPct_403x,'0.00') > '0.00' or isnull(EEAmt403x,'0.00') > '0.00' THEN 'E' else '' END
                ,drvDEFERRALPERCENTAGECS1 =  CASE WHEN (DedCode_403x IS NOT NULL and isnull(BdmEECalcRateOrPct_403x,'0.00') > '0.00') or isnull(BdmEECalcRateOrPct_403x,'0.00') > '0.00' THEN Format(isnull(isnull(BdmEECalcRateOrPct_403x,'') * 100, ''),'#0.00') Else ''  END
                ,drvPAYPERDEFERRALAMOUNT1 = CASE WHEN ((DedCode_403x IS NOT NULL and isnull(EEAmt403x,'0.00') > '0.00' ) or isnull(EEAmt403x,'0.00') > '0.00') THEN format(isnull(EEAmt403x,' ') ,'#0.00') else ''  END
                ,drvCONTRIBUTIONSOURCECODE2 =  CASE WHEN ( DedCode_ROTH IS NOT NULL and isnull(BdmEECalcRateOrPct_ROTH,'0.00') > '0.00' ) or isnull(BdmEECalcRateOrPct_ROTH,'0.00') > '0.00' or isnull(ROTHEEAmt,'0.00') > '0.00' THEN '2' END 
                ,drvDEFERRALPERCENTAGECS2 = CASE WHEN (DedCode_ROTH IS NOT NULL and isnull(BdmEECalcRateOrPct_ROTH,'0.00') > '0.00') or isnull(BdmEECalcRateOrPct_ROTH,'0.00') > '0.00' THEN Format(isnull(isnull(BdmEECalcRateOrPct_ROTH,'') *100, '') ,'#0.00') else ''  END
                ,drvPAYPERDEFERRALAMOUNT2 = CASE WHEN ((DedCode_ROTH IS NOT NULL and  isnull(ROTHEEAmt,'0.00') > '0.00') or  isnull(ROTHEEAmt,'0.00') > '0.00') then FORMAT(isnull(ROTHEEAmt,''),'#0.00') else '' END
                ,drvEmployerContEligiSource1 =  CASE WHEN DedCode_403 IS NOT NULL and EecDateOfBenefitSeniority is not null THEN 'F' END
                ,drvEmployerContEligDate1 = CONVERT(varchar,CASE WHEN DedCode_403 IS NOT NULL and EecDateOfBenefitSeniority is not null  THEN EecDateOfBenefitSeniority END,112)
                ,drvEmployerContEligiSource2 = CASE WHEn DedCode_403M IS NOT NULL and EecDateOfBenefitSeniority is not null then 'D' END
                ,drvEmployerContEligDate2 =CONVERT(varchar,CASE WHEN DedCode_403M IS NOT NULL and EecDateOfBenefitSeniority is not null THEN EecDateOfBenefitSeniority END,112)
                ,drvYEAR = '2022'
                ,drvTOTALCONTRIBUTIONYTD = Format(( Pdh403 + Pdh403x + Pdh403ER + PdhROTH ),'#0.00')
                ,drvCONTRIBSOURCECODE1 = CASE WHEN  ( DedCode_403 IS NOT NULL and  Format(Pdh403,'#0.00')  > '0.00' ) or Format(Pdh403,'#0.00')  > '0.00'  then 'F' END
                ,drvTOTALCONTRIBSOURCE1 =  CASE WHEN Format(Pdh403,'#0.00')  > '0.00' THEN Format(Pdh403,'#0.00') END --'Sum (PdhEECurAmt) where PdhDedCode = '403' from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE2 = CASE WHEN (DedCode_403x IS NOT NULL and  Format(Pdh403x,'#0.00') > '0.00') or Format(Pdh403x,'#0.00') > '0.00' then 'E' END
                ,drvTOTALCONTRIBYTDSOURCE2 = CASE WHEN Format(Pdh403x,'#0.00') > '0.00' THEN Format(Pdh403x,'#0.00') END --Format(PdhTOTALCONTRIBYTDSOURCE2,'#0.00') --Sum (PdhEECurAmt) where PdhDedCode in ('457','457CU', '403CU','403M','403PD') from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE3 = CASE WHEN (DedCode_ROTH IS NOT NULL and format(PdhROTH,'#0.00')  > '0.00' ) or format(PdhROTH,'#0.00')  > '0.00' then '2'END
                ,drvTOTALCONTRIBYTDSOURCE3 = CASE WHEN  format(PdhROTH,'#0.00')  > '0.00' THEN format(isnull(PdhROTH, ''),'#0.00') END--'Sum (PdhEECurAmt) where PdhDedCode = 'ROTH' from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE4 = CASE WHEN (DedCode_403M IS NOT NULL and  Format(Pdh403ER,'#0.00') > '0.00' ) or Format(Pdh403ER,'#0.00') > '0.00' then 'D' END
                ,drvTOTALCONTRIBYTDSOURCE4 = CASE WHEN Format(Pdh403ER,'#0.00') > '0.00' THEN  Format(Pdh403ER,'#0.00') END --S
           -- INTO dbo.U_EGIFTIAAEX_drvTbl
             FROM dbo.U_EGIFTIAAEX_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
            JOIN dbo.PayGroup WITH (NOLOCK)
                ON PgrPayGroup = EecPayGroup
                 JOIN dbo.U_EGIFTIAAEX_PDedHist WITH (NOLOCK)
                ON PdhEEID = xEEID
    
            --Left JOIN dbo.U_dsi_BDM_EGIFTIAAEX WITH (NOLOCK)
            --    ON BdmEEID = xEEID 
            --    AND BdmCoID = xCoID 
                --and BdmDedCode IN ('403','403CU','403M','403PD','ROTH')
            LEFT JOIN (
                        SELECT BdmEEID AS BdmP1EEID, BdmCOID AS BdmP1COID
                            --,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmDedCode END) AS DedCode_457
                            --,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmBenStopDate END) AS DedCode_457_StopDate
                            --,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_457
                            ,Sum(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') and BdmEECalcRateOrPct> 0 THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_403x
                            ,MAX(CASE WHEN BdmDedCode = '403' THEN BdmDedCode END) AS DedCode_403
                            ,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmDedCode END) AS DedCode_403x
                            ,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmBenStopDate END) AS DedCode_403x_StopDate
                            ,Sum(CASE WHEN BdmDedCode = 'ROTH' and BdmEECalcRateOrPct> 0 THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_ROTH
                            ,MAX(CASE WHEN BdmDedCode IN ('ROTH') THEN BdmDedCode END) AS DedCode_ROTH
                            ,MAX(CASE WHEN BdmDedCode IN ('403M') THEN BdmDedCode END) AS DedCode_403M
                            ,Sum(CASE WHEN BdmDedCode IN ('ROTH') THEN BdmEEAmt END)  AS ROTHEEAmt
                            ,Sum(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmEEAmt END) AS EEAmt403x
                        FROM dbo.U_dsi_BDM_EGIFTIAAEX WITH (NOLOCK)
                        WHERE BdmDedCode IN ('403','403CU','403M','403PD','ROTH') -- ,'457','457CU')
                        GROUP BY BdmEEID, BdmCOID) AS PlanOneBdm
                ON BdmP1EEID = xEEID
                AND BdmP1COID = xCOID
             LEFT JOIN (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                        FROM (
                                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                                FROM dbo.EmpHStat WITH (NOLOCK) ) AS LOA_Dates 
                        WHERE RN = 1) AS EshDates 
                ON EshEEID = xEEID 
                AND EshCOID = xCOID
            Left JOIN dbo.U_EGIFTIAAEX_PEarHist WITH (NOLOCK)
                ON PehEEID = xEEID


            Union all

            SELECT DISTINCT
                 drvEEID = xEEID
                ,drvCoID = xCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvSort = EecEmpNo
                ,drvSubSort = 2
                -- standard fields above and additional driver fields below
                ,drvDetailRecordID = 'D'
                ,drvEMPLOYERNAME = (SELECT TOP 1 CmmCompanyName from dbo.CompMast WITH (NOLOCK))
                ,drvEMPLOYEREIN = (SELECT TOP 1 CmmFedtaxId from dbo.CompMast WITH (NOLOCK))
                ,drvEMPLOYERPLANID = '408330'
                               
                ,drvORIGINATINGVENDORPLANID =  '408330'
                                       
                ,drvRECIPIENTVENDORPLANID =  '408330'
                                       
                ,drvPAYROLLFREQUENCY = CASE WHEN PgrPayFrequency = 'B' THEN 26 END
                ,drvEmployeeSSN = eepSSN
                ,drvEMPLOYEEID = EecEmpNo
                ,drvEMPLOYEEFIRSTNAME = EepNameFirst
                ,drvEMPLOYEEMIDDLENAME = LEFT(EepNameMiddle,1)
                ,drvEMPLOYEELASTNAME = EepNameLast
                ,drvADDRESSLINE1 = EepAddressLine1
                ,drvADDRESSLINE2 = EepAddressLine2
                ,drvCITY = EepAddressCity
                ,drvSTATE = EepAddressState
                ,drvZIPCode = EepAddressZipCode
                ,drvCOUNTRYCODE = CASE WHEN EepAddressCountry = 'USA' then 'US' END
                ,drvRESIDENCYCODE = CASE WHEN EepI9WorkAuth in ('U', 'P', 'C') then 'U'  else 'N' END
                ,drvDATEOFBIRTH = EepDateOfBirth
                ,drvGENDER = EepGender
                ,drvMARITALSTATUS = CASE WHEN EepMaritalStatus in ('C', 'M', 'P') then 'M' else 'S' END
                ,drvPHONEHOMENUMBER = EepPhoneHomeNumber
                ,drvEMAILADDRESS = EepAddressEMail
                ,drvDateofHire = EecDateOfOriginalHire
                ,drvEMPLOYMENTSTATUS = CASE WHEN EecEmplStatus = 'A' then 'E'  else EecEmplStatus END
                ,drvEmploymentSubType = CASE WHEN EecEmplStatus = 'A' and EecDateOfLastHire = EecDateOfOriginalHire then 'O'
                                             WHEN EecEmplStatus = 'A' and EecDateOfLastHire <> EecDateOfOriginalHire then 'R'
                                             WHEN EecEmplStatus  = 'T' then ''
                                             WHEN EecEmplStatus  = 'L' then 'A'
                                            END
                ,drvEMPLOYMENTSTATUSDATE = EecEmplStatusStartDate
                ,drvYEARSOFSERVICE =  DATEDIFF(YEAR, EecDateOfBenefitSeniority,GETDATE())
                ,drvANNUALSALARY = EecAnnSalary
                ,drvPerPayCompensation =  Format(EecPeriodPayRate,'#0.0000')
                ,drvYEARTODATEBASECOMPENSATION = PehInclInDefCompYTD 
                ,drvYEARTODATTOTALCEMPEN = PehCurAmtYTD
                ,drvEMPLOYEEPLANSTATUS =    CASE WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NOT NULL AND DedCode_457_StopDate IS NULL THEN 'P'
                                            WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NOT NULL AND DedCode_457_StopDate IS NOT NULL THEN 'E'
                                            WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NULL THEN 'E'
                                            END
                ,drvPlanEntryDate = EecDateOfLastHire
                ,drvCONTOURCECODE1 = CASE WHEN (DedCode_457 IS NOT NULL and isnull(BdmEECalcRateOrPct_457,'0.00') > '0.00' ) or isnull(BdmEECalcRateOrPct_457,'0.00') > '0.00' or isnull(EEAmt457,'0.00') > '0.00' then 'E' else ''  END
                ,drvDEFERRALPERCENTAGECS1 =  CASE WHEN (DedCode_457 IS NOT NULL and isnull(BdmEECalcRateOrPct_457,'0.00') > '0.00') or isnull(BdmEECalcRateOrPct_457,'0.00') > '0.00' then Format(isnull(BdmEECalcRateOrPct_457,'') * 100,'#0.00') else '' END
                ,drvPAYPERDEFERRALAMOUNT1 = CASE WHEN (DedCode_457 IS NOT NULL and isnull (EEAmt457,'0.00') > '0.00') or isnull(EEAmt457,'0.00') > '0.00' THEN format(isnull(EEAmt457,''),'0.00') else '' END
                ,drvCONTRIBUTIONSOURCECODE2 = ''--  CASE WHEN DedDedCode  = 'ROTH' then '2' END 
                ,drvDEFERRALPERCENTAGECS2 = ''-- Format(CASE WHEN DedDedCode  = 'ROTH' then eedEECalcRateOrPct END,'#0.00')
                ,drvPAYPERDEFERRALAMOUNT2 = ''
                ,drvEmployerContEligiSource1 = ''--  CASE WHEN DedDedCode  = '403' then 'F' END
                ,drvEmployerContEligDate1 = ''-- CASE WHEN DedDedCode  = '403' then EecDateOfBenefitSeniority END
                ,drvEmployerContEligiSource2 = ''-- CASE WHEn DedDedCode  = '403M' then 'D' END
                ,drvEmployerContEligDate2 = ''-- CASE WHEN DedDedCode  = '403M' then EecDateOfBenefitSeniority END
                ,drvYEAR = '2022'
                ,drvTOTALCONTRIBUTIONYTD = CASE WHEN Format(( Pdh457x ),'#0.00') > '0.00' THEN Format(isnull( Pdh457x, '' ),'#0.00') END
                ,drvCONTRIBSOURCECODE1 =' '--  CASE WHEn DedDedCode  = '403' then 'F' END
                ,drvTOTALCONTRIBSOURCE1 = ' '--  Format(Pdh403,'#0.00')  --'Sum (PdhEECurAmt) where PdhDedCode = '403' from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE2 = CASE WHEN (DedCode_457 IS NOT NULL and Format(Pdh457x,'#0.00') > '0.00') or Format(Pdh457x,'#0.00') > '0.00' THEN 'E' END
                ,drvTOTALCONTRIBYTDSOURCE2 = CASE WHEN Format(Pdh457x,'#0.00') > '0.00'  THEN Format(Pdh457x,'#0.00') END--Sum (PdhEECurAmt) where PdhDedCode in ('457','457CU', '403CU','403M','403PD') from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE3 = ''-- CASE WHEN DedDedCode = 'ROTH' then '2'END
                ,drvTOTALCONTRIBYTDSOURCE3 = ''-- format(PdhROTH,'#0.00')--'Sum (PdhEECurAmt) where PdhDedCode = 'ROTH' from 1st per control of the year to the last closed per control of the year
                ,drvCONTRIBSOURCECODE4 = ''-- CASE WHEN DedDedCode = '403M' then 'D' END
                ,drvTOTALCONTRIBYTDSOURCE4 = ''-- Format(Pdh403M,'#0.00') --Sum (PdhERCurAmt) where PdhDedCode = '403M' from 1st per control of the year to the last closed per control of the year
            --INTO dbo.U_EGIFTIAAEX_drvTbl
             FROM dbo.U_EGIFTIAAEX_EEList WITH (NOLOCK)
            JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
            JOIN dbo.U_dsi_BDM_EGIFTIAAEX WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID            
            JOIN dbo.PayGroup WITH (NOLOCK)
                ON PgrPayGroup = EecPayGroup
            JOIN dbo.U_EGIFTIAAEX_PDedHist WITH (NOLOCK)
                ON PdhEEID = xEEID
            LEFT JOIN (
                            SELECT BdmEEID AS BdmP1EEID, BdmCOID AS BdmP1COID
                            ,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmDedCode END) AS DedCode_457
                            ,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmBenStopDate END) AS DedCode_457_StopDate
                            ,Sum(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_457
                            ,sum(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmEEAmt END) EEAmt457
                         --   ,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_403x
                            --,MAX(CASE WHEN BdmDedCode = '403' THEN BdmDedCode END) AS DedCode_403
                            --,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmDedCode END) AS DedCode_403x
                            --,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmBenStopDate END) AS DedCode_403x_StopDate
                            --,MAX(CASE WHEN BdmDedCode = 'ROTH' THEN BdmEECalcRateOrPct END) AS BdmEECalcRateOrPct_ROTH
                            --,MAX(CASE WHEN BdmDedCode IN ('ROTH') THEN BdmDedCode END) AS DedCode_ROTH
                            --,MAX(CASE WHEN BdmDedCode IN ('403M') THEN BdmDedCode END) AS DedCode_403M
                        FROM dbo.U_dsi_BDM_EGIFTIAAEX WITH (NOLOCK)
                        WHERE BdmDedCode IN ('457','457CU') --,'403','403CU','403M','403PD','ROTH') 
                        GROUP BY BdmEEID, BdmCOID) AS PlanOneBdm
                ON BdmP1EEID = xEEID
                AND BdmP1COID = xCOID
            LEFT JOIN (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                        FROM (
                                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                                FROM dbo.EmpHStat WITH (NOLOCK) ) AS LOA_Dates 
                        WHERE RN = 1) AS EshDates 
                ON EshEEID = xEEID 
                AND EshCOID = xCOID
              JOIN dbo.U_EGIFTIAAEX_PEarHist WITH (NOLOCK)
                ON PehEEID = xEEID
            WHERE BdmDedCode NOT IN ('403','403CU','403M','403PD','ROTH')


    )
    drv


        
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EGIFTIAAEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EGIFTIAAEX_Header;
    SELECT DISTINCT
         drvORIGINATINGVENDORSUBPLANID = 'ORIGINATING VENDOR SUB PLAN ID'
        ,drvYEARTODATEBASECOMPENSATION = 'YEAR TO DATE BASE COMPENSATION'
        ,drvYEARTODATTOTALCEMPEN = 'YEAR TO DATE TOTAL COMPENSATION'
        ,drvALTRETIREELIGSTARTDATE = 'ALTERNATIVE RETIREMENT VESTING ELIGIBILITY START DATE'
        ,drvEmployerContEligSource1 = 'Employer Contribution Eligibility Source1'
        ,drvEmployerContEligDate1 = 'Employer Contribution Eligibility Date1'
        ,drvEmployerContEligSource2 = 'Employer Contribution Eligibility Source2'
        ,drvEmployerContEligDate2 = 'Employer Contribution Eligibility Date2'
        ,drvNEXTAUTODEFINCREASEDATE = 'NEXT AUTOMATIC DEFERRAL INCREASE DATE'
        ,drvNEXTAUTODEFINCREASEENDDATE = 'NEXT AUTOMATIC DEFERRAL INCREASE END DATE'
        ,drvAUTODEFINCREASEFREQUENCY = 'AUTOMATIC DEFERRAL INCREASE FREQUENCY'
        ,drvAUTODEFINCREASEAMOUNT = 'AUTOMATIC DEFERRAL INCREASE AMOUNT'
        ,drvAUTODEFINCREASEAMTMAX = 'AUTOMATIC DEFERRAL INCREASE AMOUNT MAXIMUM'
        ,drvAUTODEFINCREASEPERCENT = 'AUTOMATIC DEFERRAL INCREASE PERCENTAGE'
        ,drvAUTODEFINCREASEPERCENTMAX = 'AUTOMATIC DEFERRAL INCREASE PERCENTAGE MAXIMUM'
        ,drvNUMBEROFYEARSHISTREPORTED = 'NUMBER OF YEARS HISTORY REPORTED'
        ,drvTOTALCONTRIBYTDSOURCE2 = 'TOTAL CONTRIBUTION YTD –SOURCE 2'
        ,drvTOTALCONTRIBYTDSOURCE3 = 'TOTAL CONTRIBUTION YTD –SOURCE 3'
        ,drvTOTALCONTRIBYTDSOURCE4 = 'TOTAL CONTRIBUTION YTD –SOURCE 4'
    INTO dbo.U_EGIFTIAAEX_Header
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
ALTER VIEW dbo.dsi_vwEGIFTIAAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGIFTIAAEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EGIFTIAAEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202208249'
       ,expEndPerControl       = '202208249'
WHERE expFormatCode = 'EGIFTIAAEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGIFTIAAEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGIFTIAAEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGIFTIAAEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGIFTIAAEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGIFTIAAEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGIFTIAAEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGIFTIAAEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGIFTIAAEX', 'UseFileName', 'V', 'Y'


-- End ripout