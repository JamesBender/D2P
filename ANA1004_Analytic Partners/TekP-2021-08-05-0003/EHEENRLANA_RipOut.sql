/**********************************************************************************

EHEENRLANA: Health Equity Enrollment Exp

FormatCode:     EHEENRLANA
Project:        Health Equity Enrollment Exp
Client ID:      USG1000
Date/time:      2021-11-09 22:34:31.447
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_EHEENRLANA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

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

IF OBJECT_ID('dsi_sp_BuildDriverTables_EHEENRLANA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEENRLANA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EHEENRLANA','Health Equity Enrollment Exp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N','EHEENRLANAZ0','N','Jan  1 1900 12:00AM','C','N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWWGrpId"','2','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','2',NULL,'WW Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpId"','3','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','3',NULL,'Participant or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUniqueId"','4','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','4',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','5',NULL,'Change to Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','6',NULL,'Old Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLName"','7','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','7',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFName"','8','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','9',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','10','(''UD101''=''T|'')','EHEENRLANAZ0','50','D','10','10',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','11',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','12','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','12',NULL,'Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','13','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','13',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','14',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','15','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','15',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','16','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','16',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','17',NULL,'Zip Code Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','18',NULL,'Work ZIP Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','19','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','19',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','20','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','20',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','21',NULL,'Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHireDt"','22','(''UD101''=''T|'')','EHEENRLANAZ0','50','D','10','22',NULL,'Employment Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTermDt"','23','(''UD101''=''T|'')','EHEENRLANAZ0','50','D','10','23',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenGrpCode"','24','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','24',NULL,'Benefit Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenGrpEffDt"','25','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','25',NULL,'Benefit Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayGrpCode"','26','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','26',NULL,'Payroll Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayGrpEffDt"','27','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','27',NULL,'Payroll Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocCode"','28','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','28',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCode"','29','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','29',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','30',NULL,'For Future Use 1 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','31',NULL,'For Future Use 2 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','32',NULL,'Bank Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','33',NULL,'Bank Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','34',NULL,'Bank Routing Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','35',NULL,'Bank Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','36',NULL,'Payment Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCommuterPrgm"','37','(''UA''=''T|'')','EHEENRLANAZ0','50','D','10','37',NULL,'Commuter Program Benefit Group Codes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','38',NULL,'Participant Level Monthly Subsidy for PT&VP: Amoun',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','39',NULL,'Participant Level Monthly Subsidy for PT&VP: Perce',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','40',NULL,'Participant Level Monthly Subsidy for PT&VP: Maxim',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','41',NULL,'For Future Use 3 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','42',NULL,'Participant Level Monthly Subsidy for PK: Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','43',NULL,'Participant Level Monthly Subsidy for PK: Percenta',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','44',NULL,'Participant Level Monthly Subsidy for PK: Maximum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','45',NULL,'For Future Use 4 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','46',NULL,'For Future Use 5 (Commuter)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','47',NULL,'For Internal Use Only 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','48',NULL,'For Internal Use Only 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','49',NULL,'For Internal Use Only 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''T|'')','EHEENRLANAZ0','50','D','10','50',NULL,'For Internal Use Only 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''T|'')','EHEENRLANAZ0','51','D','10','51',NULL,'For Internal Use Only 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''T|'')','EHEENRLANAZ0','52','D','10','52',NULL,'For Internal Use Only 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''SS''=''T|'')','EHEENRLANAZ0','53','D','10','53',NULL,'For Internal Use Only 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''T|'')','EHEENRLANAZ0','54','D','10','54',NULL,'For Internal Use Only 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''T|'')','EHEENRLANAZ0','54','D','10','55',NULL,'For Internal Use Only 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''T|'')','EHEENRLANAZ0','54','D','10','56',NULL,'For Internal Use Only 10 (Health Care)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''T|'')','EHEENRLANAZ0','54','D','10','57',NULL,'Participant Updates Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''T'')','EHEENRLANAZ0','54','D','10','58',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWWGrpId"','2','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','2',NULL,'WW Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpId"','3','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','3',NULL,'Participant or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUniqueId"','4','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','4',NULL,'Unique ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLName"','5','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFName"','6','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','7','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','7',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','8',NULL,'Plan Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectAmt"','9','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','9',NULL,'Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEffDt"','10','(''UD101''=''T|'')','EHEENRLANAZ0','54','D','20','10',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEndDt"','11','(''UD101''=''T|'')','EHEENRLANAZ0','54','D','20','11',NULL,'Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCovOption"','12','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','12',NULL,'HSA-Compatible Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompCovOptEfDt"','13','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','13',NULL,'HSA-Compatible Coverage Option Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','14',NULL,'Standard Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','15',NULL,'Standard Coverage Option Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','16',NULL,'HRA Deductible Requirement Met',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','17',NULL,'Automatic Health Plan Claims',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','18',NULL,'Terms & Conditions Accept Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','19',NULL,'Terms & Conditions Timestamp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','20',NULL,'Custodian Statement Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','21',NULL,'Period of Non-Coverage Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','22',NULL,'Period of Non-Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','23',NULL,'Period of Non-Coverage Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDHPCovLvl"','24','(''UA''=''T|'')','EHEENRLANAZ0','54','D','20','24',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','25',NULL,'HDHP Coverage Calendar Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','26',NULL,'HRA Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','27',NULL,'For Internal Use Only 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''T|'')','EHEENRLANAZ0','54','D','20','28',NULL,'For Internal Use Only 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''T|)','EHEENRLANAZ0','54','D','20','29',NULL,'FSA/HRA Post-Deductible Met (Switch from Limited t',NULL,NULL);

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHEENRLANA_20211109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Enrollment Exp','202111099','EMPEXPORT','ONDEM_XOE',NULL,'EHEENRLANA',NULL,NULL,NULL,'202111099','Nov  9 2021  9:46PM','Nov  9 2021  9:46PM','202111091',NULL,'','','202111091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Enrollment-Sched','202111099','EMPEXPORT','SCH_EHEENR',NULL,'EHEENRLANA',NULL,NULL,NULL,'202111099','Nov  9 2021  9:46PM','Nov  9 2021  9:46PM','202111091',NULL,'','','202111091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health Equity Enrollment-Test','202111099','EMPEXPORT','TEST_XOE',NULL,'EHEENRLANA',NULL,NULL,NULL,'202111099','Nov  9 2021  9:46PM','Nov  9 2021  9:46PM','202111091',NULL,'','','202111091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEENRLANA','Testing','V','Y');
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
-- U_dsi_Translations_v3 inserts
-----------

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
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHEENRLANA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHEENRLANA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHEENRLANA' ORDER BY RunID DESC;

Execute Export
--------------
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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EHEENRLANA';

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
    DELETE FROM dbo.U_EHEENRLANA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHEENRLANA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,MFSA,DFSA,FSADC,CFHSA,FHSA,HSACF,HSAF,CIHSA,HSACI,HSAI,IHSA,FSALT,LFSA,COMPO,COMPR,TRAN1,TRAN2';

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
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
          ,drvRecType = 'ENR'
        ,drvWWGrpId = '55566'
        ,drvPartEmpId = EecEmpNo
        ,drvUniqueId = EepSSN
        ,drvLName = EepNameFirst
        ,drvFName = EepNameLast
		,drvPlanCode = CASE WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN 'HSA'
								WHEN eedDedCode IN ('FSA', 'FSALT', 'LFSA') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'HCFSA'
			                               + CAST(YEAR(GETDATE()) AS VARCHAR)
								WHEN eedDedCode IN ('FSA', 'FSALT', 'LFSA') AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN  'HCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR)
								WHEN eedDedCode IN ('FSADC') AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'DCFSA'
		                                + CAST(YEAR(GETDATE()) AS VARCHAR) 
								WHEN eedDedCode IN ('FSADC') AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN 'DCFSA' + CAST(YEAR(GETDATE()) - 1 AS VARCHAR)
							END
		,drvElectAmt = CAST(CAST(CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedEEGoalAmt
								WHEN EedDedCode = 'FSADC' THEN EedEEGoalAmt
								WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN '0.00'
							END AS DECIMAL(10,2)) AS VARCHAR)
		,drvCovEffDt = CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedBenStartDate
								WHEN EedDedCode IN ('FSADC') THEN EedBenStartDate
								WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') 
	                                AND CAST(GETDATE() AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN CAST(YEAR(GETDATE()) + 1 AS VARCHAR) + '-07-01' 
								WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') 
	                                AND CAST(GETDATE() AS DATE) < CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + '07-01' THEN CAST(YEAR(GETDATE()) AS VARCHAR) + '-07-01' 
							END
		,drvCovEndDt = ISNULL(CONVERT(VARCHAR, EedBenStopDate, 101), '')
		,drvCompCovOption = CASE WHEN EedDedCode IN ('FSALT', 'LFSA') THEN 'Y'
									WHEN EedDedCode = 'FSADC' THEN ''
									WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN ''
									ELSE 'N' END
		,drvCompCovOptEfDt = ISNULL(CONVERT(VARCHAR, CASE WHEN EedDedCode IN ('FSALT', 'LFSA') THEN EedBenStartDate
									WHEN EedDedCode = 'FSADC' THEN ''
									WHEN EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA') THEN ''
									END), 101), '') 
		,drvHDHPCovLvl = CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN ''
									WHEN EedDedCode = 'FSADC' THEN ''
									WHEN EedDedCode IN ('CFHSA', 'FHSA', 'HSACF', 'HSAF') THEN 'F'
									WHEN EedDedCode IN ('CIHSA', 'HSACI', 'HSAI', 'IHSA') THEN 'S'
								END
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
    FROM dbo.U_EHEENRLANA_EEList WITH (NOLOCK)
	JOIN dbo.EmpPers WITH(NOLOCK) ON xEEID = EepEEID
	JOIN dbo.EmpComp WITH(NOLOCK) ON xEEID = EecEEID AND xCOID = EecCOID
	JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
		ON EedEEID = xEEID
		AND EedCOID = xCOID
		AND EedFormatCode = @FormatCode
		AND EedValidForExport = 'Y'
	WHERE EedDedCode IN ('CFHSA', 'CIHSA', 'FHSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'IHSA', 'FSA', 'FSALT', 'LFSA', 'FSADC')
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
			--,HCFSA_Amount		  = SUM((CASE WHEN EedDedCode IN ('FSA', 'FSALT', 'LFSA') THEN EedEEGoalAmt END))
			--,DCFSA_Amount		  = SUM((CASE WHEN EedDedCode IN ('FSADC') THEN EedEEGoalAmt END))

   --         FROM dbo.U_dsi_bdm_EmpDeductions  WITH (NOLOCK) 
   --         WHERE   EedFormatCode = @FormatCode
   --         AND EedValidForExport = 'Y'
			--GROUP BY EedEEID, EedCOID) Eed ON Eed.EedEEID = xEEID AND Eed.EedCOID = xCOID
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