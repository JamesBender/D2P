/**********************************************************************************

EGWVKUNUMH: Unum Health and Welfare Export

FormatCode:     EGWVKUNUMH
Project:        Unum Health and Welfare Export
Client ID:      GWV1000
Date/time:      2022-07-12 14:52:10.597
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPGWK
Web Filename:   GWV1000_52S1N_EEHISTORY_EGWVKUNUMH_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGWVKUNUMH_SavePath') IS NOT NULL DROP TABLE dbo.U_EGWVKUNUMH_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGWVKUNUMH'


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
WHERE FormatCode = 'EGWVKUNUMH'
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
WHERE ExpFormatCode = 'EGWVKUNUMH'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGWVKUNUMH')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGWVKUNUMH'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGWVKUNUMH'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGWVKUNUMH'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGWVKUNUMH'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGWVKUNUMH'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGWVKUNUMH'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGWVKUNUMH'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGWVKUNUMH'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGWVKUNUMH'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGWVKUNUMH_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGWVKUNUMH_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGWVKUNUMH') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGWVKUNUMH];
GO
IF OBJECT_ID('U_EGWVKUNUMH_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_PDedHist];
GO
IF OBJECT_ID('U_EGWVKUNUMH_File') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_File];
GO
IF OBJECT_ID('U_EGWVKUNUMH_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_EEList];
GO
IF OBJECT_ID('U_EGWVKUNUMH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_drvTbl];
GO
IF OBJECT_ID('U_EGWVKUNUMH_DedList') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_DedList];
GO
IF OBJECT_ID('U_EGWVKUNUMH_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_AuditFields];
GO
IF OBJECT_ID('U_EGWVKUNUMH_Audit') IS NOT NULL DROP TABLE [dbo].[U_EGWVKUNUMH_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EGWVKUNUMH') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EGWVKUNUMH];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGWVKUNUMH','Unum Health and Welfare Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EGWVKUNUMHZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGWVKUNUMHZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL,'"eEnroll2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGWVKUNUMHZ0','50','H','01','2',NULL,'POLICY',NULL,NULL,'"POLICY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGWVKUNUMHZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGWVKUNUMHZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL,'"MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGWVKUNUMHZ0','50','H','01','5',NULL,'DOH',NULL,NULL,'"DOH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGWVKUNUMHZ0','50','H','01','6',NULL,'SALARY',NULL,NULL,'"SALARY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGWVKUNUMHZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL,'"SALARY MODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGWVKUNUMHZ0','50','H','01','8',NULL,'HOURS',NULL,NULL,'"HOURS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGWVKUNUMHZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL,'"TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGWVKUNUMHZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL,'"TERM REASON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGWVKUNUMHZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL,'"NEW MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGWVKUNUMHZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGWVKUNUMHZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL,'"MIDDLE NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGWVKUNUMHZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGWVKUNUMHZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL,'"SUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGWVKUNUMHZ0','50','H','01','16',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGWVKUNUMHZ0','50','H','01','17',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGWVKUNUMHZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGWVKUNUMHZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"SPOUSE FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGWVKUNUMHZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL,'"SPOUSE GDR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGWVKUNUMHZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL,'"SPOUSE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGWVKUNUMHZ0','50','H','01','22',NULL,'CLASS',NULL,NULL,'"CLASS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGWVKUNUMHZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGWVKUNUMHZ0','50','H','01','24',NULL,'SPOUSE COVERAGE',NULL,NULL,'"SPOUSE COVERAGE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGWVKUNUMHZ0','50','H','01','25',NULL,'CHILD COVERAGE',NULL,NULL,'"CHILD COVERAGE"','(''DA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGWVKUNUMHZ0','50','H','01','26',NULL,'SIGNATURE DATE',NULL,NULL,'"SIGNATURE DATE"','(''DA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGWVKUNUMHZ0','50','H','01','27',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGWVKUNUMHZ0','50','H','01','28',NULL,'ADD TYPE',NULL,NULL,'"ADD TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGWVKUNUMHZ0','50','H','01','29',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGWVKUNUMHZ0','50','H','01','30',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGWVKUNUMHZ0','50','H','01','31',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGWVKUNUMHZ0','50','H','01','32',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGWVKUNUMHZ0','50','H','01','33',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGWVKUNUMHZ0','50','H','01','34',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGWVKUNUMHZ0','50','H','01','35',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGWVKUNUMHZ0','50','H','01','36',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGWVKUNUMHZ0','50','H','01','37',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGWVKUNUMHZ0','50','H','01','38',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGWVKUNUMHZ0','50','H','01','39',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGWVKUNUMHZ0','50','H','01','40',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGWVKUNUMHZ0','50','H','01','41',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGWVKUNUMHZ0','50','H','01','42',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGWVKUNUMHZ0','50','H','01','43',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EGWVKUNUMHZ0','50','H','01','44',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EGWVKUNUMHZ0','50','H','01','45',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EGWVKUNUMHZ0','50','H','01','46',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EGWVKUNUMHZ0','50','H','01','47',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EGWVKUNUMHZ0','50','H','01','48',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EGWVKUNUMHZ0','50','H','01','49',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EGWVKUNUMHZ0','50','H','01','50',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EGWVKUNUMHZ0','50','H','01','51',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EGWVKUNUMHZ0','50','H','01','52',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EGWVKUNUMHZ0','50','H','01','53',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EGWVKUNUMHZ0','50','H','01','54',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EGWVKUNUMHZ0','50','H','01','55',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EGWVKUNUMHZ0','50','H','01','56',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EGWVKUNUMHZ0','50','H','01','57',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EGWVKUNUMHZ0','50','H','01','58',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EGWVKUNUMHZ0','50','H','01','59',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EGWVKUNUMHZ0','50','H','01','60',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EGWVKUNUMHZ0','50','H','01','61',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EGWVKUNUMHZ0','50','H','01','62',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EGWVKUNUMHZ0','50','H','01','63',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EGWVKUNUMHZ0','50','H','01','64',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGWVKUNUMHZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL,'"drvEnroll2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGWVKUNUMHZ0','50','D','10','2',NULL,'POLICY',NULL,NULL,'"drvPolicy"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGWVKUNUMHZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL,'"0001"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGWVKUNUMHZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL,'"drvMemberID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGWVKUNUMHZ0','50','D','10','5',NULL,'DOH',NULL,NULL,'"drvDOH"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGWVKUNUMHZ0','50','D','10','6',NULL,'SALARY',NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGWVKUNUMHZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL,'"A"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGWVKUNUMHZ0','50','D','10','8',NULL,'HOURS',NULL,NULL,'"drvHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGWVKUNUMHZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL,'"drvTermDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGWVKUNUMHZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL,'"drvTermReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGWVKUNUMHZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL,'"drvNewMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGWVKUNUMHZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGWVKUNUMHZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL,'"drvMiddeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGWVKUNUMHZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGWVKUNUMHZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGWVKUNUMHZ0','50','D','10','16',NULL,'GENDER',NULL,NULL,'"drvEepGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGWVKUNUMHZ0','50','D','10','17',NULL,'DOB',NULL,NULL,'"drvEepDateOfBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGWVKUNUMHZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEepAddressEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGWVKUNUMHZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"drvConNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGWVKUNUMHZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL,'"drvConGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGWVKUNUMHZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL,'"drvConDateOfBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGWVKUNUMHZ0','50','D','10','22',NULL,'CLASS',NULL,NULL,'"drvClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGWVKUNUMHZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGWVKUNUMHZ0','50','D','10','24',NULL,'SPOUSE COVERAGE',NULL,NULL,'"drvSpouseCoverage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGWVKUNUMHZ0','50','D','10','25',NULL,'CHILD COVERAGE',NULL,NULL,'"drvChildCoverage"','(''UA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGWVKUNUMHZ0','50','D','10','26',NULL,'SIGNATURE DATE',NULL,NULL,'"drvSignatureDate"','(''UA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGWVKUNUMHZ0','50','D','10','27',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGWVKUNUMHZ0','50','D','10','28',NULL,'ADD TYPE',NULL,NULL,'"drvAddType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGWVKUNUMHZ0','50','D','10','29',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGWVKUNUMHZ0','50','D','10','30',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGWVKUNUMHZ0','50','D','10','31',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGWVKUNUMHZ0','50','D','10','32',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGWVKUNUMHZ0','50','D','10','33',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount1"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGWVKUNUMHZ0','50','D','10','34',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGWVKUNUMHZ0','50','D','10','35',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGWVKUNUMHZ0','50','D','10','36',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGWVKUNUMHZ0','50','D','10','37',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGWVKUNUMHZ0','50','D','10','38',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGWVKUNUMHZ0','50','D','10','39',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount2"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGWVKUNUMHZ0','50','D','10','40',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGWVKUNUMHZ0','50','D','10','41',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGWVKUNUMHZ0','50','D','10','42',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGWVKUNUMHZ0','50','D','10','43',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EGWVKUNUMHZ0','50','D','10','44',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EGWVKUNUMHZ0','50','D','10','45',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount3"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EGWVKUNUMHZ0','50','D','10','46',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EGWVKUNUMHZ0','50','D','10','47',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EGWVKUNUMHZ0','50','D','10','48',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EGWVKUNUMHZ0','50','D','10','49',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EGWVKUNUMHZ0','50','D','10','50',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EGWVKUNUMHZ0','50','D','10','51',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount4"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EGWVKUNUMHZ0','50','D','10','52',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EGWVKUNUMHZ0','50','D','10','53',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EGWVKUNUMHZ0','50','D','10','54',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EGWVKUNUMHZ0','50','D','10','55',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EGWVKUNUMHZ0','50','D','10','56',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EGWVKUNUMHZ0','50','D','10','57',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount5"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EGWVKUNUMHZ0','50','D','10','58',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EGWVKUNUMHZ0','50','D','10','59',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EGWVKUNUMHZ0','50','D','10','60',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EGWVKUNUMHZ0','50','D','10','61',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EGWVKUNUMHZ0','50','D','10','62',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EGWVKUNUMHZ0','50','D','10','63',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmount6"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EGWVKUNUMHZ0','50','D','10','64',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EGWVKUNUMH_20220712.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Unum Health & Welfare Changes','202206249','EMPEXPORT','CHANGES',NULL,'EGWVKUNUMH',NULL,NULL,NULL,'202206249','Apr 28 2022  4:12PM','Apr 28 2022  4:12PM','202206171',NULL,'','','202206171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Health and Welfare Export','202206249','EMPEXPORT','ONDEM_XOE',NULL,'EGWVKUNUMH',NULL,NULL,NULL,'202206249','Apr 28 2022  4:12PM','Apr 28 2022  4:12PM','202206171',NULL,'','','202206171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Health and Welfare -Sched','202206249','EMPEXPORT','SCH_EGWVKU',NULL,'EGWVKUNUMH',NULL,NULL,NULL,'202206249','Apr 28 2022  4:12PM','Apr 28 2022  4:12PM','202206171',NULL,'','','202206171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',Y4PX9,Y4PRP',NULL,NULL,NULL,'Unum Health and Welfare -Test','202206249','EMPEXPORT','TEST_XOE',NULL,'EGWVKUNUMH',NULL,NULL,NULL,'202206249','Apr 28 2022  4:12PM','Apr 28 2022  4:12PM','202206171',NULL,'','','202206171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGWVKUNUMH','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGWVKUNUMH','D1','dbo.U_EGWVKUNUMH_HeaderTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGWVKUNUMH','D10','dbo.U_EGWVKUNUMH_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EGWVKUNUMH
-----------

IF OBJECT_ID('U_dsi_BDM_EGWVKUNUMH') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EGWVKUNUMH] (
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
-- Create table U_EGWVKUNUMH_Audit
-----------

IF OBJECT_ID('U_EGWVKUNUMH_Audit') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audBenAmt] nvarchar(2000) NULL,
    [audEEEligDate] nvarchar(2000) NULL
);

-----------
-- Create table U_EGWVKUNUMH_AuditFields
-----------

IF OBJECT_ID('U_EGWVKUNUMH_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EGWVKUNUMH_DedList
-----------

IF OBJECT_ID('U_EGWVKUNUMH_DedList') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EGWVKUNUMH_drvTbl
-----------

IF OBJECT_ID('U_EGWVKUNUMH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NOT NULL,
    [drvSubSort] char(12) NOT NULL,
    [drvEnroll2] varchar(4) NOT NULL,
    [drvPolicy] varchar(6) NOT NULL,
    [drvMemberID] char(11) NULL,
    [drvDOH] varchar(10) NULL,
    [drvSalary] money NULL,
    [drvHours] varchar(1) NOT NULL,
    [drvTermDate] varchar(10) NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddeName] varchar(50) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvEepGender] char(1) NULL,
    [drvEepDateOfBirth] varchar(10) NULL,
    [drvEepAddressEmail] varchar(50) NULL,
    [drvConNameFirst] varchar(100) NULL,
    [drvConGender] char(1) NULL,
    [drvConDateOfBirth] varchar(10) NULL,
    [drvClass] varchar(4) NOT NULL,
    [drvEffectiveDate] varchar(10) NULL,
    [drvSpouseCoverage] varchar(1) NOT NULL,
    [drvChildCoverage] varchar(1) NOT NULL,
    [drvAddType] varchar(1) NOT NULL,
    [drvBenefitId1] varchar(2) NOT NULL,
    [drvPlanCode1] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate1] varchar(10) NULL,
    [drvBenefitTermDate1] varchar(10) NULL,
    [drvBenefitSelectionAmount1] numeric NULL,
    [drvBenefitId2] varchar(2) NOT NULL,
    [drvPlanCode2] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate2] varchar(10) NULL,
    [drvBenefitTermDate2] varchar(10) NULL,
    [drvBenefitSelectionAmount2] numeric NULL,
    [drvBenefitId3] varchar(2) NOT NULL,
    [drvPlanCode3] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate3] varchar(10) NULL,
    [drvBenefitTermDate3] varchar(10) NULL,
    [drvBenefitSelectionAmount3] numeric NULL,
    [drvBenefitId4] varchar(2) NOT NULL,
    [drvPlanCode4] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate4] varchar(10) NULL,
    [drvBenefitTermDate4] varchar(10) NULL,
    [drvBenefitSelectionAmount4] numeric NULL,
    [drvBenefitId5] varchar(2) NOT NULL,
    [drvPlanCode5] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate5] varchar(10) NULL,
    [drvBenefitTermDate5] varchar(10) NULL,
    [drvBenefitSelectionAmount5] numeric NULL,
    [drvBenefitId6] varchar(2) NOT NULL,
    [drvPlanCode6] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate6] varchar(10) NULL,
    [drvBenefitTermDate6] varchar(10) NULL,
    [drvBenefitSelectionAmount6] numeric NULL
);

-----------
-- Create table U_EGWVKUNUMH_EEList
-----------

IF OBJECT_ID('U_EGWVKUNUMH_EEList') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGWVKUNUMH_File
-----------

IF OBJECT_ID('U_EGWVKUNUMH_File') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EGWVKUNUMH_PDedHist
-----------

IF OBJECT_ID('U_EGWVKUNUMH_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EGWVKUNUMH_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhBenAmtLIFEE] numeric NULL,
    [PdhBenAmtLIFES] numeric NULL,
    [PdhBenAmtLIFEC] numeric NULL,
    [PdhBenAmtADDV] numeric NULL,
    [PdhBenAmtADDC] numeric NULL,
    [PdhBenAmtADDS] numeric NULL,
    [PdhBenAmtADD] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGWVKUNUMH]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: G.W. Van Keppel

Created By: Roger Bynum
Business Analyst: Curlin Beck
Create Date: 04/28/2022
Service Request Number: TekP-2022-02-22-02

Purpose: Unum Health and Welfare Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGWVKUNUMH';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGWVKUNUMH';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGWVKUNUMH';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGWVKUNUMH';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGWVKUNUMH' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'TEST_XOE';
--EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'OEPASSIVE';
--EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'SCH_EGWVKU';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGWVKUNUMH', 'CHANGES';

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202203011'
       ,expStartPerControl     = '202203011'
       ,expLastEndPerControl   = '202203319'
       ,expEndPerControl       = '202203319'
WHERE expFormatCode = 'EGWVKUNUMH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EGWVKUNUMH';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EGWVKUNUMH', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EGWVKUNUMH';

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
    DELETE FROM dbo.U_EGWVKUNUMH_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EGWVKUNUMH_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList =  'GLIFE,GLISF,LIFEE,LIFEC,LIFES,ADDV,ADDC,ADDS,ADD';

    IF OBJECT_ID('U_EGWVKUNUMH_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EGWVKUNUMH_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EGWVKUNUMH_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes', @DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'ExclFutureDatedStopDates','Y')
 
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

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EGWVKUNUMH_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EGWVKUNUMH_AuditFields;
    CREATE TABLE dbo.U_EGWVKUNUMH_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DedCode','DedBenAmt');
    INSERT INTO dbo.U_EGWVKUNUMH_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EGWVKUNUMH_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EGWVKUNUMH_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN 'Y' ELSE 'N' END
        ,audBenAmt = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenAmount' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN audOldValue ELSE audNewValue END
        ,audEEEligDate = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedEEEligDate' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN audOldValue ELSE audNewValue END
    INTO dbo.U_EGWVKUNUMH_Audit
    FROM dbo.U_EGWVKUNUMH_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EGWVKUNUMH_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EGWVKUNUMH_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EGWVKUNUMH_DedList))
    );


    --================
    -- Changes Only
    --================
    IF (@Exportcode LIKE ('%Changes%'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EGWVKUNUMH_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EGWVKUNUMH_Audit WHERE audEEID = xEEID AND audRowNo = 1
        AND (audDedChange = 'Y'
        OR audBenOptionChange = 'Y'
        OR audNameChange = 'Y'
        OR audDemoChange = 'Y'
        OR audNewlyEnroll = 'Y'
        OR audTermPlan = 'Y')
        );
    END;

 
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EGWVKUNUMH_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGWVKUNUMH_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhBenAmtLIFEE     = MAX(CASE WHEN PdhDedCode IN ('LIFEE') THEN PdhBenAmt ELSE 0.00 END)
        ,PdhBenAmtLIFES     = MAX(CASE WHEN PdhDedCode IN ('LIFES') THEN PdhBenAmt ELSE 0.00 END)
        ,PdhBenAmtLIFEC     = MAX(CASE WHEN PdhDedCode IN ('LIFEC') THEN PdhBenAmt ELSE 0.00 END)      
        ,PdhBenAmtADDV      = MAX(CASE WHEN PdhDedCode IN ('ADDV') THEN PdhBenAmt ELSE 0.00 END)
        ,PdhBenAmtADDC      = MAX(CASE WHEN PdhDedCode IN ('ADDC') THEN PdhBenAmt ELSE 0.00 END)
        ,PdhBenAmtADDS      = MAX(CASE WHEN PdhDedCode IN ('ADDS') THEN PdhBenAmt ELSE 0.00 END)
        ,PdhBenAmtADD      = MAX(CASE WHEN PdhDedCode IN ('ADD') THEN PdhBenAmt ELSE 0.00 END)

    INTO dbo.U_EGWVKUNUMH_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EGWVKUNUMH_DedList WITH (NOLOCK)
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
    -- DETAIL RECORD - U_EGWVKUNUMH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGWVKUNUMH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGWVKUNUMH_drvTbl;
    SELECT DISTINCT
         drvEEID                        = xEEID
        ,drvCoID                        = xCoID
        ,drvDepRecID                    = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort                        = EepEEID
        ,drvSubSort                     = ISNULL(ConSystemID, 'a')
        -- standard fields above and additional driver fields below
        ,drvEnroll2                     = '    '                                                          --Number of rows excluding header
        ,drvPolicy                      = '708017'
        ,drvMemberID                    = eepSSN
        ,drvDOH                         = CONVERT(VARCHAR(10),EecDateOfLastHire, 112)
        ,drvSalary                      = CASE WHEN  DedCode_LIFEE = 'LIFEE ' THEN EecAnnSalary
                                                 WHEN  DedCode_LIFES = 'LIFES' THEN EecAnnSalary
                                                 WHEN  DedCode_LIFEC = 'LIFEC' THEN EecAnnSalary
                                                 WHEN  DedCode_ADDV = 'ADDV' THEN EecAnnSalary
                                                 WHEN  DedCode_ADDS = 'ADDS' THEN EecAnnSalary
                                                 WHEN  DedCode_ADDC = 'ADDC' THEN EecAnnSalary 
                                                ELSE '0.00'
                                            END
        ,drvHours                       = ''
        ,drvTermDate                    = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(10),EecDateOfTermination, 112) ELSE '' END
        ,drvTermReason                  = CASE WHEN EecEmplStatus = 'T' THEN 
                                                CASE WHEN EecTermReason = '203' THEN 'DT'
                                                     WHEN eecTermReason = '202' THEN 'RT'
                                                     WHEN eecTermReason NOT IN ('202','203') THEN 'TE'
                                                END
                                              ELSE ''
                                         END
        ,drvNewMemberId                  = CASE WHEN ISNULL(eepOldSSN, '') <> '' THEN EepSSN END
        ,drvFirstName                    = EepNameFirst
        ,drvMiddeName                    = EepNameMiddle
        ,drvLastName                     = EepNameLast
        ,drvSuffix                       = EepNameSuffix
        ,drvEepGender                    = EepGender
        ,drvEepDateOfBirth               = CONVERT(VARCHAR(10),EepDateOfBirth, 112)
        ,drvEepAddressEmail              = EepAddressEMail
        ,drvConNameFirst                 = CASE WHEN ConRelationShip = 'SPS' THEN ConNameFirst END
        ,drvConGender                    = CASE WHEN ConRelationShip = 'SPS' THEN ConGender END
        ,drvConDateOfBirth               = CASE WHEN ConRelationShip = 'SPS' THEN  CONVERT(VARCHAR(10), ConDateofBirth, 112) END
        ,drvClass                        = CASE WHEN DedCode_LIFEE = 'LIFEE' OR DedCode_LIFES = 'LIFES' OR DedCode_LIFEC = 'LIFEC' THEN '1000' ELSE '' END
        ,drvEffectiveDate                = CASE WHEN audReHire = 'Y' THEN CONVERT(VARCHAR(10),EecDateOfTermination, 112)
                                               WHEN EXISTS (SELECT 1 FROM dbo.U_EGWVKUNUMH_Audit WITH(NOLOCK)
                                                            WHERE audFieldName = 'EecAnnSalary' AND audSalaryChange = 'Y') 
                                                            THEN CONVERT(VARCHAR(10), dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, EecDateOfLastHire), 112)
                                               ELSE CONVERT(VARCHAR(10),BDM.BdmBenStartDate, 112)
                                          END
        ,drvSpouseCoverage               = 'N'
        ,drvChildCoverage                = 'N'
        --,drvSignatureDate              = CASE WHEN DedCode_ADD = 'ADDV' OR DedCode_ADDC = 'ADDC' OR DedCode_ADDS = 'ADDS' OR DedCode_LIFEE =  'LIFEE' OR DedCode_LIFEC = 'LIFEC' OR DedCode_LIFES = 'LIFES'
        --                                    THEN CONVERT(VARCHAR(10),BDM.Bdmbenstartdate, 112)
        --                                    END
        ,drvAddType                      = CASE WHEN EecFullTimeOrPartTime = 'F' AND EjhFullTimeOrPartTime = 'P' THEN 'O' ELSE '' END
        ,drvBenefitId1                   = CASE WHEN DedCode_LIFEE = 'LIFEE' THEN 'LM' ELSE '' END
        ,drvPlanCode1                    = CASE WHEN DedCode_LIFEE = 'LIFEE' THEN '5.0N22' ELSE '' END
        ,drvBenefitQualifyingDate1       = CASE WHEN DedCode_LIFEE = 'LIFEE' 
                                            AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                            END
        ,drvBenefitTermDate1             = CASE WHEN DedCode_LIFEE = 'LIFEE' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount1      = PdhBenAmtLIFEE
        ,drvBenefitId2                   = CASE WHEN DedCode_LIFES = 'LIFES' THEN 'LS' ELSE '' END
        ,drvPlanCode2                    = CASE WHEN DedCode_LIFES = 'LIFES' THEN '5.AN47' ELSE '' END
        ,drvBenefitQualifyingDate2       = CASE WHEN DedCode_LIFES = 'LIFES' 
                                                AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                            END
        ,drvBenefitTermDate2              = CASE WHEN DedCode_LIFES = 'LIFES' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount2       = PdhBenAmtLIFES
        ,drvBenefitId3                    = CASE WHEN DedCode_LIFEC = 'LIFEC' THEN 'LC' ELSE '' END
        ,drvPlanCode3                     = CASE WHEN DedCode_LIFEC = 'LIFEC' THEN '5.0M04' ELSE '' END
        ,drvBenefitQualifyingDate3         = CASE WHEN DedCode_LIFEC = 'LIFEC' 
                                            AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                          END
        ,drvBenefitTermDate3             = CASE WHEN DedCode_LIFEC = 'LIFEC' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount3      = PdhBenAmtLIFEC
        ,drvBenefitId4                    = CASE WHEN DedCode_ADDV = 'ADDV' THEN 'AM' ELSE '' END
        ,drvPlanCode4                     = CASE WHEN DedCode_ADDV = 'ADDV' THEN '5.0S17' ELSE '' END
        ,drvBenefitQualifyingDate4         = CASE WHEN DedCode_ADDV = 'ADDV' 
                                            AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                          END
        ,drvBenefitTermDate4             = CASE WHEN DedCode_ADDV = 'ADDV' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount4        = pdhBenAmtADDV
        ,drvBenefitId5                    = CASE WHEN DedCode_ADDS = 'ADDS' THEN 'AS' ELSE '' END
        ,drvPlanCode5                    = CASE WHEN DedCode_ADDS = 'ADDS' THEN '5.0L02' ELSE '' END
        ,drvBenefitQualifyingDate5         = CASE WHEN DedCode_ADDS = 'ADDS' 
                                            AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                          END
        ,drvBenefitTermDate5            = CASE WHEN DedCode_ADDS = 'ADDS' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount5     = pdhBenAmtADDS
        ,drvBenefitId6                    = CASE WHEN DedCode_ADDC = 'ADDC' THEN 'AC' ELSE '' END
        ,drvPlanCode6                     = CASE WHEN DedCode_ADDC = 'ADDC' THEN '5.0L23' ELSE '' END
        ,drvBenefitQualifyingDate6        = CASE WHEN DedCode_ADDC = 'ADDC' 
                                            AND Bdm.BdmChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                                                THEN CONVERT(VARCHAR(10),audEEEligDate, 112)
                                          END
        ,drvBenefitTermDate6             = CASE WHEN DedCode_ADDC = 'ADDC' AND EecEmplStatus <> 'T' THEN CONVERT(VARCHAR(10),BDM.BdmBenStopDate, 112) END
        ,drvBenefitSelectionAmount6     = pdhBenAmtADDC
    INTO dbo.U_EGWVKUNUMH_drvTbl
    FROM dbo.U_EGWVKUNUMH_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EGWVKUNUMH_PDedHist WITH(NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.U_EGWVKUNUMH_Audit WITH(NOLOCK)
        ON audEEID = xEEID
    LEFT JOIN (
        SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ,MAX(BdmBenStartDate) AS BdmBenStartDate
        ,MAX(BdmBenStopDate) AS BdmBenStopDate
        ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
        ,MAX(BdmCobraReason) AS BdmCobraReason
        ,MAX(BdmChangeReason) AS BdmChangeReason
        ,MAX(BdmIsPQB) AS BdmIsPQB
--        ,MAX(bdmBenAmt) AS bdmBenAmt
        --,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS DedCode_GLIFE
        --,MAX(CASE WHEN BdmDedCode = 'GLISF' THEN BdmDedCode END) AS DedCode_GLISF
        ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS DedCode_LIFEE
        ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS DedCode_LIFES
        ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS DedCode_LIFEC
        ,MAX(CASE WHEN BdmDedCode = 'ADDV' THEN BdmDedCode END) AS DedCode_ADDV
        ,MAX(CASE WHEN BdmDedCode = 'ADDS'THEN BdmDedCode END) AS DedCode_ADDS
        ,MAX(CASE WHEN BdmDedCode = 'ADDC' THEN BdmDedCode END) AS DedCode_ADDC
        --,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmDedCode END) AS DedCode_ADD
        FROM dbo.U_dsi_BDM_EGWVKUNUMH WITH (NOLOCK)
        GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BDM.BdmEEID = xEEID
        AND BDM.BdmCoID = xCoID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEId = xEEID
            AND ConSystemID = BdmDepRecId
        JOIN dbo.EmpHJob WITH (NOLOCK)
            ON EjhEEID = xEEID
    ;
        INSERT INTO dbo.U_EGWVKUNUMH_drvTbl
        ( drvEEID                   
        ,drvCoID                   
        ,drvDepRecID               
        ,drvSort                   
        ,drvSubSort                
        ,drvEnroll2                
        ,drvPolicy                               
        ,drvMemberID               
        ,drvDOH                    
        ,drvSalary                           
        ,drvHours                  
        ,drvTermDate               
        ,drvTermReason                
        ,drvNewMemberId            
        ,drvFirstName              
        ,drvMiddeName              
        ,drvLastName               
        ,drvSuffix                 
        ,drvEepGender              
        ,drvEepDateOfBirth         
        ,drvEepAddressEmail        
        ,drvConNameFirst           
        ,drvConGender              
        ,drvConDateOfBirth         
        ,drvClass
        ,drvEffectiveDate          
        ,drvSpouseCoverage         
        ,drvChildCoverage                             
        ,drvAddType                
        ,drvBenefitId1             
        ,drvPlanCode1              
        ,drvBenefitQualifyingDate1 
        ,drvBenefitTermDate1       
        ,drvBenefitSelectionAmount1
        ,drvBenefitId2             
        ,drvPlanCode2              
        ,drvBenefitQualifyingDate2 
        ,drvBenefitTermDate2       
        ,drvBenefitSelectionAmount2
        ,drvBenefitId3             
        ,drvPlanCode3              
        ,drvBenefitQualifyingDate3 
        ,drvBenefitTermDate3       
        ,drvBenefitSelectionAmount3
        ,drvBenefitId4             
        ,drvPlanCode4              
        ,drvBenefitQualifyingDate4
        ,drvBenefitTermDate4       
        ,drvBenefitSelectionAmount4
        ,drvBenefitId5             
        ,drvPlanCode5              
        ,drvBenefitQualifyingDate5 
        ,drvBenefitTermDate5       
        ,drvBenefitSelectionAmount5
        ,drvBenefitId6             
        ,drvPlanCode6              
        ,drvBenefitQualifyingDate6
        ,drvBenefitTermDate6       
        ,drvBenefitSelectionAmount6)
    SELECT DISTINCT
         drvEEID                        = xEEID
        ,drvCoID                        = xCoID
        ,drvDepRecID                    = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort                        = EepEEID
        ,drvSubSort                        = ISNULL(ConSystemID, 'a')
        -- standard fields above and additional driver fields below
        ,drvEnroll2                     = '    '                                                          --Number of rows excluding header
        ,drvPolicy                      = '708016'
        ,drvMemberID                    = eepSSN
        ,drvDOH                         = CONVERT(VARCHAR(10),EecDateOfLastHire, 112)
        ,drvSalary                      = '0.00'
        ,drvHours                       = ''
        ,drvTermDate                    = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(10),EecDateOfTermination, 112) ELSE '' END
        ,drvTermReason                  = CASE WHEN EecEmplStatus = 'T' THEN 
                                                CASE WHEN EecTermReason = '203' THEN 'DT'
                                                     WHEN eecTermReason = '202' THEN 'RT'
                                                     WHEN eecTermReason NOT IN ('202','203') THEN 'TE'
                                                END
                                              ELSE ''
                                          END
        ,drvNewMemberId                    = CASE WHEN ISNULL(eepOldSSN, '') <> '' THEN EepSSN END
        ,drvFirstName                    = EepNameFirst
        ,drvMiddeName                    = EepNameMiddle
        ,drvLastName                     = EepNameLast
        ,drvSuffix                        = EepNameSuffix
        ,drvEepGender                    = EepGender
        ,drvEepDateOfBirth               = CONVERT(VARCHAR(10),EepDateOfBirth, 112)
        ,drvEepAddressEmail              = EepAddressEMail
        ,drvConNameFirst                 = '' --CASE WHEN ConRelationShip = 'SPS' THEN ConNameFirst END
        ,drvConGender                    = '' --CASE WHEN ConRelationShip = 'SPS' THEN ConGender END
        ,drvConDateOfBirth               = '' --CASE WHEN ConRelationShip = 'SPS' THEN  CONVERT(VARCHAR(10), ConDateofBirth, 112) END
        ,drvClass                        = CASE WHEN EecDedGroupCode = 'EXEC' THEN '1000'   
                                             WHEN EecDedGroupCode <> 'EXEC' THEN '2000'
                                           END
        ,drvEffectiveDate                = CASE WHEN audReHire = 'Y' THEN CONVERT(VARCHAR(10),EecDateOfTermination, 112)
                                               WHEN EXISTS (SELECT 1 FROM dbo.U_EGWVKUNUMH_Audit WITH(NOLOCK)
                                                            WHERE audFieldName = 'EecAnnSalary' AND audSalaryChange = 'Y') 
                                                            THEN CONVERT(VARCHAR(10), dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, EecDateOfLastHire), 112)
                                               ELSE CONVERT(VARCHAR(10),BDM.BdmBenStartDate, 112)
                                          END
        ,drvSpouseCoverage                = CASE WHEN DedCode_GLISF = 'GLISF' THEN 'Y' ELSE 'N' END
        ,drvChildCoverage                 = 'N'
        --,drvSignatureDate                = CASE WHEN DedCode_ADD = 'ADDV' OR DedCode_ADDC = 'ADDC' OR DedCode_ADDS = 'ADDS' OR DedCode_LIFEE =  'LIFEE' OR DedCode_LIFEC = 'LIFEC' OR DedCode_LIFES = 'LIFES'
        --                                    THEN CONVERT(VARCHAR(10),BDM.Bdmbenstartdate, 112)
        --                                    END
        ,drvAddType                       = CASE WHEN EecFullTimeOrPartTime = 'F' AND EjhFullTimeOrPartTime = 'P' THEN 'O' ELSE '' END
        ,drvBenefitId1                    = ''
        ,drvPlanCode1                     = ''
        ,drvBenefitQualifyingDate1        = ''
        ,drvBenefitTermDate1              = ''
        ,drvBenefitSelectionAmount1       = '0'
        ,drvBenefitId2                    = ''
        ,drvPlanCode2                     = ''
        ,drvBenefitQualifyingDate2        = ''
        ,drvBenefitTermDate2              = ''
        ,drvBenefitSelectionAmount2       = '0'
        ,drvBenefitId3                    = ''
        ,drvPlanCode3                     = ''
        ,drvBenefitQualifyingDate3        = ''
        ,drvBenefitTermDate3              = ''
        ,drvBenefitSelectionAmount3       = '0'
        ,drvBenefitId4                    = ''
        ,drvPlanCode4                     = ''
        ,drvBenefitQualifyingDate4        = ''
        ,drvBenefitTermDate4              = ''
        ,drvBenefitSelectionAmount4       = '0'
        ,drvBenefitId5                    = ''
        ,drvPlanCode5                     = ''
        ,drvBenefitQualifyingDate5        = '' 
        ,drvBenefitTermDate5              = ''
        ,drvBenefitSelectionAmount5       = '0'
        ,drvBenefitId6                    = ''
        ,drvPlanCode6                     = ''
        ,drvBenefitQualifyingDate6        = ''
        ,drvBenefitTermDate6              = ''
        ,drvBenefitSelectionAmount6       = '0'
    FROM dbo.U_EGWVKUNUMH_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EGWVKUNUMH_PDedHist WITH(NOLOCK)
        ON pdhEEID = xEEID
    JOIN dbo.U_EGWVKUNUMH_Audit WITH(NOLOCK)
        ON audEEID = xEEID
    LEFT JOIN (
        SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ,MAX(BdmBenStartDate) AS BdmBenStartDate
        ,MAX(BdmBenStopDate) AS BdmBenStopDate
        ,MAX(BdmBenStatusDate) AS BdmBenStatusDate
        ,MAX(BdmCobraReason) AS BdmCobraReason
        ,MAX(BdmChangeReason) AS BdmChangeReason
        ,MAX(BdmIsPQB) AS BdmIsPQB
--        ,MAX(bdmBenAmt) AS bdmBenAmt
        ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) AS DedCode_GLIFE
        ,MAX(CASE WHEN BdmDedCode = 'ADD' THEN BdmDedCode END) AS DedCode_ADD
        ,MAX(CASE WHEN BdmDedCode = 'GLISF' THEN BdmDedCode END) AS DedCode_GLISF
        FROM dbo.U_dsi_BDM_EGWVKUNUMH WITH (NOLOCK)
        GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BDM.BdmEEID = xEEID
        AND BDM.BdmCoID = xCoID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEId = xEEID
            AND ConSystemID = BdmDepRecId
        JOIN dbo.EmpHJob WITH (NOLOCK)
            ON EjhEEID = xEEID;

    DECLARE @RecordCount INT
    SELECT @RecordCount = COUNT(1)
    FROM dbo.U_EGWVKUNUMH_drvTbl WITH(NOLOCK)
    UPDATE dbo.U_EGWVKUNUMH_drvTbl
    SET drvEnroll2 = CAST(@RecordCount AS VARCHAR(5))

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
ALTER VIEW dbo.dsi_vwEGWVKUNUMH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGWVKUNUMH_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EGWVKUNUMH%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202206019'
       ,expEndPerControl       = '202206019'
WHERE expFormatCode = 'EGWVKUNUMH';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGWVKUNUMH_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGWVKUNUMH_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGWVKUNUMH' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGWVKUNUMH'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGWVKUNUMH'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGWVKUNUMH', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGWVKUNUMH', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGWVKUNUMH', 'UseFileName', 'V', 'Y'


-- End ripout