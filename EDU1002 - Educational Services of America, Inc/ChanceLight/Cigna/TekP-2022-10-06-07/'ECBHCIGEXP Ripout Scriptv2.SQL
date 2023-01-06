/**********************************************************************************

ECBHCIGEXP: Cigna Accident and Critical Illness Export

FormatCode:     ECBHCIGEXP
Project:        Cigna Accident and Critical Illness Export
Client ID:      EDU1002
Date/time:      2023-01-05 15:18:27.150
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E15
Server:         E1SUP5DB03
Database:       ULTIPRO_ESA
Web Filename:   EDU1002_99956_EEHISTORY_ECBHCIGEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECBHCIGEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECBHCIGEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECBHCIGEXP'


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
WHERE FormatCode = 'ECBHCIGEXP'
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
WHERE ExpFormatCode = 'ECBHCIGEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECBHCIGEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECBHCIGEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECBHCIGEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECBHCIGEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECBHCIGEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECBHCIGEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECBHCIGEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECBHCIGEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECBHCIGEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECBHCIGEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECBHCIGEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECBHCIGEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECBHCIGEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECBHCIGEXP];
GO
IF OBJECT_ID('U_ECBHCIGEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_Header];
GO
IF OBJECT_ID('U_ECBHCIGEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_File];
GO
IF OBJECT_ID('U_ECBHCIGEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_EEList];
GO
IF OBJECT_ID('U_ECBHCIGEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_drvTbl];
GO
IF OBJECT_ID('U_ECBHCIGEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_DedList];
GO
IF OBJECT_ID('U_ECBHCIGEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_AuditFields];
GO
IF OBJECT_ID('U_ECBHCIGEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECBHCIGEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECBHCIGEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECBHCIGEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECBHCIGEXP','Cigna Accident and Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','ECBHCIGEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHCIGEXPZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL,'"Legal Company Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHCIGEXPZ0','50','H','01','2',NULL,'Client ID',NULL,NULL,'"Client ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHCIGEXPZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL,'"EE First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHCIGEXPZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL,'"EE Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHCIGEXPZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL,'"EE Street Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHCIGEXPZ0','50','H','01','6',NULL,'EE City',NULL,NULL,'"EE City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHCIGEXPZ0','50','H','01','7',NULL,'EE State',NULL,NULL,'"EE State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECBHCIGEXPZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL,'"EE Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECBHCIGEXPZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL,'"EE SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECBHCIGEXPZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL,'"EE Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECBHCIGEXPZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL,'"EE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECBHCIGEXPZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL,'"EE Smoker Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECBHCIGEXPZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL,'"EE Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECBHCIGEXPZ0','50','H','01','14',NULL,'EE Status',NULL,NULL,'"EE Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECBHCIGEXPZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL,'"EE Status Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECBHCIGEXPZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL,'"EE LOA Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECBHCIGEXPZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL,'"Cigna Product Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECBHCIGEXPZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL,'"Cigna Billing Account"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECBHCIGEXPZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL,'"Benefit Elected"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECBHCIGEXPZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL,'"Coverage Election Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECBHCIGEXPZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL,'"Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECBHCIGEXPZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL,'"QLE/Revised Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECBHCIGEXPZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL,'"Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECBHCIGEXPZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL,'"AI/CI/HC Coverage Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECBHCIGEXPZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL,'"drvEEApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECBHCIGEXPZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL,'"drvSPApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECBHCIGEXPZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL,'"SP Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECBHCIGEXPZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL,'"drvCHCIApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECBHCIGEXPZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL,'"CH Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECBHCIGEXPZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL,'"SP First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECBHCIGEXPZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL,'"SP Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECBHCIGEXPZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL,'"SP SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECBHCIGEXPZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL,'"SP Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECBHCIGEXPZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL,'"SP DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECBHCIGEXPZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL,'"SP Smoker Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECBHCIGEXPZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL,'"Payroll Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECBHCIGEXPZ0','50','H','01','37',NULL,'Payroll Deduction Amt',NULL,NULL,'"Payroll Deduction Amt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECBHCIGEXPZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL,'"Premium Paid to Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECBHCIGEXPZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL,'"AI termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECBHCIGEXPZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL,'"drvAITermStatusEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECBHCIGEXPZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL,'"CI Termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECBHCIGEXPZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL,'"drvCITermStatusEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECBHCIGEXPZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL,'"HC Termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECBHCIGEXPZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL,'"drvHCTermStatusEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECBHCIGEXPZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL,'"Takeover Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECBHCIGEXPZ0','50','H','01','46',NULL,'File Type',NULL,NULL,'"File Type"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECBHCIGEXPZ0','50','D','10','1',NULL,'Legal Company Name',NULL,NULL,'"ChanceLight Inc"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECBHCIGEXPZ0','50','D','10','2',NULL,'Client ID',NULL,NULL,'"A129587"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECBHCIGEXPZ0','50','D','10','3',NULL,'EE First Name',NULL,NULL,'"drvEENameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECBHCIGEXPZ0','50','D','10','4',NULL,'EE Last Name',NULL,NULL,'"drvEENameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECBHCIGEXPZ0','51','D','10','5',NULL,'EE Street Address',NULL,NULL,'"drvEEAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECBHCIGEXPZ0','52','D','10','6',NULL,'EE City',NULL,NULL,'"drvEECity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECBHCIGEXPZ0','53','D','10','7',NULL,'EE State',NULL,NULL,'"drvEEState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECBHCIGEXPZ0','54','D','10','8',NULL,'EE Zip Code',NULL,NULL,'"drvEEZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECBHCIGEXPZ0','55','D','10','9',NULL,'EE SSN',NULL,NULL,'"drvEESSn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECBHCIGEXPZ0','56','D','10','10',NULL,'EE Gender',NULL,NULL,'"drvEEGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECBHCIGEXPZ0','57','D','10','11',NULL,'EE DOB',NULL,NULL,'"drvEEDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECBHCIGEXPZ0','58','D','10','12',NULL,'EE Smoker Status',NULL,NULL,'"N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECBHCIGEXPZ0','59','D','10','13',NULL,'EE Date of Hire',NULL,NULL,'"drvDateofHire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECBHCIGEXPZ0','60','D','10','14',NULL,'EE Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECBHCIGEXPZ0','61','D','10','15',NULL,'EE Status Date',NULL,NULL,'"drvStatusDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECBHCIGEXPZ0','62','D','10','16',NULL,'EE LOA Type',NULL,NULL,'"drvLOAType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECBHCIGEXPZ0','63','D','10','17',NULL,'Cigna Product Class',NULL,NULL,'"001"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECBHCIGEXPZ0','64','D','10','18',NULL,'Cigna Billing Account',NULL,NULL,'"A129587001"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECBHCIGEXPZ0','65','D','10','19',NULL,'Benefit Elected',NULL,NULL,'"drvBenefitElected"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECBHCIGEXPZ0','66','D','10','20',NULL,'Coverage Election Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECBHCIGEXPZ0','67','D','10','21',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECBHCIGEXPZ0','68','D','10','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECBHCIGEXPZ0','69','D','10','23',NULL,'Plan Type',NULL,NULL,'"drvPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECBHCIGEXPZ0','70','D','10','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL,'"drvAICIHCCoverageTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECBHCIGEXPZ0','71','D','10','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL,'"drvCIApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECBHCIGEXPZ0','72','D','10','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL,'"drvSPApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECBHCIGEXPZ0','73','D','10','27',NULL,'SP Coverage Effective Date',NULL,NULL,'"drvSPCovEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECBHCIGEXPZ0','74','D','10','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL,'"drvCHCIApprovedCovAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECBHCIGEXPZ0','75','D','10','29',NULL,'CH Coverage Effective Date',NULL,NULL,'"drvCHCovEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECBHCIGEXPZ0','76','D','10','30',NULL,'SP First Name',NULL,NULL,'"drvSPFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECBHCIGEXPZ0','77','D','10','31',NULL,'SP Last Name',NULL,NULL,'"drvSPLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECBHCIGEXPZ0','78','D','10','32',NULL,'SP SSN',NULL,NULL,'"drvSPSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECBHCIGEXPZ0','79','D','10','33',NULL,'SP Gender',NULL,NULL,'"drvSPGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECBHCIGEXPZ0','80','D','10','34',NULL,'SP DOB',NULL,NULL,'"drvSPDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECBHCIGEXPZ0','81','D','10','35',NULL,'SP Smoker Status',NULL,NULL,'"drvspsmoker"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECBHCIGEXPZ0','82','D','10','36',NULL,'Payroll Frequency',NULL,NULL,'"26"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECBHCIGEXPZ0','83','D','10','37',NULL,'Payroll Deduction Amt',NULL,NULL,'"drvPayrollDedAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECBHCIGEXPZ0','84','D','10','38',NULL,'Premium Paid to Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECBHCIGEXPZ0','85','D','10','39',NULL,'AI termination Status Code',NULL,NULL,'"drvAITermSatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECBHCIGEXPZ0','86','D','10','40',NULL,'AI Termination Status Effective Date',NULL,NULL,'"drvATTermStatusEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECBHCIGEXPZ0','87','D','10','41',NULL,'CI Termination Status Code',NULL,NULL,'"drvCITermSatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECBHCIGEXPZ0','88','D','10','42',NULL,'CI Termination Status Effective Date',NULL,NULL,'"drvCTTermStatusEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECBHCIGEXPZ0','89','D','10','43',NULL,'HC Termination Status Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECBHCIGEXPZ0','90','D','10','44',NULL,'HC Termination Status Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECBHCIGEXPZ0','91','D','10','45',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECBHCIGEXPZ0','92','D','10','46',NULL,'File Type',NULL,NULL,'"F"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECBHCIGEXP_20230105.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301089','EMPEXPORT','OEACTIVE',NULL,'ECBHCIGEXP',NULL,NULL,NULL,'202301089','Dec  8 2022  1:20PM','Dec  8 2022  1:20PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301089','EMPEXPORT','OEPASSIVE',NULL,'ECBHCIGEXP',NULL,NULL,NULL,'202301089','Dec  8 2022  1:20PM','Dec  8 2022  1:20PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna Accident and Critical Il','202301089','EMPEXPORT','ONDEM_XOE',NULL,'ECBHCIGEXP',NULL,NULL,NULL,'202301089','Dec  8 2022  1:20PM','Dec  8 2022  1:20PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cigna Accident and Criti-Sched','202301089','EMPEXPORT','SCH_ECBHCI',NULL,'ECBHCIGEXP',NULL,NULL,NULL,'202301089','Dec  8 2022  1:20PM','Dec  8 2022  1:20PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Cigna Accident and Criti-Test','202301089','EMPEXPORT','TEST_XOE',NULL,'ECBHCIGEXP',NULL,NULL,NULL,'202301089','Dec  8 2022  1:20PM','Dec  8 2022  1:20PM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECBHCIGEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHCIGEXP','H01','dbo.U_ECBHCIGEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECBHCIGEXP','D10','dbo.U_ECBHCIGEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECBHCIGEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECBHCIGEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECBHCIGEXP] (
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
-- Create table U_ECBHCIGEXP_Audit
-----------

IF OBJECT_ID('U_ECBHCIGEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_ECBHCIGEXP_AuditFields
-----------

IF OBJECT_ID('U_ECBHCIGEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECBHCIGEXP_DedList
-----------

IF OBJECT_ID('U_ECBHCIGEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECBHCIGEXP_drvTbl
-----------

IF OBJECT_ID('U_ECBHCIGEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvEENameFirst] varchar(100) NULL,
    [drvEENameLast] varchar(100) NULL,
    [drvEEAddress] varchar(8000) NULL,
    [drvEECity] varchar(6000) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(50) NULL,
    [drvEESSn] char(11) NULL,
    [drvEEGender] char(1) NULL,
    [drvEEDOB] varchar(10) NULL,
    [drvDateofHire] varchar(10) NULL,
    [drvStatus] varchar(1) NULL,
    [drvStatusDate] varchar(10) NULL,
    [drvLOAType] varchar(1) NULL,
    [drvBenefitElected] varchar(4) NULL,
    [drvCovEffDate] varchar(10) NULL,
    [drvPlanType] varchar(5) NULL,
    [drvAICIHCCoverageTier] varchar(10) NULL,
    [drvCIApprovedCovAmt] varchar(30) NULL,
    [drvSPApprovedCovAmt] varchar(30) NULL,
    [drvSPCovEffDate] varchar(30) NULL,
    [drvCHCIApprovedCovAmt] varchar(30) NULL,
    [drvCHCovEffDate] varchar(30) NULL,
    [drvSpFirstName] varchar(100) NULL,
    [drvSpLastName] varchar(100) NULL,
    [drvSpSSN] char(11) NULL,
    [drvSpGender] char(1) NULL,
    [drvSpDOB] varchar(30) NULL,
    [drvspsmoker] varchar(1) NULL,
    [drvPayrollDedAmt] varchar(30) NULL,
    [drvAITermSatusCode] varchar(1) NULL,
    [drvATTermStatusEffDate] varchar(30) NULL,
    [drvCITermSatusCode] varchar(1) NULL,
    [drvCTTermStatusEffDate] varchar(30) NULL
);

-----------
-- Create table U_ECBHCIGEXP_EEList
-----------

IF OBJECT_ID('U_ECBHCIGEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECBHCIGEXP_File
-----------

IF OBJECT_ID('U_ECBHCIGEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_ECBHCIGEXP_Header
-----------

IF OBJECT_ID('U_ECBHCIGEXP_Header') IS NULL
CREATE TABLE [dbo].[U_ECBHCIGEXP_Header] (
    [drvEEApprovedCovAmt] varchar(30) NOT NULL,
    [drvSPApprovedCovAmt] varchar(30) NOT NULL,
    [drvCHCIApprovedCovAmt] varchar(30) NOT NULL,
    [drvAITermStatusEffectiveDate] varchar(36) NOT NULL,
    [drvCITermStatusEffectiveDate] varchar(36) NOT NULL,
    [drvHCTermStatusEffectiveDate] varchar(36) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECBHCIGEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChanceLight

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 12/08/2022
Service Request Number: TekP-2022-10-06-07

Purpose: Cigna Accident and Critical Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECBHCIGEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECBHCIGEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECBHCIGEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECBHCIGEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECBHCIGEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHCIGEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHCIGEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHCIGEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHCIGEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECBHCIGEXP', 'SCH_ECBHCI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECBHCIGEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECBHCIGEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ECBHCIGEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECBHCIGEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECBHCIGEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECBHCIGEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHCIGEXP_AuditFields;
    CREATE TABLE dbo.U_ECBHCIGEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_ECBHCIGEXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECBHCIGEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHCIGEXP_Audit;
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
    INTO dbo.U_ECBHCIGEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECBHCIGEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECBHCIGEXP_Audit ON dbo.U_ECBHCIGEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECBHCIGEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECBHCIGEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '10E10,10C10,10S10,10F10,20E10,20C10,20S10,20F10,30E10,30C10,30S10,30F10,10E12,10C12,10S12,10F12,20E12,20C12,20S12,20F12,30E12,30C12,30S12,30F12,ACC10,ACC12';

    IF OBJECT_ID('U_ECBHCIGEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHCIGEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECBHCIGEXP_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RateEffDate',@EndDate);

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RateEffDate',@EndDate);
    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;


    UPDATE dbo.U_dsi_bdm_ECBHCIGEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECBHCIGEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;


    UPDATE dbo.U_dsi_bdm_ECBHCIGEXP
       SET BdmUSGField2 = DbnDepBPlanTVID
   FROM dbo.U_dsi_bdm_ECBHCIGEXP
   JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
       ON DbnEEID = BdmEEID
       AND DbnCOID = BdmCOID
       AND DbnDedCode = BdmDedCode
   WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';
       -- Run BDM Module

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    

 
   

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECBHCIGEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECBHCIGEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHCIGEXP_drvTbl;
SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvEENameFirst = EepNameFirst
        ,drvEENameLast = EepNameLast
        ,drvEEAddress = REPLACE(CONCAT(Eepaddressline1, ' ', Eepaddressline2), ',','')  --dbo.dsi_fnRemoveChars(',',EepAddressLine1 + ' ' + EepAddressLine2)
        ,drvEECity = dbo.dsi_fnRemoveChars(',',EepAddressCity)
        ,drvEEState = EepAddressState
        ,drvEEZipCode = EepAddressZipCode
        ,drvEESSn = eepSSN
        ,drvEEGender = EepGender
        ,drvEEDOB = CONVERT(VARCHAR(10),EepDateOfBirth, 101)
        ,drvDateofHire =  CONVERT(VARCHAR(10),CASE WHEn EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire else  EecDateOfOriginalHire END, 101)
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN  'D'
                            ELSE 
                                CASE WHEN EecEmplStatus IN ('T', 'L', 'A')  THEN  EecEmplStatus 
                                    ELSE  'A' 
                                END
                        END
  
        ,drvStatusDate = CONVERT(VARCHAR(10),CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                              WHEN EecEmplStatus = 'L' THEN DateADD(d, -1, EshStatusStartDate )
                            END, 101)
        ,drvLOAType = CASE WHEN EecEmplStatus = 'L' THEN 'U' END
        ,drvBenefitElected = PLAN_Code
        ,drvCovEffDate = CONVERT(VARCHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',StartDate, @FileMinCovDate) , 101)
        ,drvPlanType = CASE PLAN_Code 
                                    WHEN 'AI' THEN 'PLAN1'
                                    WHEN 'CIIR' THEN  'PLAN1'
                                END
                            
        ,drvAICIHCCoverageTier =   CASE WHEN PLAN_Code IN ('AI' ) THEN
                                            CASE WHEN BenOptions in ('EEF','EEDPF','EEFAM') THEN 'Family' 
                                                 WHEN BenOptions in ('EE') THEN 'EE'
                                                 WHEN BenOptions in ('EES','EEDP', 'EESPOU') THEN 'EE Plus SP'
                                                 WHEN BenOptions in ('EEC','EECHLD') THEN 'EE Plus CH'
                                                 ELSE 'EE'
                                               END
                                        WHEN PLAN_Code IN ('CIIR') and IsFamily = '1' THEN 'Family'
                                        WHEN PLAN_Code IN ('CIIR') and IsEE = '1' THEN 'EE'
                                        WHEN PLAN_Code IN ('CIIR') and IsSpouse = '1' THEN 'EE Plus SP'
                                        WHEN PLAN_Code IN ('CIIR') and IsCH = '1' THEN 'EE Plus CH'
                                       END
                                    
        ,drvCIApprovedCovAmt = CAST(Amount as varchar)
        ,drvSPApprovedCovAmt = CASE WHEN IsSpouse is not null or IsFamily is not null then CAST(SPS_AMT as varchar) END                 
        ,drvSPCovEffDate = Convert(varchar,CASE WHEN PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD') then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime))
                                                WHEN PLAN_Code = 'CIIR' and (IsSpouse is not null or IsFamily is not null) then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime)) 
                                           END, 101) 
        ,drvCHCIApprovedCovAmt  =  CASE WHEN IsCH is not null or IsFamily is not null then Cast( CONVERT(DECIMAL(10,0),(Cast (Amount as money) * 0.50)) as varchar) END
        ,drvCHCovEffDate = convert(varchar,CASE WHEN PLAN_Code = 'AI' and BenOptions not in ('EE','EES') then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime))
                                                WHEN PLAN_Code in ('CIIR','CIIR_Dep') and (IsCH is not null or IsFamily is not null) then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                                END, 101)  
        ,drvSpFirstName = CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) then (Select top 1 ConNameFirst from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP') and ConIsDependent = 'Y') END
        ,drvSpLastName = CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) then (Select top 1 ConNameLast from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP') and ConIsDependent = 'Y') END
        ,drvSpSSN =  CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) then (Select top 1 ConSSN from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP') and ConIsDependent = 'Y') END
        ,drvSpGender = CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) then (Select top 1 ConGender from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP') and ConIsDependent = 'Y') END
        ,drvSpDOB = convert(varchar,CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) then (Select top 1 ConDateOfBirth from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP') and ConIsDependent = 'Y') END, 101)  
        
        ,drvspsmoker = CASE WHEN (PLAN_Code = 'AI' and BenOptions not in ('EE','EECHLD')) or (IsSpouse is not null or IsFamily is not null) THEN 'N' END
        ,drvPayrollDedAmt =   CASE WHEN PLAN_Code = 'AI' THEN CAST(BenefitAmounts.AI as varchar) 
                                   WHEN PLAN_Code = 'AI' AND BenefitAmounts.AI is null THEN  CAST((Select Max(EedEeLstAmt) from dbo.empdedfull   WITH (NOLOCK) where eedeeid = xeeid and eeddedcode in ('ACC10','ACC12')) as varchar)
                                   WHEN PLAN_Code = 'CIIR' and BenefitAmounts.CIIR is not null THEN CAST(BenefitAmounts.CIIR + ISNULL(BenefitAmounts.CIIR_Dep,0) as varchar)
                                   WHEN PLAN_Code = 'CIIR' and BenefitAmounts.CIIR is  null THEN CAST((Select Max(EedEeLstAmt) from dbo.empdedfull   WITH (NOLOCK) where eedeeid = xeeid and eeddedcode in ('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12' )) as varchar)
                                 END
        ,drvAITermSatusCode = CASE WHEN PLAN_Code = 'AI' AND BenStatus in ('T','C') and eecemplstatus <> 'T' THEN 'T' END
        ,drvATTermStatusEffDate = CASE WHEN PLAN_Code = 'AI' AND BenStatus in ('T','C') and eecemplstatus <> 'T' THEN convert(varchar,StopDate, 101)  END
        ,drvCITermSatusCode = CASE WHEN PLAN_Code = 'CIIR' AND BenStatus in ('T','C') and eecemplstatus <> 'T' THEN 'T' END
        ,drvCTTermStatusEffDate = CASE WHEN PLAN_Code = 'CIIR' AND BenStatus in ('T','C') and eecemplstatus <> 'T' THEN convert(varchar,StopDate, 101) END
    INTO dbo.U_ECBHCIGEXP_drvTbl
    FROM dbo.U_ECBHCIGEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select bdmeeid,bdmcoid,
                        IsFamily = MAX(    CASE 
                                                      WHEN bdmDedCode IN('10F10', '20F10', '30F10', '10F12', '20F12', '30F12')  THEN '1'                             END 
                                                 ),
                        IsEE = MAX(    CASE 
                                                      WHEN bdmDedCode IN('10E10', '20E10', '30E10', '10E12', '20E12', '30E12' )  THEN '1'                             END 
                                                 ),
                        IsCH = MAX(    CASE 
                                                      WHEN bdmDedCode IN('10C10', '20C10', '30C10', '10C12', '20C12', '30C12')  THEN '1'                             END 
                                                 ),  
                        IsSpouse = MAX(    CASE 
                                                      WHEN bdmDedCode IN('10S10', '20S10', '30S10', '10S12', '20S12', '30S12')  THEN '1'                             END 
                                                 ),                    
                        BenOptions= MAX(    CASE
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN BdmBenOption
                                                    --  WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12') THEN BdmBenOption
                                                 END 
                                                 ),    
                                                 CASE 
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN 'AI'
                                                      WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12') THEN 'CIIR'
                                                 END AS PLAN_Code,
                        StartDate= MAX(    CASE 
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN bdmbenstartdate
                                                      WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12' ) THEN bdmbenstartdate
                                                 END 
                                                 ),
                        StopDate= MAX(    CASE 
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN bdmbenstopdate
                                                      WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12' )   THEN bdmbenstopdate
                                                 END 
                                                 ),

                        SPS = MAX(CASE WHEN bdmdedcode in ('10S10', '10F10', '10S12', '10F12','20S10', '20F10', '20S12', '20F12','30S10', '30F10', '30S12', '30F12') THEN '1' END ) ,
                        SPS_AMT = MAX(CASE  WHEN BdmDedCode IN ('10S10', '10F10', '10S12', '10F12')  THEN '5000'
                                        WHEN BdmDedCode IN ('20S10', '20F10', '20S12', '20F12')  THEN '10000'
                                        WHEN BdmDedCode IN ('30S10', '30F10', '30S12', '30F12')  THEN '15000'
                                     END ) ,
                        CHD = MAX(CASE WHEN bdmdedcode in ('10C10', '20C10', '30C10', '10C12', '20C12', '30C12', '10F10', '20F10', '30F10', '10F12', '20F12', '30F12') THEN '1' END ) ,

                        BenefitAmount =  MAX(CASE 
                                                      WHEN bdmDedCode in ('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12') THEN bdmeeamt 
                                                      WHEN bdmdedcode IN ('ACC10','ACC12') THEN bdmeeamt
                                                      END
                                                 ),

                        
                        Amount = MAX(CASE WHEN bdmDedCode IN ('10E10', '10C10', '10S10', '10F10', '10E12', '10C12', '10S12', '10F12') THEN '10000'
                                                WHEN bdmDedCode IN ('20E10', '20C10', '20S10', '20F10', '20E12', '20C12', '20S12', '20F12') THEN '20000'
                                                WHEN bdmDedCode IN ('30E10', '30C10', '30S10', '30F10', '30E12', '30C12', '30S12', '30F12') THEN '30000'
                           
                                                END),
                        BenStatus= MAX(    CASE 
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN BdmBenStatus
                                                      WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12' )   THEN BdmBenStatus
                                                 END 
                                                 )
                    FROM dbo.U_dsi_BDM_ECBHCIGEXP WITH (NOLOCK)
                    GROUP BY bdmeeid,bdmcoid,CASE 
                                                      WHEN bdmDedCode IN ('ACC10','ACC12') THEN 'AI'
                                                      WHEN bdmDedCode IN('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12' )  THEN 'CIIR'
                                                 END
                    ) as bdmConsolidated
         ON bdmConsolidated.BdmCOID =  xCOID
         AND bdmConsolidated.BdmEEID =  xeeid
    LEFT JOIN (Select bcacoid, bcaeeid,
                           CIIR = MAX(CASE WHEN  bcadedcode IN ('10E10', '10C10', '10S10', '10F10', '20E10', '20C10', '20S10', '20F10', '30E10', '30C10', '30S10', '30F10', '10E12', '10C12', '10S12', '10F12', '20E12', '20C12', '20S12', '20F12', '30E12', '30C12', '30S12', '30F12')  THEN BcaEEAmt END ) ,
                           AI = MAX(CASE WHEN  bcadedcode IN ('ACC10','ACC12') THEN BcaEEAmt END ) ,
                           CIIR_SP = MAX(CASE WHEN  bcadedcode IN ('10S10', '20S10', '30S10', '10S12', '20S12', '30S12')  THEN BcaEEAmt END ) ,
                           CIIR_Dep = MAX(CASE WHEN  bcadedcode IN ('10C10', '20C10', '30C10', '10C12', '20C12', '30C12', '10F10', '20F10', '30F10', '10F12', '20F12', '30F12') THEN  EedEeLstAmt END )
                        FROM dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
                        JOIN dbo.EmpDedFull WITH (NOLOCK) 
                        ON bcaeeid = eedeeid 
                        AND bcacoid =  eedcoid
                        AND bcadedcode = eeddedcode
                        WHERE bcaformatcode = 'ECBHCIGEXP'
                        GROUP BY bcacoid, bcaeeid
                ) AS BenefitAmounts
         ON BenefitAmounts.bcaeeid =  xeeid
        AND BenefitAmounts.bcacoid =xcoid
    LEFT JOIN dbo.U_ECBHCIGEXP_Audit WITH (NOLOCK) 
         ON audEEID = bdmeeid
         AND audKey2 = bdmCoID
         AND audFieldName = 'EecDateofTermination'
         AND audNewValue is not null
         AND audDateTime BETWEEN @startdate AND @enddate
     LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    WHERE  EecEEType <> 'TES' 
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECBHCIGEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECBHCIGEXP_Header;
    SELECT DISTINCT
         drvEEApprovedCovAmt = 'EE CI Approved Coverage Amount'
        ,drvSPApprovedCovAmt = 'SP CI Approved Coverage Amount'
        ,drvCHCIApprovedCovAmt = 'CH CI Approved Coverage Amount'
        ,drvAITermStatusEffectiveDate = 'AI Termination Status Effective Date'
        ,drvCITermStatusEffectiveDate = 'CI Termination Status Effective Date'
        ,drvHCTermStatusEffectiveDate = 'HC Termination Status Effective Date'
    INTO dbo.U_ECBHCIGEXP_Header
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
ALTER VIEW dbo.dsi_vwECBHCIGEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECBHCIGEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECBHCIGEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212011'
       ,expStartPerControl     = '202212011'
       ,expLastEndPerControl   = '202212089'
       ,expEndPerControl       = '202212089'
WHERE expFormatCode = 'ECBHCIGEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECBHCIGEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECBHCIGEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECBHCIGEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECBHCIGEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECBHCIGEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECBHCIGEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECBHCIGEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECBHCIGEXP', 'UseFileName', 'V', 'Y'


-- End ripout