/**********************************************************************************

EEMP401KEX: Empower 401k Export

FormatCode:     EEMP401KEX
Project:        Empower 401k Export
Client ID:      GRE1021
Date/time:      2022-02-28 06:51:43.210
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPGREPL
Web Filename:   GRE1021_96C5A_EEHISTORY_EEMP401KEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EEMP401KEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EEMP401KEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EEMP401KEX'


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
WHERE FormatCode = 'EEMP401KEX'
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
WHERE ExpFormatCode = 'EEMP401KEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EEMP401KEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EEMP401KEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EEMP401KEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EEMP401KEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EEMP401KEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EEMP401KEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EEMP401KEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EEMP401KEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EEMP401KEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EEMP401KEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEEMP401KEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEMP401KEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEMP401KEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401KEX];
GO
IF OBJECT_ID('U_EEMP401KEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_PEarHist];
GO
IF OBJECT_ID('U_EEMP401KEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_PDedHist];
GO
IF OBJECT_ID('U_EEMP401KEX_File') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_File];
GO
IF OBJECT_ID('U_EEMP401KEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_EEList];
GO
IF OBJECT_ID('U_EEMP401KEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_drvTbl];
GO
IF OBJECT_ID('U_EEMP401KEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EEMP401KEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EEMP401KEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EEMP401KEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EEMP401KEX','Empower 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','708','S','N','EEMP401KEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EEMP401KEXZ0','13','D','10','1',NULL,'Plan Number',NULL,NULL,'"475018-01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EEMP401KEXZ0','11','D','10','14',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EEMP401KEXZ0','20','D','10','25',NULL,'Division number',NULL,NULL,'"drvDivisionNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EEMP401KEXZ0','35','D','10','45',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EEMP401KEXZ0','20','D','10','80',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EEMP401KEXZ0','20','D','10','100',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EEMP401KEXZ0','15','D','10','120',NULL,'Name Suffix',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EEMP401KEXZ0','10','D','10','135',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EEMP401KEXZ0','1','D','10','145',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EEMP401KEXZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EEMP401KEXZ0','35','D','10','147',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EEMP401KEXZ0','35','D','10','182',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EEMP401KEXZ0','20','D','10','217',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EEMP401KEXZ0','2','D','10','237',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EEMP401KEXZ0','10','D','10','239',NULL,'Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EEMP401KEXZ0','10','D','10','249',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EEMP401KEXZ0','10','D','10','259',NULL,'Work Phone Number',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EEMP401KEXZ0','4','D','10','269',NULL,'Work Phone Ext.',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EEMP401KEXZ0','2','D','10','273',NULL,'Country Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EEMP401KEXZ0','10','D','10','275',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EEMP401KEXZ0','10','D','10','285',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EEMP401KEXZ0','10','D','10','295',NULL,'Re-Hire Date',NULL,NULL,'"drvReHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EEMP401KEXZ0','10','D','10','305',NULL,'Checkdate',NULL,NULL,'"drvCheckDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EEMP401KEXZ0','10','D','10','315',NULL,'Pretax',NULL,NULL,'"drvPreTax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EEMP401KEXZ0','10','D','10','325',NULL,'Roth',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EEMP401KEXZ0','10','D','10','335',NULL,'Loans',NULL,NULL,'"drvLoans"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EEMP401KEXZ0','10','D','10','345',NULL,'Employer Profit Sharing',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EEMP401KEXZ0','10','D','10','355',NULL,'EMPLOYER PROFIT SHARING',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EEMP401KEXZ0','10','D','10','365',NULL,'EMPLOYER MONEY PURCHASE',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EEMP401KEXZ0','10','D','10','375',NULL,'Contribution Amount 7',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EEMP401KEXZ0','10','D','10','385',NULL,'Contribution Amount 8',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EEMP401KEXZ0','5','D','10','395',NULL,'YTD Hours Worked',NULL,NULL,'"drvYTDHoursWorked"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EEMP401KEXZ0','11','D','10','400',NULL,'YTD Total Compensation',NULL,NULL,'"drvYTDCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EEMP401KEXZ0','11','D','10','411',NULL,'YTD Plan Compensation',NULL,NULL,'"drvYTDPlanCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EEMP401KEXZ0','11','D','10','422',NULL,'YTD Pre Entry Compensation',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EEMP401KEXZ0','1','D','10','433',NULL,'Highly Comp Employee Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EEMP401KEXZ0','6','D','10','434',NULL,'Percent of Ownership',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EEMP401KEXZ0','1','D','10','440',NULL,'Officer Determination',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EEMP401KEXZ0','10','D','10','441',NULL,'Participation Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EEMP401KEXZ0','1','D','10','451',NULL,'Eligibility Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EEMP401KEXZ0','1','D','10','452',NULL,'LOA Reason Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EEMP401KEXZ0','10','D','10','453',NULL,'LOA Start Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EEMP401KEXZ0','10','D','10','463',NULL,'LOA End Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EEMP401KEXZ0','1','D','10','473',NULL,'Filler Space',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EEMP401KEXZ0','80','D','10','474',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EEMP401KEXZ0','17','D','10','554',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EEMP401KEXZ0','2','D','10','571',NULL,'Salary Amount Qualifier',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EEMP401KEXZ0','20','D','10','573',NULL,'Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EEMP401KEXZ0','1','D','10','593',NULL,'Sarbanes Oxley Reporting Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EEMP401KEXZ0','6','D','10','594',NULL,'Filler Space',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EEMP401KEXZ0','2','D','10','600',NULL,'Federal Exemptions',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EEMP401KEXZ0','10','D','10','602',NULL,'Employer Assigned ID',NULL,NULL,'"drvEmployeeAssignedId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EEMP401KEXZ0','6','D','10','612',NULL,'Compliance Status Code',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EEMP401KEXZ0','80','D','10','618',NULL,'Personal Email Address',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EEMP401KEXZ0','10','D','10','698',NULL,'Mobile Phone',NULL,NULL,'"drvMobilePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EEMP401KEXZ0','1','D','10','708',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EEMP401KEX_20220228.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202202259','EMPEXPORT','OEACTIVE','Feb 18 2022 10:41AM','EEMP401KEX',NULL,NULL,NULL,'202202259','Feb 18 2022  5:36AM','Feb 18 2022  5:36AM','202202251','1','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202202259','EMPEXPORT','OEPASSIVE','Feb 18 2022 10:41AM','EEMP401KEX',NULL,NULL,NULL,'202202259','Feb 18 2022  5:36AM','Feb 18 2022  5:36AM','202202251','500','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Empower 401k Export','202202259','EMPEXPORT','ONDEM_XOE','Feb 18 2022 10:42AM','EEMP401KEX',NULL,NULL,NULL,'202202259','Feb 18 2022  5:36AM','Feb 18 2022  5:36AM','202202251','500','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Empower 401k Export-Sched','202202259','EMPEXPORT','SCH_EEMP40','Feb 18 2022 10:43AM','EEMP401KEX',NULL,NULL,NULL,'202202259','Feb 18 2022  5:36AM','Feb 18 2022  5:36AM','202202251','500','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Empower 401k Export-Test','202202259','EMPEXPORT','TEST_XOE','Feb 25 2022  2:58PM','EEMP401KEX',NULL,NULL,NULL,'202202259','Feb 23 2022 12:00AM','Dec 30 1899 12:00AM','202202251','691','','','202202251',dbo.fn_GetTimedKey(),NULL,'us3jReGRE1021',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEMP401KEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP401KEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEMP401KEX','D10','dbo.U_EEMP401KEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EEMP401KEX
-----------

IF OBJECT_ID('U_dsi_BDM_EEMP401KEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EEMP401KEX] (
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
-- Create table U_EEMP401KEX_DedList
-----------

IF OBJECT_ID('U_EEMP401KEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EEMP401KEX_drvTbl
-----------

IF OBJECT_ID('U_EEMP401KEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvDivisionNumber] varchar(4) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvReHireDate] datetime NULL,
    [drvCheckDate] datetime NULL,
    [drvPreTax] nvarchar(4000) NULL,
    [drvRoth] nvarchar(4000) NULL,
    [drvLoans] nvarchar(4000) NULL,
    [drvYTDHoursWorked] nvarchar(4000) NULL,
    [drvYTDCompensation] nvarchar(4000) NULL,
    [drvYTDPlanCompensation] nvarchar(4000) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSalaryAmount] nvarchar(4000) NULL,
    [drvTerminationReasonCode] varchar(2) NULL,
    [drvEmployeeAssignedId] char(9) NULL,
    [drvMobilePhone] varchar(50) NULL,
    [drvPayFrequency] char(1) NULL
);

-----------
-- Create table U_EEMP401KEX_EEList
-----------

IF OBJECT_ID('U_EEMP401KEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEMP401KEX_File
-----------

IF OBJECT_ID('U_EEMP401KEX_File') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(708) NULL
);

-----------
-- Create table U_EEMP401KEX_PDedHist
-----------

IF OBJECT_ID('U_EEMP401KEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPayDate] datetime NULL,
    [PdhPreTax] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoans] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EEMP401KEX_PEarHist
-----------

IF OBJECT_ID('U_EEMP401KEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EEMP401KEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCurHrsIncInDefCompYTD] decimal NULL,
    [PehCurAmtIncInDefCompYTD] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEMP401KEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Green Plains

Created By: James Bender
Business Analyst: Julie Reardon
Create Date: 02/18/2022
Service Request Number: TekP-2021-10-26-0005

Purpose: Empower 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEMP401KEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEMP401KEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEMP401KEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEMP401KEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEMP401KEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401KEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401KEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401KEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401KEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEMP401KEX', 'SCH_EEMP40';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EEMP401KEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EEMP401KEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EEMP401KEX';

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
    DELETE FROM dbo.U_EEMP401KEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEMP401KEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CP,401CU,401ER,401F,401P,401RF,401RP,4KLN1,4KLN2,4KLN3,4KLN4,4KLN5,4KLN6,4KLN7,4KRCP,4KRCU';

    IF OBJECT_ID('U_EEMP401KEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401KEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EEMP401KEX_DedList
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
    IF OBJECT_ID('U_EEMP401KEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401KEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        ,PdhPayDate = MAX(PdhPayDate)
        -- Categorize Payroll Amounts
        ,PdhPreTax        = SUM(CASE WHEN PdhDedCode IN ('401CP','401CU','401F','401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth        = SUM(CASE WHEN PdhDedCode IN ('401RF','401RP','4KRCP','4KRCU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoans        = SUM(CASE WHEN PdhDedCode IN ('4KLN1','4KLN2','4KLN3','4KLN4','4KLN4','4KLN5','4KLN6','4KLN7') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EEMP401KEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EEMP401KEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EEMP401KEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401KEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehInclInDefCompHrs = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCurHrsIncInDefCompYTD           = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs ELSE 0.00 END)
        ,PehCurAmtIncInDefCompYTD           = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EEMP401KEX_PEarHist
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
    -- DETAIL RECORD - U_EEMP401KEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EEMP401KEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EEMP401KEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionNumber =    CASE WHEN EecPayGroup = 'BWFQT' THEN 'FQBW'
                                WHEN EecPayGroup IN ('SMFQT','SMFQM') THEN 'FQSM'
                                WHEN EecPayGroup IN ('BWCORP','BWTRAD','BWOBIO','BWSHEN','BWSUPE','BWOTTE','BWCC','BWBLEN','BWATK','BWWOOD','BWFAIR','BWBSTK','BWBPA','BWHOP','BWMADI','BWMTVN','BWYORK','BWOPTI') THEN 'GPBW'
                                WHEN EecPayGroup IN ('SMCORP','SMTRAD','SMBLEN','SMOPTI') THEN 'GPSM'
                                END
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IS NULL OR EepMaritalStatus = 'Z' THEN 'S' ELSE eepMaritalStatus END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhoneNumber = CASE WHEN EepPhoneHomeIsPrivate <> 'Y' THEN EepPhoneHomeNumber ELSE EecPhoneBusinessNumber END
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate =    CASE WHEN EecEmplStatus IN ('R','T') THEN EecDateOfTermination 
                                WHEN EecEmplStatus NOT IN ('R','T') AND EecDateOfOriginalHire <> EecDateOfLastHire THEN DATEADD(DAY, -1, EjhJobEffDate)
                                END
        ,drvReHireDate = CASE WHEN EecEmplStatus NOT IN ('R','T') AND EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvCheckDate = PdhPayDate -- PrgPayDate
        ,drvPreTax = FORMAT(PdhPreTax, '0000000.00')
        ,drvRoth = FORMAT(PdhRoth, '0000000.00')
        ,drvLoans = FORMAT(PdhLoans, '0000000.00')
        ,drvYTDHoursWorked = FORMAT(PehCurHrsIncInDefCompYTD, '00000')
        --,drvYTDCompensation = FORMAT(PthCurTaxableWagesYTD, '00000000.00')
        ,drvYTDCompensation = FORMAT(PehCurAmtYTD, '00000000.00')
        ,drvYTDPlanCompensation = FORMAT(PehCurAmtIncInDefCompYTD, '00000000.00')
        ,drvEmailAddress = CASE WHEN eepAddressEMailAlternate IS NOT NULL THEN eepAddressEMailAlternate ELSE EepAddressEMail END
        ,drvSalaryAmount = FORMAT(EecAnnSalary, '#0.00')
        ,drvTerminationReasonCode =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DE'
                                    WHEN EecEmplStatus = 'R' THEN 'LA'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    WHEN EecEmplStatus = 'T' THEN 'S'
                                    END
        ,drvEmployeeAssignedId = EecEmpNo
        ,drvMobilePhone = EfoPhoneNumber
        ,drvPayFrequency = PgrPayFrequency
    INTO dbo.U_EEMP401KEX_drvTbl
    FROM dbo.U_EEMP401KEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EEMP401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID
                    ,MAX(EjhJobEffDate) AS EjhJobEffDate
                FROM dbo.EmpHJob WITH (NOLOCK)
                WHERE EjhEmplStatus = 'T'
                GROUP BY EjhEEID, EjhCOID) EJH
        on EjhEEID = xEEID
        AND EjhCOID = xCOID
    JOIN dbo.U_EEMP401KEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_EEMP401KEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN (
                SELECT PthEEID, PthCOID 
                    ,SUM(PthCurTaxableWages) AS  PthCurTaxableWagesYTD
                FROM dbo.PTaxHist WITH (NOLOCK)
                WHERE PthTaxCode LIKE '%USFIT%'
                AND LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
                    AND PthPerControl <= @EndPerControl 
                GROUP BY PthEEID, PthCoID) PTH
        ON PthEEID = xEEID
        AND PthCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEEMP401KEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EEMP401KEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EEMP401KEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202111'
       ,expStartPerControl     = '202202111'
       ,expLastEndPerControl   = '202202119'
       ,expEndPerControl       = '202202119'
WHERE expFormatCode = 'EEMP401KEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEMP401KEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEMP401KEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EEMP401KEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EEMP401KEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EEMP401KEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMP401KEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EEMP401KEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EEMP401KEX', 'UseFileName', 'V', 'Y'


-- End ripout