/**********************************************************************************

ECIGNEWSAE: Cigna Critical Illness Export

FormatCode:     ECIGNEWSAE
Project:        Cigna Critical Illness Export
Client ID:      NEW1020
Date/time:      2021-11-30 22:17:52.297
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB02
Database:       ULTIPRO_WPNEWG
Web Filename:   NEW1020_CC960_EEHISTORY_ECIGNEWSAE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECIGNEWSAE_SavePath') IS NOT NULL DROP TABLE dbo.U_ECIGNEWSAE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECIGNEWSAE'


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
WHERE FormatCode = 'ECIGNEWSAE'
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
WHERE ExpFormatCode = 'ECIGNEWSAE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECIGNEWSAE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECIGNEWSAE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECIGNEWSAE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECIGNEWSAE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECIGNEWSAE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECIGNEWSAE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECIGNEWSAE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECIGNEWSAE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECIGNEWSAE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECIGNEWSAE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECIGNEWSAE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIGNEWSAE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIGNEWSAE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNEWSAE];
GO
IF OBJECT_ID('U_ECIGNEWSAE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_PEarHist];
GO
IF OBJECT_ID('U_ECIGNEWSAE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_PDedHist];
GO
IF OBJECT_ID('U_ECIGNEWSAE_File') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_File];
GO
IF OBJECT_ID('U_ECIGNEWSAE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_EEList];
GO
IF OBJECT_ID('U_ECIGNEWSAE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_drvTbl];
GO
IF OBJECT_ID('U_ECIGNEWSAE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIGNEWSAE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECIGNEWSAE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECIGNEWSAE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECIGNEWSAE','Cigna Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECIGNEWSAEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIGNEWSAEZ0','50','H','01','1',NULL,'Legal Company Name',NULL,NULL,'"Legal Company Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIGNEWSAEZ0','50','H','01','2',NULL,'Client ID',NULL,NULL,'"Client ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIGNEWSAEZ0','50','H','01','3',NULL,'EE First Name',NULL,NULL,'"EE First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIGNEWSAEZ0','50','H','01','4',NULL,'EE Last Name',NULL,NULL,'"EE Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIGNEWSAEZ0','50','H','01','5',NULL,'EE Street Address',NULL,NULL,'"EE Street Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIGNEWSAEZ0','50','H','01','6',NULL,'EE City',NULL,NULL,'"EE City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIGNEWSAEZ0','50','H','01','7',NULL,'EE State',NULL,NULL,'"EE State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIGNEWSAEZ0','50','H','01','8',NULL,'EE Zip Code',NULL,NULL,'"EE Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIGNEWSAEZ0','50','H','01','9',NULL,'EE SSN',NULL,NULL,'"EE SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIGNEWSAEZ0','50','H','01','10',NULL,'EE Gender',NULL,NULL,'"EE Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIGNEWSAEZ0','50','H','01','11',NULL,'EE DOB',NULL,NULL,'"EE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIGNEWSAEZ0','50','H','01','12',NULL,'EE Smoker Status',NULL,NULL,'"EE Smoker Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIGNEWSAEZ0','50','H','01','13',NULL,'EE Date of Hire',NULL,NULL,'"EE Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIGNEWSAEZ0','50','H','01','14',NULL,'EE Status',NULL,NULL,'"EE Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIGNEWSAEZ0','50','H','01','15',NULL,'EE Status Date',NULL,NULL,'"EE Status Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIGNEWSAEZ0','50','H','01','16',NULL,'EE LOA Type',NULL,NULL,'"EE LOA Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIGNEWSAEZ0','50','H','01','17',NULL,'Cigna Product Class',NULL,NULL,'"Cigna Product Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIGNEWSAEZ0','50','H','01','18',NULL,'Cigna Billing Account',NULL,NULL,'"Cigna Billing Account"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIGNEWSAEZ0','50','H','01','19',NULL,'Benefit Elected',NULL,NULL,'"Benefit Elected"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIGNEWSAEZ0','50','H','01','20',NULL,'Coverage Election Date',NULL,NULL,'"Coverage Election Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIGNEWSAEZ0','50','H','01','21',NULL,'Coverage Effective Date',NULL,NULL,'"Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIGNEWSAEZ0','50','H','01','22',NULL,'QLE/Revised Eligibility Date',NULL,NULL,'"QLE/Revised Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIGNEWSAEZ0','50','H','01','23',NULL,'Plan Type',NULL,NULL,'"Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIGNEWSAEZ0','50','H','01','24',NULL,'AI/CI/HC Coverage Tier',NULL,NULL,'"AI/CI/HC Coverage Tier"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIGNEWSAEZ0','50','H','01','25',NULL,'EE CI Approved Coverage Amount',NULL,NULL,'"EE CI Approved Coverage Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECIGNEWSAEZ0','50','H','01','26',NULL,'SP CI Approved Coverage Amount',NULL,NULL,'"SP CI Approved Coverage Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECIGNEWSAEZ0','50','H','01','27',NULL,'SP Coverage Effective Date',NULL,NULL,'"SP Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECIGNEWSAEZ0','50','H','01','28',NULL,'CH CI Approved Coverage Amount',NULL,NULL,'"CH CI Approved Coverage Amount"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECIGNEWSAEZ0','50','H','01','29',NULL,'CH Coverage Effective Date',NULL,NULL,'"CH Coverage Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECIGNEWSAEZ0','50','H','01','30',NULL,'SP First Name',NULL,NULL,'"SP First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECIGNEWSAEZ0','50','H','01','31',NULL,'SP Last Name',NULL,NULL,'"SP Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECIGNEWSAEZ0','50','H','01','32',NULL,'SP SSN',NULL,NULL,'"SP SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECIGNEWSAEZ0','50','H','01','33',NULL,'SP Gender',NULL,NULL,'"SP Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECIGNEWSAEZ0','50','H','01','34',NULL,'SP DOB',NULL,NULL,'"SP DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECIGNEWSAEZ0','50','H','01','35',NULL,'SP Smoker Status',NULL,NULL,'"SP Smoker Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECIGNEWSAEZ0','50','H','01','36',NULL,'Payroll Frequency',NULL,NULL,'"Payroll Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECIGNEWSAEZ0','50','H','01','37',NULL,'Payroll Deduction  Amt',NULL,NULL,'"Payroll Deduction  Amt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECIGNEWSAEZ0','50','H','01','38',NULL,'Premium Paid to Date',NULL,NULL,'"Premium Paid to Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECIGNEWSAEZ0','50','H','01','39',NULL,'AI termination Status Code',NULL,NULL,'"AI termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECIGNEWSAEZ0','50','H','01','40',NULL,'AI Termination Status Effective Date',NULL,NULL,'"AI Termination Status Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECIGNEWSAEZ0','50','H','01','41',NULL,'CI Termination Status Code',NULL,NULL,'"CI Termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECIGNEWSAEZ0','50','H','01','42',NULL,'CI Termination Status Effective Date',NULL,NULL,'"CI Termination Status Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECIGNEWSAEZ0','50','H','01','43',NULL,'HC Termination Status Code',NULL,NULL,'"HC Termination Status Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECIGNEWSAEZ0','50','H','01','44',NULL,'HC Termination Status Effective Date',NULL,NULL,'"HC Termination Status Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECIGNEWSAEZ0','50','H','01','45',NULL,'Takeover Indicator',NULL,NULL,'"Takeover Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECIGNEWSAEZ0','50','H','01','46',NULL,'File Type',NULL,NULL,'"File Type"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECIGNEWSAEZ0','50','D','10','1',NULL,'drvLegalCompanyName',NULL,NULL,'"drvLegalCompanyName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECIGNEWSAEZ0','50','D','10','2',NULL,'drvClientID',NULL,NULL,'"drvClientID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECIGNEWSAEZ0','50','D','10','3',NULL,'drvEEFirstName',NULL,NULL,'"drvEEFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECIGNEWSAEZ0','50','D','10','4',NULL,'drvEELastName',NULL,NULL,'"drvEELastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECIGNEWSAEZ0','50','D','10','5',NULL,'drvEEStreetAddress',NULL,NULL,'"drvEEStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECIGNEWSAEZ0','50','D','10','6',NULL,'drvEECity',NULL,NULL,'"drvEECity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECIGNEWSAEZ0','50','D','10','7',NULL,'drvEEState',NULL,NULL,'"drvEEState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECIGNEWSAEZ0','50','D','10','8',NULL,'drvEEZipCode',NULL,NULL,'"drvEEZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECIGNEWSAEZ0','50','D','10','9',NULL,'drvEESSN',NULL,NULL,'"drvEESSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECIGNEWSAEZ0','50','D','10','10',NULL,'drvEEGender',NULL,NULL,'"drvEEGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECIGNEWSAEZ0','50','D','10','11',NULL,'drvEEDOB',NULL,NULL,'"drvEEDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECIGNEWSAEZ0','50','D','10','12',NULL,'drvEESmokerStatus',NULL,NULL,'"drvEESmokerStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECIGNEWSAEZ0','50','D','10','13',NULL,'drvEEDateofHire',NULL,NULL,'"drvEEDateofHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECIGNEWSAEZ0','50','D','10','14',NULL,'drvEEStatus',NULL,NULL,'"drvEEStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECIGNEWSAEZ0','50','D','10','15',NULL,'drvEEStatusDate',NULL,NULL,'"drvEEStatusDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECIGNEWSAEZ0','50','D','10','16',NULL,'drvEELOAType',NULL,NULL,'"drvEELOAType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECIGNEWSAEZ0','50','D','10','17',NULL,'drvCignaProductClass',NULL,NULL,'"drvCignaProductClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECIGNEWSAEZ0','50','D','10','18',NULL,'drvCignaBillingAccount',NULL,NULL,'"drvCignaBillingAccount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECIGNEWSAEZ0','50','D','10','19',NULL,'drvBenefitElected',NULL,NULL,'"drvBenefitElected"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECIGNEWSAEZ0','50','D','10','20',NULL,'drvCoverageElectionDate',NULL,NULL,'"drvCoverageElectionDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECIGNEWSAEZ0','50','D','10','21',NULL,'drvCoverageEffectiveDate',NULL,NULL,'"drvCoverageEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECIGNEWSAEZ0','50','D','10','22',NULL,'drvQLERevisedEligibilityDate',NULL,NULL,'"drvQLERevisedEligibilityDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECIGNEWSAEZ0','50','D','10','23',NULL,'drvPlanType',NULL,NULL,'"drvPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECIGNEWSAEZ0','50','D','10','24',NULL,'drvAICIHCCoverageTier',NULL,NULL,'"drvAICIHCCoverageTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECIGNEWSAEZ0','50','D','10','25',NULL,'drvEECIApprovedCoverageAmount',NULL,NULL,'"drvEECIApprovedCoverageAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECIGNEWSAEZ0','50','D','10','26',NULL,'drvSPCIApprovedCoverageAmount',NULL,NULL,'"drvSPCIApprovedCoverageAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECIGNEWSAEZ0','50','D','10','27',NULL,'drvSPCoverageEffectiveDate',NULL,NULL,'"drvSPCoverageEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECIGNEWSAEZ0','50','D','10','28',NULL,'drvCHCIApprovedCoverageAmount',NULL,NULL,'"drvCHCIApprovedCoverageAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECIGNEWSAEZ0','50','D','10','29',NULL,'drvCHCoverageEffectiveDate',NULL,NULL,'"drvCHCoverageEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECIGNEWSAEZ0','50','D','10','30',NULL,'drvSPFirstName',NULL,NULL,'"drvSPFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECIGNEWSAEZ0','50','D','10','31',NULL,'drvSPLastName',NULL,NULL,'"drvSPLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECIGNEWSAEZ0','50','D','10','32',NULL,'drvSPSSN',NULL,NULL,'"drvSPSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECIGNEWSAEZ0','50','D','10','33',NULL,'drvSPGender',NULL,NULL,'"drvSPGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECIGNEWSAEZ0','50','D','10','34',NULL,'drvSPDOB',NULL,NULL,'"drvSPDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECIGNEWSAEZ0','50','D','10','35',NULL,'drvSPSmokerStatus',NULL,NULL,'"drvSPSmokerStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECIGNEWSAEZ0','50','D','10','36',NULL,'drvPayrollFrequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECIGNEWSAEZ0','50','D','10','37',NULL,'drvPayrollDeductionAmt',NULL,NULL,'"drvPayrollDeductionAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECIGNEWSAEZ0','50','D','10','38',NULL,'drvPremiumPaidtoDate',NULL,NULL,'"drvPremiumPaidtoDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECIGNEWSAEZ0','50','D','10','39',NULL,'drvAIterminationStatusCode',NULL,NULL,'"drvAIterminationStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECIGNEWSAEZ0','50','D','10','40',NULL,'drvAITerminationStatusEffectiveDate',NULL,NULL,'"drvAITerminationStatusEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECIGNEWSAEZ0','50','D','10','41',NULL,'drvCITerminationStatusCode',NULL,NULL,'"drvCITerminationStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECIGNEWSAEZ0','50','D','10','42',NULL,'drvCITerminationStatusEffectiveDate',NULL,NULL,'"drvCITerminationStatusEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECIGNEWSAEZ0','50','D','10','43',NULL,'drvHCTerminationStatusCode',NULL,NULL,'"drvHCTerminationStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECIGNEWSAEZ0','50','D','10','44',NULL,'drvHCTerminationStatusEffectiveDate',NULL,NULL,'"drvHCTerminationStatusEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECIGNEWSAEZ0','50','D','10','45',NULL,'drvTakeoverIndicator',NULL,NULL,'"drvTakeoverIndicator"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECIGNEWSAEZ0','50','D','10','46',NULL,'drvFileType',NULL,NULL,'"drvFileType"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECIGNEWSAE_20211130.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202108199','EMPEXPORT','OEACTIVE',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202108199','EMPEXPORT','OEPASSIVE',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Newport Cigna SA Export','202108199','EMPEXPORT','ONDEMAND',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202108199','EMPEXPORT','SCH_CICSX',NULL,'ECIGNEWSAE',NULL,NULL,NULL,'202108199','Aug 19 2021  6:36PM','Aug 19 2021  6:36PM','202108191',NULL,'','','202108191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','U5P4Y,CXNNJ',NULL,NULL,NULL,'Test Purposes Only','202111121','EMPEXPORT','TEST','Nov 23 2021 11:23PM','ECIGNEWSAE',NULL,NULL,NULL,'202111121','Nov 12 2021 12:00AM','Dec 30 1899 12:00AM','202111011','115','','','202111011',dbo.fn_GetTimedKey(),NULL,'us3cPeNEW1020',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIGNEWSAE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNEWSAE','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIGNEWSAE','D10','dbo.U_ECIGNEWSAE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECIGNEWSAE
-----------

IF OBJECT_ID('U_dsi_BDM_ECIGNEWSAE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECIGNEWSAE] (
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
-- Create table U_ECIGNEWSAE_DedList
-----------

IF OBJECT_ID('U_ECIGNEWSAE_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECIGNEWSAE_drvTbl
-----------

IF OBJECT_ID('U_ECIGNEWSAE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvLegalCompanyName] varchar(17) NOT NULL,
    [drvClientID] varchar(6) NOT NULL,
    [drvEEFirstName] varchar(100) NULL,
    [drvEELastName] varchar(100) NULL,
    [drvEEStreetAddress] varchar(6000) NULL,
    [drvEECity] varchar(255) NULL,
    [drvEEState] varchar(255) NULL,
    [drvEEZipCode] varchar(5) NULL,
    [drvEESSN] char(11) NULL,
    [drvEEGender] char(1) NULL,
    [drvEEDOB] datetime NULL,
    [drvEESmokerStatus] varchar(1) NULL,
    [drvEEDateofHire] datetime NULL,
    [drvEEStatus] varchar(1) NOT NULL,
    [drvEEStatusDate] datetime NULL,
    [drvEELOAType] varchar(1) NULL,
    [drvCignaProductClass] varchar(3) NOT NULL,
    [drvCignaBillingAccount] varchar(3) NOT NULL,
    [drvBenefitElected] varchar(3) NULL,
    [drvCoverageElectionDate] varchar(1) NOT NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvQLERevisedEligibilityDate] varchar(1) NOT NULL,
    [drvPlanType] varchar(8) NULL,
    [drvAICIHCCoverageTier] varchar(10) NULL,
    [drvEECIApprovedCoverageAmount] varchar(5) NULL,
    [drvSPCIApprovedCoverageAmount] varchar(30) NULL,
    [drvSPCoverageEffectiveDate] datetime NULL,
    [drvCHCIApprovedCoverageAmount] varchar(30) NULL,
    [drvCHCoverageEffectiveDate] datetime NULL,
    [drvSPFirstName] varchar(100) NULL,
    [drvSPLastName] varchar(100) NULL,
    [drvSPSSN] char(11) NULL,
    [drvSPGender] char(1) NULL,
    [drvSPDOB] datetime NULL,
    [drvSPSmokerStatus] varchar(1) NULL,
    [drvPayrollFrequency] varchar(2) NOT NULL,
    [drvPayrollDeductionAmt] varchar(30) NULL,
    [drvPremiumPaidtoDate] varchar(1) NOT NULL,
    [drvAIterminationStatusCode] varchar(1) NULL,
    [drvAITerminationStatusEffDate] datetime NULL,
    [drvCITerminationStatusCode] varchar(1) NULL,
    [drvCITerminationStatusEffDate] datetime NULL,
    [drvHCTerminationStatusCode] varchar(1) NULL,
    [drvHCTerminationStatusEffDate] datetime NULL,
    [drvTakeoverIndicator] varchar(1) NOT NULL,
    [drvFileType] varchar(1) NOT NULL
);

-----------
-- Create table U_ECIGNEWSAE_EEList
-----------

IF OBJECT_ID('U_ECIGNEWSAE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECIGNEWSAE_File
-----------

IF OBJECT_ID('U_ECIGNEWSAE_File') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECIGNEWSAE_PDedHist
-----------

IF OBJECT_ID('U_ECIGNEWSAE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_PDedHist] (
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
-- Create table U_ECIGNEWSAE_PEarHist
-----------

IF OBJECT_ID('U_ECIGNEWSAE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECIGNEWSAE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIGNEWSAE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Newport Group, Inc.

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 08/19/2021
Service Request Number: SR-2016-00012345

Purpose: Newport Cigna SA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECIGNEWSAE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECIGNEWSAE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECIGNEWSAE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECIGNEWSAE', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECIGNEWSAE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECIGNEWSAE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECIGNEWSAE';

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
    DELETE FROM dbo.U_ECIGNEWSAE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECIGNEWSAE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECIGNEWSAE_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from empcomp where eeceetype ='T');

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HOSPI, AI, CIC25, CIE05, CIE10, CIE15, CIE20, CIS05, CIS10';

    IF OBJECT_ID('U_ECIGNEWSAE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECIGNEWSAE_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','CIS05,CIS10,CIC25');

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

     EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

     Delete  from dbo.u_dsi_bdm_empdeductions 
     where eedformatcode = 'ECIGNEWSAE' 
    and eedbenstatus is null

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECIGNEWSAE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_PDedHist;
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
    INTO dbo.U_ECIGNEWSAE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECIGNEWSAE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECIGNEWSAE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl and PehEarnCode in ('PTO','SICK') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECIGNEWSAE_PEarHist
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
    -- DETAIL RECORD - U_ECIGNEWSAE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECIGNEWSAE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECIGNEWSAE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvLegalCompanyName = 'Newport Group Inc'
        ,drvClientID = '301241'
        ,drvEEFirstName = EepNameFirst
        ,drvEELastName = EepNameLast
        ,drvEEStreetAddress = dbo.dsi_fnRemoveChars(',',Isnull(eepaddressline1,'') + ISNULL(eepaddressline2,''))
        ,drvEECity = EepAddressCity
        ,drvEEState = EepAddressState
        ,drvEEZipCode = LEFT(EepAddressZipCode,5)
        ,drvEESSN = eepSSN
        ,drvEEGender = EepGender
        ,drvEEDOB = EepDateOfBirth
        ,drvEESmokerStatus = eepIsSmoker
        ,drvEEDateofHire = eecDateofLastHire
        ,drvEEStatus = CASE WHEN EecEmplStatus = 'T' and eecTermReason not in('203','D') THEN 'T'
                            WHEN EecEmplStatus = 'L' THEN 'L'
                            WHEN EecEmplStatus = 'T' and eecTermReason  in('203','D') THEN 'D'
                            ELSE 'A'
                       END
        ,drvEEStatusDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateLastWorked
                            WHEN EecEmplStatus = 'L' THEN Dateadd(day,-1,EecEmplStatusStartDate)
                            
                       END
        ,drvEELOAType = CASE WHEN EecEmplStatus = 'L' THEN 
                                CASE WHEN PehCurHrs > 0 THEN 'P' ELSE 'U' END
                            END
        ,drvCignaProductClass = '001'
        ,drvCignaBillingAccount = '001'
        ,drvBenefitElected = PLAN_Code
        ,drvCoverageElectionDate = ''
        ,drvCoverageEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmConsolidated.StartDate, CAST('1/1/2021' as datetime) )
        ,drvQLERevisedEligibilityDate = ''
        ,drvPlanType = CASE WHEN PLAN_Code = 'VHC' THEN 'HC960956'
                            WHEN PLAN_Code = 'VAI' THEN 'AI961746'
                            WHEN PLAN_Code IN ('VCI') THEN 'CI961662'
                            END
        ,drvAICIHCCoverageTier = CASE WHEN PLAN_Code in ('VHC','VAI') THEN        
                                            CASE WHEN BenOptions in ('EE','Z','') THEN 'EE'
                                                 WHEN BenOptions IN ('EES','EEDP') THEN 'EE Plus SP'    
                                                 WHEN BenOptions IN ('EEC') THEN 'EE Plus CH'
                                                 WHEN BenOptions IN ('EEF','EEDPF') THEN 'Family'
                                            END
                                        WHEN PLAN_Code = 'VCI'  THEN
                                                CASE WHEN SPS is null and CHD is not null then 'EE Plus CH'
                                                     WHEN CHD is not null and SPS is not null then 'Family'
                                                     WHEN SPS is not null and CHD is null then 'EE Plus SP'
                                                    ELSE 'EE'
                                                END
                                 END
        ,drvEECIApprovedCoverageAmount = Amount
        ,drvSPCIApprovedCoverageAmount = CASE WHEN SPS is not null then CAST(SPS_AMT as varchar) END
        ,drvSPCoverageEffectiveDate = CASE 
                                                WHEN PLAN_Code in ('VHC','VAI') and  BenOptions IN ('EES','EEDP','EEF','EEDPF') THEN  dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                                WHEN SPS is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                           
                                           END
        ,drvCHCIApprovedCoverageAmount = CASE WHEN CHD is not null then Cast( CONVERT(DECIMAL(10,0),(Cast (Amount as money) * 0.25)) as varchar) END
        ,drvCHCoverageEffectiveDate = CASE 
                                            WHEN PLAN_Code in ('VHC','VAI') and BenOptions IN ('EEC','EEF','EEDPF') THEN dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                            WHEN CHD is not null then dbo.dsi_fnGetMinMaxDates('MAX',StartDate, CAST('1/1/2021' as datetime) ) 
                                           
                                             END
        ,drvSPFirstName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameFirst from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPLastName = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConNameLast from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPSSN = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConSSN from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPGender = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConGender from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPDOB = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConDateOfBirth from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvSPSmokerStatus = CASE WHEN PLAN_Code in ('VHC','VAI') or SPS is not null then (Select top 1 ConIsSmoker from dbo.Contacts WITH (NOLOCK) where ConEEID = BdmEEID and ConRelationship in ('SPS','DP')) END
        ,drvPayrollFrequency = '26'
        ,drvPayrollDeductionAmt = CASE WHEN PLAN_Code = 'VAI' THEN CAST(BenefitAmounts.VAI as varchar) 
                                        WHEN PLAN_Code = 'VHC' THEN CAST(BenefitAmounts.VHC as varchar)
                                        WHEN PLAN_Code = 'VCI' THEN CAST(BenefitAmounts.VCI + ISNULL(BenefitAmounts.VCI_Dep,0) as varchar)
                                         END
        ,drvPremiumPaidtoDate = ''
        ,drvAIterminationStatusCode = CASE WHEN PLAN_Code = 'VAI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvAITerminationStatusEffDate = CASE WHEN PLAN_Code = 'VAI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvCITerminationStatusCode = CASE WHEN PLAN_Code = 'VCI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvCITerminationStatusEffDate = CASE WHEN PLAN_Code = 'VCI' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvHCTerminationStatusCode = CASE WHEN PLAN_Code = 'VHC' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN 'T' END
        ,drvHCTerminationStatusEffDate = CASE WHEN PLAN_Code = 'VHC' and EecEmplStatus <> 'T' and BenStatus in ('T','W','C') THEN StopDate END
        ,drvTakeoverIndicator = ''
        ,drvFileType = 'F'
    INTO dbo.U_ECIGNEWSAE_drvTbl
    FROM dbo.U_ECIGNEWSAE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    LEFT JOIN dbo.U_ECIGNEWSAE_PEarHist  WITH (NOLOCK)
        on PehEEID =  xeeid
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     
        /*
    JOIN (Select bdmeeid,bdmcoid,
    BenOptions= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN BdmBenOption
                                  WHEN bdmDedCode = 'AI' THEN BdmBenOption
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN BdmBenOption
                             END 
                             ),
    CASE WHEN bdmDedCode='HOSPI' THEN 'VHC'
                                  WHEN bdmDedCode = 'AI' THEN 'VAI'
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END AS PLAN_Code,
            StartDate= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN bdmbenstartdate
                                  WHEN bdmDedCode = 'AI' THEN bdmbenstartdate
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN bdmbenstartdate
                             END 
                             ),
            StopDate= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN bdmbenstopdate
                                  WHEN bdmDedCode = 'AI' THEN bdmbenstopdate
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN bdmbenstopdate
                             END 
                             ),
            SPS = MAX(CASE WHEN bdmdedcode in ('CIS05','CIS10') THEN '1' END ) ,
            SPS_AMT = MAX(CASE  WHEN BdmDedCode = 'CIS05' THEN '5000'
                    WHEN BdmDedCode = 'CIS10' THEN '10000'
                 END ) ,
            CHD = MAX(CASE WHEN bdmdedcode in ('CIC25') THEN '1' END ) ,

            BenefitAmount =  MAX(    CASE 
                                  WHEN bdmDedCode = 'AI' THEN bdmeeamt 
                                  WHEN bdmdedcode = 'HOSPI' THEN bdmeeamt
                                  END
                             ),
            Amount = MAX(CASE WHEN bdmDedCode = 'CIE05' THEN '5000'
                            WHEN bdmDedCode = 'CIE10' THEN '10000'
                            WHEN bdmDedCode = 'CIE15' THEN '15000'
                            WHEN bdmDedCode = 'CIE20' THEN '20000'
                            WHEN BdmDedCode = 'CIS05' THEN '5000'
                            WHEN BdmDedCode = 'CIS10' THEN '10000'
                            END),
            BenStatus= MAX(    CASE WHEN bdmDedCode='HOSPI' THEN BdmBenStatus
                                  WHEN bdmDedCode = 'AI' THEN BdmBenStatus
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN BdmBenStatus
                             END 
                             )
 from dbo.U_dsi_BDM_ECIGNEWSAE 

 group by bdmeeid,bdmcoid,CASE WHEN bdmDedCode='HOSPI' THEN 'VHC'
                                  WHEN bdmDedCode = 'AI' THEN 'VAI'
                                  WHEN bdmDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END) as bdmConsolidated
        ON bdmConsolidated.BdmCOID =  xCOID
        and bdmConsolidated.BdmEEID =  xeeid
        */
        JOIN (Select eedeeid as bdmeeid,eedcoid as bdmcoid,
    BenOptions= MAX(    CASE WHEN eedDedCode='HOSPI' THEN eedBenOption
                                  WHEN eedDedCode = 'AI' THEN eedBenOption
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN eedBenOption
                             END 
                             ),
    CASE WHEN eedDedCode='HOSPI' THEN 'VHC'
                                  WHEN eedDedCode = 'AI' THEN 'VAI'
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END AS PLAN_Code,
            StartDate= MAX(    CASE WHEN eedDedCode='HOSPI' THEN eedbenstartdate
                                  WHEN eedDedCode = 'AI' THEN eedbenstartdate
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN eedbenstartdate
                             END 
                             ),
            StopDate= MAX(    CASE WHEN eedDedCode='HOSPI' THEN eedstopdate
                                  WHEN eedDedCode = 'AI' THEN eedstopdate
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN eedstopdate
                             END 
                             ),
            SPS = MAX(CASE WHEN eedDedCode in ('CIS05','CIS10') THEN '1' END ) ,
            SPS_AMT = MAX(CASE  WHEN eedDedCode = 'CIS05' THEN '5000'
                    WHEN eedDedCode = 'CIS10' THEN '10000'
                 END ) ,
            CHD = MAX(CASE WHEN eedDedCode in ('CIC25') THEN '1' END ) ,

            BenefitAmount =  MAX(    CASE 
                                  WHEN eedDedCode = 'AI' THEN eedeeamt 
                                  WHEN eedDedCode = 'HOSPI' THEN eedeeamt
                                  END
                             ),
            Amount = MAX(CASE WHEN eedDedCode = 'CIE05' THEN '5000'
                            WHEN eedDedCode = 'CIE10' THEN '10000'
                            WHEN eedDedCode = 'CIE15' THEN '15000'
                            WHEN eedDedCode = 'CIE20' THEN '20000'
                            WHEN eedDedCode = 'CIS05' THEN '5000'
                            WHEN eedDedCode = 'CIS10' THEN '10000'
                            END),
            BenStatus= MAX(    CASE WHEN eedDedCode='HOSPI' THEN eedBenStatus
                                  WHEN eedDedCode = 'AI' THEN eedBenStatus
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN eedBenStatus
                             END 
                             )
 from dbo.u_dsi_bdm_empdeductions 
 where eedformatcode = 'ECIGNEWSAE'
 group by eedeeid,eedcoid,CASE WHEN eedDedCode='HOSPI' THEN 'VHC'
                                  WHEN eedDedCode = 'AI' THEN 'VAI'
                                  WHEN eedDedCode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10')  THEN 'VCI'
                             END) as bdmConsolidated
        ON bdmConsolidated.BdmCOID =  xCOID
        and bdmConsolidated.BdmEEID =  xeeid
LEFT JOIN (Select bcacoid, bcaeeid,VCI = MAX(CASE WHEN  bcadedcode IN('CIC25', 'CIE05', 'CIE10', 'CIE15', 'CIE20', 'CIS05', 'CIS10') THEN BcaEEAmt END ) ,
       VAI = MAX(CASE WHEN  bcadedcode IN('AI') THEN BcaEEAmt END ) ,
       VHC = MAX(CASE WHEN  bcadedcode IN('HOSPI') THEN BcaEEAmt END ),
           VCI_Dep = MAX(CASE WHEN  bcadedcode IN('CIC25', 'CIS05', 'CIS10') THEN EedEeLstAmt END )
 
from U_dsi_bdm_BenCalculationAmounts JOIN 
dbo.EmpDed on bcaeeid = eedeeid and bcacoid =  eedcoid
and bcadedcode = eeddedcode
where bcaformatcode = 'ECIGNEWSAE' 
group by bcacoid, bcaeeid) AS BenefitAmounts
    on BenefitAmounts.bcaeeid =  xeeid
    and BenefitAmounts.bcacoid =xcoid


    --Added this as per request from Client 11/23/2021
    Delete  from dbo.U_ECIGNEWSAE_drvTbl where 
    drvAITerminationStatusEffDate < CAST('1/1/2021' as datetime) or drvCITerminationStatusEffDate < CAST('1/1/2021' as datetime) 
    or drvHCTerminationStatusEffDate < CAST('1/1/2021' as datetime)

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECIGNEWSAE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECIGNEWSAE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECIGNEWSAE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108121'
       ,expStartPerControl     = '202108121'
       ,expLastEndPerControl   = '202108199'
       ,expEndPerControl       = '202108199'
WHERE expFormatCode = 'ECIGNEWSAE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECIGNEWSAE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECIGNEWSAE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECIGNEWSAE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECIGNEWSAE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECIGNEWSAE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIGNEWSAE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECIGNEWSAE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECIGNEWSAE', 'UseFileName', 'V', 'Y'


-- End ripout