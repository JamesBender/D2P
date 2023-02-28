/**********************************************************************************

EMBHEFSAEX: HealthEquity FSA and HAS Export

FormatCode:     EMBHEFSAEX
Project:        HealthEquity FSA and HAS Export
Client ID:      MIL1021
Date/time:      2023-02-27 15:43:25.043
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB03
Database:       ULTIPRO_WPBIOTC
Web Filename:   MIL1021_49031_EEHISTORY_EMBHEFSAEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMBHEFSAEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EMBHEFSAEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMBHEFSAEX'


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
WHERE FormatCode = 'EMBHEFSAEX'
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
WHERE ExpFormatCode = 'EMBHEFSAEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMBHEFSAEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMBHEFSAEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMBHEFSAEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMBHEFSAEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMBHEFSAEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMBHEFSAEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMBHEFSAEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMBHEFSAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMBHEFSAEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMBHEFSAEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMBHEFSAEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMBHEFSAEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMBHEFSAEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMBHEFSAEX];
GO
IF OBJECT_ID('U_EMBHEFSAEX_File') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_File];
GO
IF OBJECT_ID('U_EMBHEFSAEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_EEList];
GO
IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_PRO') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_drvTbl_PRO];
GO
IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_ENR') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_drvTbl_ENR];
GO
IF OBJECT_ID('U_EMBHEFSAEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_drvTbl];
GO
IF OBJECT_ID('U_EMBHEFSAEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_DedList];
GO
IF OBJECT_ID('U_EMBHEFSAEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_AuditFields];
GO
IF OBJECT_ID('U_EMBHEFSAEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMBHEFSAEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMBHEFSAEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMBHEFSAEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMBHEFSAEX','HealthEquity FSA and HAS Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EMBHEFSAEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMBHEFSAEXZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"PRO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMBHEFSAEXZ0','50','D','10','2',NULL,'Group ID',NULL,NULL,'"52330"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMBHEFSAEXZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvParticipantorEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMBHEFSAEXZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMBHEFSAEXZ0','50','D','10','5',NULL,'Change to Unique ID',NULL,NULL,'"drvChangetoUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMBHEFSAEXZ0','50','D','10','6',NULL,'Old Unique ID',NULL,NULL,'"drvOldUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMBHEFSAEXZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMBHEFSAEXZ0','50','D','10','8',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMBHEFSAEXZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMBHEFSAEXZ0','50','D','10','10',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMBHEFSAEXZ0','50','D','10','11',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMBHEFSAEXZ0','50','D','10','12',NULL,'Street Address 1',NULL,NULL,'"drvStreetAddress1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMBHEFSAEXZ0','50','D','10','13',NULL,'Street Address 2',NULL,NULL,'"drvStreetAddress2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMBHEFSAEXZ0','50','D','10','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMBHEFSAEXZ0','50','D','10','15',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMBHEFSAEXZ0','50','D','10','16',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMBHEFSAEXZ0','50','D','10','17',NULL,'Zip Code Extension',NULL,NULL,'"drvZipCodeExtension"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMBHEFSAEXZ0','50','D','10','18',NULL,'Work ZIP Code',NULL,NULL,'"drvWorkZIPCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMBHEFSAEXZ0','50','D','10','19',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMBHEFSAEXZ0','50','D','10','20',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMBHEFSAEXZ0','50','D','10','21',NULL,'Phone Extension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMBHEFSAEXZ0','50','D','10','22',NULL,'Employment Hire Date',NULL,NULL,'"drvEmploymentHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMBHEFSAEXZ0','50','D','10','23',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMBHEFSAEXZ0','50','D','10','24',NULL,'Benefit Group Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMBHEFSAEXZ0','50','D','10','25',NULL,'Benefit Group Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMBHEFSAEXZ0','50','D','10','26',NULL,'Payroll Group Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMBHEFSAEXZ0','50','D','10','27',NULL,'Payroll Group Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMBHEFSAEXZ0','50','D','10','28',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMBHEFSAEXZ0','50','D','10','29',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMBHEFSAEXZ0','50','D','10','30',NULL,'For Future Use 1 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMBHEFSAEXZ0','50','D','10','31',NULL,'For Future Use 2 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMBHEFSAEXZ0','50','D','10','32',NULL,'Bank Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMBHEFSAEXZ0','50','D','10','33',NULL,'Bank Account Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMBHEFSAEXZ0','50','D','10','34',NULL,'Bank Routing Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMBHEFSAEXZ0','50','D','10','35',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMBHEFSAEXZ0','50','D','10','36',NULL,'Payment Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMBHEFSAEXZ0','50','D','10','37',NULL,'Commuter Program Benefit Group Code',NULL,NULL,'"drvCommuterBenefitGroupCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMBHEFSAEXZ0','50','D','10','38',NULL,'Part Level Monthly Subsidy PT&VP Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMBHEFSAEXZ0','50','D','10','39',NULL,'Part Level Monthly Subsidy PT&VP Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMBHEFSAEXZ0','50','D','10','40',NULL,'Part Level Monthly Subsidy PT&VP Max',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMBHEFSAEXZ0','50','D','10','41',NULL,'For Future Use 3 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMBHEFSAEXZ0','50','D','10','42',NULL,'Part Level Monthly Subsidy  PK Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMBHEFSAEXZ0','50','D','10','43',NULL,'Part Level Monthly Subsidy  PK Percent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMBHEFSAEXZ0','50','D','10','44',NULL,'Part Level Monthly Subsidy PK Max',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMBHEFSAEXZ0','50','D','10','45',NULL,'For Future Use 4 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMBHEFSAEXZ0','50','D','10','46',NULL,'For Future Use 5 (Commuter)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMBHEFSAEXZ0','50','D','10','47',NULL,'For Internal Use Only 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMBHEFSAEXZ0','50','D','10','48',NULL,'For Internal Use Only 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMBHEFSAEXZ0','50','D','10','49',NULL,'For Internal Use Only 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMBHEFSAEXZ0','50','D','10','50',NULL,'For Internal Use Only 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMBHEFSAEXZ0','50','D','10','51',NULL,'For Internal Use Only 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMBHEFSAEXZ0','50','D','10','52',NULL,'For Internal Use Only 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMBHEFSAEXZ0','50','D','10','53',NULL,'For Internal Use Only 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMBHEFSAEXZ0','50','D','10','54',NULL,'For Internal Use Only 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMBHEFSAEXZ0','50','D','10','55',NULL,'For Internal Use Only 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMBHEFSAEXZ0','50','D','10','56',NULL,'For Internal Use Only 10 (Health Care)',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMBHEFSAEXZ0','50','D','10','57',NULL,'For Future Use Only 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMBHEFSAEXZ0','50','D','10','58',NULL,'Country Code',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMBHEFSAEXZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"ENR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMBHEFSAEXZ0','50','D','20','2',NULL,'Group ID',NULL,NULL,'"52330"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMBHEFSAEXZ0','50','D','20','3',NULL,'Participant or Employee ID',NULL,NULL,'"drvParticipantorEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMBHEFSAEXZ0','50','D','20','4',NULL,'Unique ID',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMBHEFSAEXZ0','50','D','20','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMBHEFSAEXZ0','50','D','20','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMBHEFSAEXZ0','50','D','20','7',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMBHEFSAEXZ0','50','D','20','8',NULL,'Plan Action Code',NULL,NULL,'"drvPlanActionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMBHEFSAEXZ0','50','D','20','9',NULL,'Election Amount',NULL,NULL,'"drvElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMBHEFSAEXZ0','50','D','20','10',NULL,'Coverage Effective Date',NULL,NULL,'"drvCoverageEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMBHEFSAEXZ0','50','D','20','11',NULL,'Coverage End Date',NULL,NULL,'"drvCoverageEndDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMBHEFSAEXZ0','50','D','20','12',NULL,'HSA-Compatible FSA Option',NULL,NULL,'"drvHSACompatibleFSAOption"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMBHEFSAEXZ0','50','D','20','13',NULL,'HSA-Compatible FSA Option Effective Date',NULL,NULL,'"drvHSAFSAEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMBHEFSAEXZ0','50','D','20','14',NULL,'Standard FSA Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMBHEFSAEXZ0','50','D','20','15',NULL,'Standard FSA Option Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMBHEFSAEXZ0','50','D','20','16',NULL,'Deductible Requirement Met',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMBHEFSAEXZ0','50','D','20','17',NULL,'Automatic Health Plan Claims',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMBHEFSAEXZ0','50','D','20','18',NULL,'Terms & Conditions Accept Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMBHEFSAEXZ0','50','D','20','19',NULL,'Terms & Conditions Timestamp',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMBHEFSAEXZ0','50','D','20','20',NULL,'Custodian Statement Preference',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMBHEFSAEXZ0','50','D','20','21',NULL,'Period of Non-Coverage Start Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMBHEFSAEXZ0','50','D','20','22',NULL,'Period of Non-Coverage End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMBHEFSAEXZ0','50','D','20','23',NULL,'Period of Non-Coverage Reason',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMBHEFSAEXZ0','50','D','20','24',NULL,'HDHP Coverage Level',NULL,NULL,'"drvHDHPCoverageLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMBHEFSAEXZ0','50','D','20','25',NULL,'HDHP Coverage Calendar Year',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMBHEFSAEXZ0','50','D','20','26',NULL,'HRA Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMBHEFSAEXZ0','50','D','20','27',NULL,'For Internal Use 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMBHEFSAEXZ0','50','D','20','28',NULL,'For Internal Use 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMBHEFSAEXZ0','50','D','20','29',NULL,'FSA/HRA Post Deductible Met',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMBHEFSAEX_20230227.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202302279','EMPEXPORT','OEACTIVE',NULL,'EMBHEFSAEX',NULL,NULL,NULL,'202302279','Feb 27 2023 12:23PM','Feb 27 2023 12:23PM','202302271',NULL,'','','202302271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202302279','EMPEXPORT','OEPASSIVE',NULL,'EMBHEFSAEX',NULL,NULL,NULL,'202302279','Feb 27 2023 12:23PM','Feb 27 2023 12:23PM','202302271',NULL,'','','202302271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSA and HAS Expor','202302279','EMPEXPORT','ONDEM_XOE',NULL,'EMBHEFSAEX',NULL,NULL,NULL,'202302279','Feb 27 2023 12:23PM','Feb 27 2023 12:23PM','202302271',NULL,'','','202302271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HealthEquity FSA and HAS-Sched','202302279','EMPEXPORT','SCH_EMBHEF',NULL,'EMBHEFSAEX',NULL,NULL,NULL,'202302279','Feb 27 2023 12:23PM','Feb 27 2023 12:23PM','202302271',NULL,'','','202302271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'HealthEquity FSA and HAS-Test','202302279','EMPEXPORT','TEST_XOE',NULL,'EMBHEFSAEX',NULL,NULL,NULL,'202302279','Feb 27 2023 12:23PM','Feb 27 2023 12:23PM','202302271',NULL,'','','202302271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMBHEFSAEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMBHEFSAEX','D10','dbo.U_EMBHEFSAEX_drvTbl_PRO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMBHEFSAEX','D20','dbo.U_EMBHEFSAEX_drvTbl_ENR',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMBHEFSAEX
-----------

IF OBJECT_ID('U_dsi_BDM_EMBHEFSAEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMBHEFSAEX] (
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
-- Create table U_EMBHEFSAEX_Audit
-----------

IF OBJECT_ID('U_EMBHEFSAEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_Audit] (
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
-- Create table U_EMBHEFSAEX_AuditFields
-----------

IF OBJECT_ID('U_EMBHEFSAEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMBHEFSAEX_DedList
-----------

IF OBJECT_ID('U_EMBHEFSAEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMBHEFSAEX_drvTbl
-----------

IF OBJECT_ID('U_EMBHEFSAEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantorEmployeeID] char(9) NULL,
    [drvUniqueID] char(11) NULL,
    [drvChangetoUniqueID] varchar(1) NOT NULL,
    [drvOldUniqueID] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvGender] char(1) NULL,
    [drvStreetAddress1] varchar(1) NOT NULL,
    [drvStreetAddress2] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvZipCodeExtension] varchar(1) NOT NULL,
    [drvWorkZIPCode] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmploymentHireDate] datetime NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvLocationCode] varchar(10) NULL,
    [drvCompanyCode] char(5) NULL,
    [rvCommuterBenefitGroupCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EMBHEFSAEX_drvTbl_ENR
-----------

IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_ENR') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_drvTbl_ENR] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantorEmployeeID] char(9) NULL,
    [drvUniqueID] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [Bdmdedcode] char(5) NULL,
    [drvPlanCode] varchar(35) NULL,
    [drvPlanActionCode] varchar(1) NOT NULL,
    [drvElectionAmount] nvarchar(4000) NULL,
    [drvCoverageEffectiveDate] varchar(1) NOT NULL,
    [drvCoverageEndDate] varchar(30) NULL,
    [drvHSACompatibleFSAOption] varchar(1) NULL,
    [drvHSAFSAEffectiveDate] varchar(30) NULL,
    [drvHDHPCoverageLevel] varchar(1) NULL
);

-----------
-- Create table U_EMBHEFSAEX_drvTbl_PRO
-----------

IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_PRO') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_drvTbl_PRO] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvParticipantorEmployeeID] char(9) NULL,
    [drvUniqueID] char(11) NULL,
    [drvChangetoUniqueID] varchar(1) NOT NULL,
    [drvOldUniqueID] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvBirthDate] varchar(30) NULL,
    [drvGender] varchar(1) NULL,
    [drvStreetAddress1] varchar(255) NULL,
    [drvStreetAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvZipCodeExtension] varchar(1) NOT NULL,
    [drvWorkZIPCode] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmploymentHireDate] varchar(30) NULL,
    [drvEmploymentTerminationDate] varchar(30) NULL,
    [drvLocationCode] varchar(10) NULL,
    [drvCompanyCode] char(5) NULL,
    [drvCommuterBenefitGroupCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EMBHEFSAEX_EEList
-----------

IF OBJECT_ID('U_EMBHEFSAEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMBHEFSAEX_File
-----------

IF OBJECT_ID('U_EMBHEFSAEX_File') IS NULL
CREATE TABLE [dbo].[U_EMBHEFSAEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMBHEFSAEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Miltenyi Biotec

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 02/27/2023
Service Request Number: TekP-2022-09-28-05

Purpose: HealthEquity FSA and HAS Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMBHEFSAEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMBHEFSAEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMBHEFSAEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMBHEFSAEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMBHEFSAEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMBHEFSAEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMBHEFSAEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMBHEFSAEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMBHEFSAEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMBHEFSAEX', 'SCH_EMBHEF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMBHEFSAEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMBHEFSAEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMBHEFSAEX';

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
    DELETE FROM dbo.U_EMBHEFSAEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMBHEFSAEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMBHEFSAEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMBHEFSAEX_AuditFields;
    CREATE TABLE dbo.U_EMBHEFSAEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
        INSERT INTO dbo.U_EMBHEFSAEX_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMBHEFSAEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMBHEFSAEX_Audit;
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
    INTO dbo.U_EMBHEFSAEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMBHEFSAEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMBHEFSAEX_Audit ON dbo.U_EMBHEFSAEX_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EMBHEFSAEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMBHEFSAEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = ' FSA,FSADC,FSALP,F2ALP,H2ACF,H2ACI,H2AI,H2AF,HSACF,HSACI,HSAF,HSAI';

    IF OBJECT_ID('U_EMBHEFSAEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMBHEFSAEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMBHEFSAEX_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMBHEFSAEX_drvTbl_PRO
    ---------------------------------
    IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_PRO','U') IS NOT NULL
        DROP TABLE dbo.U_EMBHEFSAEX_drvTbl_PRO;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvParticipantorEmployeeID = EecEmpNo
        ,drvUniqueID = EepSSN
        ,drvChangetoUniqueID = ''
        ,drvOldUniqueID = '1'
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvBirthDate = Convert(varchar, EepDateOfBirth, 101)
        ,drvGender = CASE WHEN EepGender IN ('M', 'F') THEN EepGender ELSE 'U' END
        ,drvStreetAddress1 = EepAddressLine1
        ,drvStreetAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvZipCodeExtension = ''
        ,drvWorkZIPCode = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvPhone = EepPhoneHomeNumber
        ,drvEmploymentHireDate =  Convert(varchar,EecDateOfLastHire, 101)
        ,drvEmploymentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN  Convert(varchar,EecDateOfTermination, 101) END
        ,drvLocationCode = eecorglvl1
        ,drvCompanyCode = CmpCompanyCode
        ,drvCommuterBenefitGroupCode = CASE WHEN EecFulltimeOrPartTime = 'F' AND EecLocation in ('SD','CAM','GAB','WAL','SJ','GB1201', 'CRL') then 'Y' else 'N' END
    INTO dbo.U_EMBHEFSAEX_drvTbl_PRO
    FROM dbo.U_EMBHEFSAEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMBHEFSAEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN  dbo.U_EMBHEFSAEX_Audit WITH (NOLOCK)
        ON xEEID = audEEID
           WHERE EecFulltimeOrPartTime = 'F' AND ( EecLocation in ('SD','CAM','GAB','WAL','SJ','GB1201', 'CRL') OR Bdmdedcode IN ( 'FSA', 'FSADC', 'FSALP', 'F2ALP', 'H2ACF', 'H2ACI', 'H2AI', 'H2AF', 'HSACF', 'HSACI',  'HSAF', 'HSAI'))
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
    ;
   

    ---------------------------------
    -- DETAIL RECORD - U_EMBHEFSAEX_drvTbl_ENR
    ---------------------------------
    IF OBJECT_ID('U_EMBHEFSAEX_drvTbl_ENR','U') IS NOT NULL
        DROP TABLE dbo.U_EMBHEFSAEX_drvTbl_ENR;
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvParticipantorEmployeeID = EecEmpNo
        ,drvUniqueID = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,Bdmdedcode
        ,drvPlanCode = CASE WHEN Bdmdedcode IN ('H2ACF', 'H2AF', 'HSACF', 'HSAF','H2ACI', 'H2AI', 'HSACI', 'HSAI') THEN 'HSA'
                            WHEN Bdmdedcode IN ( 'FSA' , 'FSALP', 'F2ALP' ) and @ExportCode not like  'OE%'  THEN 'HCFSA' + Cast(Year(GetDate()) as Varchar)
                            WHEN Bdmdedcode IN ( 'FSA' , 'FSALP', 'F2ALP') and @ExportCode  like  'OE%'  THEN 'HCFSA' + CAST(Year(GetDate()) +1 as varchar)     

                            WHEN Bdmdedcode IN ( 'FSADC' ) and  @ExportCode not like  'OE%'  THEN  'DCFSA' +  Cast(Year(GetDate()) as Varchar)
                            WHEN Bdmdedcode IN ( 'FSADC' ) and  @ExportCode like  'OE%'  THEN  'DCFSA'+  CAST(Year(GetDate()) +1 as varchar)
                            END
       

        ,drvPlanActionCode = ''
        ,drvElectionAmount = CASE WHEN Bdmdedcode IN ( 'FSA' , 'FSALP', 'F2ALP' ,'FSADC') THEN FORMAT(BdmEEGoalAmt, '0.00')ELSE '0.00'  END
        ,drvCoverageEffectiveDate = ''
        ,drvCoverageEndDate = CASE WHEN Bdmdedcode IN ('H2ACF', 'H2AF', 'HSACF', 'HSAF','H2ACI', 'H2AI', 'HSACI', 'HSAI')and @ExportCode not like  'OE%' THEN  Convert(varchar,dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStopDate, '12/31/'+Cast(Year(GetDate()) as Varchar)),101)
                                   WHEN Bdmdedcode IN ('H2ACF', 'H2AF', 'HSACF', 'HSAF','H2ACI', 'H2AI', 'HSACI', 'HSAI')and @ExportCode like  'OE%' THEN  Convert(varchar,dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStopDate, '12/31/'+Cast(Year(GetDate()) +1 as varchar)),101)
                                   ELSE Convert(varchar, BdmBenStopDate, 101)
                                  END
        ,drvHSACompatibleFSAOption = CASE WHEN Bdmdedcode IN ('FSALP', 'F2ALP') THEN 'Y' END
        ,drvHSAFSAEffectiveDate = CASE WHEN Bdmdedcode IN ('FSALP', 'F2ALP')and @ExportCode not like  'OE%' THEN  Convert(varchar,dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '01/01/'+Cast(Year(GetDate()) as Varchar)),101)
                                   WHEN Bdmdedcode IN ('FSALP', 'F2ALP') and @ExportCode like  'OE%' THEN  Convert(varchar,dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '01/01/'+Cast(Year(GetDate()) +1 as varchar)),101)
                                   ELSE Convert(varchar, BdmBenStartDate, 101)
                                  END
        ,drvHDHPCoverageLevel = CASE WHEN Bdmdedcode IN ('H2ACF', 'H2AF', 'HSACF', 'HSAF' ) THEN  'F'
                                     WHEN Bdmdedcode IN ('H2ACI', 'H2AI', 'HSACI', 'HSAI') THEN 'S'
                                     END
    INTO dbo.U_EMBHEFSAEX_drvTbl_ENR
    FROM dbo.U_EMBHEFSAEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMBHEFSAEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmBenstatus NOT In ( 'W', 'C')
        LEFT JOIN  dbo.U_EMBHEFSAEX_Audit WITH (NOLOCK)
        ON xEEID = audEEID
      WHERE EecFulltimeOrPartTime = 'F' AND ( EecLocation in ('SD','CAM','GAB','WAL','SJ','GB1201', 'CRL') OR Bdmdedcode IN ( 'FSA', 'FSADC', 'FSALP', 'F2ALP', 'H2ACF', 'H2ACI', 'H2AI', 'H2AF', 'HSACF', 'HSACI',  'HSAF', 'HSAI'))
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN  @StartDate AND @EndDate))
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
ALTER VIEW dbo.dsi_vwEMBHEFSAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMBHEFSAEX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMBHEFSAEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302201'
       ,expStartPerControl     = '202302201'
       ,expLastEndPerControl   = '202302279'
       ,expEndPerControl       = '202302279'
WHERE expFormatCode = 'EMBHEFSAEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMBHEFSAEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMBHEFSAEX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMBHEFSAEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMBHEFSAEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMBHEFSAEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMBHEFSAEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMBHEFSAEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMBHEFSAEX', 'UseFileName', 'V', 'Y'


-- End ripout