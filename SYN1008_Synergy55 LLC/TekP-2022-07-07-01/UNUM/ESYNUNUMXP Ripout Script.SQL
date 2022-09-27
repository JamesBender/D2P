/**********************************************************************************

ESYNUNUMXP: UNUM LIFE

FormatCode:     ESYNUNUMXP
Project:        UNUM LIFE
Client ID:      SYN1008
Date/time:      2022-09-22 13:33:48.073
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB03
Database:       ULTIPRO_WPSYNRG
Web Filename:   SYN1008_7E3AC_EEHISTORY_ESYNUNUMXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESYNUNUMXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESYNUNUMXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESYNUNUMXP'


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
WHERE FormatCode = 'ESYNUNUMXP'
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
WHERE ExpFormatCode = 'ESYNUNUMXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESYNUNUMXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESYNUNUMXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESYNUNUMXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESYNUNUMXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESYNUNUMXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESYNUNUMXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESYNUNUMXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESYNUNUMXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESYNUNUMXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESYNUNUMXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESYNUNUMXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESYNUNUMXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESYNUNUMXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESYNUNUMXP];
GO
IF OBJECT_ID('U_ESYNUNUMXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_PDedHist];
GO
IF OBJECT_ID('U_ESYNUNUMXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_File];
GO
IF OBJECT_ID('U_ESYNUNUMXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_EEList];
GO
IF OBJECT_ID('U_ESYNUNUMXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_drvTbl];
GO
IF OBJECT_ID('U_ESYNUNUMXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_DedList];
GO
IF OBJECT_ID('U_ESYNUNUMXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_AuditFields];
GO
IF OBJECT_ID('U_ESYNUNUMXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESYNUNUMXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESYNUNUMXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESYNUNUMXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESYNUNUMXP','UNUM LIFE','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ESYNUNUMXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESYNUNUMXPZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL,'"eEnroll2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESYNUNUMXPZ0','50','H','01','2',NULL,'POLICY',NULL,NULL,'"POLICY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESYNUNUMXPZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESYNUNUMXPZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL,'"MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESYNUNUMXPZ0','50','H','01','5',NULL,'DOH',NULL,NULL,'"DOH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESYNUNUMXPZ0','50','H','01','6',NULL,'SALARY',NULL,NULL,'"SALARY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESYNUNUMXPZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL,'"SALARY MODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESYNUNUMXPZ0','50','H','01','8',NULL,'HOURS',NULL,NULL,'"HOURS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESYNUNUMXPZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL,'"TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESYNUNUMXPZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL,'"TERM REASON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESYNUNUMXPZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL,'"NEW MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESYNUNUMXPZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESYNUNUMXPZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL,'"MIDDLE NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESYNUNUMXPZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESYNUNUMXPZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL,'"SUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESYNUNUMXPZ0','50','H','01','16',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESYNUNUMXPZ0','50','H','01','17',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESYNUNUMXPZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESYNUNUMXPZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"SPOUSE FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESYNUNUMXPZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL,'"SPOUSE GDR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESYNUNUMXPZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL,'"SPOUSE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESYNUNUMXPZ0','50','H','01','22',NULL,'CLASS',NULL,NULL,'"CLASS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESYNUNUMXPZ0','50','H','01','23',NULL,'SIGNATURE DATE',NULL,NULL,'"SIGNATURE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESYNUNUMXPZ0','50','H','01','24',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESYNUNUMXPZ0','50','H','01','25',NULL,'ADD TYPE',NULL,NULL,'"ADD TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESYNUNUMXPZ0','50','H','01','26',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESYNUNUMXPZ0','50','H','01','27',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESYNUNUMXPZ0','50','H','01','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESYNUNUMXPZ0','50','H','01','29',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESYNUNUMXPZ0','50','H','01','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESYNUNUMXPZ0','50','H','01','31',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESYNUNUMXPZ0','50','H','01','32',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESYNUNUMXPZ0','50','H','01','33',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESYNUNUMXPZ0','50','H','01','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESYNUNUMXPZ0','50','H','01','35',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESYNUNUMXPZ0','50','H','01','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESYNUNUMXPZ0','50','H','01','37',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESYNUNUMXPZ0','50','H','01','38',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESYNUNUMXPZ0','50','H','01','39',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESYNUNUMXPZ0','50','H','01','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESYNUNUMXPZ0','50','H','01','41',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESYNUNUMXPZ0','50','H','01','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESYNUNUMXPZ0','50','H','01','43',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESYNUNUMXPZ0','50','H','01','44',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESYNUNUMXPZ0','50','H','01','45',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESYNUNUMXPZ0','50','H','01','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESYNUNUMXPZ0','50','H','01','47',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESYNUNUMXPZ0','50','H','01','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESYNUNUMXPZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESYNUNUMXPZ0','50','H','01','50',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESYNUNUMXPZ0','50','H','01','51',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESYNUNUMXPZ0','50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESYNUNUMXPZ0','50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESYNUNUMXPZ0','50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESYNUNUMXPZ0','50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESYNUNUMXPZ0','50','H','01','56',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESYNUNUMXPZ0','50','H','01','57',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESYNUNUMXPZ0','50','H','01','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESYNUNUMXPZ0','50','H','01','59',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESYNUNUMXPZ0','50','H','01','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"BENEFIT SELECTION AMOUNT"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESYNUNUMXPZ0','50','H','01','61',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESYNUNUMXPZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL,'"drveEnroll2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESYNUNUMXPZ0','50','D','10','2',NULL,'POLICY',NULL,NULL,'"drvPOLICY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESYNUNUMXPZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL,'"drvDIVISION"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESYNUNUMXPZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESYNUNUMXPZ0','50','D','10','5',NULL,'DOH',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESYNUNUMXPZ0','50','D','10','6',NULL,'SALARY',NULL,NULL,'"drvSALARY"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESYNUNUMXPZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL,'"A"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESYNUNUMXPZ0','50','D','10','8',NULL,'HOURS',NULL,NULL,'""','(SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESYNUNUMXPZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL,'"drvDateOfTermination"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESYNUNUMXPZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL,'"drvTERMREASON"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESYNUNUMXPZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL,'"drvNEWMEMBERID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESYNUNUMXPZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESYNUNUMXPZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESYNUNUMXPZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESYNUNUMXPZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL,'"drvNameSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESYNUNUMXPZ0','50','D','10','16',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESYNUNUMXPZ0','50','D','10','17',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESYNUNUMXPZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEMAILADDRESS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESYNUNUMXPZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"drvSPOUSEFIRSTNAME"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESYNUNUMXPZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL,'"drvSPOUSEGDR"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESYNUNUMXPZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL,'"drvSPOUSEDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESYNUNUMXPZ0','50','D','10','22',NULL,'CLASS',NULL,NULL,'"drvCLASS"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESYNUNUMXPZ0','50','D','10','23',NULL,'SIGNATURE DATE',NULL,NULL,'"drvSIGNATUREDATE"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESYNUNUMXPZ0','50','D','10','24',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEFFECTIVEDATE"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESYNUNUMXPZ0','50','D','10','25',NULL,'ADD TYPE',NULL,NULL,'"drvADDTYPE"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESYNUNUMXPZ0','50','D','10','26',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESYNUNUMXPZ0','50','D','10','27',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESYNUNUMXPZ0','50','D','10','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESYNUNUMXPZ0','50','D','10','29',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESYNUNUMXPZ0','50','D','10','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESYNUNUMXPZ0','50','D','10','31',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESYNUNUMXPZ0','50','D','10','32',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESYNUNUMXPZ0','50','D','10','33',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESYNUNUMXPZ0','50','D','10','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESYNUNUMXPZ0','50','D','10','35',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESYNUNUMXPZ0','50','D','10','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESYNUNUMXPZ0','50','D','10','37',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESYNUNUMXPZ0','50','D','10','38',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESYNUNUMXPZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESYNUNUMXPZ0','50','D','10','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESYNUNUMXPZ0','50','D','10','41',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESYNUNUMXPZ0','50','D','10','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESYNUNUMXPZ0','50','D','10','43',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESYNUNUMXPZ0','50','D','10','44',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESYNUNUMXPZ0','50','D','10','45',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESYNUNUMXPZ0','50','D','10','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESYNUNUMXPZ0','50','D','10','47',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESYNUNUMXPZ0','50','D','10','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESYNUNUMXPZ0','50','D','10','49',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESYNUNUMXPZ0','50','D','10','50',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESYNUNUMXPZ0','50','D','10','51',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESYNUNUMXPZ0','51','D','10','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESYNUNUMXPZ0','52','D','10','53',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESYNUNUMXPZ0','53','D','10','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESYNUNUMXPZ0','54','D','10','55',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESYNUNUMXPZ0','55','D','10','56',NULL,'BENEFIT ID',NULL,NULL,'"drvBENEFITID6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESYNUNUMXPZ0','56','D','10','57',NULL,'PLAN CODE',NULL,NULL,'"drvPLANCODE6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESYNUNUMXPZ0','57','D','10','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvBENEFITQUALIFYINGDATE6"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESYNUNUMXPZ0','58','D','10','59',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBENEFITTERMDATE6"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESYNUNUMXPZ0','59','D','10','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL,'"drvBENEFITSELECTIONAMOUNT6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESYNUNUMXPZ0','60','D','10','61',NULL,'BENEFIT SELECTION',NULL,NULL,'""','(''ss''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESYNUNUMXP_20220922.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208189','EMPEXPORT','OEACTIVE',NULL,'ESYNUNUMXP',NULL,NULL,NULL,'202208189','Aug 18 2022  2:46PM','Aug 18 2022  2:46PM','202208181',NULL,'','','202208181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208189','EMPEXPORT','OEPASSIVE',NULL,'ESYNUNUMXP',NULL,NULL,NULL,'202208189','Aug 18 2022  2:46PM','Aug 18 2022  2:46PM','202208181',NULL,'','','202208181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',516RA,516UK,516D5,51674,KGM6D,BFBZ1,8V0N2,PU4I4,8V0S6,8V0TG,8V0PH',NULL,NULL,NULL,'UNUM LIFE ONDEM','202208189','EMPEXPORT','ONDEM_XOE',NULL,'ESYNUNUMXP',NULL,NULL,NULL,'202208189','Aug 18 2022  2:46PM','Aug 18 2022  2:46PM','202208181',NULL,'','','202208181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'516RA,516UK,516D5,51674,KGM6D,BFBZ1,8V0N2,PU4I4,8V0S6,8V0TG,8V0PH',NULL,NULL,NULL,'UNUM LIFE Sched','202208189','EMPEXPORT','SCH_ESYNUN',NULL,'ESYNUNUMXP',NULL,NULL,NULL,'202208189','Aug 18 2022  2:46PM','Aug 18 2022  2:46PM','202208181',NULL,'','','202208181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','516RA,516UK,516D5,51674,KGM6D,BFBZ1,8V0N2,PU4I4,8V0S6,8V0TG,8V0PH',NULL,NULL,NULL,'UNUM LIFE Test','202209099','EMPEXPORT','TEST_XOE','Sep  9 2022 12:00AM','ESYNUNUMXP',NULL,NULL,NULL,'202209099','Sep  9 2022 12:00AM','Dec 30 1899 12:00AM','202208311',NULL,'','','202208311',dbo.fn_GetTimedKey(),NULL,'us3kEpSYN1008',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','InitialSort','C','drvInitalSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESYNUNUMXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESYNUNUMXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESYNUNUMXP','D10','dbo.U_ESYNUNUMXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESYNUNUMXP
-----------

IF OBJECT_ID('U_dsi_BDM_ESYNUNUMXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESYNUNUMXP] (
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
-- Create table U_ESYNUNUMXP_Audit
-----------

IF OBJECT_ID('U_ESYNUNUMXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_Audit] (
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
-- Create table U_ESYNUNUMXP_AuditFields
-----------

IF OBJECT_ID('U_ESYNUNUMXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESYNUNUMXP_DedList
-----------

IF OBJECT_ID('U_ESYNUNUMXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESYNUNUMXP_drvTbl
-----------

IF OBJECT_ID('U_ESYNUNUMXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitalSort] char(11) NULL,
    [drveEnroll2] char(6) NULL,
    [drvPOLICY] varchar(7) NULL,
    [drvDIVISION] varchar(4) NULL,
    [drvSSN] char(11) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvSALARY] money NULL,
    [drvDateOfTermination] datetime NULL,
    [drvTERMREASON] varchar(2) NULL,
    [drvNEWMEMBERID] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvGENDER] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvEMAILADDRESS] varchar(50) NULL,
    [drvSPOUSEFIRSTNAME] varchar(100) NULL,
    [drvSPOUSEGDR] char(1) NULL,
    [drvSPOUSEDOB] datetime NULL,
    [drvCLASS] varchar(4) NULL,
    [drvSIGNATUREDATE] datetime NULL,
    [drvEFFECTIVEDATE] datetime NULL,
    [drvADDTYPE] varchar(1) NOT NULL,
    [drvBENEFITID1] varchar(2) NULL,
    [drvPLANCODE1] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE1] datetime NULL,
    [drvBENEFITTERMDATE1] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT1] nvarchar(4000) NULL,
    [drvBENEFITID2] varchar(2) NULL,
    [drvPLANCODE2] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE2] datetime NULL,
    [drvBENEFITTERMDATE2] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT2] nvarchar(4000) NULL,
    [drvBENEFITID3] varchar(2) NULL,
    [drvPLANCODE3] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE3] datetime NULL,
    [drvBENEFITTERMDATE3] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT3] nvarchar(4000) NULL,
    [drvBENEFITID4] varchar(2) NULL,
    [drvPLANCODE4] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE4] datetime NULL,
    [drvBENEFITTERMDATE4] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT4] nvarchar(4000) NULL,
    [drvBENEFITID5] varchar(2) NULL,
    [drvPLANCODE5] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE5] datetime NULL,
    [drvBENEFITTERMDATE5] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT5] nvarchar(4000) NULL,
    [drvBENEFITID6] varchar(2) NULL,
    [drvPLANCODE6] varchar(6) NULL,
    [drvBENEFITQUALIFYINGDATE6] datetime NULL,
    [drvBENEFITTERMDATE6] datetime NULL,
    [drvBENEFITSELECTIONAMOUNT6] nvarchar(4000) NULL
);

-----------
-- Create table U_ESYNUNUMXP_EEList
-----------

IF OBJECT_ID('U_ESYNUNUMXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESYNUNUMXP_File
-----------

IF OBJECT_ID('U_ESYNUNUMXP_File') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_ESYNUNUMXP_PDedHist
-----------

IF OBJECT_ID('U_ESYNUNUMXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESYNUNUMXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhVLFEE] numeric NULL,
    [PdhVLFCH] numeric NULL,
    [PdhVLFSP] numeric NULL,
    [PdhVADDC] numeric NULL,
    [PdhVADDE] numeric NULL,
    [PdhVADDS] numeric NULL,
    [PdhGTL] numeric NULL,
    [PdhGADD] numeric NULL,
    [PdhLTDER] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESYNUNUMXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Synergy55 LLC

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 08/18/2022
Service Request Number: TekP-2022-07-07-01

Purpose: UNUM FMLA STD LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESYNUNUMXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESYNUNUMXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESYNUNUMXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESYNUNUMXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESYNUNUMXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESYNUNUMXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESYNUNUMXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESYNUNUMXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESYNUNUMXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESYNUNUMXP', 'SCH_ESYNUN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESYNUNUMXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESYNUNUMXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESYNUNUMXP';

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
    DELETE FROM dbo.U_ESYNUNUMXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESYNUNUMXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESYNUNUMXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESYNUNUMXP_AuditFields;
    CREATE TABLE dbo.U_ESYNUNUMXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecAnnSalary');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpComp','EecTermReason');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpDed','EedBenStopDate');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepGender');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepNameFirst');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepNameLast');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepOldSSN');
        INSERT INTO dbo.U_ESYNUNUMXP_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESYNUNUMXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESYNUNUMXP_Audit;
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
    INTO dbo.U_ESYNUNUMXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESYNUNUMXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -14, @StartDate) AND @EndDate
    AND audAction <> 'DELETE'
  

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESYNUNUMXP_Audit ON dbo.U_ESYNUNUMXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ESYNUNUMXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESYNUNUMXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'VLFEE,VLFCH,VLFSP,VADDC,VADDE,VADDS,GTL,GADD,LTDER';

    IF OBJECT_ID('U_ESYNUNUMXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESYNUNUMXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESYNUNUMXP_DedList
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



    --========================================= 
    -- Update BdmChangeReason For Dependents 
    --========================================= 
    UPDATE D 
        SET D.BdmChangeReason = E.BdmChangeReason
         
    FROM dbo.U_dsi_BDM_ESYNUNUMXP D 
    JOIN dbo.U_dsi_BDM_ESYNUNUMXP E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_BDM_ESYNUNUMXP 
        SET BdmUSGField2 = EedEmpDedTVID,
        BdmUsgDate1 =  EedEEEligDate
    FROM dbo.U_dsi_BDM_ESYNUNUMXP 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_BDM_ESYNUNUMXP 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_BDM_ESYNUNUMXP 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    --UPDATE dbo.U_dsi_BDM_ESYNUNUMXP 
    --    SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    --FROM dbo.U_dsi_BDM_ESYNUNUMXP 
    --JOIN dbo.EmpDedFull WITH (NOLOCK) 
    --    ON EedEmpDedTVID = BdmUSGField2;

    ----==========================================
    ---- Build Working Tables
    ----==========================================

    -------------------------------
    ---- Working Table - PDedHist
    -------------------------------
    --IF OBJECT_ID('U_ESYNUNUMXP_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ESYNUNUMXP_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhVLFEE     = SUM(CASE WHEN PdhDedCode IN ('VLFEE') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhVLFCH     = SUM(CASE WHEN PdhDedCode IN ('VLFCH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhVLFSP     = SUM(CASE WHEN PdhDedCode IN ('VLFSP') THEN PdhEECurAmt ELSE 0.00 END)        
    --    ,PdhVADDC     = SUM(CASE WHEN PdhDedCode IN ('VADDC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhVADDE     = SUM(CASE WHEN PdhDedCode IN ('VADDE') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhVADDS     = SUM(CASE WHEN PdhDedCode IN ('VADDS') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhGTL     = SUM(CASE WHEN PdhDedCode IN ('GTL') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhGADD     = SUM(CASE WHEN PdhDedCode IN ('GADD') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhLTDER     = SUM(CASE WHEN PdhDedCode IN ('LTDER') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --   -- ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_ESYNUNUMXP_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ESYNUNUMXP_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESYNUNUMXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESYNUNUMXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESYNUNUMXP_drvTbl;

SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drveEnroll2 = CONVERT(CHAR(6), '')
        ,drvPOLICY = Ltrim(RTrim(PolicyNumber))
        ,drvDIVISION = CASE WHEN cmpcompanycode = 'AERO' THEN '0003' 
                            WHEN cmpcompanycode = 'SYN' THEN '0001'
                            WHEN cmpcompanycode = 'COM' THEN '0002'
                            END
        ,drvSSN = eepSSN
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvSALARY = CASE WHEN ISNULL(EEPUDFIELD10,0) <> '0' THEN EEPUDFIELD10 ELSE  EecAnnSalary  END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTERMREASON = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DT'
                                                 WHEN EecTermReason = '202' THEN 'RT'
                                                 ELSE 'TE' 
                                                END
                                        END

        ,drvNEWMEMBERID = CASE WHEN ISNULL(eepoldssn,'') <> '' THEN eepoldssn END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = EepNameSuffix -- NULLIF(EepNameSuffix,'Z')
        ,drvGENDER = EepGender
        ,drvDOB = EepDateOfBirth
        ,drvEMAILADDRESS = CASE WHEN EepAddressEMail IS NOT NULL THEN EepAddressEmail ELSE EepAddressEmailAlternate END
        ,drvSPOUSEFIRSTNAME = CASE WHEN VLFSP IN ('VLFSP') THEN (select Top 1 ConNameFirst from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END 
        ,drvSPOUSEGDR = CASE WHEN VLFSP IN ('VLFSP') THEN (select Top 1 ConGender from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvSPOUSEDOB = CASE WHEN VLFSP IN ('VLFSP') THEN (select Top 1 ConDateOfBirth from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvCLASS = CASE WHEN VLFSP IN ('VLFSP') or VLFEE IN ('VLFEE') OR VLFCH in ('VLFCH')  OR VADDC in ('VADDC')  OR VADDE IN ('VADDE') OR VADDS IN ('VADDS' )THEN '1000' 
                         WHEN GTL in ('GTL') or  GADD in ('GADD') OR LTDER IN ('LTDER') THEN '1001'
                    END
        ,drvSIGNATUREDATE = CASE WHEN Ltrim(RTrim(PolicyNumber)) = '915349'   THEN Signature_Date END
        ,drvEFFECTIVEDATE = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' THEN EjhJobEffDate
                                 ELSE 
                                 BENEFIT_STARTDATE
                            END
        ,drvADDTYPE = CASE WHEN EXISTS(select top 1 * from U_ESYNUNUMXP_Audit where audAction = 'Update' and audFieldName = 'EecFullTimeOrPartTime' and audEEID = xEEID and Audkey2 = xCOID and audOldValue = 'P' and audNewValue = 'F') and EecFullTimeOrPartTime = 'F' THEN 'O' ELSE '' END
        ,drvBENEFITID1 = CASE WHEN VLFEE IN ('VLFEE') THEN 'LM' END
        ,drvPLANCODE1 = CASE WHEN VLFEE IN ('VLFEE') THEN '5.0AL3' END
        ,drvBENEFITQUALIFYINGDATE1 = CASE WHEN VLFEE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VLFEE_BenefitDate END
        ,drvBENEFITTERMDATE1 = CASE WHEN VLFEE IN ('VLFEE') and EecEmplStatus <> 'T' THEN VLFEE_StopDate END
        ,drvBENEFITSELECTIONAMOUNT1 = CASE WHEN format(VLFEE_EEAmt,'#0.00')  > '0.00' THEN format(isnull(VLFEE_EEAmt, ''),'#0.00') else NULL END
        
        ,drvBENEFITID2 = CASE WHEN VLFSP IN ('VLFSP') THEN 'LS' END
        ,drvPLANCODE2 = CASE WHEN VLFSP IN ('VLFSP') THEN '5.AN3B' END
        ,drvBENEFITQUALIFYINGDATE2 = CASE WHEN VLFSP_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VLFSP_BenefitDate END
        ,drvBENEFITTERMDATE2 = CASE WHEN VLFSP IN ('VLFSP')  and EecEmplStatus <> 'T' THEN VLFSP_StopDate END
        ,drvBENEFITSELECTIONAMOUNT2 = CASE WHEN  format(VLFSP_EEAmt,'#0.00') <> '0.00' THEN format(isnull(VLFSP_EEAmt, ''),'#0.00')  else NULL END
        
        ,drvBENEFITID3 = CASE WHEN VLFCH IN ('VLFCH') THEN 'LC' END
        ,drvPLANCODE3 = CASE WHEN VLFCH IN ('VLFCH') THEN '5.AM17' END
        ,drvBENEFITQUALIFYINGDATE3 =  CASE WHEN VLFCH_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VLFCH_BenefitDate END
        ,drvBENEFITTERMDATE3 = CASE WHEN VLFCH IN ('VLFCH')  and  EecEmplStatus <> 'T' THEN VLFCH_StopDate END
        ,drvBENEFITSELECTIONAMOUNT3 = CASE WHEN  format(VLFCH_EEAmt,'#0.00')  <> '0.00' THEN format(isnull(VADDE_EEAmt, ''),'#0.00')  else NULL END
        ,drvBENEFITID4 = CASE WHEN VADDE IN ('VADDE') THEN 'AM' END
        ,drvPLANCODE4 = CASE WHEN VADDE IN ('VADDE') THEN '5.0N29' END
        ,drvBENEFITQUALIFYINGDATE4 = CASE WHEN VADDE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VADDE_BenefitDate END
        ,drvBENEFITTERMDATE4 = CASE WHEN VADDE IN ('VADDE') and EecEmplStatus <> 'T' THEN VADDE_StopDate END
        ,drvBENEFITSELECTIONAMOUNT4 = CASE WHEN  format(VADDE_EEAmt,'#0.00') <> '0.00' THEN format(isnull(VADDE_EEAmt, ''),'#0.00')  else NULL END
        ,drvBENEFITID5 = CASE WHEN VADDS IS NOT NULL THEN 'AS' END
        ,drvPLANCODE5 = CASE WHEN VADDS IN ('VADDS') THEN '5.0AM6' END
        ,drvBENEFITQUALIFYINGDATE5 = CASE WHEN VADDS_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VADDS_BenefitDate END
        ,drvBENEFITTERMDATE5 = CASE WHEN VADDS IN ('VADDS') and EecEmplStatus <> 'T' THEN VADDS_StopDate END
        ,drvBENEFITSELECTIONAMOUNT5 = CASE WHEN format(VADDS_EEAmt,'#0.00')  <> '0.00' THEN format(isnull(VADDS_EEAmt, ''),'#0.00')  else NULL END
        ,drvBENEFITID6 = CASE WHEN VADDC IS NOT NULL THEN 'AC' END
        ,drvPLANCODE6 = CASE WHEN VADDC IN ('VADDC') THEN '5.0AM5' END
        ,drvBENEFITQUALIFYINGDATE6 = CASE WHEN VADDC_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN VADDC_BenefitDate END
        ,drvBENEFITTERMDATE6 = CASE WHEN VADDC IN ('VADDC') and EecEmplStatus <> 'T' THEN VADDC_StopDate END
        ,drvBENEFITSELECTIONAMOUNT6 = CASE WHEN  isnull(VADDC_EEAmt, '') <> '' or  format(VADDC_EEAmt,'#0.00')  <> '0.00' THEN format(isnull(VADDC_EEAmt, ''),'#0.00')  else NULL END
    INTO dbo.U_ESYNUNUMXP_drvTbl
    FROM dbo.U_ESYNUNUMXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_ESYNUNUMXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
          JOIN (
             Select Distinct  EedEEID, Eedcoid,PolicyNumber = CASE 
                                WHEN EedDedCode  IN ('VLFEE','VLFCH','VLFSP','VADDC','VADDE','VADDS') THEN ' 915349' 
                                WHEN EedDedCode  IN ('GTL', 'GADD', 'LTDER')  THEN '915346' 
                               END
           
            
            
            ,VLFEE = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then EedDedCode  END))
            ,VLFEE_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then  EedEEEligDate END))
            ,VLFEE_StartDate = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then  EedBenStartDate END))
            ,VLFEE_StopDate = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then  EedBenStopDate END))
            ,VLFEE_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then  EedBenAmt  END))
            ,VLFEE_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VLFEE') then  EdhChangeReason END))

            
            ,VLFCH = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then EedDedCode  END))
            ,VLFCH_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then  EedEEEligDate END))
            ,VLFCH_StartDate = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then  EedBenStartDate END))
            ,VLFCH_StopDate = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then  EedBenStopDate END))
            ,VLFCH_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then   EedBenAmt END))
            ,VLFCH_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VLFCH') then  EdhChangeReason END))

            
            ,VLFSP = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then EedDedCode  END))
            ,VLFSP_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then  EedEEEligDate END))
            ,VLFSP_StartDate = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then  EedBenStartDate END))
            ,VLFSP_StopDate = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then  EedBenStopDate END))
            ,VLFSP_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then   EedBenAmt  END))
            ,VLFSP_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VLFSP') then  EdhChangeReason END))

            ,VADDC = MAX((CASE WHEN EedDedCode  IN ('VADDC') then EedDedCode  END))
            ,VADDC_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VADDC') then  EedEEEligDate END))
            ,VADDC_StartDate = MAX((CASE WHEN EedDedCode  IN ('VADDC') then  EedBenStartDate END))
            ,VADDC_StopDate = MAX((CASE WHEN EedDedCode  IN ('VADDC') then  EedBenStopDate END))
            ,VADDC_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VADDC') then  EedBenAmt END))
            ,VADDC_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VADDC') then  EdhChangeReason END))
            
            ,VADDE = MAX((CASE WHEN EedDedCode  IN ('VADDE') then EedDedCode  END))
            ,VADDE_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VADDE') then  EedEEEligDate END))
            ,VADDE_StartDate = MAX((CASE WHEN EedDedCode  IN ('VADDE') then  EedBenStartDate END))
            ,VADDE_StopDate = MAX((CASE WHEN EedDedCode  IN ('VADDE') then  EedBenStopDate END))
            ,VADDE_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VADDE') then   EedBenAmt  END))
            ,VADDE_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VADDE') then  EdhChangeReason END))

            ,BENEFIT_STARTDATE = MAX((CASE WHEN EedDedCode  IN ('VLFEE','VLFCH','VLFSP','VADDC','VADDE','VADDS', 'GTL', 'GADD', 'LTDER') then  EedBenStartDate END))
            ,VADDS = MAX((CASE WHEN EedDedCode  IN ('VADDS') then EedDedCode  END))
            ,VADDS_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('VADDS') then  EedEEEligDate END))
            ,VADDS_StartDate = MAX((CASE WHEN EedDedCode  IN ('VADDS') then  EedBenStartDate END))
            ,VADDS_StopDate = MAX((CASE WHEN EedDedCode  IN ('VADDS') then  EedBenStopDate END))
            ,VADDS_EEAmt = MAX((CASE WHEN EedDedCode  IN ('VADDS') then   EedBenAmt END))
            ,VADDS_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('VADDS') then  EdhChangeReason END))
            --,VADDS_BenOption = MAX((CASE WHEN EedDedCode  IN ('VADDS') then  bdmBenOption END))

            ,Signature_Date = MAX((CASE WHEN EedDedCode  IN ('VLFCH', 'VLFEE', 'VLFSP') then  EedBenStartDate END)) 
            ,GTL = MAX((CASE WHEN EedDedCode  IN ('GTL')  then EedDedCode  END))
            --,GTL_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('GTL') and  EedBenAmt  > 0 then  EedEEEligDate END))
            --,GTL_StartDate = MAX((CASE WHEN EedDedCode  IN ('GTL') and  EedBenAmt  > 0 then  EedBenStartDate END))
            --,GTL_StopDate = MAX((CASE WHEN EedDedCode  IN ('GTL') and  EedBenAmt  > 0 then  EedBenStopDate END))
            --,GTL_EEAmt = MAX((CASE WHEN EedDedCode IN ('GTL') and  EedBenAmt  > 0 then   EedBenAmt END))
            --,GTL_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('GTL') and  EedBenAmt  > 0 then  BdmChangeReason END))
            --,GTL_BenOption = MAX((CASE WHEN EedDedCode  IN ('GTL') then  bdmBenOption END))


            ,GADD = MAX((CASE WHEN EedDedCode  IN ('GADD')  then EedDedCode  END))
            --,GADD_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('GADD') and EedBenAmt  > 0 then  EedEEEligDate END))
            --,GADD_StartDate = MAX((CASE WHEN EedDedCode  IN ('GADD') and EedBenAmt  > 0 then  EedBenStartDate END))
            --,GADD_StopDate = MAX((CASE WHEN EedDedCode  IN ('GADD') and EedBenAmt  > 0 then  EedBenStopDate END))
            --,GADD_EEAmt = MAX((CASE WHEN EedDedCode  IN ('GADD') and EedBenAmt  > 0 then   EedBenAmt  END))
            --,GADD_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('GADD') and EedBenAmt  > 0 then  BdmChangeReason END))

            ,LTDER = MAX((CASE WHEN EedDedCode  IN ('LTDER')  then EedDedCode  END))
            --,LTDER_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('LTDER') and  EedBenAmt  > 0 then  EedEEEligDate END))
            --,LTDER_StartDate = MAX((CASE WHEN EedDedCode  IN ('LTDER') and  EedBenAmt  > 0  then  EedBenStartDate END))
            --,LTDER_StopDate = MAX((CASE WHEN EedDedCode  IN ('LTDER') and  EedBenAmt  > 0 then  EedBenStopDate END))
            --,LTDER_EEAmt = MAX((CASE WHEN EedDedCode  IN ('LTDER') and  EedBenAmt  > 0  then  EedEEAmt END))
            --,LTDER_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('LTDER') and  EedBenAmt  > 0 then BdmChangeReason END))
                      
            FROM dbo.u_dsi_bdm_EmpDeductions WITH (NOLOCK)
            Join U_dsi_BDM_ESYNUNUMXP  WITH (NOLOCK)
                ON BdmDedCode = EedDedCode 
                AND bdmeeid = EedEEID
            JOIN dbo.EmpHDed WITH (NOLOCK)
                ON edhEEID = EedEEID
                AND EdhDedCode= EedDedCode
            where  EedDedCode IN ('VLFEE','VLFCH','VLFSP','VADDC','VADDE','VADDS', 'GTL', 'GADD', 'LTDER')
                            AND EedFormatCode = 'ESYNUNUMXP'
                        
            GROUP BY EedEEID,Eedcoid,CASE 
                                WHEN EedDedCode IN ('VLFEE','VLFCH','VLFSP','VADDC','VADDE','VADDS') THEN ' 915349' 
                                WHEN EedDedCode IN ('GTL', 'GADD', 'LTDER') THEN '915346' 
                               END
                     
    ) as BdmConsolidated 
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
     LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT AudDateTime, audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_ESYNUNUMXP_Audit
        WHERE (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY AudDateTime, audEEID
    ) AuditRecords
        ON audEEID = xEEID
    LEFT JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob WITH (NOLOCK)
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN dbo.Company  WITH (NOLOCK) 
            ON cmpCoID = eecCOID
    where (EecEmplStatus <> 'T' OR (audTerm = 'Y' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN DATEADD(DAY, -14, @StartDate) AND @EndDate))
    and EecEEType  = 'REG'
    ; 

   --Update Header information for Enroll2 fields
    Update TOP (1)  dbo.U_ESYNUNUMXP_drvTbl set drveEnroll2 = (SELECT CONVERT(CHAR(6),count(*)) from dbo.U_ESYNUNUMXP_drvTbl) FROM  dbo.U_ESYNUNUMXP_drvTbl
    where drvInitalSort = (select top (1) drvInitalSort from dbo.U_ESYNUNUMXP_drvTbl order by drvInitalSort);

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
ALTER VIEW dbo.dsi_vwESYNUNUMXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESYNUNUMXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESYNUNUMXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208111'
       ,expStartPerControl     = '202208111'
       ,expLastEndPerControl   = '202208189'
       ,expEndPerControl       = '202208189'
WHERE expFormatCode = 'ESYNUNUMXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESYNUNUMXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESYNUNUMXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESYNUNUMXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESYNUNUMXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESYNUNUMXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESYNUNUMXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESYNUNUMXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESYNUNUMXP', 'UseFileName', 'V', 'Y'


-- End ripout