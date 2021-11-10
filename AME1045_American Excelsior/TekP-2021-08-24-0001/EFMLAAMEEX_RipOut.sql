/**********************************************************************************

EFMLAAMEEX: Sunlife FMLA Export

FormatCode:     EFMLAAMEEX
Project:        Sunlife FMLA Export
Client ID:      AME1045
Date/time:      2021-11-10 12:26:28.357
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB01
Database:       ULTIPRO_WPAEXC
Web Filename:   AME1045_66301_EEHISTORY_EFMLAAMEEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFMLAAMEEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EFMLAAMEEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFMLAAMEEX'


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
WHERE FormatCode = 'EFMLAAMEEX'
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
WHERE ExpFormatCode = 'EFMLAAMEEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFMLAAMEEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFMLAAMEEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFMLAAMEEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFMLAAMEEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFMLAAMEEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFMLAAMEEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFMLAAMEEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFMLAAMEEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFMLAAMEEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFMLAAMEEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFMLAAMEEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFMLAAMEEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFMLAAMEEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFMLAAMEEX];
GO
IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_24M') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_PEarHist_24M];
GO
IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_12M') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_PEarHist_12M];
GO
IF OBJECT_ID('U_EFMLAAMEEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_PEarHist];
GO
IF OBJECT_ID('U_EFMLAAMEEX_File') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_File];
GO
IF OBJECT_ID('U_EFMLAAMEEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_EEList];
GO
IF OBJECT_ID('U_EFMLAAMEEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EFMLAAMEEX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFMLAAMEEX','Sunlife FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','EFMLAAMEEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFMLAAMEEXZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFMLAAMEEXZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFMLAAMEEXZ0','50','H','01','3',NULL,'Employee Title',NULL,NULL,'"Employee Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFMLAAMEEXZ0','50','H','01','4',NULL,'Employee First Name',NULL,NULL,'"Employee First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFMLAAMEEXZ0','50','H','01','5',NULL,'Employee Middle Name',NULL,NULL,'"Employee Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFMLAAMEEXZ0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL,'"Employee Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFMLAAMEEXZ0','50','H','01','7',NULL,'Employee Gender',NULL,NULL,'"Employee Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFMLAAMEEXZ0','50','H','01','8',NULL,'Employee Date of Birth',NULL,NULL,'"Employee Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFMLAAMEEXZ0','50','H','01','9',NULL,'Employee Home Address Line 1',NULL,NULL,'"Employee Home Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFMLAAMEEXZ0','50','H','01','10',NULL,'Employee Home Address Line 2',NULL,NULL,'"Employee Home Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFMLAAMEEXZ0','50','H','01','11',NULL,'Employee Home City',NULL,NULL,'"Employee Home City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFMLAAMEEXZ0','50','H','01','12',NULL,'Employee Home State',NULL,NULL,'"Employee Home State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFMLAAMEEXZ0','50','H','01','13',NULL,'Employee Home Zip Code',NULL,NULL,'"Employee Home Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFMLAAMEEXZ0','50','H','01','14',NULL,'Employee County',NULL,NULL,'"Employee County"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFMLAAMEEXZ0','50','H','01','15',NULL,'Employee Country',NULL,NULL,'"Employee Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFMLAAMEEXZ0','50','H','01','16',NULL,'Employee Home Phone Number',NULL,NULL,'"Employee Home Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFMLAAMEEXZ0','50','H','01','17',NULL,'Employee Mobile Phone Number',NULL,NULL,'"Employee Mobile Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFMLAAMEEXZ0','50','H','01','18',NULL,'Primary Phone Type',NULL,NULL,'"Primary Phone Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFMLAAMEEXZ0','50','H','01','19',NULL,'Employee Email Address',NULL,NULL,'"Employee Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFMLAAMEEXZ0','50','H','01','20',NULL,'Employee Work Email Address',NULL,NULL,'"Employee Work Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFMLAAMEEXZ0','50','H','01','21',NULL,'Employee Work State',NULL,NULL,'"Employee Work State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFMLAAMEEXZ0','50','H','01','22',NULL,'Employee Original Date of Hire',NULL,NULL,'"Employee Original Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFMLAAMEEXZ0','50','H','01','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL,'"Employee Most Recent Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFMLAAMEEXZ0','50','H','01','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL,'"Employee Adjusted Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EFMLAAMEEXZ0','50','H','01','25',NULL,'Employee Job Title',NULL,NULL,'"Employee Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EFMLAAMEEXZ0','50','H','01','26',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EFMLAAMEEXZ0','50','H','01','27',NULL,'Full Time/Part Time Status',NULL,NULL,'"Full Time/Part Time Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EFMLAAMEEXZ0','50','H','01','28',NULL,'Exempt Status',NULL,NULL,'"Exempt Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EFMLAAMEEXZ0','50','H','01','29',NULL,'Compensation Method',NULL,NULL,'"Compensation Method"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EFMLAAMEEXZ0','50','H','01','30',NULL,'Union Type',NULL,NULL,'"Union Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EFMLAAMEEXZ0','50','H','01','31',NULL,'Union Name',NULL,NULL,'"Union Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EFMLAAMEEXZ0','50','H','01','32',NULL,'Scheduled Hours per Week',NULL,NULL,'"Scheduled Hours per Week"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EFMLAAMEEXZ0','50','H','01','33',NULL,'Scheduled Days per Week',NULL,NULL,'"Scheduled Days per Week"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EFMLAAMEEXZ0','50','H','01','34',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EFMLAAMEEXZ0','50','H','01','35',NULL,'Work Site Name',NULL,NULL,'"Work Site Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EFMLAAMEEXZ0','50','H','01','36',NULL,'Organization Unit',NULL,NULL,'"Organization Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EFMLAAMEEXZ0','50','H','01','37',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EFMLAAMEEXZ0','50','H','01','38',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EFMLAAMEEXZ0','50','H','01','39',NULL,'Group Type',NULL,NULL,'"Group Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EFMLAAMEEXZ0','50','H','01','40',NULL,'Employee Earning',NULL,NULL,'"Employee Earning"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EFMLAAMEEXZ0','50','H','01','41',NULL,'Earnings Frequency',NULL,NULL,'"Earnings Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EFMLAAMEEXZ0','50','H','01','42',NULL,'Earnings Effective Date',NULL,NULL,'"Earnings Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EFMLAAMEEXZ0','50','H','01','43',NULL,'STD Weekly Earnings',NULL,NULL,'"STD Weekly Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EFMLAAMEEXZ0','50','H','01','44',NULL,'LTD Monthly Earnings',NULL,NULL,'"LTD Monthly Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EFMLAAMEEXZ0','50','H','01','45',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EFMLAAMEEXZ0','50','H','01','46',NULL,'STD Eligibility Date',NULL,NULL,'"STD Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EFMLAAMEEXZ0','50','H','01','47',NULL,'STD Election',NULL,NULL,'"STD Election"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EFMLAAMEEXZ0','50','H','01','48',NULL,'STD Benefit Amount',NULL,NULL,'"STD Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EFMLAAMEEXZ0','50','H','01','49',NULL,'STD Class',NULL,NULL,'"STD Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EFMLAAMEEXZ0','50','H','01','50',NULL,'STD Termination Date',NULL,NULL,'"STD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EFMLAAMEEXZ0','51','H','01','51',NULL,'Statutory Disability Type',NULL,NULL,'"Statutory Disability Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EFMLAAMEEXZ0','52','H','01','52',NULL,'LTD Eligibility Date',NULL,NULL,'"LTD Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EFMLAAMEEXZ0','53','H','01','53',NULL,'LTD Election',NULL,NULL,'"LTD Election"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EFMLAAMEEXZ0','54','H','01','54',NULL,'LTD Benefit Amount',NULL,NULL,'"LTD Benefit Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EFMLAAMEEXZ0','54','H','01','55',NULL,'LTD Class',NULL,NULL,'"LTD Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EFMLAAMEEXZ0','54','H','01','56',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EFMLAAMEEXZ0','54','H','01','57',NULL,'Policy Number',NULL,NULL,'"Policy Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EFMLAAMEEXZ0','54','H','01','58',NULL,'Key Employee Indicator',NULL,NULL,'"Key Employee Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EFMLAAMEEXZ0','54','H','01','59',NULL,'Work At Home Indicator',NULL,NULL,'"Work At Home Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EFMLAAMEEXZ0','54','H','01','60',NULL,'50 In 75 Rule Indicator',NULL,NULL,'"50 In 75 Rule Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EFMLAAMEEXZ0','54','H','01','61',NULL,'Hours Worked Previous 12 Months',NULL,NULL,'"Hours Worked Previous 12 Months"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EFMLAAMEEXZ0','54','H','01','62',NULL,'Supervisor Employee ID',NULL,NULL,'"Supervisor Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EFMLAAMEEXZ0','54','H','01','63',NULL,'Supervisor First Name',NULL,NULL,'"Supervisor First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EFMLAAMEEXZ0','54','H','01','64',NULL,'Supervisor Last Name',NULL,NULL,'"Supervisor Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EFMLAAMEEXZ0','54','H','01','65',NULL,'Occupation Qualifier1',NULL,NULL,'"Occupation Qualifier1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EFMLAAMEEXZ0','54','H','01','66',NULL,'Occupation Qualifier2',NULL,NULL,'"Occupation Qualifier2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EFMLAAMEEXZ0','54','H','01','67',NULL,'Occupation Qualifier3',NULL,NULL,'"Occupation Qualifier3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EFMLAAMEEXZ0','54','H','01','68',NULL,'Occupation Qualifier4',NULL,NULL,'"Occupation Qualifier4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EFMLAAMEEXZ0','54','H','01','69',NULL,'Occupation Qualifier5',NULL,NULL,'"Occupation Qualifier5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EFMLAAMEEXZ0','54','H','01','70',NULL,'Occupation Qualifier6',NULL,NULL,'"Occupation Qualifier6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EFMLAAMEEXZ0','54','H','01','71',NULL,'Occupation Qualifier7',NULL,NULL,'"Occupation Qualifier7"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EFMLAAMEEXZ0','54','H','01','72',NULL,'Occupation Qualifier8',NULL,NULL,'"Occupation Qualifier8"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EFMLAAMEEXZ0','54','H','01','73',NULL,'Occupation Qualifier9',NULL,NULL,'"Occupation Qualifier9"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EFMLAAMEEXZ0','54','H','01','74',NULL,'Occupation Qualifier10',NULL,NULL,'"Occupation Qualifier10"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EFMLAAMEEXZ0','54','H','01','75',NULL,'Employer Contact 1',NULL,NULL,'"Employer Contact 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EFMLAAMEEXZ0','54','H','01','76',NULL,'Employer Contact 2',NULL,NULL,'"Employer Contact 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EFMLAAMEEXZ0','54','H','01','77',NULL,'Employer Contact 3',NULL,NULL,'"Employer Contact 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EFMLAAMEEXZ0','54','H','01','78',NULL,'Employer Contact 4',NULL,NULL,'"Employer Contact 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EFMLAAMEEXZ0','54','H','01','79',NULL,'Employer Contact 5',NULL,NULL,'"Employer Contact 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EFMLAAMEEXZ0','54','H','01','80',NULL,'Employer Contact 6',NULL,NULL,'"Employer Contact 6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EFMLAAMEEXZ0','54','H','01','81',NULL,'Employer Contact 7',NULL,NULL,'"Employer Contact 7"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EFMLAAMEEXZ0','54','H','01','82',NULL,'Employer Contact 8',NULL,NULL,'"Employer Contact 8"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EFMLAAMEEXZ0','54','H','01','83',NULL,'Employer Contact 9',NULL,NULL,'"Employer Contact 9"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EFMLAAMEEXZ0','54','H','01','84',NULL,'Employer Contact 10',NULL,NULL,'"Employer Contact 10"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EFMLAAMEEXZ0','54','H','01','85',NULL,'Reporting Field1',NULL,NULL,'"Reporting Field1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EFMLAAMEEXZ0','54','H','01','86',NULL,'Reporting Field2',NULL,NULL,'"Reporting Field2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EFMLAAMEEXZ0','54','H','01','87',NULL,'Reporting Field3',NULL,NULL,'"Reporting Field3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EFMLAAMEEXZ0','54','H','01','88',NULL,'Reporting Field4',NULL,NULL,'"Reporting Field4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EFMLAAMEEXZ0','54','H','01','89',NULL,'Spouse Date of Change',NULL,NULL,'"Spouse Date of Change"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EFMLAAMEEXZ0','54','H','01','90',NULL,'Spouse First Name',NULL,NULL,'"Spouse First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EFMLAAMEEXZ0','54','H','01','91',NULL,'Spouse Last Name',NULL,NULL,'"Spouse Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EFMLAAMEEXZ0','54','H','01','92',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EFMLAAMEEXZ0','54','H','01','93',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EFMLAAMEEXZ0','54','H','01','94',NULL,'Spouse Employee ID',NULL,NULL,'"Spouse Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EFMLAAMEEXZ0','54','H','01','95',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EFMLAAMEEXZ0','54','H','01','96',NULL,'Spouse Reason of Change',NULL,NULL,'"Spouse Reason of Change"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EFMLAAMEEXZ0','54','H','01','97',NULL,'Employment Class',NULL,NULL,'"Employment Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EFMLAAMEEXZ0','54','H','01','98',NULL,'Employment Strength',NULL,NULL,'"Employment Strength"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFMLAAMEEXZ0','54','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFMLAAMEEXZ0','54','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFMLAAMEEXZ0','54','D','10','3',NULL,'Employee Title',NULL,NULL,'"drvEmpTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFMLAAMEEXZ0','54','D','10','4',NULL,'Employee First Name',NULL,NULL,'"drvEmpFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFMLAAMEEXZ0','54','D','10','5',NULL,'Employee Middle Name',NULL,NULL,'"drvEmpMI"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFMLAAMEEXZ0','54','D','10','6',NULL,'Employee Last Name',NULL,NULL,'"drvEmpLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFMLAAMEEXZ0','54','D','10','7',NULL,'Employee Gender',NULL,NULL,'"drvEmpGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFMLAAMEEXZ0','54','D','10','8',NULL,'Employee Date of Birth',NULL,NULL,'"drvEmpDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFMLAAMEEXZ0','54','D','10','9',NULL,'Employee Home Address Line 1',NULL,NULL,'"drvEmpHomeAdd1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFMLAAMEEXZ0','54','D','10','10',NULL,'Employee Home Address Line 2',NULL,NULL,'"drvEmpHomeAdd2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFMLAAMEEXZ0','54','D','10','11',NULL,'Employee Home City',NULL,NULL,'"drvEmpHomeCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFMLAAMEEXZ0','54','D','10','12',NULL,'Employee Home State',NULL,NULL,'"drvEmpHomeState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFMLAAMEEXZ0','54','D','10','13',NULL,'Employee Home Zip Code',NULL,NULL,'"drvEmpHomeZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFMLAAMEEXZ0','54','D','10','14',NULL,'Employee County',NULL,NULL,'"drvEmpCounty"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFMLAAMEEXZ0','54','D','10','15',NULL,'Employee Country',NULL,NULL,'"drvEmpCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFMLAAMEEXZ0','54','D','10','16',NULL,'Employee Home Phone Number',NULL,NULL,'"drvEmpHomePh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFMLAAMEEXZ0','54','D','10','17',NULL,'Employee Mobile Phone Number',NULL,NULL,'"drvEmpMobilePh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFMLAAMEEXZ0','54','D','10','18',NULL,'Primary Phone Type',NULL,NULL,'"drvPrimaryPhType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFMLAAMEEXZ0','54','D','10','19',NULL,'Employee Email Address',NULL,NULL,'"drvEmpEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFMLAAMEEXZ0','54','D','10','20',NULL,'Employee Work Email Address',NULL,NULL,'"drvEmpWorkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFMLAAMEEXZ0','54','D','10','21',NULL,'Employee Work State',NULL,NULL,'"drvEmpWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFMLAAMEEXZ0','54','D','10','22',NULL,'Employee Original Date of Hire',NULL,NULL,'"drvEmpOrigDOH"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFMLAAMEEXZ0','54','D','10','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL,'"drvEmpMostRecentDOH"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFMLAAMEEXZ0','54','D','10','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL,'"drvEmpAdjDOH"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EFMLAAMEEXZ0','54','D','10','25',NULL,'Employee Job Title',NULL,NULL,'"drvEmpJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EFMLAAMEEXZ0','54','D','10','26',NULL,'Employment Status',NULL,NULL,'"drvEmployStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EFMLAAMEEXZ0','54','D','10','27',NULL,'Full Time/Part Time Status',NULL,NULL,'"drvFTPTStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EFMLAAMEEXZ0','54','D','10','28',NULL,'Exempt Status',NULL,NULL,'"drvExemptStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EFMLAAMEEXZ0','54','D','10','29',NULL,'Compensation Method',NULL,NULL,'"drvCompMethod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EFMLAAMEEXZ0','54','D','10','30',NULL,'Union Type',NULL,NULL,'"drvUnionType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EFMLAAMEEXZ0','54','D','10','31',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EFMLAAMEEXZ0','54','D','10','32',NULL,'Scheduled Hours per Week',NULL,NULL,'"drvSchHrsPerWk"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EFMLAAMEEXZ0','54','D','10','33',NULL,'Scheduled Days per Week',NULL,NULL,'"drvSchDaysPerWk"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EFMLAAMEEXZ0','54','D','10','34',NULL,'Employment Type',NULL,NULL,'"drvEmployType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EFMLAAMEEXZ0','54','D','10','35',NULL,'Work Site Name',NULL,NULL,'"drvWrkSiteName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EFMLAAMEEXZ0','54','D','10','36',NULL,'Organization Unit',NULL,NULL,'"drvOrgUnit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EFMLAAMEEXZ0','54','D','10','37',NULL,'Business Unit',NULL,NULL,'"drvBusUnit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EFMLAAMEEXZ0','54','D','10','38',NULL,'Division',NULL,NULL,'"drvDiv"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EFMLAAMEEXZ0','54','D','10','39',NULL,'Group Type',NULL,NULL,'"drvGrpType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EFMLAAMEEXZ0','54','D','10','40',NULL,'Employee Earning',NULL,NULL,'"drvEmpEarning"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EFMLAAMEEXZ0','54','D','10','41',NULL,'Earnings Frequency',NULL,NULL,'"drvEarningsFreq"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EFMLAAMEEXZ0','54','D','10','42',NULL,'Earnings Effective Date',NULL,NULL,'"drvEarningsEffDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EFMLAAMEEXZ0','54','D','10','43',NULL,'STD Weekly Earnings',NULL,NULL,'"drvSTDWklyEarnings"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EFMLAAMEEXZ0','54','D','10','44',NULL,'LTD Monthly Earnings',NULL,NULL,'"drvLTDMonthEarnings"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EFMLAAMEEXZ0','54','D','10','45',NULL,'Termination Date',NULL,NULL,'"drvTermDt"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EFMLAAMEEXZ0','54','D','10','46',NULL,'STD Eligibility Date',NULL,NULL,'"drvSTDEligDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EFMLAAMEEXZ0','54','D','10','47',NULL,'STD Election',NULL,NULL,'"drvSTDElect"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EFMLAAMEEXZ0','54','D','10','48',NULL,'STD Benefit Amount',NULL,NULL,'"drvSTDBenAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EFMLAAMEEXZ0','54','D','10','49',NULL,'STD Class',NULL,NULL,'"drvSTDClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EFMLAAMEEXZ0','54','D','10','50',NULL,'STD Termination Date',NULL,NULL,'"drvSTDTermDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EFMLAAMEEXZ0','54','D','10','51',NULL,'Statutory Disability Type',NULL,NULL,'"drvStatDisType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EFMLAAMEEXZ0','54','D','10','52',NULL,'LTD Eligibility Date',NULL,NULL,'"drvLTDEligDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EFMLAAMEEXZ0','54','D','10','53',NULL,'LTD Election',NULL,NULL,'"drvLTDElect"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EFMLAAMEEXZ0','54','D','10','54',NULL,'LTD Benefit Amount',NULL,NULL,'"drvLTDBenAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EFMLAAMEEXZ0','54','D','10','55',NULL,'LTD Class',NULL,NULL,'"drvLTDClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EFMLAAMEEXZ0','54','D','10','56',NULL,'LTD Termination Date',NULL,NULL,'"drvLTDTermDt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EFMLAAMEEXZ0','54','D','10','57',NULL,'Policy Number',NULL,NULL,'"drvPolNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EFMLAAMEEXZ0','54','D','10','58',NULL,'Key Employee Indicator',NULL,NULL,'"drvKeyEmpIndic"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EFMLAAMEEXZ0','54','D','10','59',NULL,'Work At Home Indicator',NULL,NULL,'"drvWrkAtHomeIndic"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EFMLAAMEEXZ0','54','D','10','60',NULL,'50 In 75 Rule Indicator',NULL,NULL,'"drv50in75RuleIndic"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EFMLAAMEEXZ0','54','D','10','61',NULL,'Hours Worked Previous 12 Months',NULL,NULL,'"drvHrsWrkedPrev12Mo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EFMLAAMEEXZ0','54','D','10','62',NULL,'Supervisor Employee ID',NULL,NULL,'"drvSupervisorEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EFMLAAMEEXZ0','54','D','10','63',NULL,'Supervisor First Name',NULL,NULL,'"drvSupervisorFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EFMLAAMEEXZ0','54','D','10','64',NULL,'Supervisor Last Name',NULL,NULL,'"drvSupervisorLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EFMLAAMEEXZ0','54','D','10','65',NULL,'Occupation Qualifier1',NULL,NULL,'"drvOccQual1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EFMLAAMEEXZ0','54','D','10','66',NULL,'Occupation Qualifier2',NULL,NULL,'"drvOccQual2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EFMLAAMEEXZ0','54','D','10','67',NULL,'Occupation Qualifier3',NULL,NULL,'"drvOccQual3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EFMLAAMEEXZ0','54','D','10','68',NULL,'Occupation Qualifier4',NULL,NULL,'"drvOccQual4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EFMLAAMEEXZ0','54','D','10','69',NULL,'Occupation Qualifier5',NULL,NULL,'"drvOccQual5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EFMLAAMEEXZ0','54','D','10','70',NULL,'Occupation Qualifier6',NULL,NULL,'"drvOccQual6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EFMLAAMEEXZ0','54','D','10','71',NULL,'Occupation Qualifier7',NULL,NULL,'"drvOccQual7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EFMLAAMEEXZ0','54','D','10','72',NULL,'Occupation Qualifier8',NULL,NULL,'"drvOccQual8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EFMLAAMEEXZ0','54','D','10','73',NULL,'Occupation Qualifier9',NULL,NULL,'"drvOccQual9"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EFMLAAMEEXZ0','54','D','10','74',NULL,'Occupation Qualifier10',NULL,NULL,'"drvOccQual10"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EFMLAAMEEXZ0','54','D','10','75',NULL,'Employer Contact 1',NULL,NULL,'"drvEmployCont1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EFMLAAMEEXZ0','54','D','10','76',NULL,'Employer Contact 2',NULL,NULL,'"drvEmployCont2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EFMLAAMEEXZ0','54','D','10','77',NULL,'Employer Contact 3',NULL,NULL,'"drvEmployCont3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EFMLAAMEEXZ0','54','D','10','78',NULL,'Employer Contact 4',NULL,NULL,'"drvEmployCont4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EFMLAAMEEXZ0','54','D','10','79',NULL,'Employer Contact 5',NULL,NULL,'"drvEmployCont5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EFMLAAMEEXZ0','54','D','10','80',NULL,'Employer Contact 6',NULL,NULL,'"drvEmployCont6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EFMLAAMEEXZ0','54','D','10','81',NULL,'Employer Contact 7',NULL,NULL,'"drvEmployCont7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EFMLAAMEEXZ0','54','D','10','82',NULL,'Employer Contact 8',NULL,NULL,'"drvEmployCont8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EFMLAAMEEXZ0','54','D','10','83',NULL,'Employer Contact 9',NULL,NULL,'"drvEmployCont9"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EFMLAAMEEXZ0','54','D','10','84',NULL,'Employer Contact 10',NULL,NULL,'"drvEmployCont10"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EFMLAAMEEXZ0','54','D','10','85',NULL,'Reporting Field1',NULL,NULL,'"drvRepField1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EFMLAAMEEXZ0','54','D','10','86',NULL,'Reporting Field2',NULL,NULL,'"drvRepField2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EFMLAAMEEXZ0','54','D','10','87',NULL,'Reporting Field3',NULL,NULL,'"drvRepField3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EFMLAAMEEXZ0','54','D','10','88',NULL,'Reporting Field4',NULL,NULL,'"drvRepField4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EFMLAAMEEXZ0','54','D','10','89',NULL,'Spouse Date of Change',NULL,NULL,'"drvSpouseDtOfChange"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EFMLAAMEEXZ0','54','D','10','90',NULL,'Spouse First Name',NULL,NULL,'"drvSpouseFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EFMLAAMEEXZ0','54','D','10','91',NULL,'Spouse Last Name',NULL,NULL,'"drvSpouseLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EFMLAAMEEXZ0','54','D','10','92',NULL,'Spouse Date of Birth',NULL,NULL,'"drvSpouseDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EFMLAAMEEXZ0','54','D','10','93',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EFMLAAMEEXZ0','54','D','10','94',NULL,'Spouse Employee ID',NULL,NULL,'"drvSpouseEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EFMLAAMEEXZ0','54','D','10','95',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EFMLAAMEEXZ0','54','D','10','96',NULL,'Spouse Reason of Change',NULL,NULL,'"drvSpouseReasonOfChange"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EFMLAAMEEXZ0','54','D','10','97',NULL,'Employment Class',NULL,NULL,'"drvEmployClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EFMLAAMEEXZ0','54','D','10','98',NULL,'Employment Strength',NULL,NULL,'"drvEmployStrength"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFMLAAMEEX_20211110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife FMLA Export','202110189','EMPEXPORT','ONDEM_XOE',NULL,'EFMLAAMEEX',NULL,NULL,NULL,'202110189','Oct 18 2021 12:09PM','Oct 18 2021 12:09PM','202110181',NULL,'','','202110181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife FMLA Export-Sched','202110189','EMPEXPORT','SCH_EFMLAA',NULL,'EFMLAAMEEX',NULL,NULL,NULL,'202110189','Oct 18 2021 12:09PM','Oct 18 2021 12:09PM','202110181',NULL,'','','202110181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Sunlife FMLA Export-Test','202111029','EMPEXPORT','TEST_XOE','Nov  2 2021  9:30AM','EFMLAAMEEX',NULL,NULL,NULL,'202111029','Nov  2 2021 12:00AM','Dec 30 1899 12:00AM','202110191','450','','','202110191',dbo.fn_GetTimedKey(),NULL,'us3lKiAME1045',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFMLAAMEEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFMLAAMEEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFMLAAMEEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFMLAAMEEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFMLAAMEEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFMLAAMEEX','D10','dbo.U_EFMLAAMEEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EFMLAAMEEX_drvTbl
-----------

IF OBJECT_ID('U_EFMLAAMEEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvEmpTitle] varchar(1) NOT NULL,
    [drvEmpFName] varchar(100) NULL,
    [drvEmpMI] varchar(1) NULL,
    [drvEmpLName] varchar(100) NULL,
    [drvEmpGender] varchar(1) NULL,
    [drvEmpDOB] datetime NULL,
    [drvEmpHomeAdd1] varchar(8000) NULL,
    [drvEmpHomeAdd2] varchar(8000) NULL,
    [drvEmpHomeCity] varchar(255) NULL,
    [drvEmpHomeState] varchar(255) NULL,
    [drvEmpHomeZip] varchar(5) NULL,
    [drvEmpCounty] varchar(255) NULL,
    [drvEmpCountry] varchar(1) NOT NULL,
    [drvEmpHomePh] varchar(50) NULL,
    [drvEmpMobilePh] varchar(50) NULL,
    [drvPrimaryPhType] varchar(4) NOT NULL,
    [drvEmpEmail] varchar(50) NULL,
    [drvEmpWorkEmail] varchar(50) NULL,
    [drvEmpWorkState] varchar(255) NULL,
    [drvEmpOrigDOH] datetime NULL,
    [drvEmpMostRecentDOH] datetime NULL,
    [drvEmpAdjDOH] varchar(1) NOT NULL,
    [drvEmpJobTitle] varchar(8000) NULL,
    [drvEmployStatus] varchar(2) NOT NULL,
    [drvFTPTStatus] char(1) NULL,
    [drvExemptStatus] varchar(10) NOT NULL,
    [drvCompMethod] char(1) NULL,
    [drvUnionType] varchar(9) NOT NULL,
    [drvUnionName] char(12) NULL,
    [drvSchHrsPerWk] varchar(30) NULL,
    [drvSchDaysPerWk] varchar(1) NOT NULL,
    [drvEmployType] varchar(1) NOT NULL,
    [drvWrkSiteName] char(6) NULL,
    [drvOrgUnit] char(10) NULL,
    [drvBusUnit] char(10) NULL,
    [drvDiv] varchar(1) NOT NULL,
    [drvGrpType] varchar(1) NOT NULL,
    [drvEmpEarning] varchar(30) NULL,
    [drvEarningsFreq] varchar(1) NOT NULL,
    [drvEarningsEffDt] datetime NULL,
    [drvSTDWklyEarnings] varchar(1) NOT NULL,
    [drvLTDMonthEarnings] varchar(1) NOT NULL,
    [drvTermDt] varchar(30) NOT NULL,
    [drvSTDEligDt] varchar(1) NOT NULL,
    [drvSTDElect] varchar(1) NOT NULL,
    [drvSTDBenAmt] varchar(1) NOT NULL,
    [drvSTDClass] varchar(1) NOT NULL,
    [drvSTDTermDt] varchar(1) NOT NULL,
    [drvStatDisType] varchar(1) NOT NULL,
    [drvLTDEligDt] varchar(1) NOT NULL,
    [drvLTDElect] varchar(1) NOT NULL,
    [drvLTDBenAmt] varchar(1) NOT NULL,
    [drvLTDClass] varchar(1) NOT NULL,
    [drvLTDTermDt] varchar(1) NOT NULL,
    [drvPolNum] varchar(1) NOT NULL,
    [drvKeyEmpIndic] varchar(1) NOT NULL,
    [drvWrkAtHomeIndic] varchar(1) NOT NULL,
    [drv50in75RuleIndic] varchar(1) NOT NULL,
    [drvHrsWrkedPrev12Mo] varchar(30) NULL,
    [drvSupervisorEmpId] varchar(1) NOT NULL,
    [drvSupervisorFName] varchar(1) NOT NULL,
    [drvSupervisorLName] varchar(1) NOT NULL,
    [drvOccQual1] varchar(1) NOT NULL,
    [drvOccQual2] varchar(1) NOT NULL,
    [drvOccQual3] varchar(1) NOT NULL,
    [drvOccQual4] varchar(1) NOT NULL,
    [drvOccQual5] varchar(1) NOT NULL,
    [drvOccQual6] varchar(1) NOT NULL,
    [drvOccQual7] varchar(1) NOT NULL,
    [drvOccQual8] varchar(1) NOT NULL,
    [drvOccQual9] varchar(1) NOT NULL,
    [drvOccQual10] varchar(1) NOT NULL,
    [drvEmployCont1] varchar(1) NOT NULL,
    [drvEmployCont2] varchar(1) NOT NULL,
    [drvEmployCont3] varchar(1) NOT NULL,
    [drvEmployCont4] varchar(1) NOT NULL,
    [drvEmployCont5] varchar(1) NOT NULL,
    [drvEmployCont6] varchar(1) NOT NULL,
    [drvEmployCont7] varchar(1) NOT NULL,
    [drvEmployCont8] varchar(1) NOT NULL,
    [drvEmployCont9] varchar(1) NOT NULL,
    [drvEmployCont10] varchar(1) NOT NULL,
    [drvRepField1] varchar(1) NOT NULL,
    [drvRepField2] varchar(1) NOT NULL,
    [drvRepField3] varchar(1) NOT NULL,
    [drvRepField4] varchar(1) NOT NULL,
    [drvSpouseDtOfChange] varchar(1) NOT NULL,
    [drvSpouseFName] varchar(1) NOT NULL,
    [drvSpouseLName] varchar(1) NOT NULL,
    [drvSpouseDOB] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseEmpId] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvSpouseReasonOfChange] varchar(1) NOT NULL,
    [drvEmployClass] varchar(1) NOT NULL,
    [drvEmployStrength] varchar(1) NOT NULL
);

-----------
-- Create table U_EFMLAAMEEX_EEList
-----------

IF OBJECT_ID('U_EFMLAAMEEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFMLAAMEEX_File
-----------

IF OBJECT_ID('U_EFMLAAMEEX_File') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EFMLAAMEEX_PEarHist
-----------

IF OBJECT_ID('U_EFMLAAMEEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PgrPayFrequency] char(1) NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EFMLAAMEEX_PEarHist_12M
-----------

IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_12M') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_PEarHist_12M] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PehPerControl] char(9) NULL,
    [PrgPayDate] datetime NULL,
    [PgrPayFrequency] char(1) NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EFMLAAMEEX_PEarHist_24M
-----------

IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_24M') IS NULL
CREATE TABLE [dbo].[U_EFMLAAMEEX_PEarHist_24M] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PgrPayFrequency] char(1) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFMLAAMEEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Excelsior

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/18/2021
Service Request Number: TekP-2021-08-24-0001

Purpose: Sunlife FMLA Export

Revision History
----------------
11/01/2021 by AP:
        - Changed employee work state logic.
        - Removed commas from employee job title.
        - Added older than 30 days to drop term logic.

11/10/2021 by AP:
		- Updated STD Eligibility Date, STD Class, STD Termination Date, LTD Eligibility Date, LTD Class, LTD Termination Date

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFMLAAMEEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFMLAAMEEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFMLAAMEEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFMLAAMEEX', 'SCH_EFMLAA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFMLAAMEEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFMLAAMEEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@Last24MonthsPerControl varchar(9)
            ,@Last12MonthsPerControl varchar(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EFMLAAMEEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last24MonthsPerControl =  CONVERT(VARCHAR(12),DATEADD(month,-24, @StartDate),112) + '1'

    SELECT @Last12MonthsPerControl =  CONVERT(VARCHAR(12),DATEADD(month,-12, @StartDate),112) + '1'

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFMLAAMEEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFMLAAMEEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EFMLAAMEEX_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EFMLAAMEEX_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EFMLAAMEEX_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EFMLAAMEEX_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EFMLAAMEEX_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EFMLAAMEEX_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EFMLAAMEEX_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


     -------------------------------
    ---- Working Table - PEarHist YTD
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
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
    INTO dbo.U_EFMLAAMEEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;

    -------------------------------
    ---- Working Table - PEarHist 24M
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_24M','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist_24M;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @Last24MonthsPerControl THEN PehCurAmt ELSE 0.00 END)
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
    INTO dbo.U_EFMLAAMEEX_PEarHist_24M
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    -------------------------------
    ---- Working Table - PEarHist 12M
    -------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_PEarHist_12M','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_PEarHist_12M;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
        ,PehPerControl            = MAX(PehPerControl)
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @Last12MonthsPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @Last12MonthsPerControl AND PehEarnCode IN ('COOT', 'DBL', 'OT', 'REG', 'SALRY') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EFMLAAMEEX_PEarHist_12M
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFMLAAMEEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EFMLAAMEEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EFMLAAMEEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpSSN = eepSSN
        ,drvEmpId = EecEmpNo
        ,drvEmpTitle = ''
        ,drvEmpFName = EepNameFirst
        ,drvEmpMI = LEFT(EepNameMiddle, 1)
        ,drvEmpLName = EepNameLast
        ,drvEmpGender = CASE WHEN EepGender NOT IN ('M', 'F') THEN 'N' ELSE EepGender END
        ,drvEmpDOB = EepDateOfBirth
        ,drvEmpHomeAdd1 = REPLACE(EepAddressline1, ',', '')
        ,drvEmpHomeAdd2 = REPLACE(EepAddressline2, ',', '')
        ,drvEmpHomeCity = EepAddressCity
        ,drvEmpHomeState = EepAddressState
        ,drvEmpHomeZip = LEFT(EepAddressZipCode, 5)
        ,drvEmpCounty = EepAddressCounty
        ,drvEmpCountry = ''
        ,drvEmpHomePh = EepPHoneHomeNumber
        ,drvEmpMobilePh = EfoPhoneNumber
        ,drvPrimaryPhType = 'Home'
        ,drvEmpEmail = EepAddressemailalternate
        ,drvEmpWorkEmail = EepAddressEMail
        ,drvEmpWorkState = LocAddressState
        --LocDesc
        ,drvEmpOrigDOH = EecDateOfOriginalHire
        ,drvEmpMostRecentDOH = EecDateOfLastHire
        ,drvEmpAdjDOH = ''
        ,drvEmpJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvEmployStatus = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'TE'
                                WHEN EecEmplStatus = 'L' THEN 'OL'
                                WHEN EecEmplStatus = 'S' THEN 'SU' 
                                ELSE 'AE' END
        ,drvFTPTStatus = EecFullTimeOrPartTime
        ,drvExemptStatus = CASE WHEN E.EjhFLSACategory = 'E' THEN 'Exempt' ELSE 'Non Exempt' END
        ,drvCompMethod = EecSalaryOrHourly
        ,drvUnionType = CASE WHEN ISNULL(EecUnionLocal, '') <> '' THEN 'Union' ELSE 'Non Union' END
        ,drvUnionName = EecUnionLocal
        ,drvSchHrsPerWk = CAST(CAST(CASE WHEN Peh.PgrPayFrequency = 'B' THEN EecScheduledWorkHrs / 2 ELSE EecScheduledWorkHrs END AS DECIMAL(10,1)) AS VARCHAR)
        ,drvSchDaysPerWk = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '4' ELSE '2' END
        ,drvEmployType = CASE WHEN EecEEType IN ('REG', 'UNI') THEN 'P' ELSE '' END
        ,drvWrkSiteName = EecLocation
        ,drvOrgUnit = EecOrgLvl3
        ,drvBusUnit = EecOrgLvl1
        ,drvDiv = ''
        ,drvGrpType = ''
        ,drvEmpEarning = CAST(CAST(CASE WHEN DATEDIFF(year, Eecdateoflasthire, getdate()) >= 1 THEN Peh24.PehCurAmt ELSE Peh.PehCurAmtYTD END AS DECIMAL(10,2)) AS VARCHAR)
        ,drvEarningsFreq = 'A'
        ,drvEarningsEffDt = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateInJob)  
        ,drvSTDWklyEarnings = ''
        ,drvLTDMonthEarnings = ''
        ,drvTermDt = ISNULL(CONVERT(VARCHAR, CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END, 101), '')
        ,drvSTDEligDt = Eed.EedBenStartDate
		--ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode = 'GLIFE' THEN EedBenStartDate END), 101), '')
        ,drvSTDElect = ''
        ,drvSTDBenAmt = ''
        ,drvSTDClass = CASE WHEN Eed.EedEEID IS NOT NULL THEN '1' END
        ,drvSTDTermDt = Eed.EedBenStopDate
		--ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode = 'GLIFE' THEN EedBenStopDate END), 101), '')
        ,drvStatDisType = ''
        ,drvLTDEligDt = Eed.EedBenStartDate
		--ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode = 'GLIFE' THEN EedBenStartDate END), 101), '')
        ,drvLTDElect = ''
        ,drvLTDBenAmt = ''
        ,drvLTDClass = CASE WHEN Eed.EedEEID IS NOT NULL AND EecOrgLvl3 IN ('U', 'P') THEN '1' END
        ,drvLTDTermDt = Eed.EedBenStartDate
		--ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode = 'GLIFE'  THEN EedBenStopDate END), 101), '')
        ,drvPolNum = ''
        ,drvKeyEmpIndic = ''
        ,drvWrkAtHomeIndic = ''
        ,drv50in75RuleIndic = 'Y'
        ,drvHrsWrkedPrev12Mo = CAST(CAST(Peh12.PehCurHrs AS INT) AS VARCHAR)
        ,drvSupervisorEmpId = ''
        ,drvSupervisorFName = ''
        ,drvSupervisorLName = ''
        ,drvOccQual1 = ''
        ,drvOccQual2 = ''
        ,drvOccQual3 = ''
        ,drvOccQual4 = ''
        ,drvOccQual5 = ''
        ,drvOccQual6 = ''
        ,drvOccQual7 = ''
        ,drvOccQual8 = ''
        ,drvOccQual9 = ''
        ,drvOccQual10 = ''
        ,drvEmployCont1 = ''
        ,drvEmployCont2 = ''
        ,drvEmployCont3 = ''
        ,drvEmployCont4 = ''
        ,drvEmployCont5 = ''
        ,drvEmployCont6 = ''
        ,drvEmployCont7 = ''
        ,drvEmployCont8 = ''
        ,drvEmployCont9 = ''
        ,drvEmployCont10 = ''
        ,drvRepField1 = ''
        ,drvRepField2 = ''
        ,drvRepField3 = ''
        ,drvRepField4 = ''
        ,drvSpouseDtOfChange = ''
        ,drvSpouseFName = ''
        ,drvSpouseLName = ''
        ,drvSpouseDOB = ''
        ,drvSpouseSSN = ''
        ,drvSpouseEmpId = ''
        ,drvMaritalStatus = ''
        ,drvSpouseReasonOfChange = ''
        ,drvEmployClass = ''
        ,drvEmployStrength = ''
    INTO dbo.U_EFMLAAMEEX_drvTbl
    FROM dbo.U_EFMLAAMEEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH(NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_EFMLAAMEEX_PEarHist Peh WITH(NOLOCK)
        ON Peh.PehEEID = xEEID
        AND Peh.PehCOID = xCOID
    OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E
  --  OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID AND EjhJobEffDate < @StartDate AND EjhIsRateChange = 'Y' ORDER BY EjhJobEffDate DESC) E2
    LEFT JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL') as M on M.EfoEEID = xEEID
    LEFT JOIN dbo.U_EFMLAAMEEX_PEarHist_24M Peh24 WITH(NOLOCK)
        ON Peh24.PehEEID = xEEID
        AND Peh24.PehCOID = xCOID
    LEFT JOIN dbo.U_EFMLAAMEEX_PEarHist_12M Peh12 WITH(NOLOCK)
        ON Peh12.PehEEID = xEEID
        AND Peh12.PehCOID = xCOID
	LEFT JOIN (SELECT DISTINCT EedEEID, EedCOID, MAX(EedBenStartDate) AS EedBenStartDate, MAX(EedBenStopDate) AS EedBenStopDate
				FROM dbo.EmpDedFull WITH(NOLOCK)
				WHERE EedDedCode = 'GLIFE'
				GROUP BY EedEEID, EedCOID) Eed ON Eed.EedEEID = xEEID AND EedCOID = xCOID
	--LEFT JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
	--	ON EedEEID = xEEID
	--	AND EedCOID = xCOID
	--	AND EedFormatCode = @FormatCode
 --    	AND EedValidForExport = 'Y'
    --JOIN dbo.U_dsi_BDM_EFMLAAMEEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    WHERE EecDateOfTermination IS NULL OR CAST(EecDateOfTermination AS DATE) >= DATEADD(day, -30, CAST(GETDATE() AS DATE))
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
ALTER VIEW dbo.dsi_vwEFMLAAMEEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFMLAAMEEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFMLAAMEEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110111'
       ,expStartPerControl     = '202110111'
       ,expLastEndPerControl   = '202110189'
       ,expEndPerControl       = '202110189'
WHERE expFormatCode = 'EFMLAAMEEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFMLAAMEEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EFMLAAMEEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFMLAAMEEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFMLAAMEEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFMLAAMEEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFMLAAMEEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFMLAAMEEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFMLAAMEEX', 'UseFileName', 'V', 'Y'


-- End ripout