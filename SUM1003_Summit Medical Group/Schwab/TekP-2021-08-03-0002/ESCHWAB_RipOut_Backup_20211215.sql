/**********************************************************************************

ESCHWAB: Schwab 401K export

FormatCode:     ESCHWAB
Project:        Schwab 401K export
Client ID:      SUM1003
Date/time:      2021-12-15 19:18:06.317
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E21
Server:         E2SUP1DB04
Database:       ULTIPRO_SMG
ExportPath:    \\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\
TestPath:      \\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESCHWAB_SavePath') IS NOT NULL DROP TABLE dbo.U_ESCHWAB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESCHWAB'


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
WHERE FormatCode = 'ESCHWAB'
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
WHERE ExpFormatCode = 'ESCHWAB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESCHWAB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESCHWAB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESCHWAB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESCHWAB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESCHWAB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESCHWAB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESCHWAB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESCHWAB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESCHWAB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESCHWAB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESCHWAB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESCHWAB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESCHWAB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESCHWAB];
GO
IF OBJECT_ID('U_ESCHWAB_File') IS NOT NULL DROP TABLE [dbo].[U_ESCHWAB_File];
GO
IF OBJECT_ID('U_ESCHWAB_EEList_401k') IS NOT NULL DROP TABLE [dbo].[U_ESCHWAB_EEList_401k];
GO
IF OBJECT_ID('U_ESCHWAB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESCHWAB_EEList];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_YTDearnamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_YTDearnamts];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_YTDdedamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_YTDdedamts];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_drvtrl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_drvtrl];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_drvtbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_drvtbl];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_curearnamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_curearnamts];
GO
IF OBJECT_ID('U_dsi_ESCHWAB_curdedamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWAB_curdedamts];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ESCHWAB','Schwab 401K export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','476','S','N','7X1T7L0010K0','N',NULL,'C','dbo.dsi_sp_SwitchBox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','7X1T7L0010K0','3','H','01','1',NULL,NULL,NULL,NULL,'"RID"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','7X1T7L0010K0','6','H','01','4',NULL,NULL,NULL,NULL,'"PlanID "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','7X1T7L0010K0','11','H','01','10',NULL,NULL,NULL,NULL,'"SSN"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','7X1T7L0010K0','20','H','01','21',NULL,NULL,NULL,NULL,'"Last Name                     "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','7X1T7L0010K0','15','H','01','41',NULL,NULL,NULL,NULL,'"First Name                    "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','7X1T7L0010K0','1','H','01','56',NULL,NULL,NULL,NULL,'"M "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','7X1T7L0010K0','11','H','01','57',NULL,NULL,NULL,NULL,'"401KREG         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','7X1T7L0010K0','11','H','01','68',NULL,NULL,NULL,NULL,'"CATCHUP         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','7X1T7L0010K0','11','H','01','79',NULL,NULL,NULL,NULL,'"MATCH         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','7X1T7L0010K0','11','H','01','90',NULL,NULL,NULL,NULL,'"PROFITSHARE         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','7X1T7L0010K0','11','H','01','101',NULL,NULL,NULL,NULL,'"401KROTH         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','7X1T7L0010K0','11','H','01','112',NULL,NULL,NULL,NULL,'"SAFEHARBOR         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','7X1T7L0010K0','11','H','01','123',NULL,NULL,NULL,NULL,'"Loan               "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','7X1T7L0010K0','11','H','01','134',NULL,NULL,NULL,NULL,'"Loan2               "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','7X1T7L0010K0','11','H','01','145',NULL,NULL,NULL,NULL,'"PerTotComp"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','7X1T7L0010K0','4','H','01','156',NULL,NULL,NULL,NULL,'"PerHrsWork       "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','7X1T7L0010K0','11','H','01','160',NULL,NULL,NULL,NULL,'"YTD401K"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','7X1T7L0010K0','11','H','01','171',NULL,NULL,NULL,NULL,'"YTDCATCH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','7X1T7L0010K0','11','H','01','182',NULL,NULL,NULL,NULL,'"YTDMATCH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','7X1T7L0010K0','11','H','01','193',NULL,NULL,NULL,NULL,'"YTDPS"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','7X1T7L0010K0','11','H','01','204',NULL,NULL,NULL,NULL,'"YTDROTH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','7X1T7L0010K0','11','H','01','215',NULL,NULL,NULL,NULL,'"YTDSH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','7X1T7L0010K0','11','H','01','226',NULL,NULL,NULL,NULL,'"YTDTotComp"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','7X1T7L0010K0','4','H','01','237',NULL,NULL,NULL,NULL,'"HWrk         "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','7X1T7L0010K0','1','H','01','241',NULL,NULL,NULL,NULL,'"F"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','7X1T7L0010K0','1','H','01','242',NULL,NULL,NULL,NULL,'"A "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','7X1T7L0010K0','30','H','01','243',NULL,NULL,NULL,NULL,'"Primary Address Line #1                 "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','7X1T7L0010K0','30','H','01','273',NULL,NULL,NULL,NULL,'"Primary Address Line #2                 "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','7X1T7L0010K0','30','H','01','303',NULL,NULL,NULL,NULL,'"Primary City "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','7X1T7L0010K0','2','H','01','333',NULL,NULL,NULL,NULL,'"St "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','7X1T7L0010K0','10','H','01','335',NULL,NULL,NULL,NULL,'"Zip Code "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','7X1T7L0010K0','30','H','01','345',NULL,NULL,NULL,NULL,'"Primary Country "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','7X1T7L0010K0','8','H','01','375',NULL,NULL,NULL,NULL,'"DOB"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','7X1T7L0010K0','8','H','01','383',NULL,NULL,NULL,NULL,'"HireDate "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','7X1T7L0010K0','8','H','01','391',NULL,NULL,NULL,NULL,'"PlanDate "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','7X1T7L0010K0','8','H','01','399',NULL,NULL,NULL,NULL,'"TermDate "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','7X1T7L0010K0','8','H','01','407',NULL,NULL,NULL,NULL,'"RehireDt"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','7X1T7L0010K0','3','H','01','415',NULL,NULL,NULL,NULL,'"PT% "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','7X1T7L0010K0','1','H','01','418',NULL,NULL,NULL,NULL,'"S"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','7X1T7L0010K0','15','H','01','419',NULL,NULL,NULL,NULL,'"Rpt Division                      "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','7X1T7L0010K0','15','H','01','434',NULL,NULL,NULL,NULL,'"Alt Key #1 "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','7X1T7L0010K0','15','H','01','449',NULL,NULL,NULL,NULL,'"Alt Key #2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','7X1T7L0010K0','12','H','01','464',NULL,NULL,NULL,NULL,'"Work Phone "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','7X1T7L0010K0','1','H','01','476',NULL,NULL,NULL,NULL,'"Benefit Status Reason"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','7X1T7L0010K0','3','D','02','1',NULL,NULL,NULL,NULL,'"100"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','7X1T7L0010K0','6','D','02','4',NULL,NULL,NULL,NULL,'"SMT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','7X1T7L0010K0','11','D','02','10',NULL,NULL,NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','7X1T7L0010K0','20','D','02','21',NULL,NULL,NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','7X1T7L0010K0','15','D','02','41',NULL,NULL,NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','7X1T7L0010K0','1','D','02','56',NULL,NULL,NULL,NULL,'"drvMiddlename"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','7X1T7L0010K0','11','D','02','57',NULL,NULL,NULL,NULL,'"drv401KREG"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','7X1T7L0010K0','11','D','02','68',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','7X1T7L0010K0','11','D','02','79',NULL,NULL,NULL,NULL,'"drvMATCH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','7X1T7L0010K0','11','D','02','90',NULL,NULL,NULL,NULL,'"drvPROFITSHARE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','7X1T7L0010K0','11','D','02','101',NULL,NULL,NULL,NULL,'"drv401KROTH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','7X1T7L0010K0','11','D','02','112',NULL,NULL,NULL,NULL,'"drvSAFEHARBOR"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','7X1T7L0010K0','11','D','02','123',NULL,NULL,NULL,NULL,'"drvLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','7X1T7L0010K0','11','D','02','134',NULL,NULL,NULL,NULL,'"00000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','7X1T7L0010K0','11','D','02','145',NULL,NULL,NULL,NULL,'"drvPerTotComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','7X1T7L0010K0','4','D','02','156',NULL,NULL,NULL,NULL,'"drvPerHrsWork"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','7X1T7L0010K0','11','D','02','160',NULL,NULL,NULL,NULL,'"drvYTD401K"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','7X1T7L0010K0','11','D','02','171',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','7X1T7L0010K0','11','D','02','182',NULL,NULL,NULL,NULL,'"drvYTDMATCH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','7X1T7L0010K0','11','D','02','193',NULL,NULL,NULL,NULL,'"drvYTDPS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','7X1T7L0010K0','11','D','02','204',NULL,NULL,NULL,NULL,'"drvYTDROTH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','7X1T7L0010K0','11','D','02','215',NULL,NULL,NULL,NULL,'"drvYTDSH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','7X1T7L0010K0','11','D','02','226',NULL,NULL,NULL,NULL,'"drvYTDTotComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','7X1T7L0010K0','4','D','02','237',NULL,NULL,NULL,NULL,'"drvYTDHrsWork"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','7X1T7L0010K0','1','D','02','241',NULL,NULL,NULL,NULL,'"drvFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','7X1T7L0010K0','1','D','02','242',NULL,NULL,NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','7X1T7L0010K0','30','D','02','243',NULL,NULL,NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','7X1T7L0010K0','30','D','02','273',NULL,NULL,NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','7X1T7L0010K0','30','D','02','303',NULL,NULL,NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','7X1T7L0010K0','2','D','02','333',NULL,NULL,NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','7X1T7L0010K0','10','D','02','335',NULL,NULL,NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','7X1T7L0010K0','30','D','02','345',NULL,NULL,NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','7X1T7L0010K0','8','D','02','375',NULL,NULL,NULL,NULL,'"drvDOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','7X1T7L0010K0','8','D','02','383',NULL,NULL,NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','7X1T7L0010K0','8','D','02','391',NULL,NULL,NULL,NULL,'"drvPlanDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','7X1T7L0010K0','8','D','02','399',NULL,NULL,NULL,NULL,'"drvTermDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','7X1T7L0010K0','8','D','02','407',NULL,NULL,NULL,NULL,'"drvRehireDt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','7X1T7L0010K0','3','D','02','415',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','7X1T7L0010K0','1','D','02','418',NULL,NULL,NULL,NULL,'"drvStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','7X1T7L0010K0','15','D','02','419',NULL,NULL,NULL,NULL,'"drvRptDivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','7X1T7L0010K0','15','D','02','434',NULL,NULL,NULL,NULL,'"drvAltKey1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','7X1T7L0010K0','15','D','02','449',NULL,NULL,NULL,NULL,'"drvAltKey2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','7X1T7L0010K0','12','D','02','464',NULL,NULL,NULL,NULL,'"drvWorkPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','7X1T7L0010K0','1','D','02','476',NULL,NULL,NULL,NULL,'drvBenefitStatusReason','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','7X1T7L0010K0','3','T','03','1',NULL,NULL,NULL,NULL,'"100"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','7X1T7L0010K0','6','T','03','4',NULL,NULL,NULL,NULL,'"SMT"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','7X1T7L0010K0','8','T','03','10',NULL,NULL,NULL,NULL,'"drvpedate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','7X1T7L0010K0','39','T','03','18',NULL,NULL,NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','7X1T7L0010K0','11','T','03','57',NULL,NULL,NULL,NULL,'"drvsource1tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','7X1T7L0010K0','11','T','03','68',NULL,NULL,NULL,NULL,'"00000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','7X1T7L0010K0','11','T','03','79',NULL,NULL,NULL,NULL,'"drvsource3tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','7X1T7L0010K0','11','T','03','90',NULL,NULL,NULL,NULL,'"drvsource4tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','7X1T7L0010K0','11','T','03','101',NULL,NULL,NULL,NULL,'"drvsource5tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','7X1T7L0010K0','11','T','03','112',NULL,NULL,NULL,NULL,'"drvsource6tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','7X1T7L0010K0','11','T','03','123',NULL,NULL,NULL,NULL,'"drvloan1tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','7X1T7L0010K0','11','T','03','134',NULL,NULL,NULL,NULL,'"00000000000"','(''DA''=''F'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('20211210 Schwab Biweekly',NULL,NULL,NULL,'UF32E,RCDFF,UFMUO,T59MG',NULL,NULL,NULL,'Schwab 401K export','202112109','EMPEXPORT','ESCHWAB','Dec  9 2021  9:05AM','ESCHWAB',NULL,NULL,NULL,'202112109','Dec 10 2021 12:00AM','Dec 30 1899 12:00AM','202112101','5062','',NULL,'202112101',dbo.fn_GetTimedKey(),NULL,'CALLEY',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\E2\Public\10752\Exports\CharlesSchwab\TEST_20211207a_Schwab_Biweekly.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only','202111241','EMPEXPORT','TEST','Dec  7 2021 12:00AM','ESCHWAB',NULL,NULL,NULL,'202111241','Nov 24 2021 12:00AM','Nov 20 2021 12:00AM','202111241','5060','',NULL,'202111241',dbo.fn_GetTimedKey(),NULL,'us3rVaSUM1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','ExportPath','V','\\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','InitialSort','C','drvssn');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','TestPath','V','\\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWAB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWAB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWAB','D02','dbo.U_dsi_ESCHWAB_drvtbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWAB','T03','dbo.U_dsi_ESCHWAB_drvtrl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_ESCHWAB_curdedamts
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_curdedamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_curdedamts] (
    [pdheeid] char(12) NOT NULL,
    [pdhcoid] char(5) NOT NULL,
    [dedcode] varchar(7) NULL,
    [eecuramt] money NULL,
    [ercuramt] money NULL
);

-----------
-- Create table U_dsi_ESCHWAB_curearnamts
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_curearnamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_curearnamts] (
    [peheeid] char(12) NOT NULL,
    [pehcoid] char(5) NOT NULL,
    [eecurhrs] decimal NULL,
    [eecuramt] money NULL
);

-----------
-- Create table U_dsi_ESCHWAB_drvtbl
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_drvtbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_drvtbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvssn] char(11) NULL,
    [drvlastname] varchar(100) NULL,
    [drvfirstname] varchar(100) NULL,
    [drvmiddlename] varchar(1) NULL,
    [drv401KREGamt] money NULL,
    [drv401KREG] varchar(11) NOT NULL,
    [drvMATCHamt] money NULL,
    [drvMATCH] varchar(11) NOT NULL,
    [drvPROFITSHAREamt] money NULL,
    [drvPROFITSHARE] varchar(11) NOT NULL,
    [drv401KROTHamt] money NULL,
    [drv401KROTH] varchar(11) NOT NULL,
    [drvSAFEHARBORamt] money NULL,
    [drvSAFEHARBOR] varchar(11) NOT NULL,
    [drvloanamt] money NULL,
    [drvloan] varchar(11) NOT NULL,
    [drvPerTotCompamt] money NULL,
    [drvPerTotComp] varchar(11) NOT NULL,
    [drvPerHrsWorkamt] int NULL,
    [drvPerHrsWork] varchar(4) NOT NULL,
    [drvYTD401Kamt] money NULL,
    [drvYTD401K] varchar(11) NOT NULL,
    [drvYTDMATCHamt] money NULL,
    [drvYTDMATCH] varchar(11) NOT NULL,
    [drvYTDPSamt] money NULL,
    [drvYTDPS] varchar(11) NOT NULL,
    [drvYTDROTHamt] money NULL,
    [drvYTDROTH] varchar(11) NOT NULL,
    [drvYTDSHamt] money NULL,
    [drvYTDSH] varchar(11) NOT NULL,
    [drvYTDTotCompamt] money NULL,
    [drvYTDTotComp] varchar(11) NOT NULL,
    [drvYTDHrsWorkamt] int NULL,
    [drvYTDHrsWork] varchar(4) NOT NULL,
    [drvfreq] char(1) NULL,
    [drvaddress1] varchar(255) NULL,
    [drvaddress2] varchar(255) NULL,
    [drvcity] varchar(255) NULL,
    [drvstate] varchar(255) NULL,
    [drvzipcode] varchar(50) NULL,
    [drvcountry] char(3) NULL,
    [drvdob] varchar(8000) NULL,
    [drvhiredate] varchar(8000) NULL,
    [drvplandate] char(8) NULL,
    [drvtermdate] varchar(8000) NULL,
    [drvrehiredt] varchar(8000) NULL,
    [drvstatus] varchar(1) NULL,
    [drvrptdivision] varchar(10) NULL,
    [drvaltkey1] char(1) NULL,
    [drvaltkey2] varchar(10) NULL,
    [drvworkphone] varchar(12) NULL,
    [drvBenefitStatusReason] char(1) NULL
);

-----------
-- Create table U_dsi_ESCHWAB_drvtrl
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_drvtrl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_drvtrl] (
    [drvpedate] varchar(8000) NULL,
    [drvsource1tot] varchar(24) NULL,
    [drvsource3tot] varchar(24) NULL,
    [drvsource4tot] varchar(24) NULL,
    [drvsource5tot] varchar(24) NULL,
    [drvsource6tot] varchar(24) NULL,
    [drvloan1tot] varchar(24) NULL
);

-----------
-- Create table U_dsi_ESCHWAB_YTDdedamts
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_YTDdedamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_YTDdedamts] (
    [eedeeid] char(12) NOT NULL,
    [eedcoid] char(5) NOT NULL,
    [dedcode] varchar(7) NULL,
    [eeYTDamt] money NULL,
    [erYTDamt] money NULL
);

-----------
-- Create table U_dsi_ESCHWAB_YTDearnamts
-----------

IF OBJECT_ID('U_dsi_ESCHWAB_YTDearnamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWAB_YTDearnamts] (
    [eeeeeid] char(12) NOT NULL,
    [eeecoid] char(5) NOT NULL,
    [eeYTDhrs] decimal NULL,
    [eeYTDamt] money NULL
);

-----------
-- Create table U_ESCHWAB_EEList
-----------

IF OBJECT_ID('U_ESCHWAB_EEList') IS NULL
CREATE TABLE [dbo].[U_ESCHWAB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESCHWAB_EEList_401k
-----------

IF OBJECT_ID('U_ESCHWAB_EEList_401k') IS NULL
CREATE TABLE [dbo].[U_ESCHWAB_EEList_401k] (
    [xeeid] char(12) NULL,
    [xcoid] char(5) NULL
);

-----------
-- Create table U_ESCHWAB_File
-----------

IF OBJECT_ID('U_ESCHWAB_File') IS NULL
CREATE TABLE [dbo].[U_ESCHWAB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(476) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESCHWAB]
    @systemid char(12)
AS
/************************************************************
Client: Summit Medical Group     

Created By: Ellen Havdahl
Business Analyst: Fernando Gutierrez             
Create Date: 03/04/2010
ChangePoint Request Number: 27572

Purpose: 401K export for Charles Schwab

Revision History
-----------------
Update By            Date            CP Num                Desc 
Ellen Havdahl        3/4/2010        27572                Initial  Code      
Tanya Leonce        11/14/2014        SR-2014-00065512    Updates Per Spec v2.3 - Update "Alternate Key #2"
Dave Smith            2/22/2018        SR-2018-00183882    Added benefit status field in column 29

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'ESCHWAB'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'ESCHWAB'
SELECT * FROM U_Dsi_parameters WHERE FormatCode = 'ESCHWAB'
SELECT * FROM AscExp WHERE ExpFormatCode = 'ESCHWAB'


EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESCHWAB', @AllObjects = 'Y', @IsWeb = 'N'

EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWAB', 'ESCHWAB'
EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWAB', 'TEST'
************************************************************/
BEGIN


    /**********************************
    DROP TABLE IF IT ALREADY EXISTS
    ***********************************/

    IF object_id ('U_ESCHWAB_EEList_401k') IS NOT NULL
        DROP TABLE dbo.U_ESCHWAB_EEList_401k
    IF object_id ('U_dsi_ESCHWAB_drvtbl') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_drvtbl
    IF object_id ('U_dsi_ESCHWAB_drvtrl') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_drvtrl
    IF object_id ('U_dsi_ESCHWAB_curdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_curdedamts
    IF object_id ('U_dsi_ESCHWAB_YTDdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_YTDdedamts
    IF object_id ('U_dsi_ESCHWAB_curearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_curearnamts
    IF object_id ('U_dsi_ESCHWAB_YTDearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWAB_YTDearnamts


    /*********************************************
    Declare date variables to use for filtering
    **********************************************/
    DECLARE @startdate datetime,
            @enddate datetime,
            @startpc char(9),
            @endpc char(9)


    /**********************************
      RUN EXPORT
    ***********************************/
    SELECT @startdate = convert(datetime,SUBSTRING(StartPercontrol,1,8)),
           @enddate = convert(datetime,SUBSTRING(EndPerControl,1,8)),
           @startpc = startpercontrol,
           @endpc = endpercontrol
    FROM dbo.U_dsi_Parameters
    WHERE formatcode = 'ESCHWAB'



    /****************************************
     GET EMPLOYEES FOR DETAIL RECORD
    ****************************************/

    select distinct xeeid, xcoid 
    into dbo.U_ESCHWAB_EEList_401k
    from dbo.U_ESCHWAB_EEList with (nolock) 
    join dbo.vw_int_EmpComp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    where eecemplstatus <> 'T' or 
    (
        eecemplstatus = 'T' and 
        ( 
            year(eecdateoftermination) = year(@startdate) 
            or 
            year(eecdateoftermination) = year(@enddate)
            -- HEG - 20110310
            or
            year(eecdateoftermination) = year(@startdate) - 1 -- prev yr
            or 
            year(eecdateoftermination) = year(@enddate) - 1 -- prev yr
        )
    )



    /***************************************************
    CREATE TABLE WITH DATA ELEMENTS - 401k Detail record  
    ****************************************************/

    SELECT            
        drveeid = eeceeid,
        drvcoid = eeccoid,
        drvssn = eepssn,
        drvlastname = eepnamelast,
        drvfirstname = eepnamefirst,
        drvmiddlename = left(eepnamemiddle,1),
        drv401KREGamt = convert(money,0), 
        drv401KREG = '00000000000',
        drvMATCHamt = convert(money,0), 
        drvMATCH = '00000000000',
        drvPROFITSHAREamt = convert(money,0),
        drvPROFITSHARE = '00000000000',
        drv401KROTHamt = convert(money,0), 
        drv401KROTH = '00000000000',
        drvSAFEHARBORamt = convert(money,0),
        drvSAFEHARBOR = '00000000000',
        drvloanamt = convert(money,0),
        drvloan = '00000000000',
        drvPerTotCompamt = convert(money,0),
        drvPerTotComp = '00000000000',
        drvPerHrsWorkamt = convert(int,0),
        drvPerHrsWork = '0000',
        drvYTD401Kamt = convert(money,0),
        drvYTD401K = '00000000000',
        drvYTDMATCHamt = convert(money,0), 
        drvYTDMATCH = '00000000000',
        drvYTDPSamt = convert(money,0),
        drvYTDPS = '00000000000',
        drvYTDROTHamt = convert(money,0), 
        drvYTDROTH = '00000000000',
        drvYTDSHamt = convert(money,0),
        drvYTDSH = '00000000000',
        drvYTDTotCompamt = convert(money,0),
        drvYTDTotComp = '00000000000',
        drvYTDHrsWorkamt = convert(int,0),
        drvYTDHrsWork = '0000',
        drvfreq = eecpayperiod,
        drvaddress1 = eepaddressline1,
        drvaddress2 = eepaddressline2,
        drvcity = eepaddresscity,         
        drvstate = eepaddressstate,      
        drvzipcode = case when len(eepaddresszipcode) = 5 then eepaddresszipcode
                    else left(eepaddresszipcode,5) + '-' + substring(eepaddresszipcode,6,4) end,
        drvcountry = eepaddresscountry,
        drvdob = replace(convert(char(10),eepdateofbirth,101),'/',''),
        drvhiredate = replace(convert(char(10),eecdateoforiginalhire,101),'/',''),
        drvplandate = convert(char(8),NULL),
        drvtermdate = replace(convert(char(10),eecdateoftermination,101),'/',''),
        drvrehiredt = case when eecdateoflasthire <> eecdateoforiginalhire then replace(convert(char(10),eecdateoflasthire,101),'/','') end,
        drvstatus = case when eepdatedeceased is not NULL then 'X'
                       when eectermreason = '202' then 'R'
                       else eecemplstatus end,
        drvrptdivision = eecorglvl4,
        drvaltkey1 = eepgender,
        drvaltkey2 = EecOrgLvl2,        -- 11/14/2014, TL - Replaced cmpcompanycode
        drvworkphone = case when cmpphonenumber is not NULL then left(cmpphonenumber,3) + '-' + substring(cmpphonenumber,4,3) + '-' + substring(cmpphonenumber,7,4) 
                                                          else ' ' end  , 
        --SR-2018-00183882
        drvBenefitStatusReason =    CASE 
                                        WHEN PNPSE.EedBenStatus IS NOT NULL AND PNPSP.EedBenStatus IS NULL THEN PNPSE.EedBenStatus
                                        WHEN PNPSE.EedBenStatus = 'T' AND PNPSP.EedBenStatus = 'A' THEN PNPSP.EedBenStatus
                                        ELSE ISNULL(PNPSE.EedBenStatus,PNPSP.EedBenStatus)
        END
    into dbo.U_dsi_ESCHWAB_drvtbl
    from dbo.U_ESCHWAB_EEList_401k
    join dbo.vw_int_EmpComp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    join dbo.emppers with (nolock) on eeceeid = eepeeid
    join dbo.company with (nolock) on cmpcoid = eeccoid
    --SR-2018-00183882 - added supporting tables to pull specific deduction details for PNPSE and PNPSP
    LEFT OUTER JOIN dbo.EmpDed AS PNPSE WITH (NOLOCK) on PNPSE.EedEEID = xeeid AND PNPSE.EedCoID = xcoid AND PNPSE.EedDedCode = 'PNPSE'
    LEFT OUTER join dbo.EmpDed AS PNPSP WITH (NOLOCK) on PNPSP.EedEEID = xeeid AND PNPSP.EedCoID = xcoid AND PNPSP.EedDedCode = 'PNPSP'


    /* update current ded amounts */
    SELECT
        pdheeid, 
        pdhcoid,
        case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end as dedcode,
        sum(case when pdhdedcode in ('401dp','401rp') then 0 else pdheecuramt end) as eecuramt,
        sum(case when pdhdedcode in ('401de','401re') then 0 else pdhercuramt end) as ercuramt
    into dbo.U_dsi_ESCHWAB_curdedamts
    from dbo.pdedhist with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl with (nolock) on drveeid = pdheeid and drvcoid = pdhcoid
    where pdhdedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP','401KL')
    and pdhpercontrol between @startpc and @endpc
    group by pdheeid, pdhcoid,
      case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drv401KREGamt = eecuramt+ercuramt,
        drv401KREG = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvMATCHamt = ercuramt,
        drvMATCH = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvPROFITSHAREamt = ercuramt,
        drvPROFITSHARE = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drv401KROTHamt = eecuramt+ercuramt,
        drv401KROTH = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvSAFEHARBORamt = ercuramt,
        drvSAFEHARBOR = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source6'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvLoanamt = eecuramt,
        drvLoan = dbo.dsi_fnPadZero(eecuramt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'loan1'


    /* update current earn amounts */
    select peheeid, pehcoid, sum(case when erninclindefcomphrs = 'Y' then pehcurhrs else 0 end) as eecurhrs,
           sum(case when erninclindefcomp = 'Y' then pehcuramt else 0 end) as eecuramt   
    into dbo.U_dsi_ESCHWAB_curearnamts
    from dbo.vw_int_PEarHist with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl with (nolock) on drveeid = peheeid and drvcoid = pehcoid 
    join dbo.earncode on ernearncode = pehearncode
    where pehpercontrol between @startpc and @endpc
    group by peheeid, pehcoid

    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvPerTotCompamt = eecuramt,
        drvPerTotComp = dbo.dsi_fnPadZero(eecuramt*100,11,0),
        drvPerHrsWorkamt = eecurhrs,
        drvPerHrsWork = dbo.dsi_fnPadZero(eecurhrs,4,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_curearnamts  with (nolock) on peheeid = drveeid and pehcoid = drvcoid 


    /* update YTD ded amounts */
    SELECT
        eedeeid, 
        eedcoid,
        case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end as dedcode, 
        sum(case when eeddedcode in ('401dp','401rp') then 0 else eedeeYTDamt end) as eeYTDamt,
        sum(case when eeddedcode in ('401de','401re') then 0 else eederYTDamt end) as erYTDamt
    into dbo.U_dsi_ESCHWAB_YTDdedamts
    from dbo.empded with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl with (nolock) on drveeid = eedeeid and drvcoid = eedcoid
    where eeddedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP')
    group by eedeeid, eedcoid,
      case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end 
      

    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTD401Kamt = eeYTDamt+erYTDamt,
        drvYTD401K = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTDMATCHamt = erYTDamt,
        drvYTDMATCH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTDPSamt = erYTDamt,
        drvYTDPS = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTDROTHamt = eeYTDamt+erYTDamt,
        drvYTDROTH = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTDSHamt = erYTDamt,
        drvYTDSH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source6'


    /* update YTD earn amounts */
    select eeeeeid, eeecoid, sum(case when erninclindefcomphrs = 'Y' then eeeYTDhrs else 0 end) as eeYTDhrs,
           sum(case when erninclindefcomp = 'Y' then eeeYTDamt else 0 end) as eeYTDamt
    into dbo.U_dsi_ESCHWAB_YTDearnamts
    from dbo.empearn with (nolock)
    join dbo.U_dsi_ESCHWAB_drvtbl with (nolock) on drveeid = eeeeeid and drvcoid = eeecoid 
    join dbo.earncode on ernearncode = eeeearncode
    group by eeeeeid, eeecoid


    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvYTDTotCompamt = eeYTDamt,
        drvYTDTotComp = dbo.dsi_fnPadZero(eeYTDamt*100,11,0),
        drvYTDHrsWorkamt = eeYTDhrs,
        drvYTDHrsWork = dbo.dsi_fnPadZero(eeYTDhrs,4,0)
    from dbo.U_dsi_ESCHWAB_drvtbl
    join dbo.U_dsi_ESCHWAB_YTDearnamts  with (nolock) on eeeeeid = drveeid and eeecoid = drvcoid 

    /* update Plan Entry Date */
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSE
    from dbo.empded
    where eeddedcode = 'PNPSE'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWAB_drvtbl
    join #PNPSE on eedeeid = drveeid and eedcoid = drvcoid
     
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSP
    from dbo.empded
    where eeddedcode = 'PNPSP'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWAB_drvtbl
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWAB_drvtbl
    join #PNPSP on eedeeid = drveeid and eedcoid = drvcoid
    where drvplandate is NULL


    /*************************************************************
    Build Trailer record
    *************************************************************/
        
    SELECT
        drvpedate = replace(Convert(char(10),(select max(pgpperiodenddate) from pgpayper where pgpperiodcontrol between @startpc and @endpc),101),'/',''),
        drvsource1tot = dbo.dsi_fnPadZero((select sum(drv401KREGamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0),
        drvsource3tot = dbo.dsi_fnPadZero((select sum(drvMATCHamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0),
        drvsource4tot = dbo.dsi_fnPadZero((select sum(drvPROFITSHAREamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0),
        drvsource5tot = dbo.dsi_fnPadZero((select sum(drv401KROTHamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0),
        drvsource6tot = dbo.dsi_fnPadZero((select sum(drvSAFEHARBORamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0),
        drvloan1tot = dbo.dsi_fnPadZero((select sum(drvLoanamt) *100 from dbo.U_dsi_ESCHWAB_drvtbl),11,0)
    into dbo.U_dsi_ESCHWAB_drvtrl



END
GO
Create View dbo.dsi_vwESCHWAB_Export as
        select top 2000000 Data from dbo.U_ESCHWAB_File with (nolock)
        order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESCHWAB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESCHWAB'
   AND rpoParmType = 'expSystemID'


-- End ripout