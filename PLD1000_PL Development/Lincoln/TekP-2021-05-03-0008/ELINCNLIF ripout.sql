/**********************************************************************************

ELINCNLIF: Lincoln Basic Life

FormatCode:     ELINCNLIF
Project:        Lincoln Basic Life
Client ID:      PLD1000
Date/time:      2021-12-22 09:59:25.353
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB01
Database:       ULTIPRO_WPPLDEV
Web Filename:   PLD1000_EE329_EEHISTORY_ELINCNLIF_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELINCNLIF_SavePath') IS NOT NULL DROP TABLE dbo.U_ELINCNLIF_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELINCNLIF'


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
WHERE FormatCode = 'ELINCNLIF'
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
WHERE ExpFormatCode = 'ELINCNLIF'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELINCNLIF')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELINCNLIF'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELINCNLIF'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELINCNLIF'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELINCNLIF'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELINCNLIF'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELINCNLIF'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELINCNLIF'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELINCNLIF'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELINCNLIF'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELINCNLIF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINCNLIF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINCNLIF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCNLIF];
GO
IF OBJECT_ID('U_ELINCNLIF_File') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_File];
GO
IF OBJECT_ID('U_ELINCNLIF_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_EEList];
GO
IF OBJECT_ID('U_ELINCNLIF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_drvTbl];
GO
IF OBJECT_ID('U_ELINCNLIF_Dependents') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_Dependents];
GO
IF OBJECT_ID('U_ELINCNLIF_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_DedList];
GO
IF OBJECT_ID('U_ELINCNLIF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_AuditFields];
GO
IF OBJECT_ID('U_ELINCNLIF_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINCNLIF_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELINCNLIF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELINCNLIF];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINCNLIF','Lincoln Basic Life','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','27000','S','N','ELINCNLIF0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELINCNLIF0Z0','50','H','01','1',NULL,'Employee ID',NULL,NULL,'"Employee ID "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELINCNLIF0Z0','50','H','01','2',NULL,'Change Date',NULL,NULL,'"Change Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELINCNLIF0Z0','50','H','01','3',NULL,'Dep Change Date',NULL,NULL,'"Dep Change Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELINCNLIF0Z0','50','H','01','4',NULL,'Termination Date',NULL,NULL,'"Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELINCNLIF0Z0','50','H','01','5',NULL,'Mbr First Name',NULL,NULL,'"Mbr First Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELINCNLIF0Z0','50','H','01','6',NULL,'Mbr Last Name',NULL,NULL,'"Mbr Last Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELINCNLIF0Z0','50','H','01','7',NULL,'Mbr Middle Initial',NULL,NULL,'"Mbr Middle Initial "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELINCNLIF0Z0','50','H','01','8',NULL,'Mbr SSN',NULL,NULL,'"Mbr SSN "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELINCNLIF0Z0','50','H','01','9',NULL,'Mbr Gender',NULL,NULL,'"Mbr Gender "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELINCNLIF0Z0','50','H','01','10',NULL,'Mbr DOB',NULL,NULL,'"Mbr DOB "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELINCNLIF0Z0','50','H','01','11',NULL,'App Sign Date',NULL,NULL,'"App Sign Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELINCNLIF0Z0','50','H','01','12',NULL,'Occupation',NULL,NULL,'"Occupation "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELINCNLIF0Z0','50','H','01','13',NULL,'Hrs Per Week',NULL,NULL,'"Hrs Per Week "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELINCNLIF0Z0','50','H','01','14',NULL,'Salary Amt',NULL,NULL,'"Salary Amt "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELINCNLIF0Z0','50','H','01','15',NULL,'Salary Code',NULL,NULL,'"Salary Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELINCNLIF0Z0','50','H','01','16',NULL,'Sal Eff Date',NULL,NULL,'"Sal Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELINCNLIF0Z0','50','H','01','17',NULL,'Mbr Addr 1',NULL,NULL,'"Mbr Addr 1 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELINCNLIF0Z0','50','H','01','18',NULL,'Mbr Addr 2',NULL,NULL,'"Mbr Addr 2 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELINCNLIF0Z0','50','H','01','19',NULL,'Mbr City',NULL,NULL,'"Mbr City "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELINCNLIF0Z0','50','H','01','20',NULL,'Mbr State',NULL,NULL,'"Mbr State "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELINCNLIF0Z0','50','H','01','21',NULL,'Mbr Zip Code',NULL,NULL,'"Mbr Zip Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELINCNLIF0Z0','50','H','01','22',NULL,'Mbr Zip Plus 4',NULL,NULL,'"Mbr Zip Plus 4 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELINCNLIF0Z0','50','H','01','23',NULL,'Home Phone',NULL,NULL,'"Home Phone "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELINCNLIF0Z0','50','H','01','24',NULL,'Work Phone',NULL,NULL,'"Work Phone "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELINCNLIF0Z0','50','H','01','25',NULL,'Work Phone Ext',NULL,NULL,'"Work Phone Ext "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELINCNLIF0Z0','50','H','01','26',NULL,'Email Address',NULL,NULL,'"Email Address "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELINCNLIF0Z0','50','H','01','27',NULL,'Date of Benefits Eligibility',NULL,NULL,'"Date of Benefits Eligibility "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELINCNLIF0Z0','50','H','01','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL,'"Subsequent Date of Benefits Eligibility "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELINCNLIF0Z0','50','H','01','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL,'"Reason for Prior Loss of Benefits Eligibility "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELINCNLIF0Z0','50','H','01','30',NULL,'Pri Bene First Name',NULL,NULL,'"Pri Bene First Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELINCNLIF0Z0','50','H','01','31',NULL,'Pri Bene Last Name',NULL,NULL,'"Pri Bene Last Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELINCNLIF0Z0','50','H','01','32',NULL,'Pri Bene Middle Init',NULL,NULL,'"Pri Bene Middle Init "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELINCNLIF0Z0','50','H','01','33',NULL,'Pri Bene Relationship',NULL,NULL,'"Pri Bene Relationship "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELINCNLIF0Z0','50','H','01','34',NULL,'Pri Bene Address 1',NULL,NULL,'"Pri Bene Address 1 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELINCNLIF0Z0','50','H','01','35',NULL,'Pri Bene Address 2',NULL,NULL,'"Pri Bene Address 2 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELINCNLIF0Z0','50','H','01','36',NULL,'Pri Bene City',NULL,NULL,'"Pri Bene City "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELINCNLIF0Z0','50','H','01','37',NULL,'Pri Bene State',NULL,NULL,'"Pri Bene State "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELINCNLIF0Z0','50','H','01','38',NULL,'Pri Bene Zip Code',NULL,NULL,'"Pri Bene Zip Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELINCNLIF0Z0','50','H','01','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL,'"Pri Bene Zip Plus 4 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELINCNLIF0Z0','50','H','01','40',NULL,'Pri Bene SSN',NULL,NULL,'"Pri Bene SSN "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELINCNLIF0Z0','50','H','01','41',NULL,'Co Bene First Name',NULL,NULL,'"Co Bene First Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELINCNLIF0Z0','50','H','01','42',NULL,'Co Bene Last Name',NULL,NULL,'"Co Bene Last Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ELINCNLIF0Z0','50','H','01','43',NULL,'Co Bene Middle Init',NULL,NULL,'"Co Bene Middle Init "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ELINCNLIF0Z0','50','H','01','44',NULL,'Co Bene Relationship',NULL,NULL,'"Co Bene Relationship "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ELINCNLIF0Z0','50','H','01','45',NULL,'Co Bene Address 1',NULL,NULL,'"Co Bene Address 1 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ELINCNLIF0Z0','50','H','01','46',NULL,'Co Bene Address 2',NULL,NULL,'"Co Bene Address 2 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ELINCNLIF0Z0','50','H','01','47',NULL,'Co Bene City',NULL,NULL,'"Co Bene City "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ELINCNLIF0Z0','50','H','01','48',NULL,'Co Bene State',NULL,NULL,'"Co Bene State "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ELINCNLIF0Z0','50','H','01','49',NULL,'Co Bene Zip Code',NULL,NULL,'"Co Bene Zip Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ELINCNLIF0Z0','50','H','01','50',NULL,'Co Bene Zip Plus 4',NULL,NULL,'"Co Bene Zip Plus 4 "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ELINCNLIF0Z0','50','H','01','51',NULL,'Co Bene SSN',NULL,NULL,'"Co Bene SSN "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ELINCNLIF0Z0','50','H','01','52',NULL,'Beneficiary Comments',NULL,NULL,'"Beneficiary Comments "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ELINCNLIF0Z0','50','H','01','53',NULL,'Accident Policy Number',NULL,NULL,'"Accident Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ELINCNLIF0Z0','50','H','01','54',NULL,'Accident Bill Location A/C Number',NULL,NULL,'"Accident Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ELINCNLIF0Z0','50','H','01','55',NULL,'Accident Sort Group',NULL,NULL,'"Accident Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ELINCNLIF0Z0','50','H','01','56',NULL,'Accident Eff Date',NULL,NULL,'"Accident Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ELINCNLIF0Z0','50','H','01','57',NULL,'Accident Plan Code',NULL,NULL,'"Accident Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ELINCNLIF0Z0','50','H','01','58',NULL,'Accident Class Code',NULL,NULL,'"Accident Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ELINCNLIF0Z0','50','H','01','59',NULL,'Accident Tier Code',NULL,NULL,'"Accident Tier Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ELINCNLIF0Z0','50','H','01','60',NULL,'Health Asses Tier',NULL,NULL,'"Health Asses Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ELINCNLIF0Z0','50','H','01','61',NULL,'Hospital Tier',NULL,NULL,'"Hospital Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ELINCNLIF0Z0','50','H','01','62',NULL,'Accident Disability Amount',NULL,NULL,'"Accident Disability Amount "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ELINCNLIF0Z0','50','H','01','63',NULL,'Accident DI Tier',NULL,NULL,'"Accident DI Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ELINCNLIF0Z0','50','H','01','64',NULL,'Accident DI Benefit Period',NULL,NULL,'"Accident DI Benefit Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ELINCNLIF0Z0','50','H','01','65',NULL,'Accident DI Elim Period',NULL,NULL,'"Accident DI Elim Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ELINCNLIF0Z0','50','H','01','66',NULL,'Accident Sickness Disability Amount',NULL,NULL,'"Accident Sickness Disability Amount "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ELINCNLIF0Z0','50','H','01','67',NULL,'Accident/sick Tier',NULL,NULL,'"Accident/sick Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ELINCNLIF0Z0','50','H','01','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL,'"Accident/sick DI Benefit Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ELINCNLIF0Z0','50','H','01','69',NULL,'Accident/sick DI Elim Period',NULL,NULL,'"Accident/sick DI Elim Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ELINCNLIF0Z0','50','H','01','70',NULL,'Accident Termination Date',NULL,NULL,'"Accident Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ELINCNLIF0Z0','50','H','01','71',NULL,'Critical Illness Policy Number',NULL,NULL,'"Critical Illness Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ELINCNLIF0Z0','50','H','01','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL,'"Critical Illness Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ELINCNLIF0Z0','50','H','01','73',NULL,'Critical Illness Sort Group',NULL,NULL,'"Critical Illness Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ELINCNLIF0Z0','50','H','01','74',NULL,'Critical Illness Eff Date',NULL,NULL,'"Critical Illness Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ELINCNLIF0Z0','50','H','01','75',NULL,'Critical Illness Plan Code',NULL,NULL,'"Critical Illness Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ELINCNLIF0Z0','50','H','01','76',NULL,'Critical Illness Class Code',NULL,NULL,'"Critical Illness Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ELINCNLIF0Z0','50','H','01','77',NULL,'Critical Illness Termination Date',NULL,NULL,'"Critical Illness Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ELINCNLIF0Z0','50','H','01','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL,'"EE Principal Sum Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ELINCNLIF0Z0','50','H','01','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL,'"EE Principal Sum Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ELINCNLIF0Z0','50','H','01','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL,'"SP Principal Sum Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ELINCNLIF0Z0','50','H','01','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL,'"SP Principal Sum Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ELINCNLIF0Z0','50','H','01','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL,'"CH Principal Sum Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ELINCNLIF0Z0','50','H','01','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL,'"CH Principal Sum Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ELINCNLIF0Z0','50','H','01','84',NULL,'EE Heart Amt Approved',NULL,NULL,'"EE Heart Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ELINCNLIF0Z0','50','H','01','85',NULL,'EE Heart Amt Pending',NULL,NULL,'"EE Heart Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ELINCNLIF0Z0','50','H','01','86',NULL,'SP Heart Amt Approved',NULL,NULL,'"SP Heart Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ELINCNLIF0Z0','50','H','01','87',NULL,'SP Heart Amt Pending',NULL,NULL,'"SP Heart Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ELINCNLIF0Z0','50','H','01','88',NULL,'CH Heart Amt Approved',NULL,NULL,'"CH Heart Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ELINCNLIF0Z0','50','H','01','89',NULL,'CH Heart Amt Pending',NULL,NULL,'"CH Heart Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ELINCNLIF0Z0','50','H','01','90',NULL,'EE Cancer Amt Approved',NULL,NULL,'"EE Cancer Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ELINCNLIF0Z0','50','H','01','91',NULL,'EE Cancer Amt Pending',NULL,NULL,'"EE Cancer Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ELINCNLIF0Z0','50','H','01','92',NULL,'SP Cancer Amt Approved',NULL,NULL,'"SP Cancer Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ELINCNLIF0Z0','50','H','01','93',NULL,'SP Cancer Amt Pending',NULL,NULL,'"SP Cancer Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ELINCNLIF0Z0','50','H','01','94',NULL,'CH Cancer Amt Approved',NULL,NULL,'"CH Cancer Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ELINCNLIF0Z0','50','H','01','95',NULL,'CH Cancer Amt Pending',NULL,NULL,'"CH Cancer Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ELINCNLIF0Z0','50','H','01','96',NULL,'EE Organ Amt Approved',NULL,NULL,'"EE Organ Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ELINCNLIF0Z0','50','H','01','97',NULL,'EE Organ Amt Pending',NULL,NULL,'"EE Organ Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ELINCNLIF0Z0','50','H','01','98',NULL,'SP Organ Amt Approved',NULL,NULL,'"SP Organ Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ELINCNLIF0Z0','50','H','01','99',NULL,'SP Organ Amt Pending',NULL,NULL,'"SP Organ Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ELINCNLIF0Z0','50','H','01','100',NULL,'CH Organ Amt Approved',NULL,NULL,'"CH Organ Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ELINCNLIF0Z0','50','H','01','101',NULL,'CH Organ Amt Pending',NULL,NULL,'"CH Organ Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ELINCNLIF0Z0','50','H','01','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL,'"EE Quality of Life Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ELINCNLIF0Z0','50','H','01','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL,'"EE Quality of Life Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ELINCNLIF0Z0','50','H','01','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL,'"SP Quality of Life Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ELINCNLIF0Z0','50','H','01','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL,'"SP Quality of Life Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ELINCNLIF0Z0','50','H','01','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL,'"CH Quality of Life Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ELINCNLIF0Z0','50','H','01','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL,'"CH Quality of Life Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ELINCNLIF0Z0','50','H','01','108',NULL,'Child Category Amt Approved',NULL,NULL,'"Child Category Amt Approved "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ELINCNLIF0Z0','50','H','01','109',NULL,'Child Category Amt Pending',NULL,NULL,'"Child Category Amt Pending "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ELINCNLIF0Z0','50','H','01','110',NULL,'EE Treatment Care Y/N',NULL,NULL,'"EE Treatment Care Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ELINCNLIF0Z0','50','H','01','111',NULL,'SP Treatment Care Y/N',NULL,NULL,'"SP Treatment Care Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ELINCNLIF0Z0','50','H','01','112',NULL,'CH Treatment Care Y/N',NULL,NULL,'"CH Treatment Care Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ELINCNLIF0Z0','50','H','01','113',NULL,'EE DI Y/N',NULL,NULL,'"EE DI Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ELINCNLIF0Z0','50','H','01','114',NULL,'SP DI Y/N',NULL,NULL,'"SP DI Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ELINCNLIF0Z0','50','H','01','115',NULL,'EE Accident Y/N',NULL,NULL,'"EE Accident Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ELINCNLIF0Z0','50','H','01','116',NULL,'SP Accident Y/N',NULL,NULL,'"SP Accident Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ELINCNLIF0Z0','50','H','01','117',NULL,'CH Accident Y/N',NULL,NULL,'"CH Accident Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ELINCNLIF0Z0','50','H','01','118',NULL,'EE Occ/HIV Y/N',NULL,NULL,'"EE Occ/HIV Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ELINCNLIF0Z0','50','H','01','119',NULL,'Life Policy Number',NULL,NULL,'"Life Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ELINCNLIF0Z0','50','H','01','120',NULL,'Life Bill Location A/C Number',NULL,NULL,'"Life Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ELINCNLIF0Z0','50','H','01','121',NULL,'Life Sort Group',NULL,NULL,'"Life Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ELINCNLIF0Z0','50','H','01','122',NULL,'Life Eff Date',NULL,NULL,'"Life Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ELINCNLIF0Z0','50','H','01','123',NULL,'Life Plan Code',NULL,NULL,'"Life Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ELINCNLIF0Z0','50','H','01','124',NULL,'Life Class Code',NULL,NULL,'"Life Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ELINCNLIF0Z0','50','H','01','125',NULL,'LI Cvgs',NULL,NULL,'"LI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ELINCNLIF0Z0','50','H','01','126',NULL,'LI Termination Date',NULL,NULL,'"LI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ELINCNLIF0Z0','50','H','01','127',NULL,'AD Cvgs',NULL,NULL,'"AD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ELINCNLIF0Z0','50','H','01','128',NULL,'AD Termination Date',NULL,NULL,'"AD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ELINCNLIF0Z0','50','H','01','129',NULL,'DLI Cvgs',NULL,NULL,'"DLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ELINCNLIF0Z0','50','H','01','130',NULL,'DLI Termination Date',NULL,NULL,'"DLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ELINCNLIF0Z0','50','H','01','131',NULL,'DAD Cvgs',NULL,NULL,'"DAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ELINCNLIF0Z0','50','H','01','132',NULL,'DAD Termination Date',NULL,NULL,'"DAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ELINCNLIF0Z0','50','H','01','133',NULL,'OLI Cvgs',NULL,NULL,'"OLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ELINCNLIF0Z0','50','H','01','134',NULL,'OLI Termination Date',NULL,NULL,'"OLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ELINCNLIF0Z0','50','H','01','135',NULL,'OAD Cvgs',NULL,NULL,'"OAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ELINCNLIF0Z0','50','H','01','136',NULL,'OAD Termination Date',NULL,NULL,'"OAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ELINCNLIF0Z0','50','H','01','137',NULL,'ODLI Cvgs',NULL,NULL,'"ODLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ELINCNLIF0Z0','50','H','01','138',NULL,'ODLI Termination Date',NULL,NULL,'"ODLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ELINCNLIF0Z0','50','H','01','139',NULL,'ODAD Cvgs',NULL,NULL,'"ODAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ELINCNLIF0Z0','50','H','01','140',NULL,'ODAD Termination Date',NULL,NULL,'"ODAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ELINCNLIF0Z0','50','H','01','141',NULL,'SLI Cvgs',NULL,NULL,'"SLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ELINCNLIF0Z0','50','H','01','142',NULL,'SLI Termination Date',NULL,NULL,'"SLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ELINCNLIF0Z0','50','H','01','143',NULL,'SAD Cvgs',NULL,NULL,'"SAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ELINCNLIF0Z0','50','H','01','144',NULL,'SAD Termination Date',NULL,NULL,'"SAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ELINCNLIF0Z0','50','H','01','145',NULL,'CLI Cvgs',NULL,NULL,'"CLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ELINCNLIF0Z0','50','H','01','146',NULL,'CLI Termination Date',NULL,NULL,'"CLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ELINCNLIF0Z0','50','H','01','147',NULL,'OSLI Cvgs',NULL,NULL,'"OSLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ELINCNLIF0Z0','50','H','01','148',NULL,'OSLI Termination Date',NULL,NULL,'"OSLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ELINCNLIF0Z0','50','H','01','149',NULL,'OSAD Cvgs',NULL,NULL,'"OSAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ELINCNLIF0Z0','50','H','01','150',NULL,'OSAD Termination Date',NULL,NULL,'"OSAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ELINCNLIF0Z0','50','H','01','151',NULL,'OCLI Cvgs',NULL,NULL,'"OCLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ELINCNLIF0Z0','50','H','01','152',NULL,'OCLI Termination Date',NULL,NULL,'"OCLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ELINCNLIF0Z0','50','H','01','153',NULL,'WI Policy Number',NULL,NULL,'"WI Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ELINCNLIF0Z0','50','H','01','154',NULL,'WI Bill Location A/C Number',NULL,NULL,'"WI Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ELINCNLIF0Z0','50','H','01','155',NULL,'WI Sort Group',NULL,NULL,'"WI Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ELINCNLIF0Z0','50','H','01','156',NULL,'WI Eff Date',NULL,NULL,'"WI Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ELINCNLIF0Z0','50','H','01','157',NULL,'WI Plan Code',NULL,NULL,'"WI Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ELINCNLIF0Z0','50','H','01','158',NULL,'WI Class Code',NULL,NULL,'"WI Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ELINCNLIF0Z0','50','H','01','159',NULL,'WI Cvgs',NULL,NULL,'"WI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ELINCNLIF0Z0','50','H','01','160',NULL,'WI Termination Date',NULL,NULL,'"WI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ELINCNLIF0Z0','50','H','01','161',NULL,'OWI Cvgs',NULL,NULL,'"OWI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ELINCNLIF0Z0','50','H','01','162',NULL,'OWI Termination Date',NULL,NULL,'"OWI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ELINCNLIF0Z0','50','H','01','163',NULL,'LTD Policy Number',NULL,NULL,'"LTD Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ELINCNLIF0Z0','50','H','01','164',NULL,'LTD Bill Location A/C Number',NULL,NULL,'"LTD Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ELINCNLIF0Z0','50','H','01','165',NULL,'LTD Sort Group',NULL,NULL,'"LTD Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ELINCNLIF0Z0','50','H','01','166',NULL,'LTD Eff Date',NULL,NULL,'"LTD Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ELINCNLIF0Z0','50','H','01','167',NULL,'LTD Plan Code',NULL,NULL,'"LTD Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ELINCNLIF0Z0','50','H','01','168',NULL,'LTD Class Code',NULL,NULL,'"LTD Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','ELINCNLIF0Z0','50','H','01','169',NULL,'LTD Cvgs',NULL,NULL,'"LTD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','ELINCNLIF0Z0','50','H','01','170',NULL,'LTD Termination Date',NULL,NULL,'"LTD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','ELINCNLIF0Z0','50','H','01','171',NULL,'OLTD Cvgs',NULL,NULL,'"OLTD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','ELINCNLIF0Z0','50','H','01','172',NULL,'OLTD Termination Date',NULL,NULL,'"OLTD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','ELINCNLIF0Z0','50','H','01','173',NULL,'CI Cvgs',NULL,NULL,'"CI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','ELINCNLIF0Z0','50','H','01','174',NULL,'CI Termination Date',NULL,NULL,'"CI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','ELINCNLIF0Z0','50','H','01','175',NULL,'Dent Policy Number',NULL,NULL,'"Dent Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','ELINCNLIF0Z0','50','H','01','176',NULL,'Dent Bill Location A/C Number',NULL,NULL,'"Dent Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','ELINCNLIF0Z0','50','H','01','177',NULL,'Dent Sort Group',NULL,NULL,'"Dent Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','ELINCNLIF0Z0','50','H','01','178',NULL,'Dent Eff Date',NULL,NULL,'"Dent Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','ELINCNLIF0Z0','50','H','01','179',NULL,'Dent Plan Code',NULL,NULL,'"Dent Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','ELINCNLIF0Z0','50','H','01','180',NULL,'Dent Class Code',NULL,NULL,'"Dent Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','ELINCNLIF0Z0','50','H','01','181',NULL,'Dent Coverage Tier',NULL,NULL,'"Dent Coverage Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','ELINCNLIF0Z0','50','H','01','182',NULL,'Dent Other Ins',NULL,NULL,'"Dent Other Ins "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','ELINCNLIF0Z0','50','H','01','183',NULL,'Dent Termination Date',NULL,NULL,'"Dent Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','ELINCNLIF0Z0','50','H','01','184',NULL,'DHMO Policy Number',NULL,NULL,'"DHMO Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','ELINCNLIF0Z0','50','H','01','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL,'"DHMO Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','ELINCNLIF0Z0','50','H','01','186',NULL,'DHMO Sort Group',NULL,NULL,'"DHMO Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','ELINCNLIF0Z0','50','H','01','187',NULL,'DHMO Eff Date',NULL,NULL,'"DHMO Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','ELINCNLIF0Z0','50','H','01','188',NULL,'DHMO Plan Code',NULL,NULL,'"DHMO Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','ELINCNLIF0Z0','50','H','01','189',NULL,'DHMO Class Code',NULL,NULL,'"DHMO Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','ELINCNLIF0Z0','50','H','01','190',NULL,'DHMO Coverage Tier',NULL,NULL,'"DHMO Coverage Tier  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','ELINCNLIF0Z0','50','H','01','191',NULL,'DHMO PCP',NULL,NULL,'"DHMO PCP  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','ELINCNLIF0Z0','50','H','01','192',NULL,'DHMO Termination Date',NULL,NULL,'"DHMO Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','ELINCNLIF0Z0','50','H','01','193',NULL,'LVC Policy Number',NULL,NULL,'"LVC Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','ELINCNLIF0Z0','50','H','01','194',NULL,'LVC Bill Location A/C Number',NULL,NULL,'"LVC Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','ELINCNLIF0Z0','50','H','01','195',NULL,'LVC Sort Group',NULL,NULL,'"LVC Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','ELINCNLIF0Z0','50','H','01','196',NULL,'LVC Eff Date',NULL,NULL,'"LVC Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','ELINCNLIF0Z0','50','H','01','197',NULL,'LVC Plan Code',NULL,NULL,'"LVC Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','ELINCNLIF0Z0','50','H','01','198',NULL,'LVC Class Code',NULL,NULL,'"LVC Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','ELINCNLIF0Z0','50','H','01','199',NULL,'LVC Coverage Tier',NULL,NULL,'"LVC Coverage Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','ELINCNLIF0Z0','50','H','01','200',NULL,'LVC Other Ins',NULL,NULL,'"LVC Other Ins "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','ELINCNLIF0Z0','50','H','01','201',NULL,'LVC Termination Date',NULL,NULL,'"LVC Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','ELINCNLIF0Z0','50','H','01','202',NULL,'VLVC Policy Number',NULL,NULL,'"VLVC Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','ELINCNLIF0Z0','50','H','01','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL,'"VLVC Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','ELINCNLIF0Z0','50','H','01','204',NULL,'VLVC Sort Group',NULL,NULL,'"VLVC Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','ELINCNLIF0Z0','50','H','01','205',NULL,'VLVC Eff Date',NULL,NULL,'"VLVC Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','ELINCNLIF0Z0','50','H','01','206',NULL,'VLVC Plan Code',NULL,NULL,'"VLVC Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','ELINCNLIF0Z0','50','H','01','207',NULL,'VLVC Class Code',NULL,NULL,'"VLVC Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','ELINCNLIF0Z0','50','H','01','208',NULL,'VLVC Coverage Tier',NULL,NULL,'"VLVC Coverage Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','ELINCNLIF0Z0','50','H','01','209',NULL,'VLVC Other Ins',NULL,NULL,'"VLVC Other Ins "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','ELINCNLIF0Z0','50','H','01','210',NULL,'VLVC Termination Date',NULL,NULL,'"VLVC Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','ELINCNLIF0Z0','50','H','01','211',NULL,'VDN Policy Number',NULL,NULL,'"VDN Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','ELINCNLIF0Z0','50','H','01','212',NULL,'VDN Bill Location A/C Number',NULL,NULL,'"VDN Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','ELINCNLIF0Z0','50','H','01','213',NULL,'VDN Sort Group',NULL,NULL,'"VDN Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','ELINCNLIF0Z0','50','H','01','214',NULL,'VDN Eff Date',NULL,NULL,'"VDN Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','ELINCNLIF0Z0','50','H','01','215',NULL,'VDN Plan Code',NULL,NULL,'"VDN Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','ELINCNLIF0Z0','50','H','01','216',NULL,'VDN Class Code',NULL,NULL,'"VDN Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','ELINCNLIF0Z0','50','H','01','217',NULL,'VDN Coverage Tier',NULL,NULL,'"VDN Coverage Tier "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','ELINCNLIF0Z0','50','H','01','218',NULL,'VDN Other Ins',NULL,NULL,'"VDN Other Ins "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','ELINCNLIF0Z0','50','H','01','219',NULL,'VDN Termination Date',NULL,NULL,'"VDN Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','ELINCNLIF0Z0','50','H','01','220',NULL,'VDHMO Policy Number',NULL,NULL,'"VDHMO Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','ELINCNLIF0Z0','50','H','01','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL,'"VDHMO Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','ELINCNLIF0Z0','50','H','01','222',NULL,'VDHMO Sort Group',NULL,NULL,'"VDHMO Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','ELINCNLIF0Z0','50','H','01','223',NULL,'VDHMO Eff Date',NULL,NULL,'"VDHMO Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','ELINCNLIF0Z0','50','H','01','224',NULL,'VDHMO Plan Code',NULL,NULL,'"VDHMO Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','ELINCNLIF0Z0','50','H','01','225',NULL,'VDHMO Class Code',NULL,NULL,'"VDHMO Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','ELINCNLIF0Z0','50','H','01','226',NULL,'VDHMO Coverage Tier',NULL,NULL,'"VDHMO Coverage Tier  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','ELINCNLIF0Z0','50','H','01','227',NULL,'VDHMO PCP',NULL,NULL,'"VDHMO PCP  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','ELINCNLIF0Z0','50','H','01','228',NULL,'VDHMO Termination Date',NULL,NULL,'"VDHMO Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','ELINCNLIF0Z0','50','H','01','229',NULL,'VLIF Policy Number',NULL,NULL,'"VLIF Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','ELINCNLIF0Z0','50','H','01','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL,'"VLIF Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','ELINCNLIF0Z0','50','H','01','231',NULL,'VLIF Sort Group',NULL,NULL,'"VLIF Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','ELINCNLIF0Z0','50','H','01','232',NULL,'VLIF Eff Date',NULL,NULL,'"VLIF Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','ELINCNLIF0Z0','50','H','01','233',NULL,'VLIF Plan Code',NULL,NULL,'"VLIF Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','ELINCNLIF0Z0','50','H','01','234',NULL,'VLIF Class Code',NULL,NULL,'"VLIF Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','ELINCNLIF0Z0','50','H','01','235',NULL,'VLI Cvgs',NULL,NULL,'"VLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','ELINCNLIF0Z0','50','H','01','236',NULL,'VLI Termination Date',NULL,NULL,'"VLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','ELINCNLIF0Z0','50','H','01','237',NULL,'VAD Cvgs',NULL,NULL,'"VAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','ELINCNLIF0Z0','50','H','01','238',NULL,'VAD Termination Date',NULL,NULL,'"VAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','ELINCNLIF0Z0','50','H','01','239',NULL,'VSLI Cvgs',NULL,NULL,'"VSLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','ELINCNLIF0Z0','50','H','01','240',NULL,'VSLI Termination Date',NULL,NULL,'"VSLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','ELINCNLIF0Z0','50','H','01','241',NULL,'VSAD Cvgs',NULL,NULL,'"VSAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','ELINCNLIF0Z0','50','H','01','242',NULL,'VSAD Termination Date',NULL,NULL,'"VSAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','ELINCNLIF0Z0','50','H','01','243',NULL,'VCLI Cvgs',NULL,NULL,'"VCLI Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','ELINCNLIF0Z0','50','H','01','244',NULL,'VCLI Termination Date',NULL,NULL,'"VCLI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','ELINCNLIF0Z0','50','H','01','245',NULL,'VWI Policy Number',NULL,NULL,'"VWI Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','ELINCNLIF0Z0','50','H','01','246',NULL,'VWI Bill Location A/C Number',NULL,NULL,'"VWI Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','ELINCNLIF0Z0','50','H','01','247',NULL,'VWI Sort Group',NULL,NULL,'"VWI Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','ELINCNLIF0Z0','50','H','01','248',NULL,'VWI Eff Date',NULL,NULL,'"VWI Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','ELINCNLIF0Z0','50','H','01','249',NULL,'VWI Plan Code',NULL,NULL,'"VWI Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','ELINCNLIF0Z0','50','H','01','250',NULL,'VWI Class Code',NULL,NULL,'"VWI Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','ELINCNLIF0Z0','50','H','01','251',NULL,'VWI Benefit Amt',NULL,NULL,'"VWI Benefit Amt "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','ELINCNLIF0Z0','50','H','01','252',NULL,'VWI Elim Period',NULL,NULL,'"VWI Elim Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','ELINCNLIF0Z0','50','H','01','253',NULL,'VWI Benefit Duration',NULL,NULL,'"VWI Benefit Duration "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','ELINCNLIF0Z0','50','H','01','254',NULL,'VWI Termination Date',NULL,NULL,'"VWI Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','ELINCNLIF0Z0','50','H','01','255',NULL,'VLTD Policy Number',NULL,NULL,'"VLTD Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','ELINCNLIF0Z0','50','H','01','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL,'"VLTD Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','ELINCNLIF0Z0','50','H','01','257',NULL,'VLTD Sort Group',NULL,NULL,'"VLTD Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','ELINCNLIF0Z0','50','H','01','258',NULL,'VLTD Eff Date',NULL,NULL,'"VLTD Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','ELINCNLIF0Z0','50','H','01','259',NULL,'VLTD Plan Code',NULL,NULL,'"VLTD Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','ELINCNLIF0Z0','50','H','01','260',NULL,'VLTD Class Code',NULL,NULL,'"VLTD Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','ELINCNLIF0Z0','50','H','01','261',NULL,'VLTD Benefit Amt',NULL,NULL,'"VLTD Benefit Amt "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','ELINCNLIF0Z0','50','H','01','262',NULL,'VLTD Elim Period',NULL,NULL,'"VLTD Elim Period "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','ELINCNLIF0Z0','50','H','01','263',NULL,'VLTD Benefit Duration',NULL,NULL,'"VLTD Benefit Duration "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','ELINCNLIF0Z0','50','H','01','264',NULL,'VLTD Benefit Pct',NULL,NULL,'"VLTD Benefit Pct "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','ELINCNLIF0Z0','50','H','01','265',NULL,'VLTD Termination Date',NULL,NULL,'"VLTD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','ELINCNLIF0Z0','50','H','01','266',NULL,'STAD Policy Number',NULL,NULL,'"STAD Policy Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','ELINCNLIF0Z0','50','H','01','267',NULL,'STAD Bill Location A/C Number',NULL,NULL,'"STAD Bill Location A/C Number "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','ELINCNLIF0Z0','50','H','01','268',NULL,'STAD Sort Group',NULL,NULL,'"STAD Sort Group "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','ELINCNLIF0Z0','50','H','01','269',NULL,'STAD Eff Date',NULL,NULL,'"STAD Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','ELINCNLIF0Z0','50','H','01','270',NULL,'STAD Plan Code',NULL,NULL,'"STAD Plan Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','ELINCNLIF0Z0','50','H','01','271',NULL,'STAD Class Code',NULL,NULL,'"STAD Class Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','ELINCNLIF0Z0','50','H','01','272',NULL,'STVAD Cvgs',NULL,NULL,'"STVAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','ELINCNLIF0Z0','50','H','01','273',NULL,'STVAD Termination Date',NULL,NULL,'"STVAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','ELINCNLIF0Z0','50','H','01','274',NULL,'STVSAD Cvgs',NULL,NULL,'"STVSAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','ELINCNLIF0Z0','50','H','01','275',NULL,'STVSAD Termination Date',NULL,NULL,'"STVSAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','ELINCNLIF0Z0','50','H','01','276',NULL,'STVCAD Cvgs',NULL,NULL,'"STVCAD Cvgs "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','ELINCNLIF0Z0','50','H','01','277',NULL,'STVCAD Termination Date',NULL,NULL,'"STVCAD Termination Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','ELINCNLIF0Z0','50','H','01','278',NULL,'Qualifying Event Code',NULL,NULL,'"Qualifying Event Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','ELINCNLIF0Z0','50','H','01','279',NULL,'Qualifying Event Eff Date',NULL,NULL,'"Qualifying Event Eff Date "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','ELINCNLIF0Z0','50','H','01','280',NULL,'Mbr Smoker',NULL,NULL,'"Mbr Smoker "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','ELINCNLIF0Z0','50','H','01','281',NULL,'Spouse Smoker',NULL,NULL,'"Spouse Smoker  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','ELINCNLIF0Z0','50','H','01','282',NULL,'Spouse DOB',NULL,NULL,'"Spouse DOB "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','ELINCNLIF0Z0','50','H','01','283',NULL,'Dep First Name',NULL,NULL,'"Dep First Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','ELINCNLIF0Z0','50','H','01','284',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','ELINCNLIF0Z0','50','H','01','285',NULL,'Dep M I',NULL,NULL,'"Dep M I  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','ELINCNLIF0Z0','50','H','01','286',NULL,'Dep Gender',NULL,NULL,'"Dep Gender "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','ELINCNLIF0Z0','50','H','01','287',NULL,'Dep DOB',NULL,NULL,'"Dep DOB "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','ELINCNLIF0Z0','50','H','01','288',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','ELINCNLIF0Z0','50','H','01','289',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','ELINCNLIF0Z0','50','H','01','290',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','ELINCNLIF0Z0','50','H','01','291',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','ELINCNLIF0Z0','50','H','01','292',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP  "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','ELINCNLIF0Z0','199','H','01','293',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','ELINCNLIF0Z0','200','H','01','294',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','ELINCNLIF0Z0','201','H','01','295',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','ELINCNLIF0Z0','202','H','01','296',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','ELINCNLIF0Z0','203','H','01','297',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','ELINCNLIF0Z0','204','H','01','298',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','ELINCNLIF0Z0','205','H','01','299',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','ELINCNLIF0Z0','206','H','01','300',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','ELINCNLIF0Z0','207','H','01','301',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','ELINCNLIF0Z0','208','H','01','302',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','ELINCNLIF0Z0','199','H','01','303',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','ELINCNLIF0Z0','200','H','01','304',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','ELINCNLIF0Z0','201','H','01','305',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','ELINCNLIF0Z0','202','H','01','306',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','ELINCNLIF0Z0','203','H','01','307',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','ELINCNLIF0Z0','204','H','01','308',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','ELINCNLIF0Z0','205','H','01','309',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','ELINCNLIF0Z0','206','H','01','310',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','ELINCNLIF0Z0','207','H','01','311',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','ELINCNLIF0Z0','208','H','01','312',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','ELINCNLIF0Z0','199','H','01','313',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','ELINCNLIF0Z0','200','H','01','314',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','ELINCNLIF0Z0','201','H','01','315',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','ELINCNLIF0Z0','202','H','01','316',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','ELINCNLIF0Z0','203','H','01','317',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','ELINCNLIF0Z0','204','H','01','318',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','ELINCNLIF0Z0','205','H','01','319',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','ELINCNLIF0Z0','206','H','01','320',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','ELINCNLIF0Z0','207','H','01','321',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','ELINCNLIF0Z0','208','H','01','322',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','ELINCNLIF0Z0','199','H','01','323',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','ELINCNLIF0Z0','200','H','01','324',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','ELINCNLIF0Z0','201','H','01','325',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','ELINCNLIF0Z0','202','H','01','326',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','ELINCNLIF0Z0','203','H','01','327',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','ELINCNLIF0Z0','204','H','01','328',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','ELINCNLIF0Z0','205','H','01','329',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','ELINCNLIF0Z0','206','H','01','330',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','ELINCNLIF0Z0','207','H','01','331',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','ELINCNLIF0Z0','208','H','01','332',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','ELINCNLIF0Z0','199','H','01','333',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','ELINCNLIF0Z0','200','H','01','334',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','ELINCNLIF0Z0','201','H','01','335',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','ELINCNLIF0Z0','202','H','01','336',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','ELINCNLIF0Z0','203','H','01','337',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','ELINCNLIF0Z0','204','H','01','338',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','ELINCNLIF0Z0','205','H','01','339',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','ELINCNLIF0Z0','206','H','01','340',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','ELINCNLIF0Z0','207','H','01','341',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','ELINCNLIF0Z0','208','H','01','342',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','ELINCNLIF0Z0','199','H','01','343',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','ELINCNLIF0Z0','200','H','01','344',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','ELINCNLIF0Z0','201','H','01','345',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','ELINCNLIF0Z0','202','H','01','346',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','ELINCNLIF0Z0','203','H','01','347',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','ELINCNLIF0Z0','204','H','01','348',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','ELINCNLIF0Z0','205','H','01','349',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','ELINCNLIF0Z0','206','H','01','350',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','ELINCNLIF0Z0','207','H','01','351',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','ELINCNLIF0Z0','208','H','01','352',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','ELINCNLIF0Z0','199','H','01','353',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','ELINCNLIF0Z0','200','H','01','354',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','ELINCNLIF0Z0','201','H','01','355',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','ELINCNLIF0Z0','202','H','01','356',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','ELINCNLIF0Z0','203','H','01','357',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','ELINCNLIF0Z0','204','H','01','358',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','ELINCNLIF0Z0','205','H','01','359',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','ELINCNLIF0Z0','206','H','01','360',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','ELINCNLIF0Z0','207','H','01','361',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','ELINCNLIF0Z0','208','H','01','362',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','ELINCNLIF0Z0','199','H','01','363',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','ELINCNLIF0Z0','200','H','01','364',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','ELINCNLIF0Z0','201','H','01','365',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','ELINCNLIF0Z0','202','H','01','366',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','ELINCNLIF0Z0','203','H','01','367',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','ELINCNLIF0Z0','204','H','01','368',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','ELINCNLIF0Z0','205','H','01','369',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','ELINCNLIF0Z0','206','H','01','370',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','ELINCNLIF0Z0','207','H','01','371',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','ELINCNLIF0Z0','208','H','01','372',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','ELINCNLIF0Z0','199','H','01','373',NULL,'Dep First Name',NULL,NULL,'"Dep First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','ELINCNLIF0Z0','200','H','01','374',NULL,'Dep Last Name',NULL,NULL,'"Dep Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','ELINCNLIF0Z0','201','H','01','375',NULL,'Dep M I',NULL,NULL,'"Dep M I"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','ELINCNLIF0Z0','202','H','01','376',NULL,'Dep Gender',NULL,NULL,'"Dep Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','ELINCNLIF0Z0','203','H','01','377',NULL,'Dep DOB',NULL,NULL,'"Dep DOB"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','ELINCNLIF0Z0','204','H','01','378',NULL,'Dep Relationship Code',NULL,NULL,'"Dep Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','ELINCNLIF0Z0','205','H','01','379',NULL,'Dep Student Code',NULL,NULL,'"Dep Student Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','ELINCNLIF0Z0','206','H','01','380',NULL,'Dep Disabled Y/N',NULL,NULL,'"Dep Disabled Y/N"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','ELINCNLIF0Z0','207','H','01','381',NULL,'Dep Cvg Indicator',NULL,NULL,'"Dep Cvg Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','ELINCNLIF0Z0','208','H','01','382',NULL,'Dep DHMO PCP',NULL,NULL,'"Dep DHMO PCP"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELINCNLIF0Z0','20','D','10','1',NULL,'Employee ID',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELINCNLIF0Z0','10','D','10','2',NULL,'Change Date',NULL,NULL,'"drvChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELINCNLIF0Z0','10','D','10','3',NULL,'Dep Change Date',NULL,NULL,'"drvDepChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELINCNLIF0Z0','10','D','10','4',NULL,'Termination Date',NULL,NULL,'"drvEedBenStopDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELINCNLIF0Z0','50','D','10','5',NULL,'Mbr First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELINCNLIF0Z0','50','D','10','6',NULL,'Mbr Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELINCNLIF0Z0','1','D','10','7',NULL,'Mbr Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELINCNLIF0Z0','11','D','10','8',NULL,'Mbr SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELINCNLIF0Z0','1','D','10','9',NULL,'Mbr Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELINCNLIF0Z0','10','D','10','10',NULL,'Mbr DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELINCNLIF0Z0','50','D','10','11',NULL,'App Sign Date',NULL,NULL,'"drvAppSignDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELINCNLIF0Z0','50','D','10','12',NULL,'Occupation',NULL,NULL,'"drvJobDesc"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELINCNLIF0Z0','50','D','10','13',NULL,'Hrs Per Week',NULL,NULL,'"drvScheduledWorkHrs"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELINCNLIF0Z0','50','D','10','14',NULL,'Salary Amt',NULL,NULL,'"drvAnnSalary"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELINCNLIF0Z0','50','D','10','15',NULL,'Salary Code',NULL,NULL,'"A"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELINCNLIF0Z0','50','D','10','16',NULL,'Sal Eff Date',NULL,NULL,'"drvSalaryEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELINCNLIF0Z0','50','D','10','17',NULL,'Mbr Addr 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELINCNLIF0Z0','50','D','10','18',NULL,'Mbr Addr 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELINCNLIF0Z0','50','D','10','19',NULL,'Mbr City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELINCNLIF0Z0','50','D','10','20',NULL,'Mbr State',NULL,NULL,'"drvAdressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELINCNLIF0Z0','50','D','10','21',NULL,'Mbr Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELINCNLIF0Z0','50','D','10','22',NULL,'Mbr Zip Plus 4',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELINCNLIF0Z0','50','D','10','23',NULL,'Home Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELINCNLIF0Z0','50','D','10','24',NULL,'Work Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELINCNLIF0Z0','50','D','10','25',NULL,'Work Phone Ext',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELINCNLIF0Z0','50','D','10','26',NULL,'Email Address',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELINCNLIF0Z0','50','D','10','27',NULL,'Date of Benefits Eligibility',NULL,NULL,'"drvDateOfOriginalHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELINCNLIF0Z0','50','D','10','28',NULL,'Subsequent Date of Benefits Eligibility',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELINCNLIF0Z0','50','D','10','29',NULL,'Reason for Prior Loss of Benefits Eligibility',NULL,NULL,'"drvRsnLossOfBen"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELINCNLIF0Z0','50','D','10','30',NULL,'Pri Bene First Name',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELINCNLIF0Z0','50','D','10','31',NULL,'Pri Bene Last Name',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELINCNLIF0Z0','50','D','10','32',NULL,'Pri Bene Middle Init',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELINCNLIF0Z0','50','D','10','33',NULL,'Pri Bene Relationship',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELINCNLIF0Z0','50','D','10','34',NULL,'Pri Bene Address 1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELINCNLIF0Z0','50','D','10','35',NULL,'Pri Bene Address 2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELINCNLIF0Z0','50','D','10','36',NULL,'Pri Bene City',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELINCNLIF0Z0','50','D','10','37',NULL,'Pri Bene State',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELINCNLIF0Z0','50','D','10','38',NULL,'Pri Bene Zip Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELINCNLIF0Z0','50','D','10','39',NULL,'Pri Bene Zip Plus 4',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELINCNLIF0Z0','50','D','10','40',NULL,'Pri Bene SSN',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELINCNLIF0Z0','50','D','10','41',NULL,'Co Bene First Name',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELINCNLIF0Z0','50','D','10','42',NULL,'Co Bene Last Name',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ELINCNLIF0Z0','50','D','10','43',NULL,'Co Bene Middle Init',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ELINCNLIF0Z0','50','D','10','44',NULL,'Co Bene Relationship',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ELINCNLIF0Z0','50','D','10','45',NULL,'Co Bene Address 1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ELINCNLIF0Z0','50','D','10','46',NULL,'Co Bene Address 2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ELINCNLIF0Z0','50','D','10','47',NULL,'Co Bene City',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ELINCNLIF0Z0','50','D','10','48',NULL,'Co Bene State',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ELINCNLIF0Z0','50','D','10','49',NULL,'Co Bene Zip Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ELINCNLIF0Z0','50','D','10','50',NULL,'Co Bene Zip Plus 4',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ELINCNLIF0Z0','50','D','10','51',NULL,'Co Bene SSN',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ELINCNLIF0Z0','50','D','10','52',NULL,'Beneficiary Comments',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ELINCNLIF0Z0','50','D','10','53',NULL,'Accident Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ELINCNLIF0Z0','50','D','10','54',NULL,'Accident Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ELINCNLIF0Z0','50','D','10','55',NULL,'Accident Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ELINCNLIF0Z0','50','D','10','56',NULL,'Accident Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ELINCNLIF0Z0','50','D','10','57',NULL,'Accident Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ELINCNLIF0Z0','50','D','10','58',NULL,'Accident Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ELINCNLIF0Z0','50','D','10','59',NULL,'Accident Tier Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ELINCNLIF0Z0','50','D','10','60',NULL,'Health Asses Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ELINCNLIF0Z0','50','D','10','61',NULL,'Hospital Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ELINCNLIF0Z0','50','D','10','62',NULL,'Accident Disability Amount',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ELINCNLIF0Z0','50','D','10','63',NULL,'Accident DI Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ELINCNLIF0Z0','50','D','10','64',NULL,'Accident DI Benefit Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ELINCNLIF0Z0','50','D','10','65',NULL,'Accident DI Elim Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ELINCNLIF0Z0','50','D','10','66',NULL,'Accident Sickness Disability Amount',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ELINCNLIF0Z0','50','D','10','67',NULL,'Accident/sick Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ELINCNLIF0Z0','50','D','10','68',NULL,'Accident/sick DI Benefit Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ELINCNLIF0Z0','50','D','10','69',NULL,'Accident/sick DI Elim Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ELINCNLIF0Z0','50','D','10','70',NULL,'Accident Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ELINCNLIF0Z0','50','D','10','71',NULL,'Critical Illness Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ELINCNLIF0Z0','50','D','10','72',NULL,'Critical Illness Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ELINCNLIF0Z0','50','D','10','73',NULL,'Critical Illness Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ELINCNLIF0Z0','50','D','10','74',NULL,'Critical Illness Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ELINCNLIF0Z0','50','D','10','75',NULL,'Critical Illness Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ELINCNLIF0Z0','50','D','10','76',NULL,'Critical Illness Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ELINCNLIF0Z0','50','D','10','77',NULL,'Critical Illness Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ELINCNLIF0Z0','50','D','10','78',NULL,'EE Principal Sum Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ELINCNLIF0Z0','50','D','10','79',NULL,'EE Principal Sum Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ELINCNLIF0Z0','50','D','10','80',NULL,'SP Principal Sum Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ELINCNLIF0Z0','50','D','10','81',NULL,'SP Principal Sum Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ELINCNLIF0Z0','50','D','10','82',NULL,'CH Principal Sum Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ELINCNLIF0Z0','50','D','10','83',NULL,'CH Principal Sum Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ELINCNLIF0Z0','50','D','10','84',NULL,'EE Heart Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ELINCNLIF0Z0','50','D','10','85',NULL,'EE Heart Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ELINCNLIF0Z0','50','D','10','86',NULL,'SP Heart Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ELINCNLIF0Z0','50','D','10','87',NULL,'SP Heart Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ELINCNLIF0Z0','50','D','10','88',NULL,'CH Heart Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ELINCNLIF0Z0','50','D','10','89',NULL,'CH Heart Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ELINCNLIF0Z0','50','D','10','90',NULL,'EE Cancer Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ELINCNLIF0Z0','50','D','10','91',NULL,'EE Cancer Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ELINCNLIF0Z0','50','D','10','92',NULL,'SP Cancer Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ELINCNLIF0Z0','50','D','10','93',NULL,'SP Cancer Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ELINCNLIF0Z0','50','D','10','94',NULL,'CH Cancer Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ELINCNLIF0Z0','50','D','10','95',NULL,'CH Cancer Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ELINCNLIF0Z0','50','D','10','96',NULL,'EE Organ Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ELINCNLIF0Z0','50','D','10','97',NULL,'EE Organ Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ELINCNLIF0Z0','50','D','10','98',NULL,'SP Organ Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ELINCNLIF0Z0','50','D','10','99',NULL,'SP Organ Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ELINCNLIF0Z0','50','D','10','100',NULL,'CH Organ Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ELINCNLIF0Z0','50','D','10','101',NULL,'CH Organ Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ELINCNLIF0Z0','50','D','10','102',NULL,'EE Quality of Life Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ELINCNLIF0Z0','50','D','10','103',NULL,'EE Quality of Life Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ELINCNLIF0Z0','50','D','10','104',NULL,'SP Quality of Life Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ELINCNLIF0Z0','50','D','10','105',NULL,'SP Quality of Life Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ELINCNLIF0Z0','50','D','10','106',NULL,'CH Quality of Life Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ELINCNLIF0Z0','50','D','10','107',NULL,'CH Quality of Life Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ELINCNLIF0Z0','50','D','10','108',NULL,'Child Category Amt Approved',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ELINCNLIF0Z0','50','D','10','109',NULL,'Child Category Amt Pending',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ELINCNLIF0Z0','50','D','10','110',NULL,'EE Treatment Care Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ELINCNLIF0Z0','50','D','10','111',NULL,'SP Treatment Care Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ELINCNLIF0Z0','50','D','10','112',NULL,'CH Treatment Care Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ELINCNLIF0Z0','50','D','10','113',NULL,'EE DI Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ELINCNLIF0Z0','50','D','10','114',NULL,'SP DI Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ELINCNLIF0Z0','50','D','10','115',NULL,'EE Accident Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ELINCNLIF0Z0','50','D','10','116',NULL,'SP Accident Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ELINCNLIF0Z0','50','D','10','117',NULL,'CH Accident Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ELINCNLIF0Z0','50','D','10','118',NULL,'EE Occ/HIV Y/N',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ELINCNLIF0Z0','50','D','10','119',NULL,'Life Policy Number',NULL,NULL,'"drvLifePolicyNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ELINCNLIF0Z0','50','D','10','120',NULL,'Life Bill Location A/C Number',NULL,NULL,'"drvLifBillLocNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ELINCNLIF0Z0','50','D','10','121',NULL,'Life Sort Group',NULL,NULL,'"drvLifeSortGrp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ELINCNLIF0Z0','50','D','10','122',NULL,'Life Eff Date',NULL,NULL,'"drvLifeEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ELINCNLIF0Z0','50','D','10','123',NULL,'Life Plan Code',NULL,NULL,'"drvLifePlanCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ELINCNLIF0Z0','50','D','10','124',NULL,'Life Class Code',NULL,NULL,'"drvLifeClassCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ELINCNLIF0Z0','50','D','10','125',NULL,'LI Cvgs',NULL,NULL,'"drvLICvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ELINCNLIF0Z0','50','D','10','126',NULL,'LI Termination Date',NULL,NULL,'"drvLITermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ELINCNLIF0Z0','50','D','10','127',NULL,'AD Cvgs',NULL,NULL,'"drvADCvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ELINCNLIF0Z0','50','D','10','128',NULL,'AD Termination Date',NULL,NULL,'"drvADTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ELINCNLIF0Z0','50','D','10','129',NULL,'DLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ELINCNLIF0Z0','50','D','10','130',NULL,'DLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ELINCNLIF0Z0','50','D','10','131',NULL,'DAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ELINCNLIF0Z0','50','D','10','132',NULL,'DAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ELINCNLIF0Z0','50','D','10','133',NULL,'OLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ELINCNLIF0Z0','50','D','10','134',NULL,'OLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','ELINCNLIF0Z0','51','D','10','135',NULL,'OAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','ELINCNLIF0Z0','52','D','10','136',NULL,'OAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','ELINCNLIF0Z0','53','D','10','137',NULL,'ODLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','ELINCNLIF0Z0','54','D','10','138',NULL,'ODLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','ELINCNLIF0Z0','55','D','10','139',NULL,'ODAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','ELINCNLIF0Z0','56','D','10','140',NULL,'ODAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','ELINCNLIF0Z0','57','D','10','141',NULL,'SLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','ELINCNLIF0Z0','58','D','10','142',NULL,'SLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','ELINCNLIF0Z0','59','D','10','143',NULL,'SAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','ELINCNLIF0Z0','60','D','10','144',NULL,'SAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','ELINCNLIF0Z0','61','D','10','145',NULL,'CLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','ELINCNLIF0Z0','62','D','10','146',NULL,'CLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','ELINCNLIF0Z0','63','D','10','147',NULL,'OSLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','ELINCNLIF0Z0','64','D','10','148',NULL,'OSLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','ELINCNLIF0Z0','65','D','10','149',NULL,'OSAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','ELINCNLIF0Z0','66','D','10','150',NULL,'OSAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','ELINCNLIF0Z0','67','D','10','151',NULL,'OCLI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','ELINCNLIF0Z0','68','D','10','152',NULL,'OCLI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','ELINCNLIF0Z0','69','D','10','153',NULL,'WI Policy Number',NULL,NULL,'"drvWIPolicyNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','ELINCNLIF0Z0','70','D','10','154',NULL,'WI Bill Location A/C Number',NULL,NULL,'"drvWIBillLocNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','ELINCNLIF0Z0','71','D','10','155',NULL,'WI Sort Group',NULL,NULL,'"drvWISortGroup"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','ELINCNLIF0Z0','72','D','10','156',NULL,'WI Eff Date',NULL,NULL,'"drvWIEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','ELINCNLIF0Z0','73','D','10','157',NULL,'WI Plan Code',NULL,NULL,'"drvWIPlanCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','ELINCNLIF0Z0','74','D','10','158',NULL,'WI Class Code',NULL,NULL,'"drvWIClassCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','ELINCNLIF0Z0','75','D','10','159',NULL,'WI Cvgs',NULL,NULL,'"drvWICvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','ELINCNLIF0Z0','76','D','10','160',NULL,'WI Termination Date',NULL,NULL,'"drvWITermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','ELINCNLIF0Z0','77','D','10','161',NULL,'OWI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','ELINCNLIF0Z0','78','D','10','162',NULL,'OWI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','ELINCNLIF0Z0','79','D','10','163',NULL,'LTD Policy Number',NULL,NULL,'"drvLTDPolicyNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','ELINCNLIF0Z0','80','D','10','164',NULL,'LTD Bill Location A/C Number',NULL,NULL,'"drvLTDBillLocNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','ELINCNLIF0Z0','81','D','10','165',NULL,'LTD Sort Group',NULL,NULL,'"drvLTDSortGroup"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','ELINCNLIF0Z0','82','D','10','166',NULL,'LTD Eff Date',NULL,NULL,'"drvLTDEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','ELINCNLIF0Z0','83','D','10','167',NULL,'LTD Plan Code',NULL,NULL,'"drvLTDPlanCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','ELINCNLIF0Z0','84','D','10','168',NULL,'LTD Class Code',NULL,NULL,'"drvLTDClassCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','ELINCNLIF0Z0','85','D','10','169',NULL,'LTD Cvgs',NULL,NULL,'"drvLTDCvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','ELINCNLIF0Z0','86','D','10','170',NULL,'LTD Termination Date',NULL,NULL,'"drvLTDTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','ELINCNLIF0Z0','87','D','10','171',NULL,'OLTD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','ELINCNLIF0Z0','88','D','10','172',NULL,'OLTD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','ELINCNLIF0Z0','89','D','10','173',NULL,'CI Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','ELINCNLIF0Z0','90','D','10','174',NULL,'CI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','ELINCNLIF0Z0','91','D','10','175',NULL,'Dent Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','ELINCNLIF0Z0','92','D','10','176',NULL,'Dent Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','ELINCNLIF0Z0','93','D','10','177',NULL,'Dent Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','ELINCNLIF0Z0','94','D','10','178',NULL,'Dent Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','ELINCNLIF0Z0','95','D','10','179',NULL,'Dent Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','ELINCNLIF0Z0','96','D','10','180',NULL,'Dent Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','ELINCNLIF0Z0','97','D','10','181',NULL,'Dent Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','ELINCNLIF0Z0','98','D','10','182',NULL,'Dent Other Ins',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','ELINCNLIF0Z0','99','D','10','183',NULL,'Dent Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','ELINCNLIF0Z0','100','D','10','184',NULL,'DHMO Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','ELINCNLIF0Z0','101','D','10','185',NULL,'DHMO Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','ELINCNLIF0Z0','102','D','10','186',NULL,'DHMO Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','ELINCNLIF0Z0','103','D','10','187',NULL,'DHMO Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','ELINCNLIF0Z0','104','D','10','188',NULL,'DHMO Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','ELINCNLIF0Z0','105','D','10','189',NULL,'DHMO Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','ELINCNLIF0Z0','106','D','10','190',NULL,'DHMO Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','ELINCNLIF0Z0','107','D','10','191',NULL,'DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','ELINCNLIF0Z0','108','D','10','192',NULL,'DHMO Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','ELINCNLIF0Z0','109','D','10','193',NULL,'LVC Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','ELINCNLIF0Z0','110','D','10','194',NULL,'LVC Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','ELINCNLIF0Z0','111','D','10','195',NULL,'LVC Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','ELINCNLIF0Z0','112','D','10','196',NULL,'LVC Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','ELINCNLIF0Z0','113','D','10','197',NULL,'LVC Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','ELINCNLIF0Z0','114','D','10','198',NULL,'LVC Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','ELINCNLIF0Z0','115','D','10','199',NULL,'LVC Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','ELINCNLIF0Z0','116','D','10','200',NULL,'LVC Other Ins',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','ELINCNLIF0Z0','117','D','10','201',NULL,'LVC Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','ELINCNLIF0Z0','118','D','10','202',NULL,'VLVC Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','ELINCNLIF0Z0','119','D','10','203',NULL,'VLVC Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','ELINCNLIF0Z0','120','D','10','204',NULL,'VLVC Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','ELINCNLIF0Z0','121','D','10','205',NULL,'VLVC Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','ELINCNLIF0Z0','122','D','10','206',NULL,'VLVC Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','ELINCNLIF0Z0','123','D','10','207',NULL,'VLVC Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','ELINCNLIF0Z0','124','D','10','208',NULL,'VLVC Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','ELINCNLIF0Z0','125','D','10','209',NULL,'VLVC Other Ins',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','ELINCNLIF0Z0','126','D','10','210',NULL,'VLVC Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','ELINCNLIF0Z0','127','D','10','211',NULL,'VDN Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','ELINCNLIF0Z0','128','D','10','212',NULL,'VDN Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','ELINCNLIF0Z0','129','D','10','213',NULL,'VDN Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','ELINCNLIF0Z0','130','D','10','214',NULL,'VDN Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','ELINCNLIF0Z0','131','D','10','215',NULL,'VDN Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','ELINCNLIF0Z0','132','D','10','216',NULL,'VDN Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','ELINCNLIF0Z0','133','D','10','217',NULL,'VDN Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','ELINCNLIF0Z0','134','D','10','218',NULL,'VDN Other Ins',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','ELINCNLIF0Z0','135','D','10','219',NULL,'VDN Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','ELINCNLIF0Z0','136','D','10','220',NULL,'VDHMO Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','ELINCNLIF0Z0','137','D','10','221',NULL,'VDHMO Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','ELINCNLIF0Z0','138','D','10','222',NULL,'VDHMO Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','ELINCNLIF0Z0','139','D','10','223',NULL,'VDHMO Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','ELINCNLIF0Z0','140','D','10','224',NULL,'VDHMO Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','ELINCNLIF0Z0','141','D','10','225',NULL,'VDHMO Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','ELINCNLIF0Z0','142','D','10','226',NULL,'VDHMO Coverage Tier',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','ELINCNLIF0Z0','143','D','10','227',NULL,'VDHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','ELINCNLIF0Z0','144','D','10','228',NULL,'VDHMO Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','ELINCNLIF0Z0','145','D','10','229',NULL,'VLIF Policy Number',NULL,NULL,'"drvVLIFPolicyNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','ELINCNLIF0Z0','146','D','10','230',NULL,'VLIF Bill Location A/C Number',NULL,NULL,'"drvVLIFBillLocNum"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','ELINCNLIF0Z0','147','D','10','231',NULL,'VLIF Sort Group',NULL,NULL,'"drvVLIFSortGroup"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','ELINCNLIF0Z0','148','D','10','232',NULL,'VLIF Eff Date',NULL,NULL,'"drvVLIFEffDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','ELINCNLIF0Z0','149','D','10','233',NULL,'VLIF Plan Code',NULL,NULL,'"drvVLIFPlanCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','ELINCNLIF0Z0','150','D','10','234',NULL,'VLIF Class Code',NULL,NULL,'"drvVLIFClassCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','ELINCNLIF0Z0','151','D','10','235',NULL,'VLI Cvgs',NULL,NULL,'"drvVLICvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','ELINCNLIF0Z0','152','D','10','236',NULL,'VLI Termination Date',NULL,NULL,'"drvVLITermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','ELINCNLIF0Z0','153','D','10','237',NULL,'VAD Cvgs',NULL,NULL,'"drvVADCvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','ELINCNLIF0Z0','154','D','10','238',NULL,'VAD Termination Date',NULL,NULL,'"drvVADTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','ELINCNLIF0Z0','155','D','10','239',NULL,'VSLI Cvgs',NULL,NULL,'"drvVSLICvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','ELINCNLIF0Z0','156','D','10','240',NULL,'VSLI Termination Date',NULL,NULL,'"drvVLSITermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','ELINCNLIF0Z0','157','D','10','241',NULL,'VSAD Cvgs',NULL,NULL,'"drvVSADCvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','ELINCNLIF0Z0','158','D','10','242',NULL,'VSAD Termination Date',NULL,NULL,'"drvVSADTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','ELINCNLIF0Z0','159','D','10','243',NULL,'VCLI Cvgs',NULL,NULL,'"drvVCLICvgs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','ELINCNLIF0Z0','160','D','10','244',NULL,'VCLI Termination Date',NULL,NULL,'"drvVCLITermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','ELINCNLIF0Z0','161','D','10','245',NULL,'VWI Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','ELINCNLIF0Z0','162','D','10','246',NULL,'VWI Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','ELINCNLIF0Z0','163','D','10','247',NULL,'VWI Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','ELINCNLIF0Z0','164','D','10','248',NULL,'VWI Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','ELINCNLIF0Z0','165','D','10','249',NULL,'VWI Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','ELINCNLIF0Z0','166','D','10','250',NULL,'VWI Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','ELINCNLIF0Z0','167','D','10','251',NULL,'VWI Benefit Amt',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','ELINCNLIF0Z0','168','D','10','252',NULL,'VWI Elim Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','ELINCNLIF0Z0','169','D','10','253',NULL,'VWI Benefit Duration',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','ELINCNLIF0Z0','170','D','10','254',NULL,'VWI Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','ELINCNLIF0Z0','171','D','10','255',NULL,'VLTD Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','ELINCNLIF0Z0','172','D','10','256',NULL,'VLTD Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','ELINCNLIF0Z0','173','D','10','257',NULL,'VLTD Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','ELINCNLIF0Z0','174','D','10','258',NULL,'VLTD Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','ELINCNLIF0Z0','175','D','10','259',NULL,'VLTD Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','ELINCNLIF0Z0','176','D','10','260',NULL,'VLTD Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','ELINCNLIF0Z0','177','D','10','261',NULL,'VLTD Benefit Amt',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','ELINCNLIF0Z0','178','D','10','262',NULL,'VLTD Elim Period',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','ELINCNLIF0Z0','179','D','10','263',NULL,'VLTD Benefit Duration',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','ELINCNLIF0Z0','180','D','10','264',NULL,'VLTD Benefit Pct',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','ELINCNLIF0Z0','181','D','10','265',NULL,'VLTD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','ELINCNLIF0Z0','182','D','10','266',NULL,'STAD Policy Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','ELINCNLIF0Z0','183','D','10','267',NULL,'STAD Bill Location A/C Number',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','ELINCNLIF0Z0','184','D','10','268',NULL,'STAD Sort Group',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','ELINCNLIF0Z0','185','D','10','269',NULL,'STAD Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','ELINCNLIF0Z0','186','D','10','270',NULL,'STAD Plan Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','ELINCNLIF0Z0','187','D','10','271',NULL,'STAD Class Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','ELINCNLIF0Z0','188','D','10','272',NULL,'STVAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','ELINCNLIF0Z0','189','D','10','273',NULL,'STVAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','ELINCNLIF0Z0','190','D','10','274',NULL,'STVSAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','ELINCNLIF0Z0','191','D','10','275',NULL,'STVSAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','ELINCNLIF0Z0','192','D','10','276',NULL,'STVCAD Cvgs',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','ELINCNLIF0Z0','193','D','10','277',NULL,'STVCAD Termination Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','ELINCNLIF0Z0','194','D','10','278',NULL,'Qualifying Event Code',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','ELINCNLIF0Z0','195','D','10','279',NULL,'Qualifying Event Eff Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','ELINCNLIF0Z0','196','D','10','280',NULL,'Mbr Smoker',NULL,NULL,'"drvIsSmoker"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','ELINCNLIF0Z0','197','D','10','281',NULL,'Spouse Smoker',NULL,NULL,'"drvSpouseSmoker"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','ELINCNLIF0Z0','198','D','10','282',NULL,'Spouse DOB',NULL,NULL,'"drvSpouseDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','ELINCNLIF0Z0','199','D','10','283',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','ELINCNLIF0Z0','200','D','10','284',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','ELINCNLIF0Z0','201','D','10','285',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','ELINCNLIF0Z0','202','D','10','286',NULL,'Dep Gender',NULL,NULL,'"drvDepGender1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','ELINCNLIF0Z0','203','D','10','287',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','ELINCNLIF0Z0','204','D','10','288',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','ELINCNLIF0Z0','205','D','10','289',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','ELINCNLIF0Z0','206','D','10','290',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','ELINCNLIF0Z0','207','D','10','291',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','ELINCNLIF0Z0','208','D','10','292',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','ELINCNLIF0Z0','199','D','10','293',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','ELINCNLIF0Z0','200','D','10','294',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','ELINCNLIF0Z0','201','D','10','295',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','ELINCNLIF0Z0','202','D','10','296',NULL,'Dep Gender',NULL,NULL,'"drvDepGender2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','ELINCNLIF0Z0','203','D','10','297',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','ELINCNLIF0Z0','204','D','10','298',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','ELINCNLIF0Z0','205','D','10','299',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','ELINCNLIF0Z0','206','D','10','300',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','ELINCNLIF0Z0','207','D','10','301',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','ELINCNLIF0Z0','208','D','10','302',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','ELINCNLIF0Z0','199','D','10','303',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','ELINCNLIF0Z0','200','D','10','304',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','ELINCNLIF0Z0','201','D','10','305',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','ELINCNLIF0Z0','202','D','10','306',NULL,'Dep Gender',NULL,NULL,'"drvDepGender3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','ELINCNLIF0Z0','203','D','10','307',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth3"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','ELINCNLIF0Z0','204','D','10','308',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','ELINCNLIF0Z0','205','D','10','309',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','ELINCNLIF0Z0','206','D','10','310',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','ELINCNLIF0Z0','207','D','10','311',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','ELINCNLIF0Z0','208','D','10','312',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','ELINCNLIF0Z0','199','D','10','313',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','ELINCNLIF0Z0','200','D','10','314',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','ELINCNLIF0Z0','201','D','10','315',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','ELINCNLIF0Z0','202','D','10','316',NULL,'Dep Gender',NULL,NULL,'"drvDepGender4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','ELINCNLIF0Z0','203','D','10','317',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','ELINCNLIF0Z0','204','D','10','318',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','ELINCNLIF0Z0','205','D','10','319',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','ELINCNLIF0Z0','206','D','10','320',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','ELINCNLIF0Z0','207','D','10','321',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','ELINCNLIF0Z0','208','D','10','322',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','ELINCNLIF0Z0','199','D','10','323',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','ELINCNLIF0Z0','200','D','10','324',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','ELINCNLIF0Z0','201','D','10','325',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','ELINCNLIF0Z0','202','D','10','326',NULL,'Dep Gender',NULL,NULL,'"drvDepGender5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','ELINCNLIF0Z0','203','D','10','327',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','ELINCNLIF0Z0','204','D','10','328',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','ELINCNLIF0Z0','205','D','10','329',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','ELINCNLIF0Z0','206','D','10','330',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','ELINCNLIF0Z0','207','D','10','331',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','ELINCNLIF0Z0','208','D','10','332',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','ELINCNLIF0Z0','199','D','10','333',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','ELINCNLIF0Z0','200','D','10','334',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','ELINCNLIF0Z0','201','D','10','335',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','ELINCNLIF0Z0','202','D','10','336',NULL,'Dep Gender',NULL,NULL,'"drvDepGender6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','ELINCNLIF0Z0','203','D','10','337',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth6"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','ELINCNLIF0Z0','204','D','10','338',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','ELINCNLIF0Z0','205','D','10','339',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','ELINCNLIF0Z0','206','D','10','340',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','ELINCNLIF0Z0','207','D','10','341',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','ELINCNLIF0Z0','208','D','10','342',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','ELINCNLIF0Z0','199','D','10','343',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','ELINCNLIF0Z0','200','D','10','344',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','ELINCNLIF0Z0','201','D','10','345',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','ELINCNLIF0Z0','202','D','10','346',NULL,'Dep Gender',NULL,NULL,'"drvDepGender7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','ELINCNLIF0Z0','203','D','10','347',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth7"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','ELINCNLIF0Z0','204','D','10','348',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','ELINCNLIF0Z0','205','D','10','349',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','ELINCNLIF0Z0','206','D','10','350',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','ELINCNLIF0Z0','207','D','10','351',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','ELINCNLIF0Z0','208','D','10','352',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','ELINCNLIF0Z0','199','D','10','353',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','ELINCNLIF0Z0','200','D','10','354',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','ELINCNLIF0Z0','201','D','10','355',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','ELINCNLIF0Z0','202','D','10','356',NULL,'Dep Gender',NULL,NULL,'"drvDepGender8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','ELINCNLIF0Z0','203','D','10','357',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth8"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','ELINCNLIF0Z0','204','D','10','358',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','ELINCNLIF0Z0','205','D','10','359',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','ELINCNLIF0Z0','206','D','10','360',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','ELINCNLIF0Z0','207','D','10','361',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','ELINCNLIF0Z0','208','D','10','362',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','ELINCNLIF0Z0','199','D','10','363',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','ELINCNLIF0Z0','200','D','10','364',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','ELINCNLIF0Z0','201','D','10','365',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','ELINCNLIF0Z0','202','D','10','366',NULL,'Dep Gender',NULL,NULL,'"drvDepGender9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','ELINCNLIF0Z0','203','D','10','367',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth9"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','ELINCNLIF0Z0','204','D','10','368',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','ELINCNLIF0Z0','205','D','10','369',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','ELINCNLIF0Z0','206','D','10','370',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','ELINCNLIF0Z0','207','D','10','371',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','ELINCNLIF0Z0','208','D','10','372',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','ELINCNLIF0Z0','199','D','10','373',NULL,'Dep First Name',NULL,NULL,'"drvDepNameFirst10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','ELINCNLIF0Z0','200','D','10','374',NULL,'Dep Last Name',NULL,NULL,'"drvDepNameLast10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','ELINCNLIF0Z0','201','D','10','375',NULL,'Dep M I',NULL,NULL,'"drvDepNameMiddle10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','ELINCNLIF0Z0','202','D','10','376',NULL,'Dep Gender',NULL,NULL,'"drvDepGender10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','ELINCNLIF0Z0','203','D','10','377',NULL,'Dep DOB',NULL,NULL,'"drvDepDateOfBirth10"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','ELINCNLIF0Z0','204','D','10','378',NULL,'Dep Relationship Code',NULL,NULL,'"drvRelationship10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','ELINCNLIF0Z0','205','D','10','379',NULL,'Dep Student Code',NULL,NULL,'"drvDepStudentCode10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','ELINCNLIF0Z0','206','D','10','380',NULL,'Dep Disabled Y/N',NULL,NULL,'"drvDepDisabled10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','ELINCNLIF0Z0','207','D','10','381',NULL,'Dep Cvg Indicator',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','ELINCNLIF0Z0','208','D','10','382',NULL,'Dep DHMO PCP',NULL,NULL,'""','(''SS''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELINCNLIF_20211222.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Basic Life','202106299','EMPEXPORT','ONDEM_XOE',NULL,'ELINCNLIF',NULL,NULL,NULL,'202106299','Jun 29 2021  8:59PM','Jun 29 2021  8:59PM','202106011',NULL,'','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Basic Life-Sched','202106299','EMPEXPORT','SCH_ELINCN',NULL,'ELINCNLIF',NULL,NULL,NULL,'202106299','Jun 29 2021  8:59PM','Jun 29 2021  8:59PM','202106011',NULL,'','','202106011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Lincoln Basic Life-Test','202112179','EMPEXPORT','TEST_XOE','Dec 17 2021  3:12PM','ELINCNLIF',NULL,NULL,NULL,'202112179','Dec 17 2021 12:00AM','Dec 30 1899 12:00AM','202112031','1418','','','202112031',dbo.fn_GetTimedKey(),NULL,'us3lKiPLD1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCNLIF','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCNLIF','D10','dbo.U_ELINCNLIF_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ELINCNLIF
-----------

IF OBJECT_ID('U_dsi_BDM_ELINCNLIF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELINCNLIF] (
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
-- Create table U_ELINCNLIF_Audit
-----------

IF OBJECT_ID('U_ELINCNLIF_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_ELINCNLIF_AuditFields
-----------

IF OBJECT_ID('U_ELINCNLIF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ELINCNLIF_DedList
-----------

IF OBJECT_ID('U_ELINCNLIF_DedList') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELINCNLIF_Dependents
-----------

IF OBJECT_ID('U_ELINCNLIF_Dependents') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_Dependents] (
    [ConEEID] char(12) NOT NULL,
    [ConSystemID] char(12) NOT NULL,
    [ConNameFirst] varchar(100) NULL,
    [ConNameMiddle] varchar(50) NULL,
    [ConNameLast] varchar(100) NULL,
    [ConRelationship] char(3) NULL,
    [ConIsDisabled] char(1) NULL,
    [ConGender] char(1) NULL,
    [ConDateOfBirth] datetime NULL,
    [ConIsSmoker] varchar(1) NULL,
    [ConDepNo] bigint NULL
);

-----------
-- Create table U_ELINCNLIF_drvTbl
-----------

IF OBJECT_ID('U_ELINCNLIF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvChangeDate] datetime NULL,
    [drvDepChangeDate] datetime NULL,
    [drvEedBenStopDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvSSN] varchar(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAppSignDate] datetime NULL,
    [drvJobDesc] varchar(25) NOT NULL,
    [drvScheduledWorkHrs] decimal NULL,
    [drvAnnSalary] money NULL,
    [drvSalaryEffDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAdressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvRsnLossOfBen] varchar(11) NULL,
    [drvLifePolicyNum] varchar(18) NULL,
    [drvLifBillLocNum] varchar(7) NULL,
    [drvLifeSortGrp] varchar(38) NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLICvgs] varchar(4) NULL,
    [drvLITermDate] datetime NULL,
    [drvADCvgs] varchar(4) NULL,
    [drvADTermDate] datetime NULL,
    [drvWIPolicyNum] varchar(18) NULL,
    [drvWIBillLocNum] varchar(7) NULL,
    [drvWISortGroup] varchar(38) NULL,
    [drvWIEffDate] datetime NULL,
    [drvWIPlanCode] varchar(1) NULL,
    [drvWIClassCode] varchar(1) NULL,
    [drvWICvgs] varchar(4) NULL,
    [drvWITermDate] datetime NULL,
    [drvLTDPolicyNum] varchar(18) NULL,
    [drvLTDBillLocNum] varchar(7) NULL,
    [drvLTDSortGroup] varchar(38) NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDPlanCode] varchar(1) NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvgs] varchar(5) NULL,
    [drvLTDTermDate] datetime NULL,
    [drvVLIFPolicyNum] varchar(18) NULL,
    [drvVLIFBillLocNum] varchar(7) NULL,
    [drvVLIFSortGroup] varchar(38) NULL,
    [drvVLIFEffDate] datetime NULL,
    [drvVLIFPlanCode] varchar(1) NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLICvgs] varchar(8000) NULL,
    [drvVLITermDate] datetime NULL,
    [drvVADCvgs] varchar(1) NOT NULL,
    [drvVADTermDate] varchar(1) NOT NULL,
    [drvVSLICvgs] varchar(8000) NULL,
    [drvVLSITermDate] datetime NULL,
    [drvVSADCvgs] varchar(1) NOT NULL,
    [drvVSADTermDate] varchar(1) NOT NULL,
    [drvVCLICvgs] varchar(8000) NULL,
    [drvVCLITermDate] datetime NULL,
    [drvIsSmoker] varchar(1) NULL,
    [drvSpouseSmoker] varchar(1) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvDepNameFirst1] varchar(100) NULL,
    [drvDepNameLast1] varchar(100) NULL,
    [drvDepNameMiddle1] varchar(1) NULL,
    [drvDepGender1] char(1) NULL,
    [drvDepDateOfBirth1] datetime NULL,
    [drvRelationship1] varchar(1) NULL,
    [drvDepStudentCode1] varchar(1) NULL,
    [drvDepDisabled1] char(1) NULL,
    [drvDepNameFirst2] varchar(100) NULL,
    [drvDepNameLast2] varchar(100) NULL,
    [drvDepNameMiddle2] varchar(2) NULL,
    [drvDepGender2] char(1) NULL,
    [drvDepDateOfBirth2] datetime NULL,
    [drvRelationship2] varchar(1) NULL,
    [drvDepStudentCode2] varchar(1) NULL,
    [drvDepDisabled2] char(1) NULL,
    [drvDepNameFirst3] varchar(100) NULL,
    [drvDepNameLast3] varchar(100) NULL,
    [drvDepNameMiddle3] varchar(3) NULL,
    [drvDepGender3] char(1) NULL,
    [drvDepDateOfBirth3] datetime NULL,
    [drvRelationship3] varchar(1) NULL,
    [drvDepStudentCode3] varchar(1) NULL,
    [drvDepDisabled3] char(1) NULL,
    [drvDepNameFirst4] varchar(100) NULL,
    [drvDepNameLast4] varchar(100) NULL,
    [drvDepNameMiddle4] varchar(4) NULL,
    [drvDepGender4] char(1) NULL,
    [drvDepDateOfBirth4] datetime NULL,
    [drvRelationship4] varchar(1) NULL,
    [drvDepStudentCode4] varchar(1) NULL,
    [drvDepDisabled4] char(1) NULL,
    [drvDepNameFirst5] varchar(100) NULL,
    [drvDepNameLast5] varchar(100) NULL,
    [drvDepNameMiddle5] varchar(5) NULL,
    [drvDepGender5] char(1) NULL,
    [drvDepDateOfBirth5] datetime NULL,
    [drvRelationship5] varchar(1) NULL,
    [drvDepStudentCode5] varchar(1) NULL,
    [drvDepDisabled5] char(1) NULL,
    [drvDepNameFirst6] varchar(100) NULL,
    [drvDepNameLast6] varchar(100) NULL,
    [drvDepNameMiddle6] varchar(6) NULL,
    [drvDepGender6] char(1) NULL,
    [drvDepDateOfBirth6] datetime NULL,
    [drvRelationship6] varchar(1) NULL,
    [drvDepStudentCode6] varchar(1) NULL,
    [drvDepDisabled6] char(1) NULL,
    [drvDepNameFirst7] varchar(100) NULL,
    [drvDepNameLast7] varchar(100) NULL,
    [drvDepNameMiddle7] varchar(7) NULL,
    [drvDepGender7] char(1) NULL,
    [drvDepDateOfBirth7] datetime NULL,
    [drvRelationship7] varchar(1) NULL,
    [drvDepStudentCode7] varchar(1) NULL,
    [drvDepDisabled7] char(1) NULL,
    [drvDepNameFirst8] varchar(100) NULL,
    [drvDepNameLast8] varchar(100) NULL,
    [drvDepNameMiddle8] varchar(8) NULL,
    [drvDepGender8] char(1) NULL,
    [drvDepDateOfBirth8] datetime NULL,
    [drvRelationship8] varchar(1) NULL,
    [drvDepStudentCode8] varchar(1) NULL,
    [drvDepDisabled8] char(1) NULL,
    [drvDepNameFirst9] varchar(100) NULL,
    [drvDepNameLast9] varchar(100) NULL,
    [drvDepNameMiddle9] varchar(9) NULL,
    [drvDepGender9] char(1) NULL,
    [drvDepDateOfBirth9] datetime NULL,
    [drvRelationship9] varchar(1) NULL,
    [drvDepStudentCode9] varchar(1) NULL,
    [drvDepDisabled9] char(1) NULL,
    [drvDepNameFirst10] varchar(100) NULL,
    [drvDepNameLast10] varchar(100) NULL,
    [drvDepNameMiddle10] varchar(10) NULL,
    [drvDepGender10] char(1) NULL,
    [drvDepDateOfBirth10] datetime NULL,
    [drvRelationship10] varchar(1) NULL,
    [drvDepStudentCode10] varchar(1) NULL,
    [drvDepDisabled10] char(1) NULL
);

-----------
-- Create table U_ELINCNLIF_EEList
-----------

IF OBJECT_ID('U_ELINCNLIF_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELINCNLIF_File
-----------

IF OBJECT_ID('U_ELINCNLIF_File') IS NULL
CREATE TABLE [dbo].[U_ELINCNLIF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCNLIF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PL Development

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 06/29/2021
Service Request Number: SR-2016-00012345

Purpose: Lincoln Basic Life

Revision History
----------------
10/19/2021 by AP:
        - Added sort group logic as per Lea update.

11/02/2021 by AP:
        - Adjusted VLI Cvgs, VSLI Cvgs, VCLI Cvgs fields to remove '.00'.

12/22/2021 by AP:
		- Changed sort group field to remove leading 0's.
		- Updated change date code to = ben start date in cases where the change date is less than the benefit start date.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINCNLIF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINCNLIF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINCNLIF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'TEST_XOE';                                                                                        
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCNLIF', 'SCH_ELINCN';

EXEC dbo.dsi_Bdm_sp_ErrorCheck 'ELINCNLIF';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELINCNLIF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINCNLIF';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '20190901'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ELINCNLIF_EEList
    WHERE xCoID <> dbo.dsi_Bdm_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINCNLIF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE TEST/BAD EMPLOYEES
    DELETE EE
    FROM dbo.U_ELINCNLIF_EEList EE
    JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCOID = xCOID
        JOIN dbo.EmpPers WITH (NOLOCK)
      ON EepEEID = xEEID
    WHERE LTRIM(RTRIM(EepSSN)) = '000000000'
       OR LTRIM(RTRIM(EepSSN)) = '111111111'
       OR LTRIM(RTRIM(EepSSN)) = '888888888'
       OR LEFT(LTRIM(EepSSN),3) = '999'
       OR LEFT(LTRIM(EepSSN),3) = '998'
       OR LTRIM(RTRIM(EepSSN)) = '123456789'
       OR EepSSN IS NULL
       OR EecEEType = 'TES';
 
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELINCNLIF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_AuditFields;
    CREATE TABLE dbo.U_ELINCNLIF_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ELINCNLIF_AuditFields VALUES ('EmpComp','EecDateOfTermination');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELINCNLIF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ELINCNLIF_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELINCNLIF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINCNLIF_Audit ON dbo.U_ELINCNLIF_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL,GTLB,GTLCP,GTLW,LFDEP,LFSPO,LIFEE,LTD,WKSTD';

    IF OBJECT_ID('U_ELINCNLIF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELINCNLIF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- Bdm Section
    --==========================================
    DELETE FROM dbo.U_dsi_Bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_Bdm_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
  
    -- Run Bdm Module
    EXEC dbo.dsi_Bdm_sp_PopulateDeductionsTable @FormatCode;

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_BDM_EmpDeductions
        SET EedUSGField1 =  CONVERT(VARCHAR(20),EDF.EedBenAmt)
    FROM dbo.U_dsi_BDM_EmpDeductions BDM
    JOIN dbo.EmpDedFull EDF WITH (NOLOCK)
        ON EDF.EedEmpDedTVID = BDM.EedEmpDedTVID
       AND BDM.EedFormatCode = @FormatCode;



    --==========================================
    -- Working Tables
    --==========================================    
    IF OBJECT_ID('U_ELINCNLIF_Dependents','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_Dependents;
    SELECT ConEEID
          ,ConSystemID
          ,ConNameFirst
          ,ConNameMiddle
          ,ConNameLast
          ,ConRelationship
          ,ConIsDisabled
          ,ConGender 
          ,ConDateOfBirth 
          ,ConIsSmoker
          ,ConDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY conDateOfBirth ASC)
      INTO dbo.U_ELINCNLIF_Dependents
      FROM dbo.Contacts WITH (NOLOCK)
      JOIN dbo.U_ELINCNLIF_EEList WITH (NOLOCK)
        ON ConEEID = xEEID
     WHERE ConRelationship IN ('CH','CHL','DPC','STC','SPS','DP')
     AND ConIsDependent = 'Y'
     AND ConIsActive = 'Y'
     ;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINCNLIF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELINCNLIF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCNLIF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvChangeDate =  CASE WHEN eecDateOfLastHire >= @FileMinCovDate THEN eecDateOfLastHire
                                ELSE dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasEmpBen = 'Y'), @FileMinCovDate)
                         END
                    --dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasEmpBen = 'Y'), @FileMinCovDate)
        ,drvDepChangeDate = dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasDepBen = 'Y'), @FileMinCovDate)
        ,drvEedBenStopDate = CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination
                                WHEN EedBenStopDate IS NOT NUll THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStopDate , @FileMinCovDate) 
                            END
        ,drvNameFirst =  EepNameFirst 
        ,drvNameLast = EepNameLast 
        ,drvNameMiddle = LEFT(EepNameMiddle,1) 
        ,drvSSN =  SUBSTRING(eepSSN, 1, 3) + '-' + SUBSTRING(eepSSN, 4, 2) + '-' + SUBSTRING(eepSSN, 6,4)  
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAppSignDate = CASE WHEN eecDateOfLastHire >= @FileMinCovDate THEN eecDateOfLastHire
                                ELSE dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasEmpBen = 'Y'), @FileMinCovDate)
                         END
                    --dbo.dsi_fnGetMinMaxDates('MAX',(SELECT MAX(EedBenStartDate) FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedEEID = xEEID AND EedCoID = xCoID AND EedHasEmpBen = 'Y'), @FileMinCovDate)
                        
        ,drvJobDesc = JbcDesc
        ,drvScheduledWorkHrs = CASE WHEN PgrPayFrequency = 'B' THEN EecScheduledWorkHrs/2 ELSE EecScheduledWorkHrs END
        ,drvAnnSalary = EecAnnSalary
        ,drvSalaryEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GetDATE(), eecDateOfLastHire) 
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAdressState = EepAddressState
        ,drvAddressZipCode = SUBSTRING(EepAddressZipCode, 1, 5)
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvRsnLossOfBen = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'TERMINATION' END
        ,drvLifePolicyNum = CASE WHEN EedHasLife = 'Y' THEN '000010254603-00000' END
        ,drvLifBillLocNum = CASE WHEN EedHasLife = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                      WHEN '27' THEN '1725591'
                                  END
                             END
        ,drvLifeSortGrp = CASE WHEN EedHasLife = 'Y' THEN UPPER(LTRIM(RTRIM(SUBSTRING(EecOrgLvl2, PATINDEX('%[^0]%', EecOrgLvl2+'.'), LEN(EecOrgLvl2)))) + ' ' + '-' + ' ' + O2.OrgDesc) END
        ,drvLifeEffDate = EedLifeEffDate
        ,drvLifePlanCode = CASE WHEN  EedHasLife = 'Y' THEN '1' END
        ,drvLifeClassCode = CASE WHEN  EedHasLife = 'Y' THEN '1' END
        ,drvLICvgs = CASE WHEN  EedHasLife = 'Y' THEN 'LI-1' END 
        ,drvLITermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvADCvgs = CASE WHEN  EedHasLife = 'Y' THEN 'AD-1' END
        ,drvADTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWIPolicyNum = CASE WHEN EedHasWI = 'Y' THEN '000010238521-00000' END
        ,drvWIBillLocNum = CASE WHEN EedHasWI = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                      WHEN '27' THEN '1725591'
                                  END
                             END
        ,drvWISortGroup = CASE WHEN EedHasWI = 'Y' THEN UPPER(LTRIM(RTRIM(SUBSTRING(EecOrgLvl2, PATINDEX('%[^0]%', EecOrgLvl2+'.'), LEN(EecOrgLvl2)))) + ' ' + '-' + ' ' + O2.OrgDesc) END
        ,drvWIEffDate = CASE WHEN EedHasWI = 'Y' THEN EedWIEffDate END
        ,drvWIPlanCode = CASE WHEN EedHasWI = 'Y' THEN '1' END
        ,drvWIClassCode = CASE WHEN EedHasWI = 'Y' THEN '1' END
        ,drvWICvgs = CASE WHEN EedHasWI = 'Y' THEN 'WI-1' END
        ,drvWITermDate = CASE WHEN EedHasWI = 'Y' THEN EedWITermDate END
        ,drvLTDPolicyNum = CASE WHEN EedHasLTD = 'Y' THEN '000010254605-00000' END
        ,drvLTDBillLocNum = CASE WHEN EedHasLTD = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                      WHEN '27' THEN '1725591'
                                  END
                             END
        ,drvLTDSortGroup = CASE WHEN EedHasLTD = 'Y' THEN UPPER(LTRIM(RTRIM(SUBSTRING(EecOrgLvl2, PATINDEX('%[^0]%', EecOrgLvl2+'.'), LEN(EecOrgLvl2)))) + ' ' + '-' + ' ' + O2.OrgDesc) END
        ,drvLTDEffDate = CASE WHEN EedHasLTD = 'Y' THEN EedLTDEffDate END
        ,drvLTDPlanCode = CASE WHEN EedHasLTD = 'Y' THEN '1' END
        ,drvLTDClassCode = CASE WHEN EedHasLTD = 'Y' THEN '1' END
        ,drvLTDCvgs = CASE WHEN EedHasLTD = 'Y' THEN 'LTD-1' END
        ,drvLTDTermDate = CASE WHEN EedHasLTD = 'Y' THEN EedLTDTermDate END
        ,drvVLIFPolicyNum = CASE WHEN EedHasLIFEE = 'Y' THEN '000400254604-00000' END
        ,drvVLIFBillLocNum = CASE WHEN EedHasLIFEE = 'Y' THEN
                                 CASE EecOrgLvl1 
                                      WHEN '01' THEN '1688505'
                                      WHEN '03' THEN '1688506'
                                      WHEN '13' THEN '1688508'
                                      WHEN '14' THEN '1688509'
                                      WHEN '19' THEN '1688511'
                                      WHEN '22' THEN '1688512'
                                      WHEN '24' THEN '1688513'
                                      WHEN '25' THEN '1688514'
                                      WHEN '27' THEN '1725591'
                                  END
                             END
        ,drvVLIFSortGroup = CASE WHEN EedHasLIFEE = 'Y' THEN UPPER(LTRIM(RTRIM(SUBSTRING(EecOrgLvl2, PATINDEX('%[^0]%', EecOrgLvl2+'.'), LEN(EecOrgLvl2)))) + ' ' + '-' + ' ' + O2.OrgDesc) END
        ,drvVLIFEffDate = EedVLIFEffDate
        ,drvVLIFPlanCode = CASE WHEN EedHasLIFEE = 'Y' THEN '1' END
        ,drvVLIFClassCode = CASE WHEN EedHasLIFEE = 'Y' THEN '1' END
        ,drvVLICvgs = CASE WHEN EedHasLIFEE = 'Y' THEN REPLACE(EedVLICvgs, '.00', '') END 
        ,drvVLITermDate = CASE WHEN EedHasLIFEE = 'Y' THEN EedVLITermDate END
        ,drvVADCvgs = '' --CASE WHEN EedHasLIFEE = 'Y' THEN EedVADCvgs END 
        ,drvVADTermDate = '' --CASE WHEN EedHasLIFEE = 'Y' THEN EedVADTermDate END
        ,drvVSLICvgs = CASE WHEN EedDepHasLFSPO = 'Y' THEN REPLACE(EedVSLICvgs, '.00', '') END 
        ,drvVLSITermDate = CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVLSITermDate END
        ,drvVSADCvgs = '' --CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVSADCvgs END 
        ,drvVSADTermDate = '' --CASE WHEN EedDepHasLFSPO = 'Y' THEN EedVSADTermDate END
        ,drvVCLICvgs = CASE WHEN EedDepHasLFDEP = 'Y' THEN REPLACE(EedVCLICvgs, '.00', '') END 
        ,drvVCLITermDate = CASE WHEN EedDepHasLFDEP = 'Y' THEN EedVCLITermDate END
        ,drvIsSmoker = EepIsSmoker
        ,drvSpouseSmoker = CASE WHEN EedDepHasLFSPO = 'Y' AND Dep1.ConRelationship IN ('SPS','DP') THEN Dep1.ConIsSmoker END
        ,drvSpouseDOB = CASE WHEN EedDepHasLFSPO = 'Y' AND Dep1.ConRelationship IN ('SPS','DP') THEN Dep1.ConDateOfBirth END
        --DEP1
        ,drvDepNameFirst1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConNameFirst END
        ,drvDepNameLast1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConNameLast END
        ,drvDepNameMiddle1 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep1.ConNameMiddle,1) END
        ,drvDepGender1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConGender END
        ,drvDepDateOfBirth1 = CASE WHEN EedHasDepBen = 'Y' THEN Dep1.ConDateOFBirth END
        ,drvRelationship1 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep1.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode1 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled1 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep1.ConSystemID,'') <> '' THEN ISNULL(Dep1.ConIsDisabled,'N') END
        --DEP2
        ,drvDepNameFirst2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConNameFirst END
        ,drvDepNameLast2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConNameLast END
        ,drvDepNameMiddle2 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep2.ConNameMiddle,2) END
        ,drvDepGender2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConGender END
        ,drvDepDateOfBirth2 = CASE WHEN EedHasDepBen = 'Y' THEN Dep2.ConDateOFBirth END
        ,drvRelationship2 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep2.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode2 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled2 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep2.ConSystemID,'') <> '' THEN ISNULL(Dep2.ConIsDisabled,'N') END
        --DEP3
        ,drvDepNameFirst3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConNameFirst END
        ,drvDepNameLast3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConNameLast END
        ,drvDepNameMiddle3 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep3.ConNameMiddle,3) END
        ,drvDepGender3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConGender END
        ,drvDepDateOfBirth3 = CASE WHEN EedHasDepBen = 'Y' THEN Dep3.ConDateOFBirth END
        ,drvRelationship3 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep3.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode3 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled3 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep3.ConSystemID,'') <> '' THEN ISNULL(Dep3.ConIsDisabled,'N') END
        --DEP4
        ,drvDepNameFirst4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConNameFirst END
        ,drvDepNameLast4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConNameLast END
        ,drvDepNameMiddle4 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep4.ConNameMiddle,4) END
        ,drvDepGender4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConGender END
        ,drvDepDateOfBirth4 = CASE WHEN EedHasDepBen = 'Y' THEN Dep4.ConDateOFBirth END
        ,drvRelationship4 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep4.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode4 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled4 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep4.ConSystemID,'') <> '' THEN ISNULL(Dep4.ConIsDisabled,'N') END
        --DEP5
        ,drvDepNameFirst5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConNameFirst END
        ,drvDepNameLast5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConNameLast END
        ,drvDepNameMiddle5 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep5.ConNameMiddle,5) END
        ,drvDepGender5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConGender END
        ,drvDepDateOfBirth5 = CASE WHEN EedHasDepBen = 'Y' THEN Dep5.ConDateOFBirth END
        ,drvRelationship5 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep5.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode5 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled5 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep5.ConSystemID,'') <> '' THEN ISNULL(Dep5.ConIsDisabled,'N') END
        --DEP6
        ,drvDepNameFirst6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConNameFirst END
        ,drvDepNameLast6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConNameLast END
        ,drvDepNameMiddle6 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep6.ConNameMiddle,6) END
        ,drvDepGender6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConGender END
        ,drvDepDateOfBirth6 = CASE WHEN EedHasDepBen = 'Y' THEN Dep6.ConDateOFBirth END
        ,drvRelationship6 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep6.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode6 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled6 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep6.ConSystemID,'') <> '' THEN ISNULL(Dep6.ConIsDisabled,'N') END
        --DEP7
        ,drvDepNameFirst7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConNameFirst END
        ,drvDepNameLast7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConNameLast END
        ,drvDepNameMiddle7 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep7.ConNameMiddle,7) END
        ,drvDepGender7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConGender END
        ,drvDepDateOfBirth7 = CASE WHEN EedHasDepBen = 'Y' THEN Dep7.ConDateOFBirth END
        ,drvRelationship7 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep7.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode7 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled7 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep7.ConSystemID,'') <> '' THEN ISNULL(Dep7.ConIsDisabled,'N') END
        --DEP8
        ,drvDepNameFirst8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConNameFirst END
        ,drvDepNameLast8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConNameLast END
        ,drvDepNameMiddle8 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep8.ConNameMiddle,8) END
        ,drvDepGender8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConGender END
        ,drvDepDateOfBirth8 = CASE WHEN EedHasDepBen = 'Y' THEN Dep8.ConDateOFBirth END
        ,drvRelationship8 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep8.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode8 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled8 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep8.ConSystemID,'') <> '' THEN ISNULL(Dep8.ConIsDisabled,'N') END
        --DEP9
        ,drvDepNameFirst9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConNameFirst END
        ,drvDepNameLast9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConNameLast END
        ,drvDepNameMiddle9 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep9.ConNameMiddle,9) END
        ,drvDepGender9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConGender END
        ,drvDepDateOfBirth9 = CASE WHEN EedHasDepBen = 'Y' THEN Dep9.ConDateOFBirth END
        ,drvRelationship9 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep9.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode9 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled9 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep9.ConSystemID,'') <> '' THEN ISNULL(Dep9.ConIsDisabled,'N') END
        --DEP10
        ,drvDepNameFirst10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConNameFirst END
        ,drvDepNameLast10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConNameLast END
        ,drvDepNameMiddle10 = CASE WHEN EedHasDepBen = 'Y' THEN LEFT(Dep10.ConNameMiddle,10) END
        ,drvDepGender10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConGender END
        ,drvDepDateOfBirth10 = CASE WHEN EedHasDepBen = 'Y' THEN Dep10.ConDateOFBirth END
        ,drvRelationship10 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN
                                     CASE WHEN Dep10.ConRelationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                             END
        ,drvDepStudentCode10 = CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN 'N' END
        ,drvDepDisabled10 =  CASE WHEN EedHasDepBen = 'Y' AND ISNULL(Dep10.ConSystemID,'') <> '' THEN ISNULL(Dep10.ConIsDisabled,'N') END
    INTO dbo.U_ELINCNLIF_drvTbl
    FROM dbo.U_ELINCNLIF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (eecemplstatus <> 'T' OR (EecEmplStatus= 'T' and EecTermReason <>'TRO' 
        AND EXISTS(SELECT 1 FROM dbo.U_ELINCNLIF_Audit WITH (NOLOCK) WHERE  audEEID = xEEID AND audCOID = xcoid)))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (SELECT EedEEID, EedCOID
                ,EedBenStopDate = MAX(EedBenStopDate)
                ,EedHasEmpBen = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW','WKSTD','LTD','LIFEE') THEN 'Y' END)
                ,EedHasDepBen = MAX(CASE WHEN EedDedCode IN ('LFSPO','LFDEP') THEN 'Y' END)
                ,EedHasLife = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN 'Y' END)
                ,EedLifeEffDate = MAX(CASE  WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate , '20190629') END)  --EedBenStartDate END)
                ,EedLICvgs = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN 'LI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END) 
                ,EedADTermDate = MAX(CASE WHEN EedDedCode IN ('GTL','GTLB','GTLCP','GTLW') THEN EedBenStopDate END)
                ,EedHasWI = MAX(CASE WHEN EedDedCode IN ('WKSTD') THEN 'Y'END)
                ,EedWIEffDate = MAX(CASE WHEN EedDedCode = 'WKSTD' THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate , '20180101') END)  --EedBenStartDate END)
                ,EedWITermDate = MAX(CASE WHEN EedDedCode = 'WKSTD' THEN EedBenStopDate END)
                ,EedHASLTD = MAX(CASE WHEN EedDedCode IN ('LTD') THEN 'Y' END)
                ,EedLTDEffDate = MAX(CASE WHEN EedDedCode = 'LTD' THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate , @FileMinCovDate) END)  --EedBenStartDate END)
                ,EedLTDTermDate = MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStopDate END)
                ,EedHasLIFEE = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'Y' END)
                ,EedVLIFEffDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate , @FileMinCovDate) END)  --EedBenStartDate END)
                ,EedVLICvgs = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'VLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVLITermDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN EedBenStopDate END)
                ,EedVADCvgs = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN 'VAD-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVADTermDate = MAX(CASE WHEN EedDedCode IN ('LIFEE') THEN EedBenStopDate END)
                ,EedVSLICvgs = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN 'VSLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVLSITermDate = MAX(CASE WHEN EedDedCode = 'LFSPO' THEN EedBenStopDate END)
                ,EedVSADCvgs = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN 'VSAD-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVSADTermDate = MAX(CASE WHEN EedDedCode = 'LFSPO' THEN EedBenStopDate END)
                ,EedVCLICvgs = MAX(CASE WHEN EedDedCode IN ('LFDEP') THEN 'VCLI-' + CASE WHEN ISNULL(EedBenAmt,0) = 0 THEN CONVERT(VARCHAR(20),DedEEBenAmt) ELSE CONVERT(VARCHAR(20),EedBenAmt) END END)  
                ,EedVCLITermDate = MAX(CASE WHEN EedDedCode = 'LFDEP' THEN EedBenStopDate END)
                ,EedDepHasLFSPO = MAX(CASE WHEN EedDedCode IN ('LFSPO') THEN  'Y' END)
                ,EedDepHasLFDEP = MAX(CASE WHEN EedDedCode IN ('LFDEP') THEN  'Y' END)
            FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
            JOIN dbo.U_ELINCNLIF_DedList WITH (NOLOCK)
                ON DedCode = EedDedCode
           WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCoID ) AS Eed
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep1 WITH (NOLOCK)
        ON Dep1.ConEEID = xEEID
       AND Dep1.ConDepNo = 1
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep2 WITH (NOLOCK)
        ON Dep2.ConEEID = xEEID
       AND Dep2.ConDepNo = 2
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep3 WITH (NOLOCK)
        ON Dep3.ConEEID = xEEID
       AND Dep3.ConDepNo = 3
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep4 WITH (NOLOCK)
        ON Dep4.ConEEID = xEEID
       AND Dep4.ConDepNo = 4
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep5 WITH (NOLOCK)
        ON Dep5.ConEEID = xEEID
       AND Dep5.ConDepNo = 5
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep6 WITH (NOLOCK)
        ON Dep6.ConEEID = xEEID
       AND Dep6.ConDepNo = 6
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep7 WITH (NOLOCK)
        ON Dep7.ConEEID = xEEID
       AND Dep7.ConDepNo = 7
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep8 WITH (NOLOCK)
        ON Dep8.ConEEID = xEEID
       AND Dep8.ConDepNo = 8
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep9 WITH (NOLOCK)
        ON Dep9.ConEEID = xEEID
       AND Dep9.ConDepNo = 9
     LEFT 
     JOIN dbo.U_ELINCNLIF_Dependents Dep10 WITH (NOLOCK)
        ON Dep10.ConEEID = xEEID
       AND Dep10.ConDepNo = 10
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
    ;

	---- Logic update for any change dates that are less than the benefit start date

	UPDATE dbo.U_ELINCNLIF_drvTbl
	SET drvChangeDate = drvLifeEffDate,
	drvDepChangeDate = drvLifeEffDate
	WHERE drvChangeDate < drvLifeEffDate

	--------------------------------------------------------------------------------
 
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
ALTER VIEW dbo.dsi_vwELINCNLIF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELINCNLIF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINCNLIF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

UPDATE dbo.AscDefF
SET ADFFORCOND = '(''UD101''=''T,'')'
WHERE AdfHeaderSystemID LIKE 'ELINCNLIF%' and adfsetnumber = 10 and adffieldnumber = 282

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106011'
       ,expStartPerControl     = '202106011'
       ,expLastEndPerControl   = '202106299'
       ,expEndPerControl       = '202106299'
WHERE expFormatCode = 'ELINCNLIF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINCNLIF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINCNLIF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELINCNLIF' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELINCNLIF'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELINCNLIF'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELINCNLIF', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELINCNLIF', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELINCNLIF', 'UseFileName', 'V', 'Y'


-- End ripout