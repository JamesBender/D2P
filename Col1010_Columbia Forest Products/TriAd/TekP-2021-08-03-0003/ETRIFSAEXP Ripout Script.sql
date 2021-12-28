/**********************************************************************************

ETRIFSAEXP: TriAd FSA Export

FormatCode:     ETRIFSAEXP
Project:        TriAd FSA Export
Client ID:      COL1010
Date/time:      2021-12-28 12:53:28.623
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E11
Server:         E1SUP1ST56
Database:       ULTIPRO_CFP
Web Filename:   COL1010_5F147_EEHISTORY_ETRIFSAEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETRIFSAEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ETRIFSAEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETRIFSAEXP'


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
WHERE FormatCode = 'ETRIFSAEXP'
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
WHERE ExpFormatCode = 'ETRIFSAEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETRIFSAEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETRIFSAEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETRIFSAEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETRIFSAEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETRIFSAEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETRIFSAEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETRIFSAEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETRIFSAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETRIFSAEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETRIFSAEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETRIFSAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRIFSAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRIFSAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIFSAEXP];
GO
IF OBJECT_ID('U_ETRIFSAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_PEarHist];
GO
IF OBJECT_ID('U_ETRIFSAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_PDedHist];
GO
IF OBJECT_ID('U_ETRIFSAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_File];
GO
IF OBJECT_ID('U_ETRIFSAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_EEList];
GO
IF OBJECT_ID('U_ETRIFSAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_drvTbl];
GO
IF OBJECT_ID('U_ETRIFSAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRIFSAEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETRIFSAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRIFSAEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRIFSAEXP','TriAd FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ETRIFSAEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETRIFSAEXPZ0','50','H','01','1',NULL,'Employer ID',NULL,NULL,'"Employer ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETRIFSAEXPZ0','50','H','01','2',NULL,'Employee ID ',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETRIFSAEXPZ0','50','H','01','3',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETRIFSAEXPZ0','50','H','01','4',NULL,'Prefix',NULL,NULL,'"Prefix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETRIFSAEXPZ0','50','H','01','5',NULL,'Last Name ',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETRIFSAEXPZ0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETRIFSAEXPZ0','50','H','01','7',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETRIFSAEXPZ0','50','H','01','8',NULL,'Employee work phone',NULL,NULL,'"Employee work phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETRIFSAEXPZ0','50','H','01','9',NULL,'Employee mobile phone',NULL,NULL,'"Employee mobile phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETRIFSAEXPZ0','50','H','01','10',NULL,'Street Address 1',NULL,NULL,'"Street Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETRIFSAEXPZ0','50','H','01','11',NULL,'Street Address 2',NULL,NULL,'"Street Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETRIFSAEXPZ0','50','H','01','12',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETRIFSAEXPZ0','50','H','01','13',NULL,'State/Province',NULL,NULL,'"State/Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETRIFSAEXPZ0','50','H','01','14',NULL,'Zip/Postal Code',NULL,NULL,'"Zip/Postal Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETRIFSAEXPZ0','50','H','01','15',NULL,'Country Code',NULL,NULL,'"Country Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETRIFSAEXPZ0','50','H','01','16',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETRIFSAEXPZ0','50','H','01','17',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETRIFSAEXPZ0','50','H','01','18',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETRIFSAEXPZ0','50','H','01','19',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETRIFSAEXPZ0','50','H','01','20',NULL,'Employee Status Effective Date',NULL,NULL,'"Employee Status Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETRIFSAEXPZ0','50','H','01','21',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETRIFSAEXPZ0','50','H','01','22',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETRIFSAEXPZ0','50','H','01','23',NULL,'Organization Code - Level 1',NULL,NULL,'"Organization Code - Level 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETRIFSAEXPZ0','50','H','01','24',NULL,'Organization Code - Level 2',NULL,NULL,'"Organization Code - Level 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETRIFSAEXPZ0','50','H','01','25',NULL,'Organization Code - Level 3',NULL,NULL,'"Organization Code - Level 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETRIFSAEXPZ0','50','H','01','26',NULL,'Employee Category Code',NULL,NULL,'"Employee Category Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETRIFSAEXPZ0','50','H','01','27',NULL,'Key Employee',NULL,NULL,'"Key Employee"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ETRIFSAEXPZ0','50','H','01','28',NULL,'Previous year annual compensation',NULL,NULL,'"Previous year annual compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ETRIFSAEXPZ0','50','H','01','29',NULL,'Per Pay Period Health & Welfare Benefit Premium',NULL,NULL,'"Per Pay Period Health & Welfare Benefit Premium"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ETRIFSAEXPZ0','50','H','01','30',NULL,'Officer flag',NULL,NULL,'"Officer flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ETRIFSAEXPZ0','50','H','01','31',NULL,'Ownership percentage',NULL,NULL,'"Ownership percentage"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ETRIFSAEXPZ0','50','H','01','32',NULL,'Health Plan ID',NULL,NULL,'"Health Plan ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ETRIFSAEXPZ0','50','H','01','33',NULL,'Medical Coverage Tier',NULL,NULL,'"Medical Coverage Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ETRIFSAEXPZ0','50','H','01','34',NULL,'Enrolled in HDHP ',NULL,NULL,'"Enrolled in HDHP"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ETRIFSAEXPZ0','50','H','01','35',NULL,'Plan ID Code',NULL,NULL,'"Plan ID Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ETRIFSAEXPZ0','50','H','01','36',NULL,'Plan Year Start Date',NULL,NULL,'"Plan Year Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ETRIFSAEXPZ0','50','H','01','37',NULL,'Plan Year End Date',NULL,NULL,'"Plan Year End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ETRIFSAEXPZ0','50','H','01','38',NULL,'Account Status',NULL,NULL,'"Account Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ETRIFSAEXPZ0','50','H','01','39',NULL,'Payroll Code',NULL,NULL,'"Payroll Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ETRIFSAEXPZ0','50','H','01','40',NULL,'First Payroll Deduction Date',NULL,NULL,'"First Payroll Deduction Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ETRIFSAEXPZ0','50','H','01','41',NULL,'EE Per Pay Period Election ',NULL,NULL,'"EE Per Pay Period Election"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ETRIFSAEXPZ0','50','H','01','42',NULL,'ER Per Pay Period Subsidy',NULL,NULL,'"ER Per Pay Period Subsidy"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ETRIFSAEXPZ0','50','H','01','43',NULL,'EE Annual Election Amount',NULL,NULL,'"EE Annual Election Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ETRIFSAEXPZ0','50','H','01','44',NULL,'ER Annual Election Amount',NULL,NULL,'"ER Annual Election Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ETRIFSAEXPZ0','50','H','01','45',NULL,'Account Effective Date',NULL,NULL,'"Account Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ETRIFSAEXPZ0','50','H','01','46',NULL,'Account Termination (Stop) Date',NULL,NULL,'"Account Termination (Stop) Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ETRIFSAEXPZ0','50','H','01','47',NULL,'Coverage Tier ID',NULL,NULL,'"Coverage Tier ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ETRIFSAEXPZ0','50','H','01','48',NULL,'Deductible Met',NULL,NULL,'"Deductible Met"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ETRIFSAEXPZ0','50','H','01','49',NULL,'Family Balance Max',NULL,NULL,'"Family Balance Max"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ETRIFSAEXPZ0','50','H','01','50',NULL,'Individual Balance Max ',NULL,NULL,'"Individual Balance Max"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ETRIFSAEXPZ0','50','H','01','51',NULL,'EE Contribution YTD Amount',NULL,NULL,'"EE Contribution YTD Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ETRIFSAEXPZ0','50','H','01','52',NULL,'ER Contribution YTD Amount',NULL,NULL,'"ER Contribution YTD Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ETRIFSAEXPZ0','50','H','01','53',NULL,'Other Deposit YTD Amount',NULL,NULL,'"Other Deposit YTD Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ETRIFSAEXPZ0','50','H','01','54',NULL,'YTD Claims Paid',NULL,NULL,'"YTD Claims Paid"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ETRIFSAEXPZ0','50','H','01','55',NULL,'Last Payroll Date',NULL,NULL,'"Last Payroll Date"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETRIFSAEXPZ0','50','D','10','1',NULL,'Employer ID',NULL,NULL,'"drvEmployerId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETRIFSAEXPZ0','50','D','10','2',NULL,'Employee ID ',NULL,NULL,'"drvEecEmpNo"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETRIFSAEXPZ0','50','D','10','3',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETRIFSAEXPZ0','50','D','10','4',NULL,'Prefix',NULL,NULL,'"drvNamePrefix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETRIFSAEXPZ0','50','D','10','5',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETRIFSAEXPZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETRIFSAEXPZ0','50','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETRIFSAEXPZ0','50','D','10','8',NULL,'Employee work phone',NULL,NULL,'"drvEmployeeWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETRIFSAEXPZ0','50','D','10','9',NULL,'Employee mobile phone',NULL,NULL,'"drvEmployeeMobilePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETRIFSAEXPZ0','50','D','10','10',NULL,'Street Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETRIFSAEXPZ0','50','D','10','11',NULL,'Street Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETRIFSAEXPZ0','50','D','10','12',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETRIFSAEXPZ0','50','D','10','13',NULL,'State/Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETRIFSAEXPZ0','50','D','10','14',NULL,'Zip/Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETRIFSAEXPZ0','50','D','10','15',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETRIFSAEXPZ0','50','D','10','16',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETRIFSAEXPZ0','50','D','10','17',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETRIFSAEXPZ0','50','D','10','18',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETRIFSAEXPZ0','50','D','10','19',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETRIFSAEXPZ0','50','D','10','20',NULL,'Employee Status Effective Date',NULL,NULL,'"drvEmployeeStatusEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETRIFSAEXPZ0','50','D','10','21',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETRIFSAEXPZ0','50','D','10','22',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETRIFSAEXPZ0','50','D','10','23',NULL,'Organization Code - Level 1',NULL,NULL,'"drvOrganizationCodeLevel1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETRIFSAEXPZ0','50','D','10','24',NULL,'Organization Code - Level 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETRIFSAEXPZ0','50','D','10','25',NULL,'Organization Code - Level 3',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETRIFSAEXPZ0','50','D','10','26',NULL,'Employee Category Code',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETRIFSAEXPZ0','50','D','10','27',NULL,'Key Employee',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ETRIFSAEXPZ0','50','D','10','28',NULL,'Previous year annual compensation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ETRIFSAEXPZ0','50','D','10','29',NULL,'Per Pay Period Health & Welfare Benefit Premium',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ETRIFSAEXPZ0','50','D','10','30',NULL,'Officer flag',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ETRIFSAEXPZ0','50','D','10','31',NULL,'Ownership percentage',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ETRIFSAEXPZ0','50','D','10','32',NULL,'Health Plan ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ETRIFSAEXPZ0','50','D','10','33',NULL,'Medical Coverage Tier',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ETRIFSAEXPZ0','50','D','10','34',NULL,'Enrolled in HDHP ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ETRIFSAEXPZ0','50','D','10','35',NULL,'Plan ID Code',NULL,NULL,'"drvPlanIdCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ETRIFSAEXPZ0','50','D','10','36',NULL,'Plan Year Start Date',NULL,NULL,'"drvPlanYearStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ETRIFSAEXPZ0','50','D','10','37',NULL,'Plan Year End Date',NULL,NULL,'"drvPlanYearEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ETRIFSAEXPZ0','50','D','10','38',NULL,'Account Status',NULL,NULL,'"drvAccountStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ETRIFSAEXPZ0','50','D','10','39',NULL,'Payroll Code',NULL,NULL,'"drvPayrollCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ETRIFSAEXPZ0','50','D','10','40',NULL,'First Payroll Deduction Date',NULL,NULL,'"drvFirstPayrollDedDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ETRIFSAEXPZ0','50','D','10','41',NULL,'EE Per Pay Period Election ',NULL,NULL,'"drvEEPayPerPeriodElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ETRIFSAEXPZ0','50','D','10','42',NULL,'ER Per Pay Period Subsidy',NULL,NULL,'"drvERPerPayPeriodSubsidy"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ETRIFSAEXPZ0','50','D','10','43',NULL,'EE Annual Election Amount',NULL,NULL,'"drvEEAnnualElectionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ETRIFSAEXPZ0','50','D','10','44',NULL,'ER Annual Election Amount',NULL,NULL,'"drvERAnnualElectionAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ETRIFSAEXPZ0','50','D','10','45',NULL,'Account Effective Date',NULL,NULL,'"drvAccountEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ETRIFSAEXPZ0','50','D','10','46',NULL,'Account Termination (Stop) Date',NULL,NULL,'"drvAccountTerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ETRIFSAEXPZ0','50','D','10','47',NULL,'Coverage Tier ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ETRIFSAEXPZ0','50','D','10','48',NULL,'Deductible Met',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ETRIFSAEXPZ0','50','D','10','49',NULL,'Family Balance Max',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ETRIFSAEXPZ0','50','D','10','50',NULL,'Individual Balance Max ',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ETRIFSAEXPZ0','50','D','10','51',NULL,'EE Contribution YTD Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ETRIFSAEXPZ0','50','D','10','52',NULL,'ER Contribution YTD Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ETRIFSAEXPZ0','50','D','10','53',NULL,'Other Deposit YTD Amount',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ETRIFSAEXPZ0','50','D','10','54',NULL,'YTD Claims Paid',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ETRIFSAEXPZ0','50','D','10','55',NULL,'Last Payroll Date',NULL,NULL,'""','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETRIFSAEXP_20211228.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202109279','EMPEXPORT','OEACTIVE','Sep 27 2021 11:56AM','ETRIFSAEXP',NULL,NULL,NULL,'202109279','Sep 27 2021  5:30AM','Sep 27 2021  5:30AM','202109271','1','','','202109271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202109279','EMPEXPORT','OEPASSIVE','Sep 27 2021  1:00PM','ETRIFSAEXP',NULL,NULL,NULL,'202109279','Sep 27 2021  5:30AM','Sep 27 2021  5:30AM','202109271','131','','','202109271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TriAd FSA Export','202109279','EMPEXPORT','ONDEM_XOE','Sep 27 2021  1:10PM','ETRIFSAEXP',NULL,NULL,NULL,'202109279','Sep 27 2021  5:30AM','Sep 27 2021  5:30AM','202109271','131','','','202109271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'TriAd FSA Export-Sched','202109279','EMPEXPORT','SCH_ETRIFS','Sep 27 2021  1:11PM','ETRIFSAEXP',NULL,NULL,NULL,'202109279','Sep 27 2021  5:30AM','Sep 27 2021  5:30AM','202109271','131','','','202109271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',60DZM,603MK,60DVD,RLXW5,60DPK,NDX1T,RM1JG,P34RH,RM1AP,4J7P4,MGQ2N,MMNA5',NULL,NULL,NULL,'TriAd FSA Export-Scheduled','202112029','EMPEXPORT','SCH_ETRIFS',NULL,'ETRIFSAEXP',NULL,NULL,NULL,'202112029',NULL,NULL,'202112021',NULL,NULL,'','202112021',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','60DZM,603MK,60DVD,60DPK,P34RH',NULL,NULL,NULL,'TriAd FSA Export-Test','202110071','EMPEXPORT','TEST_XOE','Oct 13 2021  9:14AM','ETRIFSAEXP',NULL,NULL,NULL,'202110071','Oct  7 2021 12:00AM','Oct  2 2021 12:00AM','202110011','130','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3cPeCOL1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',60DZM,603MK,60DVD,60DPK,P34RH',NULL,NULL,NULL,'Triad FSA OE Active','202201011','EMPEXPORT','TRIADFSAOE','Dec 21 2021  1:17PM','ETRIFSAEXP',NULL,NULL,NULL,'202201011','Jan  1 2022 12:00AM','Dec 30 1899 12:00AM','202201011','3','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3cPeCOL1010',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',60DZM,603MK,60DVD,RLXW5,60DPK,NDX1T,RM1JG,P34RH,RM1AP,4J7P4,MGQ2N,MMNA5',NULL,NULL,NULL,'TriAd FSA Export OnDemand','202112211','EMPEXPORT','TRIOND_XOE','Dec 21 2021 12:00AM','ETRIFSAEXP',NULL,NULL,NULL,'202112211','Dec 21 2021 12:00AM','Dec 11 2021 12:00AM','202112211',NULL,'','','202112211',dbo.fn_GetTimedKey(),NULL,'us3cPeCOL1010',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIFSAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIFSAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIFSAEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIFSAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIFSAEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRIFSAEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRIFSAEXP','D10','dbo.U_ETRIFSAEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ETRIFSAEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ETRIFSAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRIFSAEXP] (
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
-- Create table U_ETRIFSAEXP_DedList
-----------

IF OBJECT_ID('U_ETRIFSAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ETRIFSAEXP_drvTbl
-----------

IF OBJECT_ID('U_ETRIFSAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployerId] varchar(11) NOT NULL,
    [drvEecEmpNo] varchar(11) NULL,
    [drvSSN] varchar(13) NULL,
    [drvNamePrefix] varchar(32) NOT NULL,
    [drvNameLast] varchar(102) NOT NULL,
    [drvNameFirst] varchar(102) NOT NULL,
    [drvNameMiddle] varchar(3) NOT NULL,
    [drvEmployeeWorkPhone] varchar(14) NOT NULL,
    [drvEmployeeMobilePhone] varchar(14) NOT NULL,
    [drvAddressLine1] varchar(257) NOT NULL,
    [drvAddressLine2] varchar(257) NULL,
    [drvAddressCity] varchar(257) NOT NULL,
    [drvAddressState] varchar(257) NOT NULL,
    [drvAddressZipCode] varchar(8000) NULL,
    [drvCountryCode] varchar(4) NOT NULL,
    [drvEmailAddress] varchar(52) NULL,
    [drvEmployeeStatus] varchar(3) NOT NULL,
    [drvHireDate] varchar(10) NOT NULL,
    [drvOriginalHireDate] varchar(10) NOT NULL,
    [drvEmployeeStatusEffDate] varchar(10) NOT NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvBirthDate] varchar(10) NOT NULL,
    [drvOrganizationCodeLevel1] varchar(9) NOT NULL,
    [drvPlanIdCode] varchar(5) NOT NULL,
    [drvPlanYearStartDate] varchar(10) NOT NULL,
    [drvPlanYearEndDate] varchar(10) NOT NULL,
    [drvAccountStatus] varchar(3) NOT NULL,
    [drvPayrollCode] varchar(3) NULL,
    [drvFirstPayrollDedDate] varchar(10) NOT NULL,
    [drvEEPayPerPeriodElection] nvarchar(4000) NULL,
    [drvERPerPayPeriodSubsidy] varchar(1) NOT NULL,
    [drvEEAnnualElectionAmount] nvarchar(4000) NULL,
    [drvERAnnualElectionAmount] varchar(1) NOT NULL,
    [drvAccountEffectiveDate] varchar(10) NULL,
    [drvAccountTerminationDate] varchar(10) NOT NULL
);

-----------
-- Create table U_ETRIFSAEXP_EEList
-----------

IF OBJECT_ID('U_ETRIFSAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETRIFSAEXP_File
-----------

IF OBJECT_ID('U_ETRIFSAEXP_File') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ETRIFSAEXP_PDedHist
-----------

IF OBJECT_ID('U_ETRIFSAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_PDedHist] (
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
-- Create table U_ETRIFSAEXP_PEarHist
-----------

IF OBJECT_ID('U_ETRIFSAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRIFSAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIFSAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Columbia Forest Products

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 09/27/2021
Service Request Number: TekP-2021-08-03-0003

Purpose: TriAd FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRIFSAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRIFSAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRIFSAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRIFSAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRIFSAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIFSAEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIFSAEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIFSAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIFSAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIFSAEXP', 'SCH_ETRIFS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRIFSAEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETRIFSAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRIFSAEXP';

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
    DELETE FROM dbo.U_ETRIFSAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRIFSAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '501,502';

    IF OBJECT_ID('U_ETRIFSAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIFSAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRIFSAEXP_DedList
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
    IF OBJECT_ID('U_ETRIFSAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIFSAEXP_PDedHist;
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
    INTO dbo.U_ETRIFSAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRIFSAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETRIFSAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIFSAEXP_PEarHist;
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
    INTO dbo.U_ETRIFSAEXP_PEarHist
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
    -- DETAIL RECORD - U_ETRIFSAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRIFSAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIFSAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerId = '"930672034"'
        ,drvEecEmpNo = '"' + RTRIM(ISNULL(EecEmpNo, '')) + '"'
        ,drvSSN = '"' + RTRIM(ISNULL(eepSSN, '')) + '"'
        ,drvNamePrefix = '"' + ISNULL(EepNamePrefix,'') + '"'
        ,drvNameLast = '"' + ISNULL(EepNameLast,'') + '"'
        ,drvNameFirst = '"' + ISNULL(EepNameFirst,'') + '"'
        ,drvNameMiddle = '"' + ISNULL(LEFT(EepNameMiddle,1),'') + '"'
        ,drvEmployeeWorkPhone = '"' + CASE WHEN LEN(RTRIM(EecPhoneBusinessNumber)) > 0 THEN ISNULL(LEFT(EecPhoneBusinessNumber, 3) + '-' + RIGHT(LEFT(EecPhoneBusinessNumber, 6), 3) + '-' + RIGHT(RTRIM(EecPhoneBusinessNumber), 4),'') ELSE '' END + '"'
        ,drvEmployeeMobilePhone = '"' + ISNULL(LEFT(EfoPhoneNumber, 3) + '-' + RIGHT(LEFT(EfoPhoneNumber, 6), 3) + '-' + RIGHT(RTRIM(EfoPhoneNumber), 4),'') + '"' 
        ,drvAddressLine1 = '"' + ISNULL(EepAddressLine1,'') + '"'
        ,drvAddressLine2 = '"' + RTRIM(ISNULL(EepAddressLine2,'')) + '"'
        ,drvAddressCity = '"' + ISNULL(EepAddressCity,'') + '"'
        ,drvAddressState = '"' + ISNULL(EepAddressState,'') + '"'
        ,drvAddressZipCode = '"' + REPLACE(ISNULL(EepAddressZipCode,''), '-', '') + '"'
        ,drvCountryCode = '"US"'
        ,drvEmailAddress = '"' + RTRIM(ISNULL(EepAddressEMail,'')) + '"'
        ,drvEmployeeStatus =    '"' + CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                    WHEN EecEmplStatus IN ('L','A') THEN 'A'
                                    ELSE ''
                                END + '"'
        ,drvHireDate =  '"' + ISNULL(CONVERT(VARCHAR(8), EecDateOfLastHire, 112),'') + '"'
        ,drvOriginalHireDate = '"' + ISNULL(CONVERT(VARCHAR(8), EecDateOfLastHire, 112),'') + '"'
        ,drvEmployeeStatusEffDate =    CASE WHEN EecEmplStatus = 'T' THEN '"' + ISNULL(CONVERT(VARCHAR(8), EecDateOfTermination, 112),'') + '"'
                                        WHEN EecEmplStatus IN ('L','A') THEN '"' + ISNULL(CONVERT(VARCHAR(8), EecDateOfLastHire, 112),'') + '"'
                                        ELSE '""'
                                    END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN '"' + ISNULL(CONVERT(VARCHAR(8), EecDateOfTermination, 112),'') + '"' END
        ,drvBirthDate = '"' + ISNULL(CONVERT(VARCHAR(8), EepDateOfBirth, 112),'') + '"'
        ,drvOrganizationCodeLevel1 =    '"' + CASE WHEN EecUDField04 = '01' THEN 'GSO'
                                            WHEN EecUDField04 = '02' THEN 'GSO Out'
                                            WHEN EecUDField04 = '03' THEN 'Chathm'
                                            WHEN EecUDField04 = '04' THEN 'Craigsv'
                                            WHEN EecUDField04 = '05' THEN 'Klamath'
                                            WHEN EecUDField04 = '06' THEN 'Mellen'
                                            WHEN EecUDField04 = '07' THEN 'Newport'
                                            WHEN EecUDField04 = '08' THEN 'OldFort'
                                            WHEN EecUDField04 = '10' THEN 'Presque'
                                            ELSE ''
                                        END + '"'

        ,drvPlanIdCode = '"' + 
                                CASE WHEN BdmDedCode = '501' THEN 'HCA'
                                    WHEN BdmDedCode = '502' THEN 'DCA'
                                    ELSE ''
                                END + '"'
        ,drvPlanYearStartDate = '"20220101"'
        ,drvPlanYearEndDate = '"20221231"'
        ,drvAccountStatus =    '"' +
                                    CASE WHEN BdmDedCode IN ('501','502') AND BdmBenStatus = 'A' THEN 'A'
                                        WHEN BdmDedCode IN ('501','502') AND BdmBenStatus IN ('T','C') THEN 'T'
                                        ELSE ''
                                    END + '"'
        ,drvPayrollCode =    '"' + CASE WHEN PgrPayFrequency IN ('W','B','S') THEN PgrPayFrequency END + '"'
        ,drvFirstPayrollDedDate = '"20220101"'
        ,drvEEPayPerPeriodElection = '"' + CASE WHEN BdmDedCode IN ('501','502') THEN FORMAT(BdmEEAmt, '#0.00') END + '"'
        ,drvERPerPayPeriodSubsidy = ''
        ,drvEEAnnualElectionAmount = '"' + CASE WHEN BdmDedCode IN ('501','502') THEN FORMAT(BdmEEGoalAmt, '#0.00') END + '"'
        ,drvERAnnualElectionAmount = ''
        ,drvAccountEffectiveDate = '"' + CASE WHEN BdmDedCode IN ('501','502') THEN CONVERT(VARCHAR(8), dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDate, '1/1/2022'), 112) END + '"'
        ,drvAccountTerminationDate = '"' + ISNULL(CONVERT(VARCHAR(8), BdmBenStopDate, 112),'') + '"'
    INTO dbo.U_ETRIFSAEXP_drvTbl
    FROM dbo.U_ETRIFSAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)    
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETRIFSAEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
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
ALTER VIEW dbo.dsi_vwETRIFSAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRIFSAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRIFSAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109201'
       ,expStartPerControl     = '202109201'
       ,expLastEndPerControl   = '202109279'
       ,expEndPerControl       = '202109279'
WHERE expFormatCode = 'ETRIFSAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRIFSAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRIFSAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETRIFSAEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETRIFSAEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETRIFSAEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETRIFSAEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETRIFSAEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETRIFSAEXP', 'UseFileName', 'V', 'Y'


-- End ripout