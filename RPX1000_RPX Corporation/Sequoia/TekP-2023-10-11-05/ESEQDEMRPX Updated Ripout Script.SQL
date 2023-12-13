/**********************************************************************************

ESEQDEMRPX: Sequoia Demographics Export

FormatCode:     ESEQDEMRPX
Project:        Sequoia Demographics Export
Client ID:      RPX1000
Date/time:      2023-12-13 07:13:22.233
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP1DB02
Database:       ULTIPRO_WPRPXCO
Web Filename:   RPX1000_C4EA3_EEHISTORY_ESEQDEMRPX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESEQDEMRPX_SavePath') IS NOT NULL DROP TABLE dbo.U_ESEQDEMRPX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESEQDEMRPX'


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
WHERE FormatCode = 'ESEQDEMRPX'
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
WHERE ExpFormatCode = 'ESEQDEMRPX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESEQDEMRPX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESEQDEMRPX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESEQDEMRPX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESEQDEMRPX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESEQDEMRPX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESEQDEMRPX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESEQDEMRPX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESEQDEMRPX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESEQDEMRPX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESEQDEMRPX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESEQDEMRPX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESEQDEMRPX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESEQDEMRPX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMRPX];
GO
IF OBJECT_ID('U_ESEQDEMRPX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_PEarHist];
GO
IF OBJECT_ID('U_ESEQDEMRPX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_PDedHist];
GO
IF OBJECT_ID('U_ESEQDEMRPX_File') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_File];
GO
IF OBJECT_ID('U_ESEQDEMRPX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_EEList];
GO
IF OBJECT_ID('U_ESEQDEMRPX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_drvTbl];
GO
IF OBJECT_ID('U_ESEQDEMRPX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_DedList];
GO
IF OBJECT_ID('U_ESEQDEMRPX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_AuditFields];
GO
IF OBJECT_ID('U_ESEQDEMRPX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESEQDEMRPX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESEQDEMRPX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESEQDEMRPX','Sequoia Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ESEQDEMRPXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEQDEMRPXZ0','50','H','01','1',NULL,'COMPANY NAME',NULL,NULL,'"COMPANY NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEQDEMRPXZ0','50','H','01','2',NULL,'APPLICATION COMPANY ID',NULL,NULL,'"APPLICATION COMPANY ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEQDEMRPXZ0','50','H','01','3',NULL,'EMPLOYEE ID',NULL,NULL,'"EMPLOYEE ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEQDEMRPXZ0','50','H','01','4',NULL,'EMPLOYEE SSN',NULL,NULL,'"EMPLOYEE SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEQDEMRPXZ0','50','H','01','5',NULL,'MEMBER SSN',NULL,NULL,'"MEMBER SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEQDEMRPXZ0','50','H','01','6',NULL,'NEW MEMBER SSN',NULL,NULL,'"NEW MEMBER SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEQDEMRPXZ0','50','H','01','7',NULL,'SSN CHANGE TYPE',NULL,NULL,'"SSN CHANGE TYPE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEQDEMRPXZ0','50','H','01','8',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESEQDEMRPXZ0','50','H','01','9',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESEQDEMRPXZ0','50','H','01','10',NULL,'MIDDLE NAME',NULL,NULL,'"MIDDLE NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESEQDEMRPXZ0','50','H','01','11',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESEQDEMRPXZ0','50','H','01','12',NULL,'RELATIONSHIP',NULL,NULL,'"RELATIONSHIP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESEQDEMRPXZ0','50','H','01','13',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESEQDEMRPXZ0','50','H','01','14',NULL,'MARITAL STATUS',NULL,NULL,'"MARITAL STATUS"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESEQDEMRPXZ0','50','H','01','15',NULL,'EMPLOYEE STATUS',NULL,NULL,'"EMPLOYEE STATUS"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESEQDEMRPXZ0','50','H','01','16',NULL,'EMPLOYEE STATUS DATE',NULL,NULL,'"EMPLOYEE STATUS DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESEQDEMRPXZ0','50','H','01','17',NULL,'HIRE DATE',NULL,NULL,'"HIRE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESEQDEMRPXZ0','50','H','01','18',NULL,'STREET ADDRESS1',NULL,NULL,'"STREET ADDRESS1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESEQDEMRPXZ0','50','H','01','19',NULL,'STREET ADDRESS2',NULL,NULL,'"STREET ADDRESS2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESEQDEMRPXZ0','50','H','01','20',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESEQDEMRPXZ0','50','H','01','21',NULL,'STATE',NULL,NULL,'"STATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESEQDEMRPXZ0','50','H','01','22',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESEQDEMRPXZ0','50','H','01','23',NULL,'HOME PHONE',NULL,NULL,'"HOME PHONE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESEQDEMRPXZ0','50','H','01','24',NULL,'CELL PHONE',NULL,NULL,'"CELL PHONE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESEQDEMRPXZ0','50','H','01','25',NULL,'WORK PHONE',NULL,NULL,'"WORK PHONE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESEQDEMRPXZ0','50','H','01','26',NULL,'WORK EMAIL',NULL,NULL,'"WORK EMAIL"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESEQDEMRPXZ0','50','H','01','27',NULL,'JOB TITLE',NULL,NULL,'"JOB TITLE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESEQDEMRPXZ0','50','H','01','28',NULL,'EMPLOYEE LOCATION',NULL,NULL,'"EMPLOYEE LOCATION"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESEQDEMRPXZ0','50','H','01','29',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL,'"EMPLOYEE LOCATION EFFECTIVE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESEQDEMRPXZ0','50','H','01','30',NULL,'EMPLOYEE CLASS',NULL,NULL,'"EMPLOYEE CLASS"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESEQDEMRPXZ0','50','H','01','31',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL,'"EMPLOYEE CLASS EFFECTIVE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESEQDEMRPXZ0','50','H','01','32',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL,'"EMPLOYEE DEPARTMENT"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESEQDEMRPXZ0','50','H','01','33',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL,'"EMPLOYEE DEPARTMENT EFFECTIVE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESEQDEMRPXZ0','50','H','01','34',NULL,'EMPLOYEE DIVISION',NULL,NULL,'"EMPLOYEE DIVISION"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESEQDEMRPXZ0','50','H','01','35',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL,'"EMPLOYEE DIVISION EFFECTIVE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESEQDEMRPXZ0','50','H','01','36',NULL,'PAY FREQUENCY',NULL,NULL,'"PAY FREQUENCY"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESEQDEMRPXZ0','50','H','01','37',NULL,'HOURS PER WEEK',NULL,NULL,'"HOURS PER WEEK"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESEQDEMRPXZ0','50','H','01','38',NULL,'ANNUAL WAGES',NULL,NULL,'"ANNUAL WAGES"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESEQDEMRPXZ0','50','H','01','39',NULL,'WAGES EFFECTIVE DATE',NULL,NULL,'"WAGES EFFECTIVE DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESEQDEMRPXZ0','50','H','01','40',NULL,'APPLICATION PERSON ID',NULL,NULL,'"APPLICATION PERSON ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESEQDEMRPXZ0','50','H','01','41',NULL,'PLAN YEAR',NULL,NULL,'"PLAN YEAR"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESEQDEMRPXZ0','50','H','01','42',NULL,'APPLICATION PLAN ID',NULL,NULL,'"APPLICATION PLAN ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESEQDEMRPXZ0','50','H','01','43',NULL,'PLAN TYPE',NULL,NULL,'"PLAN TYPE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESEQDEMRPXZ0','50','H','01','44',NULL,'PLAN GROUP NUMBER',NULL,NULL,'"PLAN GROUP NUMBER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESEQDEMRPXZ0','50','H','01','45',NULL,'CLASS CODE',NULL,NULL,'"CLASS CODE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESEQDEMRPXZ0','50','H','01','46',NULL,'ENROLLMENT STATUS',NULL,NULL,'"ENROLLMENT STATUS"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESEQDEMRPXZ0','50','H','01','47',NULL,'ENROLLMENT START DATE',NULL,NULL,'"ENROLLMENT START DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESEQDEMRPXZ0','50','H','01','48',NULL,'ENROLLMENT END DATE',NULL,NULL,'"ENROLLMENT END DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESEQDEMRPXZ0','50','H','01','49',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL,'"ORIGINAL ENROLLMENT START DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESEQDEMRPXZ0','50','H','01','50',NULL,'APPROVED AMOUNT',NULL,NULL,'"APPROVED AMOUNT"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESEQDEMRPXZ0','50','H','01','51',NULL,'REQUESTED AMOUNT',NULL,NULL,'"REQUESTED AMOUNT"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESEQDEMRPXZ0','50','H','01','52',NULL,'ENROLLMENT TYPE',NULL,NULL,'"ENROLLMENT TYPE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESEQDEMRPXZ0','50','H','01','53',NULL,'COVERAGE DESCRIPTION',NULL,NULL,'"COVERAGE DESCRIPTION"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESEQDEMRPXZ0','50','H','01','54',NULL,'COVERAGE TIER',NULL,NULL,'"COVERAGE TIER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESEQDEMRPXZ0','50','H','01','55',NULL,'PLAN NAME',NULL,NULL,'"PLAN NAME"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESEQDEMRPXZ0','50','D','10','1',NULL,'COMPANY NAME',NULL,NULL,'"RPX"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESEQDEMRPXZ0','50','D','10','2',NULL,'APPLICATION COMPANY ID',NULL,NULL,'"drvApplicationCompanyID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESEQDEMRPXZ0','50','D','10','3',NULL,'EMPLOYEE ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESEQDEMRPXZ0','50','D','10','4',NULL,'EMPLOYEE SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESEQDEMRPXZ0','50','D','10','5',NULL,'MEMBER SSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESEQDEMRPXZ0','50','D','10','6',NULL,'NEW MEMBER SSN',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESEQDEMRPXZ0','50','D','10','7',NULL,'SSN CHANGE TYPE',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESEQDEMRPXZ0','50','D','10','8',NULL,'FIRST NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESEQDEMRPXZ0','50','D','10','9',NULL,'LAST NAME',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESEQDEMRPXZ0','50','D','10','10',NULL,'MIDDLE NAME',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESEQDEMRPXZ0','50','D','10','11',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESEQDEMRPXZ0','50','D','10','12',NULL,'RELATIONSHIP',NULL,NULL,'"drvRelationship"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESEQDEMRPXZ0','50','D','10','13',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESEQDEMRPXZ0','50','D','10','14',NULL,'MARITAL STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESEQDEMRPXZ0','50','D','10','15',NULL,'EMPLOYEE STATUS',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESEQDEMRPXZ0','50','D','10','16',NULL,'EMPLOYEE STATUS DATE',NULL,NULL,'"drvEmployeeStatusDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESEQDEMRPXZ0','50','D','10','17',NULL,'HIRE DATE',NULL,NULL,'"drvHireDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESEQDEMRPXZ0','50','D','10','18',NULL,'STREET ADDRESS1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESEQDEMRPXZ0','50','D','10','19',NULL,'STREET ADDRESS2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESEQDEMRPXZ0','50','D','10','20',NULL,'CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESEQDEMRPXZ0','50','D','10','21',NULL,'STATE',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESEQDEMRPXZ0','50','D','10','22',NULL,'ZIP',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESEQDEMRPXZ0','50','D','10','23',NULL,'HOME PHONE',NULL,NULL,'"drvHomePhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESEQDEMRPXZ0','50','D','10','24',NULL,'CELL PHONE',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESEQDEMRPXZ0','50','D','10','25',NULL,'WORK PHONE',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESEQDEMRPXZ0','50','D','10','26',NULL,'WORK EMAIL',NULL,NULL,'"drvWorkEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESEQDEMRPXZ0','50','D','10','27',NULL,'JOB TITLE',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESEQDEMRPXZ0','50','D','10','28',NULL,'EMPLOYEE LOCATION',NULL,NULL,'"drvEmployeeLocation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESEQDEMRPXZ0','50','D','10','29',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL,'"drvEmployeeLocationEffDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESEQDEMRPXZ0','50','D','10','30',NULL,'EMPLOYEE CLASS',NULL,NULL,'"drvEmployeeClass"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESEQDEMRPXZ0','50','D','10','31',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL,'"drvEmployeeClassEffDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESEQDEMRPXZ0','50','D','10','32',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL,'"drvEmployeeDepartment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESEQDEMRPXZ0','50','D','10','33',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL,'"drvEmployeeDepartmentEffDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESEQDEMRPXZ0','50','D','10','34',NULL,'EMPLOYEE DIVISION',NULL,NULL,'"drvEmployeeDivision"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESEQDEMRPXZ0','50','D','10','35',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL,'"drvEmployeeDivisionEffectiveDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESEQDEMRPXZ0','50','D','10','36',NULL,'PAY FREQUENCY',NULL,NULL,'"drvPayFrequency"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESEQDEMRPXZ0','50','D','10','37',NULL,'HOURS PER WEEK',NULL,NULL,'"drvHoursPerWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESEQDEMRPXZ0','50','D','10','38',NULL,'ANNUAL WAGES',NULL,NULL,'"drvAnnualWages"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESEQDEMRPXZ0','50','D','10','39',NULL,'WAGES EFFECTIVE DATE',NULL,NULL,'"drvWagesEffectiveDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESEQDEMRPXZ0','50','D','10','40',NULL,'APPLICATION PERSON ID',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESEQDEMRPXZ0','50','D','10','41',NULL,'PLAN YEAR',NULL,NULL,'"drvPlanYear"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESEQDEMRPXZ0','50','D','10','42',NULL,'APPLICATION PLAN ID',NULL,NULL,'"drvApplicationPlanID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESEQDEMRPXZ0','50','D','10','43',NULL,'PLAN TYPE',NULL,NULL,'"drvPlanType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESEQDEMRPXZ0','50','D','10','44',NULL,'PLAN GROUP NUMBER',NULL,NULL,'"drvPlanGroupNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESEQDEMRPXZ0','50','D','10','45',NULL,'CLASS CODE',NULL,NULL,'"drvClassCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESEQDEMRPXZ0','50','D','10','46',NULL,'ENROLLMENT STATUS',NULL,NULL,'"drvEnrollmentStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESEQDEMRPXZ0','50','D','10','47',NULL,'ENROLLMENT START DATE',NULL,NULL,'"drvEnrollmentStartDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESEQDEMRPXZ0','50','D','10','48',NULL,'ENROLLMENT END DATE',NULL,NULL,'"drvEnrollmentEndDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESEQDEMRPXZ0','50','D','10','49',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL,'"drvOriginalEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESEQDEMRPXZ0','50','D','10','50',NULL,'APPROVED AMOUNT',NULL,NULL,'"drvApprovedAmount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESEQDEMRPXZ0','50','D','10','51',NULL,'REQUESTED AMOUNT',NULL,NULL,'"drvRequestedAmount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESEQDEMRPXZ0','50','D','10','52',NULL,'ENROLLMENT TYPE',NULL,NULL,'"drvEnrollmentType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESEQDEMRPXZ0','50','D','10','53',NULL,'COVERAGE DESCRIPTION',NULL,NULL,'"drvCoverateDesc"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESEQDEMRPXZ0','50','D','10','54',NULL,'COVERAGE TIER',NULL,NULL,'"drvCoverageTier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESEQDEMRPXZ0','50','D','10','55',NULL,'PLAN NAME',NULL,NULL,'"drvPlanName"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESEQDEMRPX_20231213.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',IAGFG',NULL,NULL,NULL,'Active Open Enrollment Export','202301019','EMPEXPORT','OEACTIVE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202301019','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011129','EMPEXPORT','OEPASSIVE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202011129','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202011121',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sequoia Demographics Export','202011129','EMPEXPORT','ONDEM_XOE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202011129','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202011121',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','6B2RH,IAGFG,RPJU9,RPJPN,6B2VD',NULL,NULL,NULL,'Sequoia Demo - Daily 2am','202204159','EMPEXPORT','SCH_ESEQDE','Apr 21 2022  9:28AM','ESEQDEMRPX',NULL,NULL,NULL,'202312019','Apr 15 2022 12:00AM','Dec 30 1899 12:00AM','202311241','1244','','','202204081',dbo.fn_GetTimedKey(),NULL,'us3cBeRPX1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',IAGFG',NULL,NULL,NULL,'Sequoia Demographics Exp-Test','202301111','EMPEXPORT','TEST_XOE','Jan 11 2023 12:00AM','ESEQDEMRPX',NULL,NULL,NULL,'202301111','Jan 11 2023 12:00AM','Dec 30 1899 12:00AM','202301051','1238','','','202301051',dbo.fn_GetTimedKey(),NULL,'us3cBeRPX1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMRPX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMRPX','D10','dbo.U_ESEQDEMRPX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESEQDEMRPX
-----------

IF OBJECT_ID('U_dsi_BDM_ESEQDEMRPX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESEQDEMRPX] (
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
-- Create table U_ESEQDEMRPX_Audit
-----------

IF OBJECT_ID('U_ESEQDEMRPX_Audit') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_Audit] (
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
-- Create table U_ESEQDEMRPX_AuditFields
-----------

IF OBJECT_ID('U_ESEQDEMRPX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESEQDEMRPX_DedList
-----------

IF OBJECT_ID('U_ESEQDEMRPX_DedList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESEQDEMRPX_drvTbl
-----------

IF OBJECT_ID('U_ESEQDEMRPX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvRelationship] varchar(22) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvEmployeeStatus] varchar(10) NULL,
    [drvEmployeeStatusDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvEmployeeLocation] varchar(25) NULL,
    [drvEmployeeLocationEffDate] datetime NULL,
    [drvEmployeeClass] varchar(7) NULL,
    [drvEmployeeClassEffDate] datetime NULL,
    [drvEmployeeDivision] varchar(10) NULL,
    [drvEmployeeDivisionEffectiveDate] datetime NULL,
    [drvEmployeeDepartment] varchar(10) NULL,
    [drvEmployeeDepartmentEffDate] datetime NULL,
    [drvPayFrequency] char(1) NULL,
    [drvHoursPerWeek] nvarchar(4000) NULL,
    [drvAnnualWages] nvarchar(4000) NULL,
    [drvWagesEffectiveDate] datetime NULL,
    [drvPlanYear] varchar(4) NOT NULL,
    [drvPlanType] varchar(3) NULL,
    [drvPlanGroupNumber] varchar(9) NULL,
    [drvClassCode] varchar(1) NOT NULL,
    [drvEnrollmentStatus] varchar(10) NOT NULL,
    [drvEnrollmentStartDate] datetime NULL,
    [drvEnrollmentEndDate] datetime NULL,
    [drvOriginalEnrollmentDate] datetime NULL,
    [drvApprovedAmount] nvarchar(4000) NULL,
    [drvRequestedAmount] nvarchar(4000) NULL,
    [drvEnrollmentType] varchar(1) NOT NULL,
    [drvCoverateDesc] varchar(5) NULL,
    [drvCoverageTier] varchar(3) NULL,
    [drvApplicationCompanyID] varchar(3) NOT NULL,
    [drvApplicationPlanID] char(5) NULL,
    [drvPlanName] varchar(40) NULL
);

-----------
-- Create table U_ESEQDEMRPX_EEList
-----------

IF OBJECT_ID('U_ESEQDEMRPX_EEList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESEQDEMRPX_File
-----------

IF OBJECT_ID('U_ESEQDEMRPX_File') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ESEQDEMRPX_PDedHist
-----------

IF OBJECT_ID('U_ESEQDEMRPX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_PDedHist] (
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
-- Create table U_ESEQDEMRPX_PEarHist
-----------

IF OBJECT_ID('U_ESEQDEMRPX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMRPX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: RPX Corporation

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/05/2021
Service Request Number: TekP-2020-11-09-0001

Purpose: Sequoia Demographics Export

Revision History
----------------
Update By           Date           Request Num          Desc
Darren Collard      03/19/2022     TekP-2022-02-08-01   Update Plan Year and Enrollment Start Date logic
Darren Collard      11/12/2022     TekP-2022-10-05-04   Added ADENT dedcode + 3 new fields (Application Company ID, Application Plan ID , Plan Name)
Marie Waters        11/28/2023       TekP-2023-10-11-05   Updated deduction codes and OE plan year coding.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESEQDEMRPX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESEQDEMRPX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'SCH_ESEQDE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESEQDEMRPX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESEQDEMRPX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESEQDEMRPX';

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
    DELETE FROM dbo.U_ESEQDEMRPX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESEQDEMRPX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESEQDEMRPX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES' or EecEEID IN ('9A8UWL0010J0','9I9KJJ0010J0')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
     SET @DedList = 'RPXAT,RPXHS,RPXHM,RPXGD,MKHMO,NLTDB,NELIF,NSLIF,NCLIF,NBLIF,NADD,NSTD,NLTD,NSTDB,VIS,VISBU,ADENT'; -- MW updated from 'RPXAT,RPXHS,RPXHM,RPXGD,MKHMO,SLTDB,LIFEE,SSLFE,SCLFE,ELIFE,SADD,SSTD,SLTD,SSTDB,VIS,VISBU,ADENT';
    --SET @DedList = 'APPO1,APPO2,DPMED,AHMO1,AHMO2,DPMED,EPO1,EPO2,DPMED,KHMO1,KHMO2,DPMED,ADEN1,ADEN2,DPDEN,DENP1,DENP2,DPDEN,VSNPR ,DPVIS,LIFER,BADD,VLP,VLEG,ADDEE,ADDEG,VLPSP,ADDSP,VLDEP,ADDCH,LTDER,STDER';


    IF OBJECT_ID('U_ESEQDEMRPX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESEQDEMRPX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESEQDEMRPX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_AuditFields;
    CREATE TABLE dbo.U_ESEQDEMRPX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','EecDedGroupCode');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','eecOrglvl2');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','eecOrglvl1');

    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESEQDEMRPX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_Audit;
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
--        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESEQDEMRPX_Audit
    FROM dbo.U_ESEQDEMRPX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESEQDEMRPX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE'
    --AND 
    ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_ESEQDEMRPX_Audit WHERE audRowNo > 1;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate -30);
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

    
    DELETE dbo.U_dsi_BDM_ESEQDEMRPX 
    where BdmDedCode IN ('VLP','VLEG','ADDEE','ADDEG') AND BdmRecType <> 'EMP'

    
    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ESEQDEMRPX D
    JOIN dbo.U_dsi_bdm_ESEQDEMRPX E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESEQDEMRPX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_PDedHist;
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
    INTO dbo.U_ESEQDEMRPX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESEQDEMRPX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESEQDEMRPX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_PEarHist;
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
    INTO dbo.U_ESEQDEMRPX_PEarHist
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
    -- DETAIL RECORD - U_ESEQDEMRPX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESEQDEMRPX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_drvTbl;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvSSN = eepSSN
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                ELSE
                                    CASE WHEN ConRelationship IN ('SPS','DPR') THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partner'
                                        WHEN ConRelationship IN ('CHL','STC','CHD') THEN 'Child'
                                        WHEN ConRelationship = 'DPC' THEN 'Domestic Partner Child'
                                    END
                            END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvMaritalStatus = CASE WHEN  eepMaritalStatus = 'S' THEN 'I'
                                 WHEN  eepMaritalStatus = 'C' THEN 'B'
                                 WHEN eepMaritalStatus in ('','Z')  THEN 'R'
                                 WHEN eepMaritalStatus = 'P' THEN 'S'
                                 ELSE  eepMaritalStatus
                            END
        ,drvEmployeeStatus =    CASE WHEN EecEmplStatus = 'T'  and eectermreason = '203' THEN 'Deceased'
                                     WHEN EecEmplStatus = 'T'  and eectermreason <> '203' THEN 'Terminated'
                                    WHEN EecEmplStatus = 'L' THEN 'L1'
                                    WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                                    WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                                END
        ,drvEmployeeStatusDate = CASE WHEN BdmRecType = 'EMP' and EecEmplStatus = 'T' THEN eecdateoftermination ELSE EecEmplStatusStartDate END
        ,drvHireDate = CASE WHEN BdmRecType = 'EMP' THEN EecDateOfLastHire END
        ,drvAddressLine1 = eepAddressLine1 
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = ''
        ,drvWorkEmail = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
        ,drvJobTitle = CASE WHEN BdmRecType = 'EMP' THEN JbcDesc END
        ,drvEmployeeLocation = CASE WHEN BdmRecType = 'EMP' THEN LocDesc END
        ,drvEmployeeLocationEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'EecLocation') END
        ,drvEmployeeClass =   CASE WHEN EecDedGroupCode <> 'NONE' THEN 'Regular' END
        ,drvEmployeeClassEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'EecDedGroupCode') END
        ,drvEmployeeDivision = CASE WHEN BdmRecType = 'EMP' THEN eecOrglvl1 END
        ,drvEmployeeDivisionEffectiveDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'eecOrglvl1') END
        ,drvEmployeeDepartment = CASE WHEN BdmRecType = 'EMP' THEN eecOrglvl2 END
        ,drvEmployeeDepartmentEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'eecOrglvl2') END
        ,drvPayFrequency = CASE WHEN BdmRecType = 'EMP' THEN PgrPayFrequency END
        ,drvHoursPerWeek = CASE WHEN BdmRecType = 'EMP' THEN FORMAT( (EecScheduledWorkHrs * 24 ) / 52, '#0.00') END
        ,drvAnnualWages = CASE WHEN BdmRecType = 'EMP' THEN FORMAT(EecAnnSalary, '#0.00') END
        ,drvWagesEffectiveDate = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GetDATE(), eecDateOfLastHire) END
        --,drvPlanYear = CAST( CASE WHEN YEAR(BdmBenStartDAte) < 2021 THEN '2021' ELSE  YEAR(BdmBenStartDAte) END as varchar) -- FORMAT(DATEPART(YEAR, BdmBenStartDate), '0000')
        ,drvPlanYear = '2024'--CASE WHEN @ExportCode LIKE 'OE%' THEN CAST(YEAR(@EndDate)+1  AS varchar(4)) ELSE CAST(YEAR(@EndDate) AS varchar(4)) END -- MW add case for OE 11/28/23
        ,drvPlanType =    CASE  WHEN Bdmdedcode = 'RPXAT' THEN 'PPO'
                                WHEN Bdmdedcode = 'RPXHS' THEN 'HSA'
                                WHEN Bdmdedcode = 'RPXHM' THEN 'HMO'
                                WHEN Bdmdedcode = 'RPXGD' THEN 'DEN'
                                WHEN Bdmdedcode = 'ADENT' THEN 'DEN'      -- ADENT to the Case statement. CB 202301111
                                WHEN Bdmdedcode = 'MKHMO' THEN 'HMO'
                                WHEN Bdmdedcode = 'NLTDB' THEN 'LTD' --'SLTDB' MW updated 11/28
                                WHEN Bdmdedcode = 'NELIF' THEN 'LM'  --'LIFEE' MW updated 11/28
                                WHEN Bdmdedcode = 'NSLIF' THEN 'LS'  --'SSLFE' MW updated 11/28
                                WHEN Bdmdedcode = 'NCLIF' THEN 'LC'  --'SCLFE' MW updated 11/28
                                WHEN Bdmdedcode = 'NBLIF' THEN 'LIF' --'ELIFE' MW updated 11/28
                                WHEN Bdmdedcode = 'NADD' THEN 'AJ'   --'SADD' MW updated 11/28
                                WHEN Bdmdedcode = 'NSTD' THEN 'STD'  --'SSTD' MW updated 11/28
                                WHEN Bdmdedcode = 'NLTD' THEN 'LTD'  --'SLTD' MW updated 11/28
                                WHEN Bdmdedcode = 'NSTDB' THEN 'STD' --'SSTDB' MW updated 11/28
                                WHEN Bdmdedcode = 'VIS' THEN 'VIS'
                                WHEN Bdmdedcode = 'VISBU' THEN 'VIS'
                        END
        ,drvPlanGroupNumber =    CASE   WHEN Bdmdedcode = 'RPXAT' THEN '117497'
                                        WHEN Bdmdedcode = 'RPXHS' THEN '117497'
                                        WHEN Bdmdedcode = 'RPXHM' THEN '117497'
                                        WHEN Bdmdedcode = 'ADENT' THEN '117497'     -- ADENT's Policy number to the Case statement. CB 202301111
                                        WHEN Bdmdedcode = 'RPXGD' THEN '00556372'
                                        WHEN Bdmdedcode = 'MKHMO' THEN '000603773'
                                        WHEN Bdmdedcode = 'NLTDB' THEN '160627' --'SLTDB' MW updated 11/28
                                        WHEN Bdmdedcode = 'NELIF' THEN '160627' --'LIFEE' MW updated 11/28
                                        WHEN Bdmdedcode = 'NSLIF' THEN '160627' --'SSLFE' MW updated 11/28
                                        WHEN Bdmdedcode = 'NCLIF' THEN '160627' --'SCLFE' MW updated 11/28
                                        WHEN Bdmdedcode = 'NBLIF' THEN '160627' ---'ELIFE' MW updated 11/28
                                        WHEN Bdmdedcode = 'NADD' THEN '160627'   --'SADD' MW updated 11/28
                                        WHEN Bdmdedcode = 'NSTD' THEN '160627'  --'SSTD' MW updated 11/28
                                        WHEN Bdmdedcode = 'NLTD' THEN '160627'  --'SLTD' MW updated 11/28
                                        WHEN Bdmdedcode = 'NSTDB' THEN '160627'  --'SSTDB' MW updated 11/28
                                        WHEN Bdmdedcode = 'VIS' THEN '30029593'
                                        WHEN Bdmdedcode = 'VISBU' THEN '30029593'
                                END
        ,drvClassCode = ''
        ,drvEnrollmentStatus =    --CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE 
                                        WHEN BdmBenStatus IN ('C','T') THEN 'Terminated'
                                        WHEN BdmBenStatus = 'W' THEN 'Waived'
                                        ELSE 'Enrolled'
                                    END
                                --END
--      ,drvEnrollmentStartDate = dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDAte, '1/1/2021') --'1/1/' + FORMAT(DATEPART(YEAR, GETDATE()), '0000') --2020' --BdmBenStartDate
        ,drvEnrollmentStartDate = CASE WHEN @ExportCode LIKE 'OE%' THEN '1/1/2024'   ELSE dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDAte, DATEFROMPARTS(YEAR(@EndDate), 1, 1)) END
        ,drvEnrollmentEndDate = BdmBenStopDate
        ,drvOriginalEnrollmentDate = dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDAte, '1/1/2021')
        ,drvApprovedAmount = CASE WHEN BdmDedCode IN ('NELIF', 'NSLIF', 'NCLIF') THEN FORMAT( cast(isnull( (Select max(bdmusgfield1) from dbo.U_dsi_BDM_ESEQDEMRPX A where A.bdmeeid =  xeeid and A.bdmdedcode = bdmdedcode),0) as money), '#0.00') END
        ,drvRequestedAmount = CASE WHEN BdmDedCode IN ('NELIF', 'NSLIF', 'NCLIF') THEN FORMAT(isnull(amtDesiredAmt,0), '#0.00') END
        ,drvEnrollmentType = 'A'  --CASE WHEN BdmBenStatus = 'A' THEN 'A' END

        ,drvCoverateDesc =    CASE WHEN BdmDedCode IN ('NSTD', 'NLTD','VIS') THEN 'BASE'
                            WHEN BdmDedCode IN ('NLTDB', 'NSTDB' ,'VISBU' ) THEN 'BUYUP'
                            END
        ,drvCoverageTier =    CASE WHEN BdmBenOption = '1EE' THEN 'EMP' 
                                WHEN BdmBenOption IN ('2EES','3EEDP') THEN 'ESP'
                                WHEN BdmBenOption IN ('4EEC') THEN 'ECH'
                                WHEN BdmBenOption IN ('5EEF') THEN 'FAM'
                            END
        ,drvApplicationCompanyID = 'RPX'
        ,drvApplicationPlanID    = dedDedCode
        ,drvPlanName             = dedLongDesc
    INTO dbo.U_ESEQDEMRPX_drvTbl
    FROM dbo.U_ESEQDEMRPX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESEQDEMRPX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl1Code, OrgDesc AS OrgLvl1Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl1
        ON EecOrgLvl1 = OrgLvl1Code
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhOrgLvl1
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhOrgLvl1, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
        AND EjhOrgLvl1 = EecOrgLvl1
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                    SELECT EedEEID AS amtEEID, EedCOID AS amtCOID, EedDedCode AS amtDedCode, EedEOIDesiredAmt AS amtDesiredAmt, EedBenAmt AS amtBenAmt
                    FROM (
                            SELECT EedEEID, EedCOID, EedDedCode, EedEOIDesiredAmt, EedBenAmt, EedStartDate, ROW_NUMBER() OVER (PARTITION BY EedEEID, EedCOID, EedDedCode ORDER BY EedStartDate DESC) AS RN
                            FROM dbo.EmpDedFull WITH (NOLOCK)
                            /*WHERE eedDedCode IN ('UNVOL')*/) AS A
                    WHERE RN = 1 ) AS Amt
        ON amtEEID = xEEID
        AND amtCOID = xCOID
    LEFT JOIN dbo.DedCode WITH (NOLOCK)
        ON BdmDedCode = DedDedCode
    JOIN dbo.BenGrp WITH (NOLOCK)
        ON EecDedGroupCode = CbgBenGroupCode
    ;


    Delete from dbo.U_ESEQDEMRPX_drvTbl where drvPlanType in ('LS','LC') and drvDeprecid is null
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
ALTER VIEW dbo.dsi_vwESEQDEMRPX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESEQDEMRPX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESEQDEMRPX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011051'
       ,expStartPerControl     = '202011051'
       ,expLastEndPerControl   = '202011129'
       ,expEndPerControl       = '202011129'
WHERE expFormatCode = 'ESEQDEMRPX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESEQDEMRPX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESEQDEMRPX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESEQDEMRPX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESEQDEMRPX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESEQDEMRPX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESEQDEMRPX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESEQDEMRPX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESEQDEMRPX', 'UseFileName', 'V', 'Y'


-- End ripout