/**********************************************************************************


>>>>>> NOTE: this ripout is cloned from EHFXHRPTEN


EHFXHRPTE2: Health E(fx) - Payroll File

FormatCode:     EHFXHRPTE2
Project:        Health E(fx) - Payroll File
Client ID:      TEN1000
Date/time:      2023-02-06 08:43:44.287
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW2WUP2DB02
Database:       ULTIPRO_WPTEN
Web Filename:   TEN1000_2FE70_EEHISTORY_EHFXHRPTE2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHFXHRPTE2_SavePath') IS NOT NULL DROP TABLE dbo.U_EHFXHRPTE2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHFXHRPTE2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHFXHRPTE2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHFXHRPTE2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHFXHRPTE2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHFXHRPTE2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHFXHRPTE2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHFXHRPTE2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHFXHRPTE2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHFXHRPTE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHFXHRPTE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHFXHRPTE2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHFXHRPTE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHFXHRPTE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHFXHRPTE2_BAK') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXHRPTE2_BAK];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHFXHRPTE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXHRPTE2];
GO
IF OBJECT_ID('U_EHFXHRPTE2_File') IS NOT NULL DROP TABLE [dbo].[U_EHFXHRPTE2_File];
GO
IF OBJECT_ID('U_EHFXHRPTE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHFXHRPTE2_EEList];
GO
IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnHist];
GO
IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnCurrHC') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnCurrHC];
GO
IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnCurr') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnCurr];
GO
IF OBJECT_ID('U_dsi_EHFXHRPTE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXHRPTE2_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EHFXHRPTE2','Health E(fx) - Payroll File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ENY88W000030','N','Jul  1 2015 10:10AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENY88W000030','8','H','01','1',NULL,NULL,NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENY88W000030','20','H','01','9',NULL,NULL,NULL,NULL,'"TYP Restaurant Group"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENY88W000030','4','H','01','29',NULL,NULL,NULL,NULL,'"FEIN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENY88W000030','9','H','01','33',NULL,NULL,NULL,NULL,'"EE Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENY88W000030','3','H','01','42',NULL,NULL,NULL,NULL,'"SSN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENY88W000030','10','H','01','45',NULL,NULL,NULL,NULL,'"First Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENY88W000030','19','H','01','55',NULL,NULL,NULL,NULL,'"Middle Name/Initial"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENY88W000030','9','H','01','74',NULL,NULL,NULL,NULL,'"Last Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENY88W000030','9','H','01','83',NULL,NULL,NULL,NULL,'"Address 1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENY88W000030','9','H','01','92',NULL,NULL,NULL,NULL,'"Address 2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENY88W000030','4','H','01','101',NULL,NULL,NULL,NULL,'"City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENY88W000030','5','H','01','105',NULL,NULL,NULL,NULL,'"State"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENY88W000030','3','H','01','110',NULL,NULL,NULL,NULL,'"Zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENY88W000030','13','H','01','113',NULL,NULL,NULL,NULL,'"Primary Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENY88W000030','12','H','01','126',NULL,NULL,NULL,NULL,'"Phone Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENY88W000030','6','H','01','138',NULL,NULL,NULL,NULL,'"Gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENY88W000030','13','H','01','144',NULL,NULL,NULL,NULL,'"Date of Birth"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENY88W000030','18','H','01','157',NULL,NULL,NULL,NULL,'"Original Hire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENY88W000030','11','H','01','175',NULL,NULL,NULL,NULL,'"Rehire Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENY88W000030','9','H','01','186',NULL,NULL,NULL,NULL,'"Term Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENY88W000030','8','H','01','195',NULL,NULL,NULL,NULL,'"Job Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENY88W000030','15','H','01','203',NULL,NULL,NULL,NULL,'"Job Description"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENY88W000030','19','H','01','218',NULL,NULL,NULL,NULL,'"Full/Part Time Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENY88W000030','17','H','01','237',NULL,NULL,NULL,NULL,'"Employment Status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENY88W000030','8','H','01','254',NULL,NULL,NULL,NULL,'"LOA Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENY88W000030','10','H','01','262',NULL,NULL,NULL,NULL,'"LOA Reason"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENY88W000030','14','H','01','272',NULL,NULL,NULL,NULL,'"LOA Begin Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENY88W000030','12','H','01','286',NULL,NULL,NULL,NULL,'"LOA End Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENY88W000030','6','H','01','298',NULL,NULL,NULL,NULL,'"Region"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENY88W000030','9','H','01','304',NULL,NULL,NULL,NULL,'"Work City"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENY88W000030','18','H','01','313',NULL,NULL,NULL,NULL,'"Salary/Hourly Code"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENY88W000030','24','H','01','331',NULL,NULL,NULL,NULL,'"Pay Period Service Hours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENY88W000030','17','H','01','355',NULL,NULL,NULL,NULL,'"Payroll Frequency"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENY88W000030','0','H','01','372',NULL,NULL,NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENY88W000030','18','H','01','372',NULL,NULL,NULL,NULL,'"Gross YTD Earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENY88W000030','25','H','01','390',NULL,NULL,NULL,NULL,'"Gross Pay Period Earnings"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENY88W000030','11','H','01','415',NULL,NULL,NULL,NULL,'"Hourly Rate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENY88W000030','13','H','01','426',NULL,NULL,NULL,NULL,'"PP Start Date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENY88W000030','11','H','01','439',NULL,NULL,NULL,NULL,'"PP End Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENY88W000030','35','D','02','1',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENY88W000030','35','D','02','36',NULL,'TYP Restaurant Group',NULL,NULL,'"drvTypGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENY88W000030','35','D','02','71',NULL,'FEIN',NULL,NULL,'"drvFEIN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENY88W000030','35','D','02','106',NULL,'EE Number',NULL,NULL,'"drvEmpNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENY88W000030','35','D','02','141',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENY88W000030','35','D','02','176',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENY88W000030','35','D','02','211',NULL,'Middle Name/Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENY88W000030','35','D','02','246',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENY88W000030','35','D','02','281',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENY88W000030','35','D','02','316',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENY88W000030','35','D','02','351',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENY88W000030','35','D','02','386',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENY88W000030','35','D','02','421',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENY88W000030','35','D','02','456',NULL,'Primary Email',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENY88W000030','35','D','02','491',NULL,'Phone Number',NULL,NULL,'"drvPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENY88W000030','35','D','02','526',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENY88W000030','35','D','02','561',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENY88W000030','35','D','02','596',NULL,'Original Hire Date',NULL,NULL,'"drvOrigDOH"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENY88W000030','35','D','02','631',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENY88W000030','35','D','02','666',NULL,'Term Date',NULL,NULL,'"drvDOT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENY88W000030','35','D','02','701',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENY88W000030','35','D','02','736',NULL,'Job Description',NULL,NULL,'"drvJobDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENY88W000030','35','D','02','771',NULL,'Full/Part Time Code',NULL,NULL,'"drvFTorPT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENY88W000030','35','D','02','806',NULL,'Employment Status',NULL,NULL,'"drvWorkStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENY88W000030','35','D','02','841',NULL,'LOA Code',NULL,NULL,'"drvLOAcode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENY88W000030','35','D','02','876',NULL,'LOA Reason',NULL,NULL,'"drvLOAreason"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENY88W000030','35','D','02','911',NULL,'LOA Begin Date',NULL,NULL,'"drvLOAstartDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENY88W000030','35','D','02','946',NULL,'LOA End Date',NULL,NULL,'"drvLOAendDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENY88W000030','35','D','02','981',NULL,'Region',NULL,NULL,'"drvRegion"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENY88W000030','35','D','02','1016',NULL,'Work City',NULL,NULL,'"drvWorkCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENY88W000030','35','D','02','1051',NULL,'Salary/Hourly Code',NULL,NULL,'"drvSalHrlyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENY88W000030','35','D','02','1086',NULL,'Pay Period Service Hours',NULL,NULL,'"drvPeriodHours"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENY88W000030','35','D','02','1121',NULL,'Payroll Frequency',NULL,NULL,'"drvPayFreq"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENY88W000030','35','D','02','1156',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENY88W000030','35','D','02','1191',NULL,'Gross YTD Earnings',NULL,NULL,'"drvGrossYTD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENY88W000030','35','D','02','1226',NULL,'Gross Pay Period Earnings',NULL,NULL,'"drvGrossPeriod"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENY88W000030','35','D','02','1261',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENY88W000030','35','D','02','1296',NULL,'PP Start Date',NULL,NULL,'"drvPeriodStartDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENY88W000030','35','D','02','1331',NULL,'PP End Date',NULL,NULL,'"drvPeriodEndDate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHFXHRPTE2_20230206.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'EHFXHRPTE2 export','201512309','EMPEXPORT','EHFXHRPTE2','Jul 10 2015  3:15PM','EHFXHRPTE2',NULL,NULL,NULL,'201512309','Jun 26 2015 12:00AM','Dec 30 1899 12:00AM','201512231','1198',NULL,NULL,'201512231',dbo.fn_GetTimedKey(),NULL,'USGTDIMAIO',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'TEST','202106049','EMPEXPORT','TEST','Mar 21 2022  3:38PM','EHFXHRPTE2',NULL,NULL,NULL,'202106049','Jun  4 2021 12:00AM','Dec 30 1899 12:00AM','202106041','340',NULL,NULL,'202106041',dbo.fn_GetTimedKey(),NULL,'us3lKiTEN1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','ExportDescription','C','Health E(fx) Payroll File -TEN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','SystemID','V','FE1BE98BF85B');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXHRPTE2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXHRPTE2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXHRPTE2','D02','dbo.U_dsi_EHFXHRPTE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_EHFXHRPTE2_drvTbl
-----------

IF OBJECT_ID('U_dsi_EHFXHRPTE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXHRPTE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvsort1] int NOT NULL,
    [drvsort2] char(11) NULL,
    [drvLocation] char(6) NULL,
    [drvTypGroup] varchar(20) NOT NULL,
    [drvFEIN] varchar(10) NOT NULL,
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
    [drvRegion] varchar(10) NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvSalHrlyCode] char(1) NULL,
    [drvPeriodHours] varchar(30) NULL,
    [drvPayFreq] varchar(12) NOT NULL,
    [drvGrossYTD] money NULL,
    [drvGrossPeriod] money NULL,
    [drvHourlyRate] money NULL,
    [drvPeriodStartDate] varchar(10) NULL,
    [drvPeriodEndDate] varchar(10) NULL
);

-----------
-- Create table U_dsi_EHFXHRPTE2_EarnCurr
-----------

IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnCurr') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnCurr] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [epercontrol] char(9) NOT NULL,
    [ecuramt] money NULL,
    [ecurhrs] decimal NULL
);

-----------
-- Create table U_dsi_EHFXHRPTE2_EarnCurrHC
-----------

IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnCurrHC') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnCurrHC] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [ecurHCamt] money NULL,
    [ecurHChrs] decimal NULL
);

-----------
-- Create table U_dsi_EHFXHRPTE2_EarnHist
-----------

IF OBJECT_ID('U_dsi_EHFXHRPTE2_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXHRPTE2_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);

-----------
-- Create table U_EHFXHRPTE2_EEList
-----------

IF OBJECT_ID('U_EHFXHRPTE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EHFXHRPTE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHFXHRPTE2_File
-----------

IF OBJECT_ID('U_EHFXHRPTE2_File') IS NULL
CREATE TABLE [dbo].[U_EHFXHRPTE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
GO
/*   
delete from dbo.U_dsi_TOC  
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXHRPTE2'  
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)  
  select 'dsi_sp_BuildDriverTables_EHFXHRPTE2',GetDate(),'P','V1.TD'  
*/  
  
  
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXHRPTE2]  
 @systemid varchar(12) = ''  
AS  
Begin  
  
  
/*************************************************************************************************  
DRIVER TABLE SP FOR:  EmployCheck - HRIS Payroll File - Pipe Delimited  
BUILT FOR: Tender Greens  
ORIGINAL BUILD (V-1.0): 07/01/2015 - TDiMaio   - SF 5480446  
UPDATE: 09/09/2019 - Michael Chollet - SF 15332373 - Added (and pgppaygroup = eecpaygroup ) to the pgpayper join now that they also have W pay groups
*************************************************************************************************/  
  
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
    
 -- Declare @Systemid char(12)   
 -- set @Systemid = '6DWPQL0000K0'  
  
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
set @daysstopped = 30 -- set number of days if looking for only showing deds stopped within certain days  
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull  
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment  
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type  
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee  
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee  
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown  
set @oetype = 'F'  -- P or F indicates if this export is for a passive or full(active) oe  
  
  
-- clean up EELIST if needed  
  
-- clean up list if not using all companies  
if @allcomp = 'N' 
begin  
   delete dbo.u_EHFXHRPTE2_EELIST  
   from dbo.u_EHFXHRPTE2_EELIST  
   join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid  
   where t.eecemplstatus = 'T'  
   and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid  
    and a.eecemplstatus <> 'T')  
  
end  
  
  
-- Clean up eelist if only one record per employee  
if @onerecperemp = 'Y'  
begin  
   delete dbo.u_EHFXHRPTE2_EELIST  
   from dbo.u_EHFXHRPTE2_EELIST  
   join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid  
   where t.eecemplstatus = 'T'  
   and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid  
    and a.eecemplstatus <> 'T')  
  
   --delete dbo.u_EHFXHRPTE2_eelist  
   --from dbo.u_EHFXHRPTE2_eelist a  
   --join emppers with (nolock) on xeeid = eepeeid  
   --where eephomecoid <> xcoid  
   --and exists(select 1 from dbo.u_EHFXHRPTE2_eelist b where a.xeeid = b.xeeid  
   --having count(*) > 1)  
end  
  
--keep terms on the file for 120 days  
delete dbo.u_EHFXHRPTE2_eelist  
where xeeid+xcoid in (select eeceeid+EecCoID from vw_int_EmpComp where eecemplstatus = 'T' and eecdateoftermination + 365 < @EndDate)  
  
--TD 7/10/15 remove ee's with 00000 ssn's  
delete dbo.u_EHFXHRPTE2_eelist  
from dbo.u_EHFXHRPTE2_eelist  
join emppers ep with (nolock) on xeeid = ep.eepEEID  
where ep.eepSSN like '00000%'  
or ep.eepSSN like '12345%'  
  
-- Build earning history YTD  
  
if object_id('U_dsi_EHFXHRPTE2_EarnHist') is not null  
  drop table dbo.U_dsi_EHFXHRPTE2_EarnHist  
  
SELECT  
 xEEID eeeid,  
 xCOID ecoid,  
-- pehearncode eearncode,  
 SUM(ISNULL(pehCurAmt,0.00)) AS eamt,  
 SUM(ISNULL(pehCurHrs,0.00)) AS ehrs  
  
 INTO dbo.U_dsi_EHFXHRPTE2_EarnHist  
  from dbo.u_EHFXHRPTE2_EELIST   
 JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID  
  AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)  
  --TD 12/08/15 added HOT  
  --TD 12/11/15 added JRYDY, BEREV & STIP  
  AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                        
  --AND pehPerControl between @StartPerControl and @EndPerControl    --Period  
 GROUP BY xEEID,xCOID--,pehearncode  
  
--select * from dbo.U_dsi_EHFXHRPTE2_EarnHist  
  
  
-- Build earning this ppd  
  
if object_id('U_dsi_EHFXHRPTE2_EarnCurr') is not null  
  drop table dbo.U_dsi_EHFXHRPTE2_EarnCurr  
--select * from  U_dsi_EHFXHRPTE2_EarnCurr order by eeeid  
  
SELECT  
 xEEID eeeid,  
 xCOID ecoid,  
-- pehearncode eearncode,  
 PehPerControl epercontrol,  
 SUM(ISNULL(pehCurAmt,0.00)) AS ecuramt,  
 SUM(ISNULL(pehCurHrs,0.00)) AS ecurhrs  
  
 INTO dbo.U_dsi_EHFXHRPTE2_EarnCurr  
  from dbo.u_EHFXHRPTE2_EELIST   
 JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID  
  AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl   
  --TD 12/08/15 added HOT  
  --TD 12/11/15 added JRYDY, BEREV & STIP  
  AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                        
  
 GROUP BY xEEID,xCOID,PehPerControl--,pehearncode  
  
  
-- Build HealthCare Hours this ppd  
  
if object_id('U_dsi_EHFXHRPTE2_EarnCurrHC') is not null  
  drop table dbo.U_dsi_EHFXHRPTE2_EarnCurrHC  
--select * from  U_dsi_EHFXHRPTE2_EarnCurrHC order by eeeid  
  
SELECT  
 xEEID eeeid,  
 xCOID ecoid,  
-- pehearncode eearncode,  
-- pehpaydate epaydate,  
 SUM(ISNULL(pehCurAmt,0.00)) AS ecurHCamt,  
 SUM(ISNULL(pehCurHrs,0.00)) AS ecurHChrs  
  
 INTO dbo.U_dsi_EHFXHRPTE2_EarnCurrHC  
  from dbo.u_EHFXHRPTE2_EELIST   
 JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID  
  AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl   
 JOIN EarnCode on ErnEarncode = PehEarnCode and ErnInclInHealthCareHours = 'Y'  
  
 GROUP BY xEEID,xCOID,pehpaydate--,pehearncode  
  
  
-- Populate Source for Employees  
  
if object_id('dbo.U_dsi_EHFXHRPTE2_drvTbl') is not null  
  drop table dbo.U_dsi_EHFXHRPTE2_drvTbl  
  
-- EE Detail  
  
  select distinct  
 drvEEID = xEEID,   
 drvcoid = xcoid,  
 drvsort1 = 2,  
 drvsort2 = eepssn,  
-- standard fields above and additional driver fields below  
 drvLocation = eecLocation,  
 drvTypGroup = 'TYP Restaurant Group',  
 drvFEIN = '20-1058272',  
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
 drvLOAreason = loa.lchCode,  
 drvLOAstartDate = CONVERT(varchar(10), loa.EshStatusStartDate, 112),  
 drvLOAendDate = CONVERT(varchar(10), loa.EshStatusStopDate, 112),  
 drvRegion = EecOrgLvl2, --TD 8/5/15 as requested  
 drvWorkCity = LocAddressCity, --TD 7/10/15 added --OPT  
 drvSalHrlyCode = EecSalaryOrHourly,  
 drvPeriodHours = case when ecurhrs >= 0 then cast(ecurhrs/*ecurHChrs*/ as varchar) end, --TD 7/21/15 as requested.  
 drvPayFreq = case when EecPayPeriod = 'W' then 'Weekly'  
       when EecPayPeriod = 'B' then 'Bi-Weekly'  
       when EecPayPeriod = 'S' then 'Semi-monthly'  
       when EecPayPeriod = 'M' then 'Monthly' else '' end,  
 drvGrossYTD = case when eamt >= 0 then ISNULL(eamt,0) end, --TD 7/21/15 as requested.  
 drvGrossPeriod = case when ecuramt >=0 then isnull(ecuramt,0) end,  
 drvHourlyRate = CAST(EecHourlyPayRate as money),--case when eecemplstatus <> 'T' then CAST(EecHourlyPayRate as money) end,  
 drvPeriodStartDate = CONVERT(varchar(10), PgpPeriodStartDate, 112),--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodStartDate, 112) end,  
 drvPeriodEndDate = CONVERT(varchar(10), PgpPeriodEndDate, 112)--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodEndDate, 112) end  
  
  into dbo.U_dsi_EHFXHRPTE2_drvTbl  
  from dbo.u_EHFXHRPTE2_eelist with (nolock)  
 join empPers with (nolock) on  xEEID = eepEEID  
 join vw_int_EmpComp with (nolock) on xEEID = eecEEid and  xCOID = eecCOID  
 join Location with (nolock) on LocCode = EecLocation  
 join jobcode with (nolock) on eecJobCode = jbcJobCode  
  
 left join (select codcode, coddesc descr from codes where codtable = 'EMPLOYEESTATUS') estat on estat.codcode = eecemplstatus  
   
 left join dbo.U_dsi_EHFXHRPTE2_EarnHist on xEEID = eEEID and xCOID = eCOID  
 --left join dbo.U_dsi_EHFXHRPTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID   
  
 left join pgpayper with (nolock) on PgpPeriodControl between @StartPerControl and @EndPerControl and pgppaygroup = eecpaygroup  
-- left join pgpayper with (nolock) on PgpPeriodControl between @StartPerControl and @EndPerControl and pgpperiodtype = 'R'  and pgppaygroup = eecpaygroup     
 --TD 9/15/15 per request:  
 join dbo.U_dsi_EHFXHRPTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID and ec.epercontrol = PgpPeriodControl  
  
  
 left join dbo.U_dsi_EHFXHRPTE2_EarnCurrHC ecHC on xEEID = ecHC.eEEID and xCOID = ecHC.eCOID   
  
   
 left join (select eeceeid eeid, eeccoid coid, lchCode, lchDesc, lchFMLAQualified, lchType, eshStatusStartDate, eshStatusStopDate  
  from vw_int_EmpComp  
  left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'  
  join loareasn on lchcode = eecLeaveReason  
  where eecemplstatus = 'L' and EshStatusStartDate between @StartDate and @EndDate) LOA on loa.eeid = xeeid and loa.coid = xcoid  
   
  
   
--select * from dbo.U_dsi_EHFXHRPTE2_drvTbl  
  
  
  
    
  
  
-- Create Headers  
  
-- Create Trailers  
  
  
  
  
-- Set FileName    
if (dbo.dsi_fnVariable('EHFXHRPTE2','UseFileName') = 'N')  
  update dbo.U_dsi_Parameters  
 set ExportFile =  'TEN_HealthEfx_Payroll_' + convert(char(8),getdate(),112) + '.txt'  
 where FormatCode = 'EHFXHRPTE2'  
  
  
-- Remember to alter view for correct sorting  
/*  
  
 ALTER  View dbo.dsi_vwEHFXHRPTE2_Export as  
        select top 2000000 rtrim(Data) as Data  
         from dbo.U_EHFXHRPTE2_File with (nolock)  
         order by case when substring(Recordset,1,1) = 'H' then 1   
        when substring(Recordset,1,1) = 'D' then 2 end,  
   initialsort, subsort, substring(Recordset,2,2)           
           
*/  
  
  
  
--Used for testing  
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXHRPTE2','EHFXHRPTE2'  
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXHRPTE2','TEST'  
  
  
END  
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXHRPTE2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXHRPTE2',GetDate(),'P','V1.TD'
*/


CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXHRPTE2_BAK]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  EmployCheck - HRIS Payroll File - Pipe Delimited
BUILT FOR: Tender Greens
ORIGINAL BUILD (V-1.0): 07/01/2015 - TDiMaio   - SF 5480446
*************************************************************************************************/

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

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_EHFXHRPTE2_EELIST
            from dbo.u_EHFXHRPTE2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EHFXHRPTE2_EELIST
            from dbo.u_EHFXHRPTE2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_EHFXHRPTE2_eelist
            from dbo.u_EHFXHRPTE2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EHFXHRPTE2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--keep terms on the file for 120 days
delete dbo.u_EHFXHRPTE2_eelist
where xeeid+xcoid in (select eeceeid+EecCoID from empcomp where eecemplstatus = 'T' and eecdateoftermination + 120 < @EndDate)

--TD 7/10/15 remove ee's with 00000 ssn's
delete dbo.u_EHFXHRPTE2_eelist
from dbo.u_EHFXHRPTE2_eelist
join emppers ep with (nolock) on xeeid = ep.eepEEID
where ep.eepSSN like '00000%'
or ep.eepSSN like '12345%'

-- Build earning history YTD

if object_id('U_dsi_EHFXHRPTE2_EarnHist') is not null
  drop table dbo.U_dsi_EHFXHRPTE2_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    INTO dbo.U_dsi_EHFXHRPTE2_EarnHist
        from dbo.u_EHFXHRPTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND year(convert(DATETIME,left(pehPerControl,8))) = year(@StartDate)
    GROUP BY xEEID,xCOID--,pehearncode

--select * from dbo.U_dsi_EHFXHRPTE2_EarnHist


-- Build earning this ppd

if object_id('U_dsi_EHFXHRPTE2_EarnCurr') is not null
  drop table dbo.U_dsi_EHFXHRPTE2_EarnCurr
--select * from  U_dsi_EHFXHRPTE2_EarnCurr order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    pehpaydate epaydate,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecuramt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurhrs,
    PehPerControl epercontrol

    INTO dbo.U_dsi_EHFXHRPTE2_EarnCurr
        from dbo.u_EHFXHRPTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        --AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl 
        AND convert(DATETIME,left(pehPerControl,8)) between @startdate and @enddate --Period (vendor requests files by calendar month dates)
        and pehCurAmt > 0

    GROUP BY xEEID,xCOID,pehpaydate,PehPerControl--,pehearncode


-- Build HealthCare Hours this ppd

if object_id('U_dsi_EHFXHRPTE2_EarnCurrHC') is not null
  drop table dbo.U_dsi_EHFXHRPTE2_EarnCurrHC
--select * from  U_dsi_EHFXHRPTE2_EarnCurrHC order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    pehpaydate epaydate,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecurHCamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurHChrs,
    PehPerControl epercontrol

    INTO dbo.U_dsi_EHFXHRPTE2_EarnCurrHC
        from dbo.u_EHFXHRPTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND convert(DATETIME,left(pehPerControl,8)) between @startdate and @enddate --Period (vendor requests files by calendar month dates)        
    JOIN EarnCode on ErnEarncode = PehEarnCode and ErnInclInHealthCareHours = 'Y'

    GROUP BY xEEID,xCOID,pehpaydate,PehPerControl--,pehearncode


-- Populate Source for Employees

if object_id('dbo.U_dsi_EHFXHRPTE2_drvTbl') is not null
  drop table dbo.U_dsi_EHFXHRPTE2_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvsort1 = 2,
    drvsort2 = eepssn,
-- standard fields above and additional driver fields below
    drvLocation = eecLocation,
    drvTypGroup = 'TYP Restaurant Group',
    drvFEIN = '20-1058272',
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
    drvLOAreason = loa.lchCode,
    drvLOAstartDate = CONVERT(varchar(10), loa.EshStatusStartDate, 112),
    drvLOAendDate = CONVERT(varchar(10), loa.EshStatusStopDate, 112),
    drvRegion = EecOrgLvl2, --TD 8/5/15 as requested
    drvWorkCity = LocAddressCity,    --TD 7/10/15 added --OPT
    drvSalHrlyCode = EecSalaryOrHourly,
    drvPeriodHours = case when ecurhrs >= 0 then cast(ecurhrs/*ecurHChrs*/ as varchar) end, --TD 7/21/15 as requested.
    drvPayFreq = case when EecPayPeriod = 'W' then 'Weekly'
                      when EecPayPeriod = 'B' then 'Bi-Weekly'
                      when EecPayPeriod = 'S' then 'Semi-monthly'
                      when EecPayPeriod = 'M' then 'Monthly' else '' end,
    drvGrossYTD = case when eamt >= 0 then ISNULL(eamt,0) end, --TD 7/21/15 as requested.
    drvGrossPeriod = case when ecuramt >=0 then isnull(ecuramt,0) end,
    drvHourlyRate = CAST(EecHourlyPayRate as money),--case when eecemplstatus <> 'T' then CAST(EecHourlyPayRate as money) end,
    drvPeriodStartDate = CONVERT(varchar(10), PgpPeriodStartDate, 112),--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodStartDate, 112) end,
    drvPeriodEndDate = CONVERT(varchar(10), PgpPeriodEndDate, 112)--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodEndDate, 112) end

  into dbo.U_dsi_EHFXHRPTE2_drvTbl
  from dbo.u_EHFXHRPTE2_eelist with (nolock)
    join empPers with (nolock) on     xEEID = eepEEID
    join empcomp with (nolock) on    xEEID = eecEEid and     xCOID = eecCOID
    join Location with (nolock) on LocCode = EecLocation
    join jobcode with (nolock) on eecJobCode = jbcJobCode

    left join (select codcode, coddesc descr from codes where codtable = 'EMPLOYEESTATUS') estat on estat.codcode = eecemplstatus
    
    left join dbo.U_dsi_EHFXHRPTE2_EarnHist on xEEID = eEEID and xCOID = eCOID

    --left join pgpayper with (nolock) on PgpPayDate between @StartDate and @EndDate
    --and pgpperiodtype = 'R'    
    
    ----TD 9/15/15 per request:
    --join dbo.U_dsi_EHFXHRPTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID and ec.epaydate = PgpPayDate

    --left join dbo.U_dsi_EHFXHRPTE2_EarnCurrHC ecHC on xEEID = ecHC.eEEID and xCOID = ecHC.eCOID and ecHC.epaydate = pgpPayDate 
    
    --
    join dbo.U_dsi_EHFXHRPTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID 
        
    left join dbo.U_dsi_EHFXHRPTE2_EarnCurrHC ecHC on xEEID = ecHC.eEEID and xCOID = ecHC.eCOID --and ecHC.epaydate = pgpPayDate 

    left join pgpayper with (nolock) on convert(DATETIME,left(PgpPeriodControl,8)) between @startdate and @enddate
    and pgpperiodtype = 'R'    
    
    left join (select eeceeid eeid, eeccoid coid, lchCode, lchDesc, lchFMLAQualified, lchType, eshStatusStartDate, eshStatusStopDate
        from empcomp
        left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
        join loareasn on lchcode = eecLeaveReason
        where eecemplstatus = 'L' and EshStatusStartDate between @StartDate and @EndDate) LOA on loa.eeid = xeeid and loa.coid = xcoid
    

    
--select * from dbo.U_dsi_EHFXHRPTE2_drvTbl



  


-- Create Headers

-- Create Trailers




-- Set FileName  
if (dbo.dsi_fnVariable('EHFXHRPTE2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'TEN_HealthEfx_Payroll_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'EHFXHRPTE2'


-- Remember to alter view for correct sorting
/*

 ALTER  View dbo.dsi_vwEHFXHRPTE2_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EHFXHRPTE2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 end,
            initialsort, subsort, substring(Recordset,2,2)         
         
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXHRPTE2','EHFXHRPTE2'
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXHRPTE2','TEST'


END
GO
 CREATE  View dbo.dsi_vwEHFXHRPTE2_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EHFXHRPTE2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 end,
            initialsort, subsort, substring(Recordset,2,2)         

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHFXHRPTE2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHFXHRPTE2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHFXHRPTE2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHFXHRPTE2', 'UseFileName', 'V', 'Y'


-- End ripout