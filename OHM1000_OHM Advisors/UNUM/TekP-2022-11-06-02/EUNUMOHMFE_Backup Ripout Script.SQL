/**********************************************************************************

EUNUMOHMFE: Unum Basic Life, Vol Life ADD Export

FormatCode:     EUNUMOHMFE
Project:        Unum Basic Life, Vol Life ADD Export
Client ID:      OHM1000
Date/time:      2023-04-10 14:26:46.763
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP5DB01
Database:       ULTIPRO_WPOHMA
Web Filename:   OHM1000_2AXSQ_EEHISTORY_EUNUMOHMFE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUNUMOHMFE_SavePath') IS NOT NULL DROP TABLE dbo.U_EUNUMOHMFE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUNUMOHMFE'


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
WHERE FormatCode = 'EUNUMOHMFE'
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
WHERE ExpFormatCode = 'EUNUMOHMFE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUNUMOHMFE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUNUMOHMFE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUNUMOHMFE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUNUMOHMFE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUNUMOHMFE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUNUMOHMFE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUNUMOHMFE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUNUMOHMFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUNUMOHMFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUNUMOHMFE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUNUMOHMFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMOHMFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMOHMFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMOHMFE];
GO
IF OBJECT_ID('U_EUNUMOHMFE_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_File];
GO
IF OBJECT_ID('U_EUNUMOHMFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_EEList];
GO
IF OBJECT_ID('U_EUNUMOHMFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_drvTbl];
GO
IF OBJECT_ID('U_EUNUMOHMFE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_DedList];
GO
IF OBJECT_ID('U_EUNUMOHMFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_AuditFields];
GO
IF OBJECT_ID('U_EUNUMOHMFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMOHMFE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMOHMFE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMOHMFE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMOHMFE','Unum Basic Life, Vol Life ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EUNUMOHMFEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMOHMFEZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL,'"eEnroll2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMOHMFEZ0','50','H','01','2',NULL,'POLICY',NULL,NULL,'"POLICY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMOHMFEZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMOHMFEZ0','50','H','01','3',NULL,'PRI DIV',NULL,NULL,'"PRI DIV"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMOHMFEZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL,'"MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMOHMFEZ0','50','H','01','5',NULL,'DOH',NULL,NULL,'"DOH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMOHMFEZ0','50','H','01','6',NULL,'SALARY',NULL,NULL,'"SALARY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMOHMFEZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL,'"SALARY MODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMOHMFEZ0','50','H','01','8',NULL,'HOURS',NULL,NULL,'"HOURS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMOHMFEZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL,'"TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMOHMFEZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL,'"TERM REASON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMOHMFEZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL,'"NEW MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMOHMFEZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMOHMFEZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL,'"MIDDLE NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMOHMFEZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMOHMFEZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL,'"SUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMOHMFEZ0','50','H','01','16',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMOHMFEZ0','50','H','01','17',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMOHMFEZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMOHMFEZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"SPOUSE FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMOHMFEZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL,'"SPOUSE GDR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMOHMFEZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL,'"SPOUSE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMOHMFEZ0','50','H','01','22',NULL,'CLASS',NULL,NULL,'"CLASS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMOHMFEZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"SIGNATURE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMOHMFEZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMOHMFEZ0','50','H','01','23',NULL,'SPOUSE COVERAGE',NULL,NULL,'"SPOUSE COVERAGE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMOHMFEZ0','50','H','01','23',NULL,'CHILD COVERAGE',NULL,NULL,'"CHILD COVERAGE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMOHMFEZ0','50','H','01','24',NULL,'ADD TYPE',NULL,NULL,'"ADD TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMOHMFEZ0','50','H','01','25',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMOHMFEZ0','50','H','01','26',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMOHMFEZ0','50','H','01','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMOHMFEZ0','50','H','01','28',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMOHMFEZ0','50','H','01','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMOHMFEZ0','50','H','01','31',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMOHMFEZ0','50','H','01','30',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMOHMFEZ0','50','H','01','31',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMOHMFEZ0','50','H','01','32',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMOHMFEZ0','50','H','01','33',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMOHMFEZ0','50','H','01','34',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMOHMFEZ0','50','H','01','37',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMOHMFEZ0','50','H','01','35',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMOHMFEZ0','50','H','01','36',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMOHMFEZ0','50','H','01','37',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMOHMFEZ0','50','H','01','38',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMOHMFEZ0','50','H','01','39',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMOHMFEZ0','50','H','01','43',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMOHMFEZ0','50','H','01','40',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMOHMFEZ0','50','H','01','41',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMOHMFEZ0','50','H','01','42',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMOHMFEZ0','50','H','01','43',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMOHMFEZ0','50','H','01','44',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMOHMFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMOHMFEZ0','50','H','01','45',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMOHMFEZ0','50','H','01','46',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMOHMFEZ0','50','H','01','47',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMOHMFEZ0','50','H','01','48',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMOHMFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMOHMFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMOHMFEZ0','50','H','01','50',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMOHMFEZ0','50','H','01','51',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUNUMOHMFEZ0','50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EUNUMOHMFEZ0','50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EUNUMOHMFEZ0','50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EUNUMOHMFEZ0','50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMOHMFEZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL,'"drvEnroll2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMOHMFEZ0','50','D','10','2',NULL,'POLICY',NULL,NULL,'"drvPolicy"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMOHMFEZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMOHMFEZ0','50','D','10','3',NULL,'PRI DIV',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMOHMFEZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL,'"drvMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMOHMFEZ0','50','D','10','5',NULL,'DOH',NULL,NULL,'"drvDateOfHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMOHMFEZ0','50','D','10','6',NULL,'SALARY',NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMOHMFEZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL,'"drvSalaryMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMOHMFEZ0','50','D','10','8',NULL,'HOURS',NULL,NULL,'"drvHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMOHMFEZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMOHMFEZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL,'"drvTermReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMOHMFEZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL,'"drvNewMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMOHMFEZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMOHMFEZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMOHMFEZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMOHMFEZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMOHMFEZ0','50','D','10','16',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMOHMFEZ0','50','D','10','17',NULL,'DOB',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMOHMFEZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMOHMFEZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMOHMFEZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL,'"drvSpouseGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMOHMFEZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL,'"drvSpounseDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMOHMFEZ0','50','D','10','22',NULL,'CLASS',NULL,NULL,'"drvClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMOHMFEZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvSignatureDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMOHMFEZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMOHMFEZ0','50','D','10','23',NULL,'SPOUSE COVERAGE',NULL,NULL,'"drvSPOUSECOVERAGE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMOHMFEZ0','50','D','10','23',NULL,'CHILD COVERAGE',NULL,NULL,'"drvCHILDCOVERAGE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMOHMFEZ0','50','D','10','24',NULL,'ADD TYPE',NULL,NULL,'"drvAddType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMOHMFEZ0','50','D','10','25',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMOHMFEZ0','50','D','10','26',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMOHMFEZ0','50','D','10','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMOHMFEZ0','50','D','10','28',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMOHMFEZ0','50','D','10','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMOHMFEZ0','50','D','10','31',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelection1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMOHMFEZ0','50','D','10','31',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMOHMFEZ0','50','D','10','32',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMOHMFEZ0','50','D','10','33',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMOHMFEZ0','50','D','10','34',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUNUMOHMFEZ0','50','D','10','35',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUNUMOHMFEZ0','50','D','10','37',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelection2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUNUMOHMFEZ0','50','D','10','37',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUNUMOHMFEZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUNUMOHMFEZ0','50','D','10','39',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUNUMOHMFEZ0','50','D','10','40',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUNUMOHMFEZ0','50','D','10','41',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUNUMOHMFEZ0','50','D','10','43',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelection3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUNUMOHMFEZ0','50','D','10','43',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUNUMOHMFEZ0','50','D','10','44',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUNUMOHMFEZ0','50','D','10','45',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUNUMOHMFEZ0','50','D','10','46',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUNUMOHMFEZ0','50','D','10','47',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUNUMOHMFEZ0','50','D','10','49',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelection4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUNUMOHMFEZ0','50','D','10','49',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUNUMOHMFEZ0','50','D','10','50',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUNUMOHMFEZ0','50','D','10','51',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUNUMOHMFEZ0','50','D','10','52',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUNUMOHMFEZ0','50','D','10','53',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUNUMOHMFEZ0','50','D','10','55',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelection5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUNUMOHMFEZ0','50','D','10','55',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUNUMOHMFEZ0','50','D','10','56',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUNUMOHMFEZ0','50','D','10','57',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBenefitQualifyingDate6"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EUNUMOHMFEZ0','50','D','10','58',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTerminationDate6"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EUNUMOHMFEZ0','50','D','10','59',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBenefitSelectionAmt6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EUNUMOHMFEZ0','50','D','10','60',NULL,'BENEFIT SELECTION',NULL,NULL,'"drvBenefitSelection"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUNUMOHMFE_20230410.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'Active Open Enrollment Export','202105109','EMPEXPORT','OEACTIVE','Jan  9 2020 12:02PM','EUNUMOHMFE',NULL,NULL,NULL,'202105109','Nov  2 2020 12:00AM','Dec 30 1899 12:00AM','202104071','1','','','202104071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202105109','EMPEXPORT','OEPASSIVE','Nov  4 2019 11:55AM','EUNUMOHMFE',NULL,NULL,NULL,'202105109','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','202104071','848','','','202104071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Life Export','202105109','EMPEXPORT','ONDEMAND',NULL,'EUNUMOHMFE',NULL,NULL,NULL,'202105109','Sep 25 2019 12:30PM','Sep 25 2019 12:30PM','202104071',NULL,'','','202104071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',5Q675',NULL,NULL,NULL,'Unum LifeAccHosp - Monthly 7th','202105109','EMPEXPORT','SCH_UNMX','Nov  4 2019 12:00AM','EUNUMOHMFE',NULL,NULL,NULL,'202303319','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','202303011','833','','','202104071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202105269','EMPEXPORT','TEST','May 26 2021  9:10AM','EUNUMOHMFE',NULL,NULL,NULL,'202105269','May 26 2021 12:00AM','Dec 30 1899 12:00AM','202105131','952','','','202105131',dbo.fn_GetTimedKey(),NULL,'us3lKiOHM1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMOHMFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMOHMFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMOHMFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMOHMFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMOHMFE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMOHMFE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMOHMFE','D10','dbo.U_EUNUMOHMFE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUNUMOHMFE
-----------

IF OBJECT_ID('U_dsi_BDM_EUNUMOHMFE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMOHMFE] (
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
-- Create table U_EUNUMOHMFE_Audit
-----------

IF OBJECT_ID('U_EUNUMOHMFE_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);

-----------
-- Create table U_EUNUMOHMFE_AuditFields
-----------

IF OBJECT_ID('U_EUNUMOHMFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EUNUMOHMFE_DedList
-----------

IF OBJECT_ID('U_EUNUMOHMFE_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUNUMOHMFE_drvTbl
-----------

IF OBJECT_ID('U_EUNUMOHMFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEnroll2] char(6) NULL,
    [drvPolicy] varchar(6) NULL,
    [drvDivision] varchar(4) NOT NULL,
    [drvMemberId] char(11) NULL,
    [drvDateOfHire] datetime NULL,
    [drvSalary] money NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvHours] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseGender] char(1) NULL,
    [drvSpounseDateOfBirth] datetime NULL,
    [drvClass] varchar(4) NULL,
    [drvSignatureDate] datetime NULL,
    [audReHire] varchar(1) NULL,
    [AUDTERM] varchar(1) NULL,
    [AUDSALARYCHANGE] varchar(1) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvSPOUSECOVERAGE] varchar(1) NOT NULL,
    [drvCHILDCOVERAGE] varchar(1) NOT NULL,
    [drvAddType] varchar(1) NOT NULL,
    [drvBenefitId1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualifyingDate1] datetime NULL,
    [drvBenefitTerminationDate1] datetime NULL,
    [drvBenefitSelectionAmt1] varchar(256) NULL,
    [drvBenefitSelection1] varchar(1) NOT NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualifyingDate2] datetime NULL,
    [drvBenefitTerminationDate2] datetime NULL,
    [drvBenefitSelectionAmt2] varchar(256) NULL,
    [drvBenefitSelection2] varchar(1) NOT NULL,
    [drvBenefitId3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenefitQualifyingDate3] datetime NULL,
    [drvBenefitTerminationDate3] datetime NULL,
    [drvBenefitSelectionAmt3] varchar(256) NULL,
    [drvBenefitSelection3] varchar(1) NOT NULL,
    [drvBenefitId4] varchar(2) NULL,
    [drvPlanCode4] varchar(6) NULL,
    [drvBenefitQualifyingDate4] datetime NULL,
    [drvBenefitTerminationDate4] datetime NULL,
    [drvBenefitSelectionAmt4] varchar(12) NULL,
    [drvBenefitSelection4] varchar(1) NOT NULL,
    [drvBenefitId5] varchar(2) NULL,
    [drvPlanCode5] varchar(6) NULL,
    [drvBenefitQualifyingDate5] datetime NULL,
    [drvBenefitTerminationDate5] datetime NULL,
    [drvBenefitSelectionAmt5] varchar(12) NULL,
    [drvBenefitSelection5] varchar(1) NOT NULL,
    [drvBenefitId6] varchar(2) NOT NULL,
    [drvPlanCode6] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate6] datetime NULL,
    [drvBenefitTerminationDate6] datetime NULL,
    [drvBenefitSelectionAmt6] varchar(12) NULL,
    [drvBenefitSelection] varchar(1) NOT NULL
);

-----------
-- Create table U_EUNUMOHMFE_EEList
-----------

IF OBJECT_ID('U_EUNUMOHMFE_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUNUMOHMFE_File
-----------

IF OBJECT_ID('U_EUNUMOHMFE_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMOHMFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMOHMFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: OHM Advisors

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/31/2021
Service Request Number: TekP-2021-03-01-0001

Purpose: Unum Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       10/03/2019     SR-2019-000XXXXX   Initial Build

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMOHMFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMOHMFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMOHMFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMOHMFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMOHMFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMOHMFE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMOHMFE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMOHMFE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMOHMFE', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMOHMFE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMOHMFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMOHMFE';

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



    
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUNUMOHMFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMOHMFE_AuditFields;
    CREATE TABLE dbo.U_EUNUMOHMFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_EUNUMOHMFE_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMOHMFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMOHMFE_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EUNUMOHMFE_Audit
    FROM dbo.U_EUNUMOHMFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EUNUMOHMFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EUNUMOHMFE_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    --========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMOHMFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMOHMFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --DELETE EE LIST where Employee Type is TES
    Delete U_EUNUMOHMFE_EEList
    FROM U_EUNUMOHMFE_EEList JOIN EmpComp
    ON EecEeid = xEEID and EEcCoid = xCoid
    WHERE EecEEType = 'TES'
        --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLCB2,BLCH1,BLCH2,BLCS2,BLFEB,BLFEE,BLFES,BLFSP,BLSPB,BLSPS,HOSP,LFCH1,LFCH2,LFEE,LFSP,VGAIN';

    IF OBJECT_ID('U_EUNUMOHMFE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMOHMFE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMOHMFE_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '90')

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
    -- Build Driver Tables
    --==========================================


    --========================================= 
    -- Update BdmChangeReason For Dependents 
    --========================================= 
    UPDATE D 
        SET D.BdmChangeReason = E.BdmChangeReason
         
    FROM dbo.U_dsi_BDM_EUNUMOHMFE D 
    JOIN dbo.U_dsi_BDM_EUNUMOHMFE E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMOHMFE 
        SET BdmUSGField2 = EedEmpDedTVID,
        BdmUsgDate1 =  EedEEEligDate
    FROM dbo.U_dsi_BDM_EUNUMOHMFE 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_BDM_EUNUMOHMFE 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_BDM_EUNUMOHMFE 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMOHMFE 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    FROM dbo.U_dsi_BDM_EUNUMOHMFE 
    JOIN dbo.EmpDedFull WITH (NOLOCK) 
        ON EedEmpDedTVID = BdmUSGField2;
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMOHMFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMOHMFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMOHMFE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvEnroll2 =  CONVERT(CHAR(6),'')
        ,drvPolicy = PolicyNumber
        ,drvDivision = '0001'
        ,drvMemberId = eepSSN
        ,drvDateOfHire = EecDateOflasthire
        ,drvSalary = CASE WHEN ISNULL(EEPUDFIELD10,0) <> 0 THEN EEPUDFIELD10 ELSE  EecAnnSalary  END
        ,drvSalaryMode = 'A'
        ,drvHours = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTermReason = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DT'
                                                 WHEN EecTermReason IN ('202') THEN 'RT'
                                                 ELSE 'TE' END
                               END
        ,drvNewMemberId = CASE WHEN ISNULL(eepoldssn,'') <> '' THEN eepoldssn END 
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvLastName = EepNameLast
        ,drvSuffix = EepNameSuffix
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvEmailAddress = EepAddressEMail
        ,drvSpouseFirstName = CASE WHEN LFSP IN ('LFSP') THEN (select Top 1 ConNameFirst from Contacts where ConIsDependent = 'Y' and ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvSpouseGender = CASE WHEN LFSP IN ('LFSP')  THEN (select Top 1 ConGender from Contacts where ConIsDependent = 'Y' and ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvSpounseDateOfBirth = CASE WHEN LFSP IN ('LFSP') THEN (select Top 1 ConDateOfBirth from Contacts where ConIsDependent = 'Y' and ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvClass = CASE WHEN LFSP IN ('LFSP') or LFEE IN ('LFEE') or LFCH1 in ('LFCH1')  or LFCH2 in ('LFCH2') THEN '1000' 
                         WHEN BLFEB IS NOT NULL then '1000'
                         WHEN BLFES IS NOT NULL then '2000'
                         WHEN BLFEE IS NOT NULL then '3000'
                         WHEN HOSP IS NOT NULL OR VGAIN IS NOT NULL THEN '0010'
                    END
        ,drvSignatureDate = Signature_Date
        ,audReHire,AUDTERM,AUDSALARYCHANGE
        ,drvEffectiveDate = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' AND audNewHire = 'N' THEN EjhJobEffDate
                                 ELSE 
                                 BENEFIT_STARTDATE
                            END
        ,drvSPOUSECOVERAGE = CASE WHEN BLFSP IS NOT NULL or  BLSPB IS NOT NULL or BLSPS IS NOT NULL THEN 'Y' else  'N' END
        ,drvCHILDCOVERAGE = CASE WHEN BLCB2 IS NOT NULL or  BLCH1 IS NOT NULL or BLCH2 IS NOT NULL OR BLCS2 IS NOT NULL THEN 'Y' else  'N' END
        ,drvAddType = CASE WHEN EXISTS(select top 1 * from U_EUNUMOHMFE_Audit where audAction = 'Update' and audFieldName = 'EecFullTimeOrPartTime' and audEEID = xEEID and Audkey2 = xCOID and audOldValue = 'P' and audNewValue = 'F') and EecFullTimeOrPartTime = 'F' THEN 'O' ELSE '' END
        ,drvBenefitId1 = CASE WHEN LFEE IN ('LFEE') THEN 'LM'
                          END
        ,drvPlanCode1 = CASE WHEN LFEE IN ('LFEE') THEN '5.0N25' END
        ,drvBenefitQualifyingDate1 = CASE WHEN LFEE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LFEE_BenefitDate END
        ,drvBenefitTerminationDate1 = CASE WHEN EecEmplStatus <> 'T' THEN LFEE_StopDate END
        ,drvBenefitSelectionAmt1 = CASE WHEN LFEE IN ('LFEE') THEN LFEE_EEAmt END        
        ,drvBenefitSelection1 = '' --'Y'--CASE WHEN LFEE IN ('LFEE') THEN 'Y' END
        ,drvBenefitId2 = CASE WHEN LFSP IN ('LFSP') THEN 'LS'
                          END
        ,drvPlanCode2 = CASE WHEN LFSP IN ('LFSP') THEN '5.AM05' END
        ,drvBenefitQualifyingDate2 = CASE WHEN LFSP_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LFSP_BenefitDate END
        ,drvBenefitTerminationDate2 = CASE WHEN EecEmplStatus <> 'T' THEN LFSP_StopDate END
        ,drvBenefitSelectionAmt2 = CASE WHEN LFSP IN ('LFSP') THEN LFSP_EEAmt END
        ,drvBenefitSelection2 = '' --'Y'--CASE WHEN LFSP IN ('LFSP') THEN 'Y' END
        ,drvBenefitId3 = CASE WHEN LFCH1 IN ('LFCH1') OR  LFCH2 IS NOT NULL THEN 'LC'
                          END
        ,drvPlanCode3 = CASE WHEN LFCH1 IN ('LFCH1') OR  LFCH2 IS NOT NULL THEN '5.0M03' END
        ,drvBenefitQualifyingDate3 = CASE WHEN (LFCH1 IN ('LFCH1') and LFCH1_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')) OR ( LFCH2 IN ('LFCH1') and LFCH2_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')) 
                    THEN ISNULL(LFCH1_BenefitDate,LFCH2_BenefitDate) END
        ,drvBenefitTerminationDate3 = CASE WHEN (LFCH1 IN ('LFCH1') OR  LFCH2 IS NOT NULL  ) and EecEmplStatus <> 'T' THEN LFCH1_StopDate END
        ,drvBenefitSelectionAmt3 = CASE WHEN (LFCH1 IN ('LFCH1') OR  LFCH2 IS NOT NULL  )  THEN ISNULL(LFCH1_EEAmt,LFCH2_EEAmt) END
        ,drvBenefitSelection3 = '' --'Y'--CASE WHEN (LFCH1 IN ('LFCH1') OR  LFCH2 IS NOT NULL  )  THEN '' END
        ,drvBenefitId4 = CASE WHEN HOSP IS NOT NULL THEN 'H1' END
        ,drvPlanCode4 = CASE WHEN HOSP IS NOT NULL THEN 
                            CASE WHEN HOSP_BenOption = 'EMP' THEN 'HOSPM1'
                                 WHEN HOSP_BenOption = 'EMPCH' THEN 'HOSPC1'
                                 WHEN HOSP_BenOption = 'EMPSP' THEN 'HOSPS1'
                                 WHEN HOSP_BenOption = 'FAM' THEN 'HOSPF1'
                            END
        
                     END 
 
        ,drvBenefitQualifyingDate4 =  CASE WHEN HOSP_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN HOSP_BenefitDate END
        ,drvBenefitTerminationDate4 = CASE WHEN EecEmplStatus <> 'T' THEN HOSP_StopDate END
        ,drvBenefitSelectionAmt4 = SPACE(12)
        ,drvBenefitSelection4 = '' --'Y'
        ,drvBenefitId5 = CASE WHEN VGAIN IS NOT NULL THEN 'KA' END
        ,drvPlanCode5 =  CASE WHEN VGAIN IS NOT NULL THEN 
        
                            CASE WHEN VGAIN_BenOption = 'EMP' THEN 'ACCDM1'
                                 WHEN VGAIN_BenOption = 'EMPCH' THEN 'ACCDC1'
                                 WHEN VGAIN_BenOption = 'EMPSP' THEN 'ACCDS1'
                                 WHEN VGAIN_BenOption = 'FAM' THEN 'ACCDF1'
                            END
                            
                         END
        ,drvBenefitQualifyingDate5 = CASE WHEN VGAIN_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN VGAIN_BenefitDate END
        ,drvBenefitTerminationDate5 = CASE WHEN EecEmplStatus <> 'T' THEN VGAIN_StopDate END
        ,drvBenefitSelectionAmt5 = SPACE(12)
        ,drvBenefitSelection5 = '' --'Y'
        ,drvBenefitId6 = '  '
        ,drvPlanCode6 = '      '
        ,drvBenefitQualifyingDate6 = CAST(NULL as datetime)
        ,drvBenefitTerminationDate6 = CAST(NULL as datetime)
        ,drvBenefitSelectionAmt6 = SPACE(12)
        ,drvBenefitSelection = '' --'Y'
    INTO dbo.U_EUNUMOHMFE_drvTbl
    FROM dbo.U_EUNUMOHMFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            Select  bdmEEID,bdmcoid,BdmDepRecId,PolicyNumber = CASE 
                                WHEN BDMDedCode IN ('BLFEB', 'BLFEE', 'BLFES', 'BLFSP', 'BLSPB', 'BLSPS', 'BLCB2', 'BLCH1', 'BLCH2', 'BLCS2') THEN '431166' 
                                WHEN BDMDedCode IN ('LFEE', 'LFSP', 'LFCH1' ,'LFCH2') THEN '431167' 
                                WHEN BDMDedCode IN ('HOSP') THEN '431168' 
                                WHEN BDMDedCode IN ('VGAIN') THEN '431169' 
                            END
           
            
            
            ,BLCH1 = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then BDMDedCode END))
            ,BLCH1_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then  BdmUsgDate1 END))
            ,BLCH1_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then  bdmBenStartDate END))
            ,BLCH1_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then  BdmStopDate END))
            ,BLCH1_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then  BdmUSGField1 END))
            ,BLCH1_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLCH1') then  bdmChangeReason END))

            
            ,BLCS2 = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then BDMDedCode END))
            ,BLCS2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then  BdmUsgDate1 END))
            ,BLCS2_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then  bdmBenStartDate END))
            ,BLCS2_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then  BdmStopDate END))
            ,BLCS2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then  BdmUSGField1 END))
            ,BLCS2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLCS2') then  bdmChangeReason END))

            
            ,BLCH2 = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then BDMDedCode END))
            ,BLCH2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then  BdmUsgDate1 END))
            ,BLCH2_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then  bdmBenStartDate END))
            ,BLCH2_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then  BdmStopDate END))
            ,BLCH2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then  BdmUSGField1 END))
            ,BLCH2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLCH2') then  bdmChangeReason END))

            ,BLSPS = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then BDMDedCode END))
            ,BLSPS_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then  BdmUsgDate1 END))
            ,BLSPS_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then  bdmBenStartDate END))
            ,BLSPS_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then  BdmStopDate END))
            ,BLSPS_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then  BdmUSGField1 END))
            ,BLSPS_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLSPS') then  bdmChangeReason END))
            
            ,BLCB2 = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then BDMDedCode END))
            ,BLCB2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then  BdmUsgDate1 END))
            ,BLCB2_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then  bdmBenStartDate END))
            ,BLCB2_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then  BdmStopDate END))
            ,BLCB2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then  BdmUSGField1 END))
            ,BLCB2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLCB2') then  bdmChangeReason END))

            ,BENEFIT_STARTDATE = MAX((CASE WHEN BDMDedCode IN ('BLCB2','BLCH1','BLCH2','BLCS2','BLFEB','BLFEE','BLFES','BLFSP','BLSPB','BLSPS','HOSP','LFCH1','LFCH2','LFEE','LFSP','VGAIN') then  bdmBenStartDate END)) 
            ,VGAIN = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then BDMDedCode END))
            ,VGAIN_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  BdmUsgDate1 END))
            ,VGAIN_StartDate = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  bdmBenStartDate END))
            ,VGAIN_StopDate = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  BdmStopDate END))
            ,VGAIN_EEAmt = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  BdmUSGField1 END))
            ,VGAIN_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  bdmChangeReason END))
            ,VGAIN_BenOption = MAX((CASE WHEN BDMDedCode IN ('VGAIN') then  bdmBenOption END))

            ,Signature_Date = MAX((CASE WHEN BDMDedCode IN ('LFEE', 'LFSP', 'LFCH1','LFCH2') then  bdmBenStartDate END)) 
            ,HOSP = MAX((CASE WHEN BDMDedCode IN ('HOSP') then BDMDedCode END))
            ,HOSP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  BdmUsgDate1 END))
            ,HOSP_StartDate = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  bdmBenStartDate END))
            ,HOSP_StopDate = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  BdmStopDate END))
            ,HOSP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  BdmUSGField1 END))
            ,HOSP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  bdmChangeReason END))
            ,HOSP_BenOption = MAX((CASE WHEN BDMDedCode IN ('HOSP') then  bdmBenOption END))


            ,BLFES = MAX((CASE WHEN BDMDedCode IN ('BLFES') then BDMDedCode END))
            ,BLFES_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLFES') then  BdmUsgDate1 END))
            ,BLFES_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLFES') then  bdmBenStartDate END))
            ,BLFES_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLFES') then  BdmStopDate END))
            ,BLFES_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLFES') then  BdmUSGField1 END))
            ,BLFES_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLFES') then  bdmChangeReason END))

            ,BLFEB = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then BDMDedCode END))
            ,BLFEB_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then  BdmUsgDate1 END))
            ,BLFEB_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then  bdmBenStartDate END))
            ,BLFEB_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then  BdmStopDate END))
            ,BLFEB_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then  BdmUSGField1 END))
            ,BLFEB_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLFEB') then  bdmChangeReason END))
            
            ,BLSPB = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then BDMDedCode END))
            ,BLSPB_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then  BdmUsgDate1 END))
            ,BLSPB_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then  bdmBenStartDate END))
            ,BLSPB_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then  BdmStopDate END))
            ,BLSPB_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then  BdmUSGField1 END))
            ,BLSPB_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLSPB') then  bdmChangeReason END))
            
            
            ,BLFEE = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then BDMDedCode END))
            ,BLFEE_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then  BdmBenStatusDate END))
            ,BLFEE_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then  bdmBenStartDate END))
            ,BLFEE_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then  BdmStopDate END))
            ,BLFEE_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then  BdmUSGField1 END))
            ,BLFEE_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLFEE') then  bdmChangeReason END))

            ,BLFSP = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then BDMDedCode END))
            ,BLFSP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then  BdmUsgDate1 END))
            ,BLFSP_StartDate = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then  bdmBenStartDate END))
            ,BLFSP_StopDate = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then  BdmStopDate END))
            ,BLFSP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then  BdmUSGField1 END))
            ,BLFSP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('BLFSP') then  bdmChangeReason END))

            ,LFEE = MAX((CASE WHEN BDMDedCode IN ('LFEE') then BDMDedCode END))
            ,LFEE_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  BdmUsgDate1 END))
            ,LFEE_StartDate = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  bdmBenStartDate END))
            ,LFEE_StopDate = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  BdmStopDate END))
            ,LFEE_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  BdmUSGField1 END))
            ,LFEE_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  bdmChangeReason END))
            ,LFSP = MAX((CASE WHEN BDMDedCode IN ('LFSP') then BDMDedCode END))
            ,LFSP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LFSP') then  BdmUsgDate1 END))
            ,LFSP_StartDate = MAX((CASE WHEN BDMDedCode IN ('LFSP') then  bdmBenStartDate END))
            ,LFSP_StopDate = MAX((CASE WHEN BDMDedCode IN ('LFSP') then  BdmStopDate END))
            ,LFSP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LFSP') then  BdmUSGField1 END))
            ,LFSP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LFEE') then  bdmChangeReason END))

            ,LFCH1 = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then BDMDedCode END))
            ,LFCH1_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then  BdmUsgDate1 END))
            ,LFCH1_StartDate = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then  bdmBenStartDate END))
            ,LFCH1_StopDate = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then  BdmStopDate END))
            ,LFCH1_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then  BdmUSGField1 END))
            ,LFCH1_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LFCH1') then  bdmChangeReason END))

            ,LFCH2 = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then BDMDedCode END))
            ,LFCH2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then  BdmUsgDate1 END))
            ,LFCH2_StartDate = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then  bdmBenStartDate END))
            ,LFCH2_StopDate = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then  BdmStopDate END))
            ,LFCH2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then  BdmUSGField1 END))
            ,LFCH2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LFCH2') then  bdmChangeReason END))
            
            from U_dsi_BDM_EUNUMOHMFE  where BdmRecType = 'EMP' group by bdmEEID,bdmcoid,BdmDepRecId,CASE 
                                WHEN BDMDedCode IN ('BLFEB', 'BLFEE', 'BLFES', 'BLFSP', 'BLSPB', 'BLSPS', 'BLCB2', 'BLCH1', 'BLCH2', 'BLCS2') THEN '431166' 
                                WHEN BDMDedCode IN ('LFEE', 'LFSP', 'LFCH1' ,'LFCH2') THEN '431167' 
                                WHEN BDMDedCode IN ('HOSP') THEN '431168' 
                                WHEN BDMDedCode IN ('VGAIN') THEN '431169' 
                            END
    ) as BdmConsolidated 
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_EUNUMOHMFE_Audit
        WHERE (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    LEFT JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID;

   
  
    Delete from dbo.U_EUNUMOHMFE_drvTbl where drvPolicy is null

    /*  -- Update for ADD
    Update dbo.U_EUNUMOHMFE_drvTbl set 
        drvBenefitId4 = CASE WHEN drvBenefitId1 = 'LM' THEN 'AM' ELSE '' END
        ,drvPlanCode4 =  CASE WHEN drvPlanCode1 = '5.0N30' THEN '5.0N29' ELSE '' END
        ,drvBenefitQualifyingDate4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN drvBenefitQualifyingDate1 END
        ,drvBenefitTerminationDate4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN drvBenefitTerminationDate1 END
        ,drvBenefitSelectionAmt4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN ISNULL(drvBenefitSelectionAmt1,'') END
        ,drvBenefitSelection4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN ISNULL(drvBenefitSelection1,'') ELSE '' END
        ,drvBenefitId5 = CASE WHEN drvBenefitId2 = 'LS' THEN 'AS' ELSE '' END
        ,drvPlanCode5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN '5.0Q03' ELSE '' END
        ,drvBenefitQualifyingDate5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN drvBenefitQualifyingDate2 END
        ,drvBenefitTerminationDate5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN drvBenefitTerminationDate2 END
        ,drvBenefitSelectionAmt5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN ISNULL(drvBenefitSelectionAmt2,'') END
        ,drvBenefitSelection5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN ISNULL(drvBenefitSelection2,'') ELSE ''  END
        ,drvBenefitId6 = CASE WHEN drvBenefitId3 = 'LC' THEN 'AC' ELSE ''END
        ,drvPlanCode6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN '5.0AM5' ELSE '' END
        ,drvBenefitQualifyingDate6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN drvBenefitQualifyingDate3 END
        ,drvBenefitTerminationDate6 =  CASE WHEN drvPlanCode3 = '5.AM17' THEN drvBenefitTerminationDate3 END
        ,drvBenefitSelectionAmt6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN ISNULL(drvBenefitSelectionAmt3,'') END
        ,drvBenefitSelection = ''
        where drvPolicy = '701930'
    */

    --Update Header information for Enroll2 fields

    Update TOP (1)  U_EUNUMOHMFE_drvTbl set drvEnroll2 = (SELECT CONVERT(CHAR(6),count(*)) from U_EUNUMOHMFE_drvTbl) FROM  U_EUNUMOHMFE_drvTbl
    where drvInitialSort  = (select top (1) drvInitialSort from dbo.U_EUNUMOHMFE_drvTbl order by drvInitialSort)
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EUNUMOHMFE_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EUNUMTEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUNUMOHMFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMOHMFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMOHMFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104071'
       ,expStartPerControl     = '202104071'
       ,expLastEndPerControl   = '202105109'
       ,expEndPerControl       = '202105109'
WHERE expFormatCode = 'EUNUMOHMFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMOHMFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMOHMFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUNUMOHMFE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUNUMOHMFE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUNUMOHMFE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMOHMFE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUNUMOHMFE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMOHMFE', 'UseFileName', 'V', 'Y'


-- End ripout