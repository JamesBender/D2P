/**********************************************************************************

EHFXCENTEN: Health E(fx) Census File

FormatCode:     EHFXCENTEN
Project:        Health E(fx) Census File
Client ID:      TEN1000
Date/time:      2021-12-30 20:22:26.013
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW2WUP2DB02
Database:       ULTIPRO_WPTEN
Web Filename:   TEN1000_2FE70_EEHISTORY_EHFXCENTEN_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHFXCENTEN_SavePath') IS NOT NULL DROP TABLE dbo.U_EHFXCENTEN_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHFXCENTEN'


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
WHERE FormatCode = 'EHFXCENTEN'
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
WHERE ExpFormatCode = 'EHFXCENTEN'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHFXCENTEN')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHFXCENTEN'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHFXCENTEN'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHFXCENTEN'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHFXCENTEN'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHFXCENTEN'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHFXCENTEN'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHFXCENTEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHFXCENTEN'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHFXCENTEN'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHFXCENTEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHFXCENTEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHFXCENTEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXCENTEN];
GO
IF OBJECT_ID('U_EHFXCENTEN_File') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTEN_File];
GO
IF OBJECT_ID('U_EHFXCENTEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTEN_EEList];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_StatStack') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_StatStack];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_LOA') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_LOA];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_EarnHist];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnCurrHC') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_EarnCurrHC];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnCurr') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_EarnCurr];
GO
IF OBJECT_ID('U_dsi_EHFXCENTEN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTEN_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','EHFXCENTEN','Health E(fx) Census File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EHFXCENTENZ0','N','Sep 28 2016  4:35PM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHFXCENTENZ0','8','H','01','1',NULL,NULL,NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHFXCENTENZ0','20','H','01','9',NULL,NULL,NULL,NULL,'"TYP Restaurant Group"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHFXCENTENZ0','4','H','01','29',NULL,NULL,NULL,NULL,'"FEIN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHFXCENTENZ0','9','H','01','33',NULL,NULL,NULL,NULL,'"EE Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHFXCENTENZ0','3','H','01','42',NULL,NULL,NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHFXCENTENZ0','10','H','01','45',NULL,NULL,NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHFXCENTENZ0','19','H','01','55',NULL,NULL,NULL,NULL,'"Middle Name/Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHFXCENTENZ0','9','H','01','74',NULL,NULL,NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHFXCENTENZ0','9','H','01','83',NULL,NULL,NULL,NULL,'"Address 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHFXCENTENZ0','9','H','01','92',NULL,NULL,NULL,NULL,'"Address 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHFXCENTENZ0','4','H','01','101',NULL,NULL,NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHFXCENTENZ0','5','H','01','105',NULL,NULL,NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHFXCENTENZ0','3','H','01','110',NULL,NULL,NULL,NULL,'"Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHFXCENTENZ0','13','H','01','113',NULL,NULL,NULL,NULL,'"Primary Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHFXCENTENZ0','12','H','01','126',NULL,NULL,NULL,NULL,'"Phone Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHFXCENTENZ0','6','H','01','138',NULL,NULL,NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHFXCENTENZ0','13','H','01','144',NULL,NULL,NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHFXCENTENZ0','18','H','01','157',NULL,NULL,NULL,NULL,'"Original Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHFXCENTENZ0','11','H','01','175',NULL,NULL,NULL,NULL,'"Rehire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHFXCENTENZ0','9','H','01','186',NULL,NULL,NULL,NULL,'"Term Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHFXCENTENZ0','8','H','01','195',NULL,NULL,NULL,NULL,'"Job Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHFXCENTENZ0','15','H','01','203',NULL,NULL,NULL,NULL,'"Job Description"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHFXCENTENZ0','19','H','01','218',NULL,NULL,NULL,NULL,'"Full/Part Time Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHFXCENTENZ0','17','H','01','237',NULL,NULL,NULL,NULL,'"Employment Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHFXCENTENZ0','8','H','01','254',NULL,NULL,NULL,NULL,'"LOA Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHFXCENTENZ0','10','H','01','262',NULL,NULL,NULL,NULL,'"LOA Reason"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHFXCENTENZ0','14','H','01','272',NULL,NULL,NULL,NULL,'"LOA Begin Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHFXCENTENZ0','12','H','01','286',NULL,NULL,NULL,NULL,'"LOA End Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHFXCENTENZ0','6','H','01','298',NULL,NULL,NULL,NULL,'"Region"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHFXCENTENZ0','9','H','01','304',NULL,NULL,NULL,NULL,'"Work City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHFXCENTENZ0','18','H','01','313',NULL,NULL,NULL,NULL,'"Salary/Hourly Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHFXCENTENZ0','11','H','01','331',NULL,NULL,NULL,NULL,'"Hourly Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHFXCENTENZ0','18','H','01','341',NULL,NULL,NULL,NULL,'"Status Change Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHFXCENTENZ0','18','H','01','359',NULL,NULL,NULL,NULL,'"Annual Salary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHFXCENTENZ0','18','H','01','377',NULL,NULL,NULL,NULL,'"Deduction Group"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHFXCENTENZ0','35','D','02','1',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHFXCENTENZ0','35','D','02','36',NULL,'TYP Restaurant Group',NULL,NULL,'"drvTypGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHFXCENTENZ0','35','D','02','71',NULL,'FEIN',NULL,NULL,'"drvFEIN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHFXCENTENZ0','35','D','02','106',NULL,'EE Number',NULL,NULL,'"drvEmpNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHFXCENTENZ0','35','D','02','141',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHFXCENTENZ0','35','D','02','176',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHFXCENTENZ0','35','D','02','211',NULL,'Middle Name/Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHFXCENTENZ0','35','D','02','246',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHFXCENTENZ0','35','D','02','281',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHFXCENTENZ0','35','D','02','316',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHFXCENTENZ0','35','D','02','351',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHFXCENTENZ0','35','D','02','386',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHFXCENTENZ0','35','D','02','421',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHFXCENTENZ0','35','D','02','456',NULL,'Primary Email',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHFXCENTENZ0','35','D','02','491',NULL,'Phone Number',NULL,NULL,'"drvPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHFXCENTENZ0','35','D','02','526',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHFXCENTENZ0','35','D','02','561',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHFXCENTENZ0','35','D','02','596',NULL,'Original Hire Date',NULL,NULL,'"drvOrigDOH"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHFXCENTENZ0','35','D','02','631',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHFXCENTENZ0','35','D','02','666',NULL,'Term Date',NULL,NULL,'"drvDOT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHFXCENTENZ0','35','D','02','701',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHFXCENTENZ0','35','D','02','736',NULL,'Job Description',NULL,NULL,'"drvJobDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHFXCENTENZ0','35','D','02','771',NULL,'Full/Part Time Code',NULL,NULL,'"drvFTorPT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHFXCENTENZ0','35','D','02','806',NULL,'Employment Status',NULL,NULL,'"drvWorkStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHFXCENTENZ0','35','D','02','841',NULL,'LOA Code',NULL,NULL,'"drvLOAcode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHFXCENTENZ0','35','D','02','876',NULL,'LOA Reason',NULL,NULL,'"drvLOAreason"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHFXCENTENZ0','35','D','02','911',NULL,'LOA Begin Date',NULL,NULL,'"drvLOAstartDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHFXCENTENZ0','35','D','02','946',NULL,'LOA End Date',NULL,NULL,'"drvLOAendDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHFXCENTENZ0','35','D','02','981',NULL,'Region',NULL,NULL,'"drvRegion"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHFXCENTENZ0','35','D','02','1016',NULL,'Work City',NULL,NULL,'"drvWorkCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHFXCENTENZ0','35','D','02','1051',NULL,'Salary/Hourly Code',NULL,NULL,'"drvSalHrlyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHFXCENTENZ0','35','D','02','1086',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHFXCENTENZ0','35','D','02','1096',NULL,'Hourly Rate',NULL,NULL,'"drvStatChgDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHFXCENTENZ0','35','D','02','2010',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHFXCENTENZ0','35','D','02','2045',NULL,'Deduction Group',NULL,NULL,'"drvDeductionGroup"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHFXCENTEN_20211230.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',VW78G,VU0V6,IAGFG,ZU1PY',NULL,NULL,NULL,'EHFXCENTEN export','202104169','EMPEXPORT','EHFXCENTEN',NULL,'EHFXCENTEN',NULL,NULL,NULL,'202112299',NULL,NULL,'202112221',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TEST','202107239','EMPEXPORT','TEST','Sep 22 2021  9:36PM','EHFXCENTEN',NULL,NULL,NULL,'202107239','Jul 23 2021 12:00AM','Dec 30 1899 12:00AM','202107021','1083','','','202107021',dbo.fn_GetTimedKey(),NULL,'us3lKiTEN1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','ExportDescription','C','Health E(fx) Census File');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','SystemID','V','318A128B5C8A');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTEN','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXCENTEN','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXCENTEN','D02','dbo.U_dsi_EHFXCENTEN_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_EHFXCENTEN_drvTbl
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvsort1] int NOT NULL,
    [drvsort2] char(11) NULL,
    [drvLocation] char(6) NULL,
    [drvTypGroup] varchar(40) NULL,
    [drvFEIN] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(52) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvOrigDOH] varchar(10) NULL,
    [drvRehireDate] varchar(10) NULL,
    [drvDOT] varchar(10) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobDesc] varchar(25) NOT NULL,
    [drvFTorPT] varchar(2) NOT NULL,
    [drvWorkStatus] varchar(45) NULL,
    [drvLOAcode] char(6) NULL,
    [drvLOAreason] char(6) NULL,
    [drvLOAstartDate] varchar(10) NULL,
    [drvLOAendDate] varchar(10) NULL,
    [drvRegion] char(10) NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvSalHrlyCode] char(1) NULL,
    [drvHourlyRate] money NULL,
    [drvStatChgDate] varchar(10) NULL,
    [drvAnnualSalary] varchar(30) NULL,
    [drvDeductionGroup] char(5) NULL
);

-----------
-- Create table U_dsi_EHFXCENTEN_EarnCurr
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnCurr') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_EarnCurr] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [epercontrol] char(9) NOT NULL,
    [ecuramt] money NULL,
    [ecurhrs] decimal NULL
);

-----------
-- Create table U_dsi_EHFXCENTEN_EarnCurrHC
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnCurrHC') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_EarnCurrHC] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [ecurHCamt] money NULL,
    [ecurHChrs] decimal NULL
);

-----------
-- Create table U_dsi_EHFXCENTEN_EarnHist
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);

-----------
-- Create table U_dsi_EHFXCENTEN_LOA
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_LOA') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_LOA] (
    [leeid] char(12) NULL,
    [lcoid] char(5) NULL,
    [loa_date] datetime NULL,
    [return_date] datetime NULL,
    [lreason] char(6) NULL
);

-----------
-- Create table U_dsi_EHFXCENTEN_StatStack
-----------

IF OBJECT_ID('U_dsi_EHFXCENTEN_StatStack') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTEN_StatStack] (
    [seeid] char(12) NOT NULL,
    [scoid] char(5) NOT NULL,
    [sstat] char(1) NULL,
    [sdate] datetime NULL,
    [sreason] char(6) NULL,
    [sNo] bigint NULL
);

-----------
-- Create table U_EHFXCENTEN_EEList
-----------

IF OBJECT_ID('U_EHFXCENTEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EHFXCENTEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHFXCENTEN_File
-----------

IF OBJECT_ID('U_EHFXCENTEN_File') IS NULL
CREATE TABLE [dbo].[U_EHFXCENTEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXCENTEN'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXCENTEN',GetDate(),'P','V1.TD'
*/

/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXCENTEN'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXCENTEN',GetDate(),'P','V1.TD'
*/

CREATE   PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXCENTEN]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************************
Client Name: Tender Greens

Created By: Guido Pozo
Business Analyst: Charon Covington
Create Date: 09/28/2016
Service Request Number: SF#07494906

Purpose: Health E(fx) - Census File

Revision History
----------------
07/09/2021 by AP:
        - Updated logic for audit which was affecting status change. See lines 629-631.

07/20/2021 by AP:
        - Set back EmpComp as the audit driver for EecFullTimeOrPartTime.
        - Removed test employees.

07/23/2021 by AP:
        - Updated Status Change Date field to most recent ejhjobeffdate.
        - Added Annual Salar field.

08/25/2021 by AP:
        - Exclue employees who have start dates greater than the end date of filter.
        
Inshan Singh         05.05.2021      TekP-2021-02-19-0002       Fixed duplicate issue caused by drvStatChgDate field
Chelsea Bartholomew     10.10.2018   12489430                   Added logic removing employees with SSNs like 99999999%
Darren Collard          12.30.2021   TekP-2021-11-10-0005       Update Columns TYP Restaurant Group(2), FEIN(3), add Deduction Group (35)

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHFXCENTEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHFXCENTEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHFXCENTEN';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EHFXCENTEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHFXCENTEN' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTEN', 'EHFXCENTEN';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTEN', 'TEST';        --\\us.saas\ew2\WP7\Downloads\V10\Exports\TEN\EmployeeHistoryExport\
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHFXCENTEN';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHFXCENTEN', @AllObjects = 'Y', @IsWeb='Y';
**********************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = formatcode,
        @ExportCode = Exportcode,
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 30    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed


    -----------
    -- Audit Code - Get Old 'DedGroupCode' Value
    -----------
    IF OBJECT_ID('U_EHFXCENTEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHFXCENTEN_Audit;
/*    SELECT audEEID = audKey1Value 
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHFXCENTEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    WHERE 
        audDateTime BETWEEN @StartDate AND @EndDate
        --audDateTime > @EndDate
    AND audTableName = 'EmpComp'
    AND audFieldName = 'EecFullTimeOrPartTime';*/


    /*SELECT audEEID = audKey1Value 
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        --,audKey3Label
        ,audTableName
        ,audFieldName
        ,audAction
        ,EjhJobEffDate
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value,  audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHFXCENTEN_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    JOIN dbo.EmpHJob WITH (NOLOCK)
        ON audKey1Value = EjhEEID
        AND audKey2Value = EjhCOID    
        AND EjhJobEffDate  BETWEEN @StartDate AND @EndDate
    WHERE 
        --audDateTime 
        --EjhJobEffDate 
        --BETWEEN '1/1/2021' AND '4/13/2021' -- 2021-02-23 15:47:29.563, effective date is 3/1/2021
        --audDateTime > @EndDate
    --AND 
    audTableName = 'EmpHJob' -- 'EmpComp'
    AND audFieldName = 'EjhFullTimeOrPartTime' --'EecFullTimeOrPartTime'*/


    
-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_EHFXCENTEN_EELIST
            from dbo.u_EHFXCENTEN_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EHFXCENTEN_EELIST
            from dbo.u_EHFXCENTEN_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_EHFXCENTEN_eelist
            from dbo.u_EHFXCENTEN_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EHFXCENTEN_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--keep terms on the file for 120 days
delete dbo.u_EHFXCENTEN_eelist
where xeeid+xcoid in (select eeceeid+EecCoID from empcomp where eecemplstatus = 'T' and eecdateoftermination + 120 < @EndDate)

--TD 7/10/15 remove ee's with 00000 ssn's
delete dbo.u_EHFXCENTEN_eelist
from dbo.u_EHFXCENTEN_eelist
join emppers ep with (nolock) on xeeid = ep.eepEEID
where ep.eepSSN like '00000%'
or ep.eepSSN like '12345%' or eepSSN like '666%' or eepSSN like '333%' or eepSSN like '99999999%' --CAB1010


-- Build earning history YTD

if object_id('U_dsi_EHFXCENTEN_EarnHist') is not null
  drop table dbo.U_dsi_EHFXCENTEN_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    INTO dbo.U_dsi_EHFXCENTEN_EarnHist
        from dbo.u_EHFXCENTEN_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
        --TD 12/08/15 added HOT
        --TD 12/11/15 added JRYDY, BEREV & STIP
        AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                            
        --AND pehPerControl between @StartPerControl and @EndPerControl       --Period
    GROUP BY xEEID,xCOID--,pehearncode

--select * from dbo.U_dsi_EHFXCENTEN_EarnHist

-- Build earning this ppd

if object_id('U_dsi_EHFXCENTEN_EarnCurr') is not null
  drop table dbo.U_dsi_EHFXCENTEN_EarnCurr
--select * from  U_dsi_EHFXCENTEN_EarnCurr order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    PehPerControl epercontrol,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecuramt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurhrs

    INTO dbo.U_dsi_EHFXCENTEN_EarnCurr
        from dbo.u_EHFXCENTEN_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl 
        --TD 12/08/15 added HOT
        --TD 12/11/15 added JRYDY, BEREV & STIP
        AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                            

    GROUP BY xEEID,xCOID,PehPerControl--,pehearncode

-- Build HealthCare Hours this ppd

if object_id('U_dsi_EHFXCENTEN_EarnCurrHC') is not null
  drop table dbo.U_dsi_EHFXCENTEN_EarnCurrHC
--select * from  U_dsi_EHFXCENTEN_EarnCurrHC order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
--    pehpaydate epaydate,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecurHCamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurHChrs

    INTO dbo.U_dsi_EHFXCENTEN_EarnCurrHC
        from dbo.u_EHFXCENTEN_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl 
    JOIN EarnCode on ErnEarncode = PehEarnCode and ErnInclInHealthCareHours = 'Y'

    GROUP BY xEEID,xCOID,pehpaydate--,pehearncode


-- LOA logic - 10/19/2016

    if object_id('dbo.U_dsi_EHFXCENTEN_StatStack') is not null
      drop table dbo.U_dsi_EHFXCENTEN_StatStack

    select esheeid seeid, eshcoid scoid, eshemplstatus sstat,eshstatusstartdate sdate, eshemplstatusreason sreason,
    ROW_NUMBER() OVER (PARTITION BY eshEEID ORDER BY eshstatusstartdate desc) sNo
    into dbo.U_dsi_EHFXCENTEN_StatStack
    from emphstat

    --select * from dbo.U_dsi_EHFXCENTEN_StatStack where seeid = '8XDC0U0000K0'


    if object_id('dbo.U_dsi_EHFXCENTEN_LOA') is not null
      drop table dbo.U_dsi_EHFXCENTEN_LOA

--    select xeeid leeid, xcoid lcoid, l.sdate loa_date,r.sdate return_date, L.sreason lreason
--    select xeeid leeid, xcoid lcoid, max(l.sdate) loa_date,max(r.sdate) return_date, L.sreason lreason    --Get Maximum LOA only

    -- Is Status Next Status after LOA is 'T' then populate the status date minus 1 day.(12/2/2016)
    select xeeid leeid, xcoid lcoid, max(l.sdate) loa_date,max( Case when r.sstat = 'T' then r.sdate-1 else r.sdate end) return_date, L.sreason lreason    --Get Maximum LOA only
    into dbo.U_dsi_EHFXCENTEN_LOA
    from dbo.U_EHFXCENTEN_EEList
    join U_dsi_EHFXCENTEN_StatStack L on xeeid = l.seeid and xcoid = l.scoid and l.sstat = 'L'
    --left join U_dsi_EHFXCENTEN_StatStack R on xeeid = r.seeid and xcoid = r.scoid and r.sstat = 'A' and r.sno = l.sno - 1
    left join U_dsi_EHFXCENTEN_StatStack R on xeeid = r.seeid and xcoid = r.scoid and (r.sstat = 'A' or r.sstat = 'T') and r.sno = l.sno - 1    --(12/2/2016)
    group by xeeid,xcoid,L.sreason                                                                        --Get Maximum LOA only
    
    
    -- select * from dbo.U_dsi_EHFXCENTEN_LOA where leeid = '8XDC0U0000K0'

-- Populate Source for Employees

if object_id('dbo.U_dsi_EHFXCENTEN_drvTbl') is not null
  drop table dbo.U_dsi_EHFXCENTEN_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvsort1 = 2,
    drvsort2 = eepssn,
-- standard fields above and additional driver fields below
    drvLocation = eecLocation,
    drvTypGroup = cmpCompanyName, --'TYP Restaurant Group', DLC 12/30/2021
    drvFEIN = cmpFedTaxID,        --'20-1058272',           DLC 12/30/2021
    drvEmpNo = EecEmpNo,
    drvSSN = eepssn,
    drvNameFirst = RTRIM(eepnamefirst),
    drvNameMiddle = RTRIM(eepnamemiddle),
    drvNameLast = RTRIM(eepnamelast),
    drvAddress1 = EepAddressLine1,
    drvAddress2 = EepAddressLine2,
    drvCity = EepAddressCity,
    drvState = EepAddressState,
    drvZip = eepaddresszipcode,
    drvEmail = eepAddressEMail,
    drvPhone = case when isnull(EepPhoneHomeNumber,'') <> '' then Stuff(Stuff(eepPhoneHomeNumber,7,0,'-'),4,0,'-') else '' end, --TD 8/5/15 --OPT
    drvGender = EepGender, --TD 8/5/15 --OPT
    drvDOB = CONVERT(varchar(10), EepDateOfBirth, 112),
    drvOrigDOH = CONVERT(varchar(10), EecDateOfOriginalHire, 112),
    drvRehireDate = case when EecDateOfLastHire > EecDateOfOriginalHire then CONVERT(varchar(10), EecDateOfLastHire, 112) else '' end,
    drvDOT = case when EecEmplStatus = 'T' and ISNULL(eecdateoftermination,'') <> '' then CONVERT(varchar(10), EecDateOfTermination, 112) else '' end,
    drvJobCode = EecJobCode, --TD 8/5/15 --OPT
    drvJobDesc = jbcDesc, --TD 8/5/15 --OPT
    drvFTorPT = case when EecFullTimeOrPartTime = 'F' then 'FT'
                     when EecFullTimeOrPartTime = 'P' then 'PT'
                else '' end,
    drvWorkStatus = estat.descr,
    drvLOAcode = loa.LchType,
    drvLOAreason = lreason,    --loa.lchCode,
    drvLOAstartDate = CONVERT(varchar(10), loa_date, 112),        --CONVERT(varchar(10), loa.EshStatusStartDate, 112),
    drvLOAendDate = CONVERT(varchar(10), return_date, 112),                            --10/19/16 loa.EshStatusStopDate
    drvRegion = EecOrgLvl2, --TD 8/5/15 as requested
    drvWorkCity = LocAddressCity,    --TD 7/10/15 added --OPT
    drvSalHrlyCode = EecSalaryOrHourly,
/*
    drvPeriodHours = case when ecurhrs >= 0 then cast(ecurhrs/*ecurHChrs*/ as varchar) end, --TD 7/21/15 as requested.
    drvPayFreq = case when EecPayPeriod = 'W' then 'Weekly'
                      when EecPayPeriod = 'B' then 'Bi-Weekly'
                      when EecPayPeriod = 'S' then 'Semi-monthly'
                      when EecPayPeriod = 'M' then 'Monthly' else '' end,
    drvGrossYTD = case when eamt >= 0 then ISNULL(eamt,0) end, --TD 7/21/15 as requested.
    drvGrossPeriod = case when ecuramt >=0 then isnull(ecuramt,0) end,
*/
    drvHourlyRate = CAST(EecHourlyPayRate as money)    --case when eecemplstatus <> 'T' then CAST(EecHourlyPayRate as money) end,
--        drvPeriodStartDate = CONVERT(varchar(10), PgpPeriodStartDate, 112),--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodStartDate, 112) end,
--        drvPeriodEndDate = CONVERT(varchar(10), PgpPeriodEndDate, 112)--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodEndDate, 112) end
    ,drvStatChgDate = CONVERT(VARCHAR(10), EjhJobEffDate, 112)
                        --CASE WHEN AudNewValue IS NOT NULL THEN CONVERT(VARCHAR(10), EjhJobEffDate, 112) END
    ,drvAnnualSalary = CAST(EecAnnSalary AS VARCHAR)
    ,drvDeductionGroup = EecDedGroupCode  --DLC 12/30/2021
  into dbo.U_dsi_EHFXCENTEN_drvTbl
  from dbo.u_EHFXCENTEN_eelist with (nolock)
    join empPers with (nolock) on     xEEID = eepEEID
    join empcomp with (nolock) on    xEEID = eecEEid and     xCOID = eecCOID
    join Location with (nolock) on LocCode = EecLocation
    join jobcode with (nolock) on eecJobCode = jbcJobCode
    join company with (nolock) on xCOID = cmpCOID

    left join (select codcode, coddesc descr from codes where codtable = 'EMPLOYEESTATUS') estat on estat.codcode = eecemplstatus

    left join dbo.U_dsi_EHFXCENTEN_EarnHist on xEEID = eEEID and xCOID = eCOID
    --left join dbo.U_dsi_EHFXCENTEN_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID 

    left join pgpayper with (nolock) on PgpPeriodControl between @StartPerControl and @EndPerControl and pgpperiodtype = 'R'    

    --TD 9/15/15 per request:
    --join dbo.U_dsi_EHFXCENTEN_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID and ec.epercontrol = PgpPeriodControl  --10/10/16 removed so that LOAs are included

    left join dbo.U_dsi_EHFXCENTEN_EarnCurrHC ecHC on xEEID = ecHC.eEEID and xCOID = ecHC.eCOID 

    left join (select eeceeid eeid, eeccoid coid, lchCode, lchDesc, lchFMLAQualified, lchType, eshStatusStartDate, eshStatusStopDate
        from empcomp
        left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
        join loareasn on lchcode = eecLeaveReason
        where eecemplstatus = 'L' 
        --and EshStatusStartDate between @StartDate and @EndDate                        --10/10/16 removed
        and eecemplstatusstartdate = eshstatusstartdate
        ) LOA on loa.eeid = xeeid and loa.coid = xcoid

    left join U_dsi_EHFXCENTEN_LOA LOAR on loar.leeid = xeeid
    /*LEFT JOIN dbo.U_EHFXCENTEN_Audit WITH (NOLOCK)
        ON xEEID = AudEEID
        AND xCOID = AudKey2
        AND audRowNo = 1*/
    OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E

    --LEFT JOIN (
    --            SELECT  xEEID AS yEEID, xCOID AS yCOID, EjhJobEffDate AS yEjhJobEffDate
    --            FROM dbo.vw_AuditData WITH (NOLOCK)
    --            JOIN dbo.u_EHFXCENTEN_EELIST WITH (NOLOCK)
    --                ON AudKey1Value = xEEID
    --            JOIN (
    --                    SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate
    --                    FROM (
    --                            SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
    --                            --SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID, EjhFullTimeOrPartTime ORDER BY EjhJobEffDate DESC) AS RN -- 05/05/2021 TekP-2021-02-19-0002 I. Singh Removed  EjhFullTimeOrPartTime from partition to prevent duplicate
    --                            FROM dbo.EmpHJob WITH (NOLOCK)
    --                        ) AS Ejh
    --                    WHERE RN = 1) AS X
    --                ON xEEID = EjhEEID
    --                AND xCOID = EjhCoID
    --                AND audNewValue = EjhFullTimeOrPartTime
    --            WHERE audTableName = 'EmpComp' --'EmpHJob' --audTableName = 'EmpComp' 
    --               AND audFieldName = 'EecFullTimeOrPartTime' --'EjhFullTimeOrPartTime' -- AND audFieldName =  'EEcFullTimeOrPartTime' 
    --               AND audAction = 'Update'
    --            ) AS Y
    --    ON xEEID = yEEID
    --    AND xCOID = yCOID
    WHERE CAST(EecDateOfLastHire AS DATE) <= CAST(@EndDate AS DATE)  -- Exclude employees that have future start dates
        ;

    DELETE dbo.U_dsi_EHFXCENTEN_drvTbl
    WHERE drvSSN IN ('615432101', '615587270', '777123456')  -- Remove test employees
    ;

--select * from dbo.U_dsi_EHFXCENTEN_drvTbl

-- Create Headers

-- Create Trailers

-- Set FileName  
--if (dbo.dsi_fnVariable('EHFXCENTEN','UseFileName') = 'N')
--  update dbo.U_dsi_Parameters
--    set ExportFile =  'TEN_HealthEfx_Payroll_' + convert(char(8),getdate(),112) + '.txt'
--    where FormatCode = 'EHFXCENTEN'

-- Remember to alter view for correct sorting
/*

 ALTER  View dbo.dsi_vwEHFXCENTEN_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EHFXCENTEN_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 end,
            initialsort, subsort, substring(Recordset,2,2)         



UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202104021'
       ,ExpStartPerControl     = '202104021'
       ,ExpLastEndPerControl   = '202104169'
       ,ExpEndPerControl       = '202104169'
WHERE ExpFormatCode = 'EHFXCENTEN';


--Check out AscDefF
SELECT * FROM dbo.AscDefF WITH (NOLOCK) 
WHERE adfHeaderSystemID = (Select AdhSystemID FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode='EHFXCENTEN')
ORDER BY AdfSetNumber, AdfFieldNumber;


*/




--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTEN','EHFXCENTEN'
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTEN','TEST'
END
GO
Create View dbo.dsi_vwEHFXCENTEN_Export as
                            select top 200000000 Data from dbo.U_EHFXCENTEN_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort

/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXCENTEN'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXCENTEN',GetDate(),'P','V1.TD'
*/

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHFXCENTEN' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHFXCENTEN'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHFXCENTEN'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHFXCENTEN', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHFXCENTEN', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHFXCENTEN', 'UseFileName', 'V', 'Y'


-- End ripout