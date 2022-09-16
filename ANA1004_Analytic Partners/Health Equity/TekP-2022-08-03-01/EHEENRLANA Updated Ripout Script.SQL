/**********************************************************************************

EHEENRLANA: Health Equity Enrollment Exp

FormatCode:     EHEENRLANA
Project:        Health Equity Enrollment Exp
Client ID:      ANA1004
Date/time:      2022-09-12 17:43:05.867
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP5DB04
Database:       ULTIPRO_WPANPA
Web Filename:   ANA1004_WT244_EEHISTORY_EHEENRLANA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHEENRLANA_SavePath') IS NOT NULL DROP TABLE dbo.U_EHEENRLANA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHEENRLANA'


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
WHERE FormatCode = 'EHEENRLANA'
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
WHERE ExpFormatCode = 'EHEENRLANA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHEENRLANA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHEENRLANA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHEENRLANA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHEENRLANA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHEENRLANA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHEENRLANA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHEENRLANA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHEENRLANA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHEENRLANA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHEENRLANA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHEENRLANA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHEENRLANA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHEENRLANA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEENRLANA];
GO
IF OBJECT_ID('U_EHEENRLANA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_PDedHist];
GO
IF OBJECT_ID('U_EHEENRLANA_File') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_File];
GO
IF OBJECT_ID('U_EHEENRLANA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_EEList];
GO
IF OBJECT_ID('U_EHEENRLANA_drvProTbl') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_drvProTbl];
GO
IF OBJECT_ID('U_EHEENRLANA_drvEnrTbl') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_drvEnrTbl];
GO
IF OBJECT_ID('U_EHEENRLANA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_DedList];
GO
IF OBJECT_ID('U_EHEENRLANA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_AuditFields];
GO
IF OBJECT_ID('U_EHEENRLANA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHEENRLANA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHEENRLANA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHEENRLANA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHEENRLANA','Health Equity Enrollment Exp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EHEENRLANAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHEENRLANAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHEENRLANAZ0','50','D','10','2',NULL,'WW Group ID',NULL,NULL,'"drvWWGrpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHEENRLANAZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvPartEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHEENRLANAZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHEENRLANAZ0','50','D','10','5',NULL,'Change to Unique ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHEENRLANAZ0','50','D','10','6',NULL,'Old Unique ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHEENRLANAZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHEENRLANAZ0','50','D','10','8',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHEENRLANAZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHEENRLANAZ0','50','D','10','10',NULL,'Birth Date',NULL,NULL,'"drvDOB"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHEENRLANAZ0','50','D','10','11',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHEENRLANAZ0','50','D','10','12',NULL,'Street Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHEENRLANAZ0','50','D','10','13',NULL,'Street Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHEENRLANAZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHEENRLANAZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHEENRLANAZ0','50','D','10','16',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHEENRLANAZ0','50','D','10','17',NULL,'Zip Code Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHEENRLANAZ0','50','D','10','18',NULL,'Work ZIP Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHEENRLANAZ0','50','D','10','19',NULL,'Email Address',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHEENRLANAZ0','50','D','10','20',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHEENRLANAZ0','50','D','10','21',NULL,'Phone Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHEENRLANAZ0','50','D','10','22',NULL,'Employment Hire Date',NULL,NULL,'"drvEmpHireDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHEENRLANAZ0','50','D','10','23',NULL,'Employment Termination Date',NULL,NULL,'"drvEmpTermDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHEENRLANAZ0','50','D','10','24',NULL,'Benefit Group Code',NULL,NULL,'"drvBenGrpCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHEENRLANAZ0','50','D','10','25',NULL,'Benefit Group Effective Date',NULL,NULL,'"drvBenGrpEffDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHEENRLANAZ0','50','D','10','26',NULL,'Payroll Group Code',NULL,NULL,'"drvPayGrpCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHEENRLANAZ0','50','D','10','27',NULL,'Payroll Group Effective Date',NULL,NULL,'"drvPayGrpEffDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHEENRLANAZ0','50','D','10','28',NULL,'Location Code',NULL,NULL,'"drvLocCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHEENRLANAZ0','50','D','10','29',NULL,'Company Code',NULL,NULL,'"drvCompCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHEENRLANAZ0','50','D','10','30',NULL,'For Future Use 1 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHEENRLANAZ0','50','D','10','31',NULL,'For Future Use 2 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHEENRLANAZ0','50','D','10','32',NULL,'Bank Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHEENRLANAZ0','50','D','10','33',NULL,'Bank Account Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHEENRLANAZ0','50','D','10','34',NULL,'Bank Routing Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHEENRLANAZ0','50','D','10','35',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHEENRLANAZ0','50','D','10','36',NULL,'Payment Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EHEENRLANAZ0','50','D','10','37',NULL,'Commuter Program Benefit Group Codes',NULL,NULL,'"drvCommuterPrgm"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EHEENRLANAZ0','50','D','10','38',NULL,'Participant Level Monthly Subsidy for PT&VP: Amoun',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EHEENRLANAZ0','50','D','10','39',NULL,'Participant Level Monthly Subsidy for PT&VP: Perce',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EHEENRLANAZ0','50','D','10','40',NULL,'Participant Level Monthly Subsidy for PT&VP: Maxim',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EHEENRLANAZ0','50','D','10','41',NULL,'For Future Use 3 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EHEENRLANAZ0','50','D','10','42',NULL,'Participant Level Monthly Subsidy for PK: Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EHEENRLANAZ0','50','D','10','43',NULL,'Participant Level Monthly Subsidy for PK: Percenta',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EHEENRLANAZ0','50','D','10','44',NULL,'Participant Level Monthly Subsidy for PK: Maximum',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EHEENRLANAZ0','50','D','10','45',NULL,'For Future Use 4 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EHEENRLANAZ0','50','D','10','46',NULL,'For Future Use 5 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EHEENRLANAZ0','50','D','10','47',NULL,'For Internal Use Only 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EHEENRLANAZ0','50','D','10','48',NULL,'For Internal Use Only 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EHEENRLANAZ0','50','D','10','49',NULL,'For Internal Use Only 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EHEENRLANAZ0','50','D','10','50',NULL,'For Internal Use Only 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EHEENRLANAZ0','51','D','10','51',NULL,'For Internal Use Only 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EHEENRLANAZ0','52','D','10','52',NULL,'For Internal Use Only 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EHEENRLANAZ0','53','D','10','53',NULL,'For Internal Use Only 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EHEENRLANAZ0','54','D','10','54',NULL,'For Internal Use Only 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EHEENRLANAZ0','54','D','10','55',NULL,'For Internal Use Only 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EHEENRLANAZ0','54','D','10','56',NULL,'For Internal Use Only 10 (Health Care)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EHEENRLANAZ0','54','D','10','57',NULL,'Participant Updates Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EHEENRLANAZ0','54','D','10','58',NULL,'Country Code',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHEENRLANAZ0','54','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHEENRLANAZ0','54','D','20','2',NULL,'WW Group ID',NULL,NULL,'"drvWWGrpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHEENRLANAZ0','54','D','20','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvPartEmpId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHEENRLANAZ0','54','D','20','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHEENRLANAZ0','54','D','20','5',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHEENRLANAZ0','54','D','20','6',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHEENRLANAZ0','54','D','20','7',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHEENRLANAZ0','54','D','20','8',NULL,'Plan Action Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHEENRLANAZ0','54','D','20','9',NULL,'Election Amount',NULL,NULL,'"drvElectAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHEENRLANAZ0','54','D','20','10',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHEENRLANAZ0','54','D','20','11',NULL,'Coverage End Date',NULL,NULL,'"drvCovEndDt"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHEENRLANAZ0','54','D','20','12',NULL,'HSA-Compatible Coverage Option',NULL,NULL,'"drvCompCovOption"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHEENRLANAZ0','54','D','20','13',NULL,'HSA-Compatible Coverage Option Effective Date',NULL,NULL,'"drvCompCovOptEfDt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHEENRLANAZ0','54','D','20','14',NULL,'Standard Coverage Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHEENRLANAZ0','54','D','20','15',NULL,'Standard Coverage Option Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHEENRLANAZ0','54','D','20','16',NULL,'HRA Deductible Requirement Met',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHEENRLANAZ0','54','D','20','17',NULL,'Automatic Health Plan Claims',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHEENRLANAZ0','54','D','20','18',NULL,'Terms & Conditions Accept Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHEENRLANAZ0','54','D','20','19',NULL,'Terms & Conditions Timestamp',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHEENRLANAZ0','54','D','20','20',NULL,'Custodian Statement Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHEENRLANAZ0','54','D','20','21',NULL,'Period of Non-Coverage Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHEENRLANAZ0','54','D','20','22',NULL,'Period of Non-Coverage End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHEENRLANAZ0','54','D','20','23',NULL,'Period of Non-Coverage Reason',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHEENRLANAZ0','54','D','20','24',NULL,'HDHP Coverage Level',NULL,NULL,'"drvHDHPCovLvl"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHEENRLANAZ0','54','D','20','25',NULL,'HDHP Coverage Calendar Year',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHEENRLANAZ0','54','D','20','26',NULL,'HRA Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHEENRLANAZ0','54','D','20','27',NULL,'For Internal Use Only 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHEENRLANAZ0','54','D','20','28',NULL,'For Internal Use Only 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHEENRLANAZ0','54','D','20','29',NULL,'FSA/HRA Post-Deductible Met (Switch from Limited t',NULL,NULL,'""','(''SS''=''T|)');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHEENRLANA_20220912.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','9IGR6',NULL,NULL,NULL,'Active Open Enrollment Export','202207019','EMPEXPORT','OEACTIVE','Nov 11 2021  4:41PM','EHEENRLANA',NULL,NULL,NULL,'202207019','Nov  9 2021 12:00AM','Dec 30 1899 12:00AM','202207011','39','','','202207011',dbo.fn_GetTimedKey(),NULL,'us3cPeANA1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',9IGR6',NULL,NULL,NULL,'Passive Open Enrollment Export','202207019','EMPEXPORT','OEPASSIVE','Nov 11 2021  4:41PM','EHEENRLANA',NULL,NULL,NULL,'202207019','Nov  9 2021 12:00AM','Dec 30 1899 12:00AM','202207011','188','','','202207011',dbo.fn_GetTimedKey(),NULL,'us3cPeANA1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Enrollment Exp','202111099','EMPEXPORT','ONDEM_XOE',NULL,'EHEENRLANA',NULL,NULL,NULL,'202111099','Nov  9 2021  9:46PM','Nov  9 2021  9:46PM','202111091',NULL,'','','202111091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',9KINY,9KIPP,9KIRJ,9KIMZ,9KIIC,9KIOQ,9KILD,9KIQJ,9IGR6,9KIK7,9PGC6',NULL,NULL,NULL,'Health Equity Enrollment-Sched','202203089','EMPEXPORT','SCH_EHEENR',NULL,'EHEENRLANA',NULL,NULL,NULL,'202209099','Nov  9 2021  9:46PM','Nov  9 2021  9:46PM','202209021',NULL,'','','202203081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',9IGR6',NULL,NULL,NULL,'Health Equity Enrollment-Test','202207011','EMPEXPORT','TEST_XOE','Feb 10 2022  6:19PM','EHEENRLANA',NULL,NULL,NULL,'202207011','Feb 10 2022 12:00AM','Dec 30 1899 12:00AM','202207011','189','','','202207011',dbo.fn_GetTimedKey(),NULL,'us3cPeANA1004',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHEENRLANA','D10','dbo.U_EHEENRLANA_drvProTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHEENRLANA','D20','dbo.U_EHEENRLANA_drvEnrTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EHEENRLANA
-----------

IF OBJECT_ID('U_dsi_BDM_EHEENRLANA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHEENRLANA] (
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
-- Create table U_EHEENRLANA_Audit
-----------

IF OBJECT_ID('U_EHEENRLANA_Audit') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_Audit] (
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
    [audSalaryChange] varchar(1) NOT NULL,
    [audFullTimePartTimeChange] varchar(1) NOT NULL
);

-----------
-- Create table U_EHEENRLANA_AuditFields
-----------

IF OBJECT_ID('U_EHEENRLANA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EHEENRLANA_DedList
-----------

IF OBJECT_ID('U_EHEENRLANA_DedList') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EHEENRLANA_drvEnrTbl
-----------

IF OBJECT_ID('U_EHEENRLANA_drvEnrTbl') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_drvEnrTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(3) NOT NULL,
    [drvWWGrpId] varchar(5) NOT NULL,
    [drvPartEmpId] char(9) NULL,
    [drvUniqueId] char(11) NULL,
    [drvLName] varchar(100) NULL,
    [drvFName] varchar(100) NULL,
    [drvPlanCode] varchar(35) NULL,
    [drvElectAmt] varchar(30) NULL,
    [drvCovEffDt] varchar(30) NOT NULL,
    [drvCovEndDt] datetime NULL,
    [drvCompCovOption] varchar(1) NOT NULL,
    [drvCompCovOptEfDt] varchar(30) NOT NULL,
    [drvHDHPCovLvl] varchar(1) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EHEENRLANA_drvProTbl
-----------

IF OBJECT_ID('U_EHEENRLANA_drvProTbl') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_drvProTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(3) NOT NULL,
    [drvWWGrpId] varchar(5) NOT NULL,
    [drvPartEmpId] char(9) NULL,
    [drvUniqueId] char(11) NULL,
    [drvLName] varchar(100) NULL,
    [drvFName] varchar(100) NULL,
    [drvDOB] datetime NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmpHireDt] datetime NULL,
    [drvEmpTermDt] varchar(30) NOT NULL,
    [drvBenGrpCode] varchar(1) NOT NULL,
    [drvBenGrpEffDt] varchar(1) NOT NULL,
    [drvPayGrpCode] varchar(1) NOT NULL,
    [drvPayGrpEffDt] varchar(1) NOT NULL,
    [drvLocCode] varchar(1) NOT NULL,
    [drvCompCode] varchar(1) NOT NULL,
    [drvCommuterPrgm] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_EHEENRLANA_EEList
-----------

IF OBJECT_ID('U_EHEENRLANA_EEList') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHEENRLANA_File
-----------

IF OBJECT_ID('U_EHEENRLANA_File') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EHEENRLANA_PDedHist
-----------

IF OBJECT_ID('U_EHEENRLANA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHEENRLANA_PDedHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEENRLANA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Analytic Partners

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 11/09/2021
Service Request Number: TekP-2021-08-05-0003

Purpose: Health Equity Enrollment Exp

Revision History
----------------
11/11/2021 by AP:
    - Fixed first name and last name order in ENR record.
    - Added Open Enrollment and Passive Sessions to file.

11/18/2021 by AP:
    - ENR fields fixed or updated: Coverage Effective Date, Coverage End Date, HSA Compatible Coverage Option, 
      HSA Compatible Coverage Option Eff Date.

11/23/2021 by AP:
    - Updated enrollment end date.

12/01/2021 by AP:
    - Further clean up to coverage end date (to review with Cheryl Petitti).

8/19/2022 by Marie Waters
    -Add addtional deduction codes MFSA and DFSA


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHEENRLANA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHEENRLANA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEENRLANA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEENRLANA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEENRLANA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEENRLANA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEENRLANA', 'SCH_EHEENR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHEENRLANA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHEENRLANA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME
            ,@CovEndDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EHEENRLANA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = case when cast(getdate() as date) < cast(cast(year(getdate()) as varchar) + '-07-01' as varchar)
                                    then CONCAT(YEAR(GETDATE()) -1, '0701') ELSE CONCAT(YEAR(GETDATE()), '0701') END
        ,@CovEndDate      = case when cast(getdate() as date) > cast(cast(year(getdate()) as varchar) + '-07-01' as varchar)
                                    then CONCAT(YEAR(GETDATE()) +1, '0630') ELSE CONCAT(YEAR(GETDATE()), '0630') END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EHEENRLANA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHEENRLANA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,MFSA,DFSA,FSADC,CFHSA,FHSA,HSACF,HSAF,CIHSA,HSACI,HSAI,IHSA,FSALT,LFSA,COMPO,COMPR,TRAN1,TRAN2,MFSA,DFSA';

    IF OBJECT_ID('U_EHEENRLANA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHEENRLANA_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHEENRLANA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_AuditFields;
    CREATE TABLE dbo.U_EHEENRLANA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_EHEENRLANA_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHEENRLANA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_Audit;
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
        ,audFullTimePartTimeChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecFullTimeOrPartTime' AND ISNULL(audNewValue, '') = 'P' AND ISNULL(audOldValue, '') = 'F' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EHEENRLANA_Audit
    FROM dbo.U_EHEENRLANA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EHEENRLANA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EHEENRLANA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_PDedHist;
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
    INTO dbo.U_EHEENRLANA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHEENRLANA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHEENRLANA_drvProTbl
    ---------------------------------
    IF OBJECT_ID('U_EHEENRLANA_drvProTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_drvProTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecType = 'PRO'
        ,drvWWGrpId = '55566'
        ,drvPartEmpId = EecEmpNo
        ,drvUniqueId = EepSSN
        ,drvLName = EepNameLast
        ,drvFName = EepNameFirst
        ,drvDOB = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'M'
                            WHEN EepGender = 'F' THEN 'F'
                            ELSE 'U' END
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = LEFT(EepAddressZipCode, 5)
        ,drvEmail = EepAddressEMail
        ,drvPhone = EepPhoneHomeNumber
        ,drvEmpHireDt = EecDateOfOriginalHire
        ,drvEmpTermDt = ISNULL(CONVERT(VARCHAR, EecDateOfTermination, 101), '')
        ,drvBenGrpCode = ''
        ,drvBenGrpEffDt = ''
        ,drvPayGrpCode = ''
        ,drvPayGrpEffDt = ''
        ,drvLocCode = ''
        ,drvCompCode = ''
        ,drvCommuterPrgm = CASE WHEN EecCOID = '9IGR6' AND EecEmplStatus = 'A' AND audFullTimePartTimeChange = 'Y' THEN 'N' ELSE 'Y' END
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '1'
    INTO dbo.U_EHEENRLANA_drvProTbl
    FROM dbo.U_EHEENRLANA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EHEENRLANA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        -- AND audFullTimePartTimeChange = 'Y'
    -- JOIN dbo.U_dsi_BDM_EHEENRLANA WITH (NOLOCK)
    --     ON BdmEEID = xEEID 
    --     AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EHEENRLANA_drvEnrTbl
    ---------------------------------
    IF OBJECT_ID('U_EHEENRLANA_drvEnrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHEENRLANA_drvEnrTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
          ,drvRecType = 'ENR'
        ,drvWWGrpId = '55566'
        ,drvPartEmpId = EecEmpNo
        ,drvUniqueId = EepSSN
        ,drvLName = EepNameLast
        ,drvFName = EepNameFirst
        ,drvPlanCode = CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN 'HSA'
                                WHEN eedDedCode IN ('FSA', 'FSALT', 'LFSA', 'MFSA') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'HCFSA' -- added MFSA 8/19/22
                                           + CAST(YEAR(GETDATE()) AS VARCHAR)
                                WHEN eedDedCode IN ('FSA', 'FSALT', 'LFSA') AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN  'HCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR) -- added DFSA  8/19/22
                                WHEN eedDedCode IN ('FSADC', 'DFSA') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'DCFSA'
                                        + CAST(YEAR(GETDATE()) AS VARCHAR) 
                                WHEN eedDedCode IN ('FSADC') AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'DCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR)
                            END
        ,drvElectAmt = CAST(CAST(CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA', 'MFSA') THEN EedEEGoalAmt
                                WHEN EedDedCode IN ( 'FSADC', 'DFSA') THEN EedEEGoalAmt
                                WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN '0.00'
                            END AS DECIMAL(10,2)) AS VARCHAR)
        ,drvCovEffDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA', 'FSADC', 'CFHSA', 'CIHSA', 'FHSA', 'HSACF', 
                                                    'HSACI', 'HSAF', 'HSAI', 'IHSA', 'MFSA', 'DFSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate) -- added 'MFSA', 'DFSA' 8/19/22
                                        END), 101), '')
        --CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedBenStartDate
  --                              WHEN EedDedCode IN ('FSADC') THEN EedBenStartDate
  --                              WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') 
  --                                  AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN CAST(YEAR(GETDATE()) + 1 AS VARCHAR) + '-07-01' 
  --                              WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') 
  --                                  AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN CAST(YEAR(GETDATE()) AS VARCHAR) + '-07-01' 
  --                          END
        ,drvCovEndDt = CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') AND EedBenStatus <> 'A'
                                       -- THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStopDate, @CovEndDate) 
                                      THEN EedBenStopDate
                            WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA', 'FSADC', 'MFSA', 'DFSA') AND EedBenStatus <> 'A' THEN EedBenStopDate  -- added 'MFSA', 'DFSA' 8/22/19
                            ELSE
                                CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') AND EedBenStatus = 'A' AND 
                                        CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01'  -- IF THE DATE IS GREATER THAN 07/01/CURRENT YEAR
                                            THEN CAST(YEAR(GETDATE()) + 1 AS VARCHAR) + '-' + '06-30' -- THEN SHOW NEXT YEAR/06/30 AS END DATE
                                        WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') AND EedBenStatus = 'A' AND 
                                            CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' 
                                                THEN CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '06-30' -- IF NOT THEN SHOW CURRENT YEAR/06/30
                                            END
                                    END
        --ISNULL(CONVERT(VARCHAR, EedBenStopDate, 101), '')
        ,drvCompCovOption = CASE WHEN EedDedCode IN ('FSALT', 'LFSA') THEN 'Y'
                                    ELSE '' END
        ,drvCompCovOptEfDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EedDedCode IN ('FSALT', 'LFSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate)
                                    END), 101), '')
        ,drvHDHPCovLvl = CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA', 'MFSA') THEN ''    -- added 'MFSA' 8/19/22
                                    WHEN EedDedCode IN ( 'FSADC', 'DFSA')  THEN ''            -- added 'DFSA' 8/19/22
                                    WHEN EedDedCode IN ('CFHSA', 'FHSA', 'HSACF', 'HSAF') THEN 'F'
                                    WHEN EedDedCode IN ('CIHSA', 'HSACI', 'HSAI', 'IHSA') THEN 'S'
                                END
        ,drvInitialSort = '1' + EepSSN
        ,drvSubSort = '2'
        --,drvPlanCode = CASE WHEN HSA IS NOT NULL THEN 'HSA'
        --                    WHEN HCFSA IS NOT NULL THEN 'HCFSA'
        --                    WHEN DCFSA IS NOT NULL THEN 'DCFSA' END
        --,drvElectAmt = CASE WHEN HCFSA IS NOT NULL THEN HCFSA_Amount 
        --                        WHEN DCFSA IS NOT NULL THEN DCFSA_Amount
        --                        WHEN HSA IS NOT NULL THEN '0.00' END
        --,drvCovEffDt = CASE WHEN HCFSA IS NOT NULL THEN HCFSA_EedBenStartDate
        --                        WHEN DCFSA IS NOT NULL THEN DCFSA_EedBenStartDate
        --                        WHEN HSA IS NOT NULL THEN HSA_EedBenStartDate END
        --,drvCovEndDt = CASE WHEN HCFSA IS NOT NULL THEN HCFSA_EedBenStopDate 
        --                        WHEN DCFSA IS NOT NULL THEN DCFSA_EedBenStopDate
        --                        WHEN HSA IS NOT NULL THEN HSA_EedBenStopDate END
        --,drvCompCovOption = CASE WHEN HCFSA IS NOT NULL THEN 'Y'
        --                            WHEN DCFSA IS NOT NULL THEN ''
        --                            WHEN HSA IS NOT NULL THEN ''
        --                            ELSE 'N' END
        --,drvCompCovOptEfDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN HCFSA IS NOT NULL THEN HCFSA_EedBenStartDate
        --                            ELSE '' END), 101), '')
        --,drvHDHPCovLvl = CASE WHEN HCFSA IS NOT NULL THEN ''
        --                        WHEN DCFSA IS NOT NULL THEN ''
        --                        WHEN CFHSA_F IS NOT NULL THEN 'F'
        --                        WHEN CIHSA_S IS NOT NULL THEN 'S' END
    INTO dbo.U_EHEENRLANA_drvEnrTbl
    FROM dbo.U_EHEENRLANA_drvProTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK) ON EecEEID = drvEEID AND EecCOID = drvCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = drvEEID
        AND EedCOID = drvCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
     WHERE EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA', 'FSA', 'FSALT', 'LFSA', 'FSADC', 'MFSA', 'DFSA')
   -- JOIN (SELECT  eedEEID,eedcoid
   --         ,HSA = MAX((CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN 'HSA' END))
   --         ,HCFSA = MAX((CASE WHEN eedDedCode IN ('FSA', 'FSALT', 'LFSA') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'HCFSA'
   --                                 + CAST(YEAR(GETDATE()) AS VARCHAR) ELSE 'HCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR) END))
   --         ,DCFSA = MAX((CASE WHEN eedDedCode IN ('FSADC') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'DCFSA'
   --                                 + CAST(YEAR(GETDATE()) AS VARCHAR) ELSE 'DCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR) END))
   --         ,HCFSA_EedBenStartDate = MAX((CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedBenStartDate END))
   --         ,DCFSA_EedBenStartDate = MAX((CASE WHEN EedDedCode = 'FSADC' THEN EedBenStartDate END))
   --         ,HSA_EedBenStartDate = MAX((CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') 
   --                                 AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN CAST(YEAR(GETDATE()) + 1 AS VARCHAR) + '-07-01'
   --                                             ELSE CAST(YEAR(GETDATE()) AS VARCHAR) + '-07-01' END))
   --         ,HCFSA_EedBenStopDate = MAX((CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedBenStopDate END))
   --         ,DCFSA_EedBenStopDate = MAX((CASE WHEN EedDedCode IN ('FSADC') THEN EedBenStopDate END))
   --         ,HSA_EedBenStopDate   = MAX((CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN EedBenStopDate END))
   --         ,CFHSA_F              = MAX((CASE WHEN EedDedCode IN ('CFHSA', 'FHSA', 'HSACF', 'HSAF') THEN 'F' END))
   --         ,CIHSA_S              = MAX((CASE WHEN EedDedCode IN ('CIHSA', 'HSACI', 'HSAI', 'IHSA') THEN 'S' END))
            --,HCFSA_Amount          = SUM((CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedEEGoalAmt END))
            --,DCFSA_Amount          = SUM((CASE WHEN EedDedCode IN ('FSADC') THEN EedEEGoalAmt END))

   --         FROM dbo.U_dsi_bdm_EmpDeductions  WITH (NOLOCK) 
   --         WHERE   EedFormatCode = @FormatCode
   --         AND EedValidForExport = 'Y'
            --GROUP BY EedEEID, EedCOID) Eed ON Eed.EedEEID = xEEID AND Eed.EedCO

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
ALTER VIEW dbo.dsi_vwEHEENRLANA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHEENRLANA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHEENRLANA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111021'
       ,expStartPerControl     = '202111021'
       ,expLastEndPerControl   = '202111099'
       ,expEndPerControl       = '202111099'
WHERE expFormatCode = 'EHEENRLANA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHEENRLANA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHEENRLANA_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHEENRLANA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHEENRLANA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHEENRLANA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHEENRLANA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHEENRLANA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHEENRLANA', 'UseFileName', 'V', 'Y'


-- End ripout