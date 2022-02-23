/**********************************************************************************

ESPPSUNEXP: Sunlife Absense File Export

FormatCode:     ESPPSUNEXP
Project:        Sunlife Absense File Export
Client ID:      SOU1052
Date/time:      2022-01-07 23:26:14.733
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB03
Database:       ULTIPRO_WPSPPI
Web Filename:   SOU1052_D2LZ4_EEHISTORY_ESPPSUNEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESPPSUNEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ESPPSUNEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESPPSUNEXP'


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
WHERE FormatCode = 'ESPPSUNEXP'
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
WHERE ExpFormatCode = 'ESPPSUNEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESPPSUNEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESPPSUNEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESPPSUNEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESPPSUNEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESPPSUNEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESPPSUNEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESPPSUNEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESPPSUNEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESPPSUNEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESPPSUNEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESPPSUNEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESPPSUNEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESPPSUNEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPPSUNEXP];
GO
IF OBJECT_ID('U_ESPPSUNEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_File];
GO
IF OBJECT_ID('U_ESPPSUNEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_EEList];
GO
IF OBJECT_ID('U_ESPPSUNEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_drvTbl];
GO
IF OBJECT_ID('U_ESPPSUNEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_DedList];
GO
IF OBJECT_ID('U_ESPPSUNEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_AuditFields];
GO
IF OBJECT_ID('U_ESPPSUNEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESPPSUNEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESPPSUNEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESPPSUNEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESPPSUNEXP','Sunlife Absence File Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','ESPPSUNEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESPPSUNEXPZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESPPSUNEXPZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESPPSUNEXPZ0','50','H','01','3',NULL,'Employee Title',NULL,NULL,'"Employee Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESPPSUNEXPZ0','50','H','01','4',NULL,'Employee First Name',NULL,NULL,'"Employee First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESPPSUNEXPZ0','50','H','01','5',NULL,'Employee Middle Name',NULL,NULL,'"Employee Middle Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESPPSUNEXPZ0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL,'"Employee Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESPPSUNEXPZ0','50','H','01','7',NULL,'Employee Gender',NULL,NULL,'"Employee Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESPPSUNEXPZ0','50','H','01','8',NULL,'Employee Date of Birth',NULL,NULL,'"Employee Date of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESPPSUNEXPZ0','50','H','01','9',NULL,'Employee Home Address Line 1',NULL,NULL,'"Employee Home Address Line 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESPPSUNEXPZ0','50','H','01','10',NULL,'Employee Home Address Line 2',NULL,NULL,'"Employee Home Address Line 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESPPSUNEXPZ0','50','H','01','11',NULL,'Employee Home City',NULL,NULL,'"Employee Home City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESPPSUNEXPZ0','50','H','01','12',NULL,'Employee Home State',NULL,NULL,'"Employee Home State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESPPSUNEXPZ0','50','H','01','13',NULL,'Employee Home Zip Code',NULL,NULL,'"Employee Home Zip Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESPPSUNEXPZ0','50','H','01','14',NULL,'Employee County',NULL,NULL,'"Employee County"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESPPSUNEXPZ0','50','H','01','15',NULL,'Employee Country',NULL,NULL,'"Employee Country"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESPPSUNEXPZ0','50','H','01','16',NULL,'Employee Home Phone Number',NULL,NULL,'"Employee Home Phone Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESPPSUNEXPZ0','50','H','01','17',NULL,'Employee Mobile Phone Number',NULL,NULL,'"Employee Mobile Phone Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESPPSUNEXPZ0','50','H','01','18',NULL,'Primary Phone Type',NULL,NULL,'"Primary Phone Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESPPSUNEXPZ0','50','H','01','19',NULL,'Employee Email Address',NULL,NULL,'"Employee Email Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESPPSUNEXPZ0','50','H','01','20',NULL,'Employee Work Email Address',NULL,NULL,'"Employee Work Email Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESPPSUNEXPZ0','50','H','01','21',NULL,'Employee Work State',NULL,NULL,'"Employee Work State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESPPSUNEXPZ0','50','H','01','22',NULL,'Employee Original Date of Hire',NULL,NULL,'"Employee Original Date of Hire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESPPSUNEXPZ0','50','H','01','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL,'"Employee Most Recent Date of Hire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESPPSUNEXPZ0','50','H','01','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL,'"Employee Adjusted Date of Hire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESPPSUNEXPZ0','50','H','01','25',NULL,'Employee Job Title',NULL,NULL,'"Employee Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESPPSUNEXPZ0','50','H','01','26',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESPPSUNEXPZ0','50','H','01','27',NULL,'Full Time/Part Time Status',NULL,NULL,'"Full Time/Part Time Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESPPSUNEXPZ0','50','H','01','28',NULL,'Exempt Status',NULL,NULL,'"Exempt Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESPPSUNEXPZ0','50','H','01','29',NULL,'Compensation Method',NULL,NULL,'"Compensation Method"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESPPSUNEXPZ0','50','H','01','30',NULL,'Union Type',NULL,NULL,'"Union Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESPPSUNEXPZ0','50','H','01','31',NULL,'Union Name',NULL,NULL,'"Union Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESPPSUNEXPZ0','50','H','01','32',NULL,'Scheduled Hours per Week',NULL,NULL,'"Scheduled Hours per Week"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESPPSUNEXPZ0','50','H','01','33',NULL,'Scheduled Days per Week',NULL,NULL,'"Scheduled Days per Week"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESPPSUNEXPZ0','50','H','01','34',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESPPSUNEXPZ0','50','H','01','35',NULL,'Work Site Name',NULL,NULL,'"Work Site Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESPPSUNEXPZ0','50','H','01','36',NULL,'Organization Unit',NULL,NULL,'"Organization Unit "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESPPSUNEXPZ0','50','H','01','37',NULL,'Business Unit',NULL,NULL,'"Business Unit"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESPPSUNEXPZ0','50','H','01','38',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESPPSUNEXPZ0','50','H','01','39',NULL,'Group Type',NULL,NULL,'"Group Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESPPSUNEXPZ0','50','H','01','40',NULL,'Employee Earning',NULL,NULL,'"Employee Earning"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESPPSUNEXPZ0','50','H','01','41',NULL,'Earnings Frequency',NULL,NULL,'"Earnings Frequency"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESPPSUNEXPZ0','50','H','01','42',NULL,'Earnings Effective Date',NULL,NULL,'"Earnings Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESPPSUNEXPZ0','50','H','01','43',NULL,'STD Weekly Earnings',NULL,NULL,'"STD Weekly Earnings"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESPPSUNEXPZ0','50','H','01','44',NULL,'LTD Monthly Earnings',NULL,NULL,'"LTD Monthly Earnings"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESPPSUNEXPZ0','50','H','01','45',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESPPSUNEXPZ0','50','H','01','46',NULL,'STD Employee Earnings Amount',NULL,NULL,'"STD Employee Earnings Amount"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESPPSUNEXPZ0','50','H','01','47',NULL,'STD Earnings Frequency',NULL,NULL,'"STD Earnings Frequency"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESPPSUNEXPZ0','50','H','01','48',NULL,'STD Earnings Effective Date',NULL,NULL,'"STD Earnings Effective Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESPPSUNEXPZ0','50','H','01','49',NULL,'STD Eligibility Date',NULL,NULL,'"STD Eligibility Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESPPSUNEXPZ0','50','H','01','50',NULL,'STD Election',NULL,NULL,'"STD Election"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESPPSUNEXPZ0','50','H','01','51',NULL,'STD Benefit Amount',NULL,NULL,'"STD Benefit Amount"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESPPSUNEXPZ0','50','H','01','52',NULL,'STD Class',NULL,NULL,'"STD Class"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESPPSUNEXPZ0','50','H','01','53',NULL,'STD Termination Date',NULL,NULL,'"STD Termination Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESPPSUNEXPZ0','50','H','01','54',NULL,'Statutory Disability Type',NULL,NULL,'"Statutory Disability Type"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESPPSUNEXPZ0','50','H','01','55',NULL,'LTD Eligibility Date',NULL,NULL,'"LTD Eligibility Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESPPSUNEXPZ0','50','H','01','56',NULL,'LTD Election',NULL,NULL,'"LTD Election"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESPPSUNEXPZ0','50','H','01','57',NULL,'LTD Benefit Amount',NULL,NULL,'"LTD Benefit Amount"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESPPSUNEXPZ0','50','H','01','58',NULL,'LTD Class',NULL,NULL,'"LTD Class"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESPPSUNEXPZ0','50','H','01','59',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESPPSUNEXPZ0','50','H','01','60',NULL,'Policy Number',NULL,NULL,'"Policy Number"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESPPSUNEXPZ0','50','H','01','61',NULL,'Key Employee Indicator',NULL,NULL,'"Key Employee Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESPPSUNEXPZ0','50','H','01','62',NULL,'Work At Home Indicator',NULL,NULL,'"Work At Home Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESPPSUNEXPZ0','50','H','01','63',NULL,'50 In 75 Rule Indicator',NULL,NULL,'"50 In 75 Rule Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESPPSUNEXPZ0','50','H','01','64',NULL,'Hours Worked Previous 12 Months',NULL,NULL,'"Hours Worked Previous 12 Months"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESPPSUNEXPZ0','50','H','01','65',NULL,'Supervisor Employee ID',NULL,NULL,'"Supervisor Employee ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESPPSUNEXPZ0','50','H','01','66',NULL,'Supervisor First Name',NULL,NULL,'"Supervisor First Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESPPSUNEXPZ0','50','H','01','67',NULL,'Supervisor Last Name',NULL,NULL,'"Supervisor Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESPPSUNEXPZ0','50','H','01','68',NULL,'Occupation Qualifier1',NULL,NULL,'"Occupation Qualifier1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESPPSUNEXPZ0','50','H','01','69',NULL,'Occupation Qualifier2',NULL,NULL,'"Occupation Qualifier2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESPPSUNEXPZ0','50','H','01','70',NULL,'Occupation Qualifier3',NULL,NULL,'"Occupation Qualifier3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESPPSUNEXPZ0','50','H','01','71',NULL,'Occupation Qualifier4',NULL,NULL,'"Occupation Qualifier4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESPPSUNEXPZ0','50','H','01','72',NULL,'Occupation Qualifier5',NULL,NULL,'"Occupation Qualifier5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESPPSUNEXPZ0','50','H','01','73',NULL,'Occupation Qualifier6',NULL,NULL,'"Occupation Qualifier6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESPPSUNEXPZ0','50','H','01','74',NULL,'Occupation Qualifier7',NULL,NULL,'"Occupation Qualifier7"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESPPSUNEXPZ0','50','H','01','75',NULL,'Occupation Qualifier8',NULL,NULL,'"Occupation Qualifier8"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESPPSUNEXPZ0','50','H','01','76',NULL,'Occupation Qualifier9',NULL,NULL,'"Occupation Qualifier9"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESPPSUNEXPZ0','50','H','01','77',NULL,'Occupation Qualifier10',NULL,NULL,'"Occupation Qualifier10"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESPPSUNEXPZ0','50','H','01','78',NULL,'Employer Contact 1',NULL,NULL,'"Employer Contact 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESPPSUNEXPZ0','50','H','01','79',NULL,'Employer Contact 2',NULL,NULL,'"Employer Contact 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESPPSUNEXPZ0','50','H','01','80',NULL,'Employer Contact 3',NULL,NULL,'"Employer Contact 3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESPPSUNEXPZ0','50','H','01','81',NULL,'Employer Contact 4',NULL,NULL,'"Employer Contact 4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESPPSUNEXPZ0','50','H','01','82',NULL,'Employer Contact 5',NULL,NULL,'"Employer Contact 5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESPPSUNEXPZ0','50','H','01','83',NULL,'Employer Contact 6',NULL,NULL,'"Employer Contact 6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESPPSUNEXPZ0','50','H','01','84',NULL,'Employer Contact 7',NULL,NULL,'"Employer Contact 7"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ESPPSUNEXPZ0','50','H','01','85',NULL,'Employer Contact 8',NULL,NULL,'"Employer Contact 8"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ESPPSUNEXPZ0','50','H','01','86',NULL,'Employer Contact 9',NULL,NULL,'"Employer Contact 9"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ESPPSUNEXPZ0','50','H','01','87',NULL,'Employer Contact 10',NULL,NULL,'"Employer Contact 10"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ESPPSUNEXPZ0','50','H','01','88',NULL,'Reporting Field1',NULL,NULL,'"Reporting Field1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ESPPSUNEXPZ0','50','H','01','89',NULL,'Reporting Field2',NULL,NULL,'"Reporting Field2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ESPPSUNEXPZ0','50','H','01','90',NULL,'Reporting Field3',NULL,NULL,'"Reporting Field3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ESPPSUNEXPZ0','50','H','01','91',NULL,'Reporting Field4',NULL,NULL,'"Reporting Field4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ESPPSUNEXPZ0','50','H','01','92',NULL,'Reporting Field5',NULL,NULL,'"Reporting Field5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ESPPSUNEXPZ0','50','H','01','93',NULL,'Spouse Date of Change',NULL,NULL,'"Spouse Date of Change"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ESPPSUNEXPZ0','50','H','01','94',NULL,'Spouse First Name',NULL,NULL,'"Spouse First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ESPPSUNEXPZ0','50','H','01','95',NULL,'Spouse Last Name',NULL,NULL,'"Spouse Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ESPPSUNEXPZ0','50','H','01','96',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ESPPSUNEXPZ0','50','H','01','97',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ESPPSUNEXPZ0','50','H','01','98',NULL,'Spouse Employee ID',NULL,NULL,'"Spouse Employee ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ESPPSUNEXPZ0','50','H','01','99',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ESPPSUNEXPZ0','50','H','01','100',NULL,'Spouse Reason of Change',NULL,NULL,'"Spouse Reason of Change"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ESPPSUNEXPZ0','50','H','01','101',NULL,'Employment Class',NULL,NULL,'"Employment Class"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ESPPSUNEXPZ0','50','H','01','102',NULL,'Employment Strength',NULL,NULL,'"Employment Strength"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESPPSUNEXPZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESPPSUNEXPZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESPPSUNEXPZ0','50','D','10','3',NULL,'Employee Title',NULL,NULL,'"drvEmployeeTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESPPSUNEXPZ0','50','D','10','4',NULL,'Employee First Name',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESPPSUNEXPZ0','50','D','10','5',NULL,'Employee Middle Name',NULL,NULL,'"drvEmployeeMiddleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESPPSUNEXPZ0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESPPSUNEXPZ0','50','D','10','7',NULL,'Employee Gender',NULL,NULL,'"drvEmployeeGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESPPSUNEXPZ0','50','D','10','8',NULL,'Employee Date of Birth',NULL,NULL,'"drvEmployeeDateofBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESPPSUNEXPZ0','50','D','10','9',NULL,'Employee Home Address Line 1',NULL,NULL,'"drvEmployeeHomeAddLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESPPSUNEXPZ0','50','D','10','10',NULL,'Employee Home Address Line 2',NULL,NULL,'"drvEmployeeHomeAddLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESPPSUNEXPZ0','50','D','10','11',NULL,'Employee Home City',NULL,NULL,'"drvEmployeeHomeCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESPPSUNEXPZ0','50','D','10','12',NULL,'Employee Home State',NULL,NULL,'"drvEmployeeHomeState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESPPSUNEXPZ0','50','D','10','13',NULL,'Employee Home Zip Code',NULL,NULL,'"drvEmployeeHomeZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESPPSUNEXPZ0','50','D','10','14',NULL,'Employee County',NULL,NULL,'"drvEmployeeCounty"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESPPSUNEXPZ0','50','D','10','15',NULL,'Employee Country',NULL,NULL,'"drvEmployeeCountry"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESPPSUNEXPZ0','50','D','10','16',NULL,'Employee Home Phone Number',NULL,NULL,'"drvEmployeeHomePhoneNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESPPSUNEXPZ0','50','D','10','17',NULL,'Employee Mobile Phone Number',NULL,NULL,'"drvEmployeeMobilePhoneNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESPPSUNEXPZ0','50','D','10','18',NULL,'Primary Phone Type',NULL,NULL,'"drvPrimaryPhoneType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESPPSUNEXPZ0','50','D','10','19',NULL,'Employee Email Address',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESPPSUNEXPZ0','50','D','10','20',NULL,'Employee Work Email Address',NULL,NULL,'"drvEmployeeWorkEmailAddress"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESPPSUNEXPZ0','50','D','10','21',NULL,'Employee Work State',NULL,NULL,'"drvEmployeeWorkState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESPPSUNEXPZ0','50','D','10','22',NULL,'Employee Original Date of Hire',NULL,NULL,'"drvEmployeeOriginalDateofHire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESPPSUNEXPZ0','50','D','10','23',NULL,'Employee Most Recent Date of Hire',NULL,NULL,'"drvEmployeeMostRecentDOH"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESPPSUNEXPZ0','50','D','10','24',NULL,'Employee Adjusted Date of Hire',NULL,NULL,'"drvEmployeeAdjustedDateofHire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESPPSUNEXPZ0','50','D','10','25',NULL,'Employee Job Title',NULL,NULL,'"drvEmployeeJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESPPSUNEXPZ0','50','D','10','26',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESPPSUNEXPZ0','50','D','10','27',NULL,'Full Time/Part Time Status',NULL,NULL,'"drvFullTimePartTimeStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESPPSUNEXPZ0','50','D','10','28',NULL,'Exempt Status',NULL,NULL,'"drvExemptStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESPPSUNEXPZ0','50','D','10','29',NULL,'Compensation Method',NULL,NULL,'"drvCompensationMethod"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESPPSUNEXPZ0','50','D','10','30',NULL,'Union Type',NULL,NULL,'"drvUnionType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESPPSUNEXPZ0','50','D','10','31',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESPPSUNEXPZ0','50','D','10','32',NULL,'Scheduled Hours per Week',NULL,NULL,'"drvScheduledHoursperWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESPPSUNEXPZ0','50','D','10','33',NULL,'Scheduled Days per Week',NULL,NULL,'"drvScheduledDaysperWeek"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESPPSUNEXPZ0','50','D','10','34',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESPPSUNEXPZ0','50','D','10','35',NULL,'Work Site Name',NULL,NULL,'"drvWorkSiteName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESPPSUNEXPZ0','50','D','10','36',NULL,'Organization Unit',NULL,NULL,'"drvOrganizationUnit"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESPPSUNEXPZ0','50','D','10','37',NULL,'Business Unit',NULL,NULL,'"drvBusinessUnit"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESPPSUNEXPZ0','50','D','10','38',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESPPSUNEXPZ0','50','D','10','39',NULL,'Group Type',NULL,NULL,'"drvGroupType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESPPSUNEXPZ0','50','D','10','40',NULL,'Employee Earning',NULL,NULL,'"drvEmployeeEarning"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESPPSUNEXPZ0','50','D','10','41',NULL,'Earnings Frequency',NULL,NULL,'"drvEarningsFrequency"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESPPSUNEXPZ0','50','D','10','42',NULL,'Earnings Effective Date',NULL,NULL,'"drvEarningsEffectiveDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESPPSUNEXPZ0','50','D','10','43',NULL,'STD Weekly Earnings',NULL,NULL,'"drvSTDWeeklyEarnings"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESPPSUNEXPZ0','50','D','10','44',NULL,'LTD Monthly Earnings',NULL,NULL,'"drvLTDMonthlyEarnings"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESPPSUNEXPZ0','50','D','10','45',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESPPSUNEXPZ0','50','D','10','46',NULL,'STD Employee Earnings Amount',NULL,NULL,'"drvSTDEmployeeEarningsAmount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESPPSUNEXPZ0','50','D','10','47',NULL,'STD Earnings Frequency',NULL,NULL,'"drvSTDEarningsFrequency"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESPPSUNEXPZ0','50','D','10','48',NULL,'STD Earnings Effective Date',NULL,NULL,'"drvSTDEarningsEffectiveDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESPPSUNEXPZ0','50','D','10','49',NULL,'STD Eligibility Date',NULL,NULL,'"drvSTDEligibilityDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESPPSUNEXPZ0','50','D','10','50',NULL,'STD Election',NULL,NULL,'"drvSTDElection"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESPPSUNEXPZ0','50','D','10','51',NULL,'STD Benefit Amount',NULL,NULL,'"drvSTDBenefitAmount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESPPSUNEXPZ0','50','D','10','52',NULL,'STD Class',NULL,NULL,'"drvSTDClass"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESPPSUNEXPZ0','50','D','10','53',NULL,'STD Termination Date',NULL,NULL,'"drvSTDTerminationDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESPPSUNEXPZ0','50','D','10','54',NULL,'Statutory Disability Type',NULL,NULL,'"drvStatutoryDisabilityType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESPPSUNEXPZ0','50','D','10','55',NULL,'LTD Eligibility Date',NULL,NULL,'"drvLTDEligibilityDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESPPSUNEXPZ0','50','D','10','56',NULL,'LTD Election',NULL,NULL,'"drvLTDElection"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESPPSUNEXPZ0','50','D','10','57',NULL,'LTD Benefit Amount',NULL,NULL,'"drvLTDBenefitAmount"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESPPSUNEXPZ0','50','D','10','58',NULL,'LTD Class',NULL,NULL,'"drvLTDClass"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ESPPSUNEXPZ0','50','D','10','59',NULL,'LTD Termination Date',NULL,NULL,'"drvLTDTerminationDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ESPPSUNEXPZ0','50','D','10','60',NULL,'Policy Number',NULL,NULL,'"drvPolicyNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ESPPSUNEXPZ0','50','D','10','61',NULL,'Key Employee Indicator',NULL,NULL,'"drvKeyEmployeeIndicator"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ESPPSUNEXPZ0','50','D','10','62',NULL,'Work At Home Indicator',NULL,NULL,'"drvWorkAtHomeIndicator"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ESPPSUNEXPZ0','50','D','10','63',NULL,'50 In 75 Rule Indicator',NULL,NULL,'"drv50In75RuleIndicator"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ESPPSUNEXPZ0','50','D','10','64',NULL,'Hours Worked Previous 12 Months',NULL,NULL,'"drvHoursWorkedPrevious12Mos"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ESPPSUNEXPZ0','50','D','10','65',NULL,'Supervisor Employee ID',NULL,NULL,'"drvSupervisorEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ESPPSUNEXPZ0','50','D','10','66',NULL,'Supervisor First Name',NULL,NULL,'"drvSupervisorFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ESPPSUNEXPZ0','50','D','10','67',NULL,'Supervisor Last Name',NULL,NULL,'"drvSupervisorLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ESPPSUNEXPZ0','50','D','10','68',NULL,'Occupation Qualifier1',NULL,NULL,'"drvOccupationQualifier1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ESPPSUNEXPZ0','50','D','10','69',NULL,'Occupation Qualifier2',NULL,NULL,'"drvOccupationQualifier2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ESPPSUNEXPZ0','50','D','10','70',NULL,'Occupation Qualifier3',NULL,NULL,'"drvOccupationQualifier3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ESPPSUNEXPZ0','50','D','10','71',NULL,'Occupation Qualifier4',NULL,NULL,'"drvOccupationQualifier4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ESPPSUNEXPZ0','50','D','10','72',NULL,'Occupation Qualifier5',NULL,NULL,'"drvOccupationQualifier5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ESPPSUNEXPZ0','50','D','10','73',NULL,'Occupation Qualifier6',NULL,NULL,'"drvOccupationQualifier6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ESPPSUNEXPZ0','50','D','10','74',NULL,'Occupation Qualifier7',NULL,NULL,'"drvOccupationQualifier7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ESPPSUNEXPZ0','50','D','10','75',NULL,'Occupation Qualifier8',NULL,NULL,'"drvOccupationQualifier8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ESPPSUNEXPZ0','50','D','10','76',NULL,'Occupation Qualifier9',NULL,NULL,'"drvOccupationQualifier9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ESPPSUNEXPZ0','50','D','10','77',NULL,'Occupation Qualifier10',NULL,NULL,'"drvOccupationQualifier10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ESPPSUNEXPZ0','50','D','10','78',NULL,'Employer Contact 1',NULL,NULL,'"drvEmployerContact1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ESPPSUNEXPZ0','50','D','10','79',NULL,'Employer Contact 2',NULL,NULL,'"drvEmployerContact2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ESPPSUNEXPZ0','50','D','10','80',NULL,'Employer Contact 3',NULL,NULL,'"drvEmployerContact3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ESPPSUNEXPZ0','50','D','10','81',NULL,'Employer Contact 4',NULL,NULL,'"drvEmployerContact4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ESPPSUNEXPZ0','50','D','10','82',NULL,'Employer Contact 5',NULL,NULL,'"drvEmployerContact5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ESPPSUNEXPZ0','50','D','10','83',NULL,'Employer Contact 6',NULL,NULL,'"drvEmployerContact6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ESPPSUNEXPZ0','50','D','10','84',NULL,'Employer Contact 7',NULL,NULL,'"drvEmployerContact7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ESPPSUNEXPZ0','50','D','10','85',NULL,'Employer Contact 8',NULL,NULL,'"drvEmployerContact8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ESPPSUNEXPZ0','50','D','10','86',NULL,'Employer Contact 9',NULL,NULL,'"drvEmployerContact9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ESPPSUNEXPZ0','50','D','10','87',NULL,'Employer Contact 10',NULL,NULL,'"drvEmployerContact10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ESPPSUNEXPZ0','50','D','10','88',NULL,'Reporting Field1',NULL,NULL,'"drvReportingField1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ESPPSUNEXPZ0','50','D','10','89',NULL,'Reporting Field2',NULL,NULL,'"drvReportingField2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ESPPSUNEXPZ0','50','D','10','90',NULL,'Reporting Field3',NULL,NULL,'"drvReportingField3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ESPPSUNEXPZ0','50','D','10','91',NULL,'Reporting Field4',NULL,NULL,'"drvReportingField4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ESPPSUNEXPZ0','50','D','10','92',NULL,'Reporting Field5',NULL,NULL,'"drvReportingField5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ESPPSUNEXPZ0','50','D','10','93',NULL,'Spouse Date of Change',NULL,NULL,'"drvSpouseDateofChange"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ESPPSUNEXPZ0','50','D','10','94',NULL,'Spouse First Name',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ESPPSUNEXPZ0','50','D','10','95',NULL,'Spouse Last Name',NULL,NULL,'"drvSpouseLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ESPPSUNEXPZ0','50','D','10','96',NULL,'Spouse Date of Birth',NULL,NULL,'"drvSpouseDateofBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ESPPSUNEXPZ0','50','D','10','97',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ESPPSUNEXPZ0','50','D','10','98',NULL,'Spouse Employee ID',NULL,NULL,'"drvSpouseEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ESPPSUNEXPZ0','50','D','10','99',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ESPPSUNEXPZ0','50','D','10','100',NULL,'Spouse Reason of Change',NULL,NULL,'"drvSpouseReasonofChange"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ESPPSUNEXPZ0','50','D','10','101',NULL,'Employment Class',NULL,NULL,'"drvEmploymentClass"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ESPPSUNEXPZ0','50','D','10','102',NULL,'Employment Strength',NULL,NULL,'"drvEmploymentStrength"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESPPSUNEXP_20220107.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202201069','EMPEXPORT','OEACTIVE',NULL,'ESPPSUNEXP',NULL,NULL,NULL,'202201069','Jan  6 2022  4:03PM','Jan  6 2022  4:03PM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202201069','EMPEXPORT','OEPASSIVE',NULL,'ESPPSUNEXP',NULL,NULL,NULL,'202201069','Jan  6 2022  4:03PM','Jan  6 2022  4:03PM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Absense File Export','202201069','EMPEXPORT','ONDEM_XOE',NULL,'ESPPSUNEXP',NULL,NULL,NULL,'202201069','Jan  6 2022  4:03PM','Jan  6 2022  4:03PM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Absense File Exp-Sched','202201069','EMPEXPORT','SCH_ESPPSU',NULL,'ESPPSUNEXP',NULL,NULL,NULL,'202201069','Jan  6 2022  4:03PM','Jan  6 2022  4:03PM','202201061',NULL,'','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Sunlife Absense File Exp-Test','202201069','EMPEXPORT','TEST_XOE','Jan  7 2022 11:25PM','ESPPSUNEXP',NULL,NULL,NULL,'202201069','Jan  6 2022  4:03PM','Jan  6 2022  4:03PM','202201061','734','','','202201061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','IsUTF','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPPSUNEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPPSUNEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPPSUNEXP','D10','dbo.U_ESPPSUNEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESPPSUNEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ESPPSUNEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESPPSUNEXP] (
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
-- Create table U_ESPPSUNEXP_Audit
-----------

IF OBJECT_ID('U_ESPPSUNEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_ESPPSUNEXP_AuditFields
-----------

IF OBJECT_ID('U_ESPPSUNEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_ESPPSUNEXP_DedList
-----------

IF OBJECT_ID('U_ESPPSUNEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESPPSUNEXP_drvTbl
-----------

IF OBJECT_ID('U_ESPPSUNEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeTitle] varchar(1) NOT NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(1) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeGender] varchar(1) NULL,
    [drvEmployeeDateofBirth] datetime NULL,
    [drvEmployeeHomeAddLine1] varchar(255) NULL,
    [drvEmployeeHomeAddLine2] varchar(255) NULL,
    [drvEmployeeHomeCity] varchar(255) NULL,
    [drvEmployeeHomeState] varchar(255) NULL,
    [drvEmployeeHomeZipCode] varchar(50) NULL,
    [drvEmployeeCounty] varchar(1) NOT NULL,
    [drvEmployeeCountry] varchar(1) NOT NULL,
    [drvEmployeeHomePhoneNumber] varchar(50) NULL,
    [drvEmployeeMobilePhoneNumber] varchar(50) NULL,
    [drvPrimaryPhoneType] varchar(1) NOT NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL,
    [drvEmployeeWorkEmailAddress] varchar(1) NOT NULL,
    [drvEmployeeWorkState] varchar(255) NULL,
    [drvEmployeeOriginalDateofHire] datetime NULL,
    [drvEmployeeMostRecentDOH] datetime NULL,
    [drvEmployeeAdjustedDateofHire] varchar(1) NOT NULL,
    [drvEmployeeJobTitle] varchar(25) NOT NULL,
    [drvEmploymentStatus] varchar(2) NULL,
    [drvFullTimePartTimeStatus] varchar(1) NULL,
    [drvExemptStatus] varchar(1) NOT NULL,
    [drvCompensationMethod] varchar(1) NOT NULL,
    [drvUnionType] varchar(1) NOT NULL,
    [drvUnionName] varchar(1) NOT NULL,
    [drvScheduledHoursperWeek] varchar(2) NOT NULL,
    [drvScheduledDaysperWeek] varchar(1) NOT NULL,
    [drvEmploymentType] varchar(1) NOT NULL,
    [drvWorkSiteName] varchar(26) NOT NULL,
    [drvOrganizationUnit] varchar(1) NOT NULL,
    [drvBusinessUnit] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvGroupType] varchar(1) NOT NULL,
    [drvEmployeeEarning] varchar(30) NULL,
    [drvEarningsFrequency] varchar(6) NOT NULL,
    [drvEarningsEffectiveDate] datetime NULL,
    [drvSTDWeeklyEarnings] varchar(1) NOT NULL,
    [drvLTDMonthlyEarnings] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvSTDEmployeeEarningsAmount] varchar(1) NOT NULL,
    [drvSTDEarningsFrequency] varchar(1) NOT NULL,
    [drvSTDEarningsEffectiveDate] varchar(1) NOT NULL,
    [drvSTDEligibilityDate] datetime NULL,
    [drvSTDElection] varchar(1) NOT NULL,
    [drvSTDBenefitAmount] varchar(1) NOT NULL,
    [drvSTDClass] varchar(1) NOT NULL,
    [drvSTDTerminationDate] datetime NULL,
    [drvStatutoryDisabilityType] varchar(1) NOT NULL,
    [drvLTDEligibilityDate] datetime NULL,
    [drvLTDElection] varchar(1) NOT NULL,
    [drvLTDBenefitAmount] varchar(1) NOT NULL,
    [drvLTDClass] varchar(1) NOT NULL,
    [drvLTDTerminationDate] datetime NULL,
    [drvPolicyNumber] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvWorkAtHomeIndicator] varchar(1) NOT NULL,
    [drv50In75RuleIndicator] varchar(1) NOT NULL,
    [drvHoursWorkedPrevious12Mos] varchar(1) NOT NULL,
    [drvSupervisorEmployeeID] varchar(1) NOT NULL,
    [drvSupervisorFirstName] varchar(1) NOT NULL,
    [drvSupervisorLastName] varchar(1) NOT NULL,
    [drvOccupationQualifier1] varchar(1) NOT NULL,
    [drvOccupationQualifier2] varchar(1) NOT NULL,
    [drvOccupationQualifier3] varchar(1) NOT NULL,
    [drvOccupationQualifier4] varchar(1) NOT NULL,
    [drvOccupationQualifier5] varchar(1) NOT NULL,
    [drvOccupationQualifier6] varchar(1) NOT NULL,
    [drvOccupationQualifier7] varchar(1) NOT NULL,
    [drvOccupationQualifier8] varchar(1) NOT NULL,
    [drvOccupationQualifier9] varchar(1) NOT NULL,
    [drvOccupationQualifier10] varchar(1) NOT NULL,
    [drvEmployerContact1] varchar(1) NOT NULL,
    [drvEmployerContact2] varchar(1) NOT NULL,
    [drvEmployerContact3] varchar(1) NOT NULL,
    [drvEmployerContact4] varchar(1) NOT NULL,
    [drvEmployerContact5] varchar(1) NOT NULL,
    [drvEmployerContact6] varchar(1) NOT NULL,
    [drvEmployerContact7] varchar(1) NOT NULL,
    [drvEmployerContact8] varchar(1) NOT NULL,
    [drvEmployerContact9] varchar(1) NOT NULL,
    [drvEmployerContact10] varchar(1) NOT NULL,
    [drvReportingField1] varchar(25) NULL,
    [drvReportingField2] char(10) NULL,
    [drvReportingField3] varchar(1) NOT NULL,
    [drvReportingField4] varchar(1) NOT NULL,
    [drvReportingField5] varchar(1) NOT NULL,
    [drvSpouseDateofChange] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(1) NOT NULL,
    [drvSpouseLastName] varchar(1) NOT NULL,
    [drvSpouseDateofBirth] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSpouseEmployeeID] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvSpouseReasonofChange] varchar(1) NOT NULL,
    [drvEmploymentClass] varchar(1) NOT NULL,
    [drvEmploymentStrength] varchar(1) NOT NULL
);

-----------
-- Create table U_ESPPSUNEXP_EEList
-----------

IF OBJECT_ID('U_ESPPSUNEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESPPSUNEXP_File
-----------

IF OBJECT_ID('U_ESPPSUNEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESPPSUNEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPPSUNEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Soutwest Power Tool

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 01/06/2022
Service Request Number: TekP-2021-10-26-0004

Purpose: Sunlife Absense File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESPPSUNEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESPPSUNEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESPPSUNEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESPPSUNEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESPPSUNEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPPSUNEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPPSUNEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPPSUNEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPPSUNEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPPSUNEXP', 'SCH_ESPPSU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESPPSUNEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESPPSUNEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@MinDate datetime

    -- Set FormatCode
    SELECT @FormatCode = 'ESPPSUNEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinDate          = CAST('1/1/2022' as Datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESPPSUNEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESPPSUNEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

       DELETE FROM dbo.U_ESPPSUNEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (Select eeceeid from dbo.EmpComp with (nolock) where eeceetype = 'TES');


    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '9002,9000,9001';

    IF OBJECT_ID('U_ESPPSUNEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESPPSUNEXP_DedList
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
    /*
    IF OBJECT_ID('U_ESPPSUNEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_PDedHist;
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
    INTO dbo.U_ESPPSUNEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESPPSUNEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESPPSUNEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_PEarHist;
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
    INTO dbo.U_ESPPSUNEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    */
     --Audit Table
    IF OBJECT_ID('U_ESPPSUNEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_AuditFields;
    CREATE TABLE dbo.U_ESPPSUNEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESPPSUNEXP_AuditFields VALUES ('EmpComp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESPPSUNEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_ESPPSUNEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESPPSUNEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESPPSUNEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESPPSUNEXP_Audit ON dbo.U_ESPPSUNEXP_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESPPSUNEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPPSUNEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPPSUNEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeTitle = ''
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleName = LEFT(EepNameMiddle,1)
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeGender = CASE WHEN EepGender in ('M','F') THEN EepGender ELSE 'U' END
        ,drvEmployeeDateofBirth = EepDateOfBirth
        ,drvEmployeeHomeAddLine1 = EepAddressLine1
        ,drvEmployeeHomeAddLine2 = EepAddressLine2
        ,drvEmployeeHomeCity = EepAddressCity
        ,drvEmployeeHomeState = EepAddressState
        ,drvEmployeeHomeZipCode = EepAddressZipCode
        ,drvEmployeeCounty = ''
        ,drvEmployeeCountry = ''
        ,drvEmployeeHomePhoneNumber = EepPhoneHomeNumber
        ,drvEmployeeMobilePhoneNumber = (Select top 1 efoPhoneNumber from dbo.EmpMPhon WITH (NOLOCK) where efoPhoneType = 'CEL' and efoEEID = xEEID )
        ,drvPrimaryPhoneType = ''
        ,drvEmployeeEmailAddress = eepAddressEMailAlternate
        ,drvEmployeeWorkEmailAddress = ''
        ,drvEmployeeWorkState = LocAddressState
        ,drvEmployeeOriginalDateofHire = EecDateOfOriginalHire
        ,drvEmployeeMostRecentDOH = EecDateOfLastHire
        ,drvEmployeeAdjustedDateofHire = ''
        ,drvEmployeeJobTitle = JbcDesc
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus  IN ('A') THEN 'AE'
                                    WHEN EecEmplStatus in ('L') THEN 'OL'
                                    WHEN EecEmplStatus IN ('O', 'R') THEN 'IN' 
                                    WHEN EecEmplStatus = 'S' THEN 'SU'
                                    WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN 'RT'
                                    WHEN EecEmplStatus = 'T' THEN 'TE'
                                END
        ,drvFullTimePartTimeStatus = CASE WHEN EecFullTimeOrPartTime in ('F') THEN 'F'
                                          WHEN EecFullTimeOrPartTime in ('P') THEN 'P'
                               END
        ,drvExemptStatus = ''
        ,drvCompensationMethod = ''
        ,drvUnionType = ''
        ,drvUnionName = ''
        ,drvScheduledHoursperWeek = '40'
        ,drvScheduledDaysperWeek = '5'
        ,drvEmploymentType = ''
        ,drvWorkSiteName = 'Southwest Power Pool, Inc.'
        ,drvOrganizationUnit = ''
        ,drvBusinessUnit = ''
        ,drvDivision = ''
        ,drvGroupType = ''
        ,drvEmployeeEarning = CAST(eecAnnSalary as varchar)
        ,drvEarningsFrequency = 'Annual'
        ,drvEarningsEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateOfLastHire)     
        ,drvSTDWeeklyEarnings = ''
        ,drvLTDMonthlyEarnings = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSTDEmployeeEarningsAmount = ''
        ,drvSTDEarningsFrequency = ''
        ,drvSTDEarningsEffectiveDate = ''
        ,drvSTDEligibilityDate = CASE WHEN STD Is NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',STD_StartDate, @MinDate)  END
        ,drvSTDElection = ''
        ,drvSTDBenefitAmount = ''
        ,drvSTDClass = ''
        ,drvSTDTerminationDate = CASE WHEN STD Is NOT NULL THEN STD_StopDate END
        ,drvStatutoryDisabilityType = ''
        ,drvLTDEligibilityDate = CASE WHEN LTD Is NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',LTD_StartDate, @MinDate) END
        ,drvLTDElection = ''
        ,drvLTDBenefitAmount = ''
        ,drvLTDClass = CASE WHEN EecJobCode in ('CNTR', 'EXDIRIR', 'EXDRMM', 'HRDHR', 'ITENTARC', 'PRESCEO', 'PRESCEOE') or EecJobCode like 'DIR%' or EecJobCode like 'ITDIR%' or EecJobCode like '%VP%' THEN '1' ELSE '2' END
        ,drvLTDTerminationDate = CASE WHEN LTD Is NOT NULL THEN LTD_StopDate END
        ,drvPolicyNumber = ''
        ,drvKeyEmployeeIndicator = 'N'
        ,drvWorkAtHomeIndicator = ''
        ,drv50In75RuleIndicator = 'Y'
        ,drvHoursWorkedPrevious12Mos = ''
        ,drvSupervisorEmployeeID = ''
        ,drvSupervisorFirstName = ''
        ,drvSupervisorLastName = ''
        ,drvOccupationQualifier1 = ''
        ,drvOccupationQualifier2 = ''
        ,drvOccupationQualifier3 = ''
        ,drvOccupationQualifier4 = ''
        ,drvOccupationQualifier5 = ''
        ,drvOccupationQualifier6 = ''
        ,drvOccupationQualifier7 = ''
        ,drvOccupationQualifier8 = ''
        ,drvOccupationQualifier9 = ''
        ,drvOccupationQualifier10 = ''
        ,drvEmployerContact1 = ''
        ,drvEmployerContact2 = ''
        ,drvEmployerContact3 = ''
        ,drvEmployerContact4 = ''
        ,drvEmployerContact5 = ''
        ,drvEmployerContact6 = ''
        ,drvEmployerContact7 = ''
        ,drvEmployerContact8 = ''
        ,drvEmployerContact9 = ''
        ,drvEmployerContact10 = ''
        ,drvReportingField1 = OrgDesc
        ,drvReportingField2 = OrgCode
        ,drvReportingField3 = ''
        ,drvReportingField4 = ''
        ,drvReportingField5 = ''
        ,drvSpouseDateofChange = ''
        ,drvSpouseFirstName = ''
        ,drvSpouseLastName = ''
        ,drvSpouseDateofBirth = ''
        ,drvSpouseSSN = ''
        ,drvSpouseEmployeeID = ''
        ,drvMaritalStatus = ''
        ,drvSpouseReasonofChange = ''
        ,drvEmploymentClass = ''
        ,drvEmploymentStrength = ''
    INTO dbo.U_ESPPSUNEXP_drvTbl
    FROM dbo.U_ESPPSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_ESPPSUNEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
        Select BdmEEID,bdmcoid
                ,STD =  MAX( CASE WHEN bdmDedcode in ('9002') THEN bdmcoid END)
                ,STD_StartDate =  MAX( CASE WHEN bdmDedcode in ('9002') THEN bdmBenStartDate END)
                ,STD_StopDate =  MAX( CASE WHEN bdmDedcode in ('9002') THEN bdmBenStopDate END)

                ,LTD =  MAX( CASE WHEN bdmDedcode in ('9000', '9001') THEN bdmcoid END)
                ,LTD_StartDate =  MAX( CASE WHEN bdmDedcode in ('9000', '9001') THEN bdmBenStartDate END)
                ,LTD_StopDate =  MAX( CASE WHEN bdmDedcode in ('9000', '9001') THEN bdmBenStopDate END)

            FROM dbo.U_dsi_BDM_ESPPSUNEXP WITH (NOLOCK)
            Group by BdmEEID,bdmcoid
    ) as ConsolidatedBDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Location WITH (NOLOCK)
        on LocCode = eecLocation
    LEft JOIN dbo.OrgLevel
        on OrgCode = rtrim(eecOrgLvl3)
        and orgLvl  = 3
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
ALTER VIEW dbo.dsi_vwESPPSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESPPSUNEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESPPSUNEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112301'
       ,expStartPerControl     = '202112301'
       ,expLastEndPerControl   = '202201069'
       ,expEndPerControl       = '202201069'
WHERE expFormatCode = 'ESPPSUNEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESPPSUNEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESPPSUNEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESPPSUNEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESPPSUNEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESPPSUNEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESPPSUNEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESPPSUNEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESPPSUNEXP', 'UseFileName', 'V', 'Y'


-- End ripout