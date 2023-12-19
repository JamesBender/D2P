/**********************************************************************************

EJMTSABAD2: Saba Demographics Export

FormatCode:     EJMTSABAD2
Project:        Saba Demographics Export
Client ID:      JOH1012
Date/time:      2023-12-19 15:25:54.877
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB03
Database:       ULTIPRO_WPJMT
Web Filename:   JOH1012_C631C_EEHISTORY_EJMTSABAD2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EJMTSABAD2_SavePath') IS NOT NULL DROP TABLE dbo.U_EJMTSABAD2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EJMTSABAD2'


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
WHERE FormatCode = 'EJMTSABAD2'
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
WHERE ExpFormatCode = 'EJMTSABAD2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EJMTSABAD2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EJMTSABAD2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EJMTSABAD2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EJMTSABAD2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EJMTSABAD2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EJMTSABAD2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EJMTSABAD2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EJMTSABAD2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EJMTSABAD2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EJMTSABAD2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEJMTSABAD2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEJMTSABAD2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EJMTSABAD2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJMTSABAD2];
GO
IF OBJECT_ID('U_EJMTSABAD2_File') IS NOT NULL DROP TABLE [dbo].[U_EJMTSABAD2_File];
GO
IF OBJECT_ID('U_EJMTSABAD2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EJMTSABAD2_EEList];
GO
IF OBJECT_ID('U_EJMTSABAD2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EJMTSABAD2_drvTbl];
GO
IF OBJECT_ID('U_EJMTSABAD2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EJMTSABAD2_AuditFields];
GO
IF OBJECT_ID('U_EJMTSABAD2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EJMTSABAD2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EJMTSABAD2','Saba Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EJMTSABAD2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EJMTSABAD2Z0','50','H','01','1',NULL,'Subject Username',NULL,NULL,'"Subject Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EJMTSABAD2Z0','50','H','01','2',NULL,'Manager Username',NULL,NULL,'"Manager Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EJMTSABAD2Z0','50','H','01','3',NULL,'HR Rep Username',NULL,NULL,'"HR Rep Username"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EJMTSABAD2Z0','50','H','01','4',NULL,'Career Coach',NULL,NULL,'"Career Coach"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EJMTSABAD2Z0','50','H','01','5',NULL,'Firstname',NULL,NULL,'"Firstname"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EJMTSABAD2Z0','50','H','01','6',NULL,'Lastname',NULL,NULL,'"Lastname"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EJMTSABAD2Z0','50','H','01','7',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EJMTSABAD2Z0','50','H','01','8',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EJMTSABAD2Z0','50','H','01','9',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EJMTSABAD2Z0','50','H','01','10',NULL,'Last Promotion Date',NULL,NULL,'"Last Promotion Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EJMTSABAD2Z0','50','H','01','11',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EJMTSABAD2Z0','50','H','01','12',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EJMTSABAD2Z0','50','H','01','13',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EJMTSABAD2Z0','50','H','01','14',NULL,'Company',NULL,NULL,'"Company"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EJMTSABAD2Z0','50','H','01','15',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EJMTSABAD2Z0','50','H','01','16',NULL,'Job Code',NULL,NULL,'"Job Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EJMTSABAD2Z0','50','H','01','17',NULL,'Base Salary',NULL,NULL,'"Base Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EJMTSABAD2Z0','50','H','01','18',NULL,'Variable Pay/Bonus Target',NULL,NULL,'"Variable Pay/Bonus Target"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EJMTSABAD2Z0','50','H','01','19',NULL,'Deactivate User',NULL,NULL,'"Deactivate User"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EJMTSABAD2Z0','50','H','01','20',NULL,'Job Description ID',NULL,NULL,'"Job Description ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EJMTSABAD2Z0','50','H','01','21',NULL,'Hours Worked Per Year',NULL,NULL,'"Hours Worked Per Year"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EJMTSABAD2Z0','50','H','01','22',NULL,'Hourly Rate',NULL,NULL,'"Hourly Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EJMTSABAD2Z0','50','H','01','23',NULL,'Hourly Base Salary Pay Type',NULL,NULL,'"Hourly Base Salary Pay Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EJMTSABAD2Z0','50','H','01','24',NULL,'Currency ISO code',NULL,NULL,'"Currency ISO code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EJMTSABAD2Z0','50','H','01','25',NULL,'45 Day Form Code',NULL,NULL,'"45 Day Form Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EJMTSABAD2Z0','50','H','01','26',NULL,'Form Code',NULL,NULL,'"Form Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EJMTSABAD2Z0','50','H','01','27',NULL,'Corporate Title',NULL,NULL,'"Corporate Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EJMTSABAD2Z0','50','H','01','28',NULL,'Previous Rate',NULL,NULL,'"Previous Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EJMTSABAD2Z0','50','H','01','29',NULL,'Previous Effective Date',NULL,NULL,'"Previous Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EJMTSABAD2Z0','50','H','01','30',NULL,'2nd Previous Rate',NULL,NULL,'"2nd Previous Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EJMTSABAD2Z0','50','H','01','31',NULL,'2nd Effective Date',NULL,NULL,'"2nd Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EJMTSABAD2Z0','50','H','01','32',NULL,'GL Code - Department',NULL,NULL,'"GL Code - Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EJMTSABAD2Z0','50','H','01','33',NULL,'GL Code - Office',NULL,NULL,'"GL Code - Office"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EJMTSABAD2Z0','50','H','01','34',NULL,'Phone 1',NULL,NULL,'"Phone 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EJMTSABAD2Z0','50','H','01','35',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EJMTSABAD2Z0','50','H','01','36',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EJMTSABAD2Z0','50','H','01','37',NULL,'Salary Type',NULL,NULL,'"Salary Type "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EJMTSABAD2Z0','50','H','01','38',NULL,'Employment Status',NULL,NULL,'"Employment Status "','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EJMTSABAD2Z0','50','D','10','1',NULL,'Subject Username',NULL,NULL,'"drvSubjectUserName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EJMTSABAD2Z0','50','D','10','2',NULL,'ManagerUsername',NULL,NULL,'"drvManagerUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EJMTSABAD2Z0','50','D','10','3',NULL,'HR Rep Username',NULL,NULL,'"drvHRRepUsername"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EJMTSABAD2Z0','50','D','10','4',NULL,'Career Coach',NULL,NULL,'"drvCareerCoach"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EJMTSABAD2Z0','50','D','10','5',NULL,'Firstname',NULL,NULL,'"drvFirstname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EJMTSABAD2Z0','50','D','10','6',NULL,'Lastname',NULL,NULL,'"drvLastname"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EJMTSABAD2Z0','50','D','10','7',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EJMTSABAD2Z0','50','D','10','8',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EJMTSABAD2Z0','50','D','10','9',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EJMTSABAD2Z0','50','D','10','10',NULL,'Last Promotion Date',NULL,NULL,'"drvLastPromotionDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EJMTSABAD2Z0','50','D','10','11',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EJMTSABAD2Z0','50','D','10','12',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EJMTSABAD2Z0','50','D','10','13',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EJMTSABAD2Z0','51','D','10','14',NULL,'Company',NULL,NULL,'"drvCompany"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EJMTSABAD2Z0','52','D','10','15',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EJMTSABAD2Z0','53','D','10','16',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EJMTSABAD2Z0','54','D','10','17',NULL,'Base Salary',NULL,NULL,'"drvBaseSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EJMTSABAD2Z0','55','D','10','18',NULL,'Variable Pay/Bonus Target',NULL,NULL,'"drvVariablePayBonusTarget"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EJMTSABAD2Z0','56','D','10','19',NULL,'Deactivate User',NULL,NULL,'"drvDeactivateUser"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EJMTSABAD2Z0','57','D','10','20',NULL,'Job Description ID',NULL,NULL,'"drvJobDescriptionID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EJMTSABAD2Z0','58','D','10','21',NULL,'Hours Worked Per Year',NULL,NULL,'"drvHoursWorkedPerYear"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EJMTSABAD2Z0','59','D','10','22',NULL,'Hourly Rate',NULL,NULL,'"drvHourlyRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EJMTSABAD2Z0','60','D','10','23',NULL,'Hourly Base Salary Pay Type',NULL,NULL,'"drvHourlyBaseSalaryPayType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EJMTSABAD2Z0','61','D','10','24',NULL,'Currency ISO code',NULL,NULL,'"drvCurrencyISOcode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EJMTSABAD2Z0','62','D','10','25',NULL,'45 Day Form Code',NULL,NULL,'"drvDayFormCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EJMTSABAD2Z0','63','D','10','26',NULL,'Form Code',NULL,NULL,'"drvFormCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EJMTSABAD2Z0','64','D','10','27',NULL,'Corporate Title',NULL,NULL,'"drvCorporateTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EJMTSABAD2Z0','65','D','10','28',NULL,'Previous Rate',NULL,NULL,'"drvPreviousRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EJMTSABAD2Z0','66','D','10','29',NULL,'Previous Effective Date',NULL,NULL,'"drvPreviousEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EJMTSABAD2Z0','67','D','10','30',NULL,'2nd Previous Rate',NULL,NULL,'"drvndPreviousRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EJMTSABAD2Z0','68','D','10','31',NULL,'2nd Effective Date',NULL,NULL,'"drvndEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EJMTSABAD2Z0','69','D','10','32',NULL,'GL Code - Department',NULL,NULL,'"drvGLCodeDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EJMTSABAD2Z0','70','D','10','33',NULL,'GL Code - Office',NULL,NULL,'"drvGLCodeOffice"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EJMTSABAD2Z0','71','D','10','34',NULL,'Phone 1',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EJMTSABAD2Z0','72','D','10','35',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EJMTSABAD2Z0','73','D','10','36',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EJMTSABAD2Z0','74','D','10','37',NULL,'Salary Type',NULL,NULL,'"drvSalaryType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EJMTSABAD2Z0','74','D','10','38',NULL,'Employment Status',NULL,NULL,'"drvEmpStatus"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EJMTSABAD2_20231219.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','8WQGC,8G8JP,YQZB8',NULL,NULL,NULL,'Saba Demographics On Demand','202305189','EMPEXPORT','ONDEM_XOE',NULL,'EJMTSABAD2',NULL,NULL,NULL,'202305189','Feb 16 2023 12:37PM','Feb 16 2023 12:37PM','202305181',NULL,'','','202305181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','8WQGC,8G8JP,YQZB8',NULL,NULL,NULL,'Saba Demo Sched Daily 5AM ET','206002299','EMPEXPORT','SCH_EJMTSA',NULL,'EJMTSABAD2',NULL,NULL,NULL,'202311299','Feb 16 2023 12:37PM','Feb 16 2023 12:37PM','202311281',NULL,'','','202302161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','8WQGC,8G8JP,YQZB8',NULL,NULL,NULL,'Saba Demographics Export-Test','202303279','EMPEXPORT','TEST_XOE',NULL,'EJMTSABAD2',NULL,NULL,NULL,'202303279','Feb 16 2023 12:37PM','Feb 16 2023 12:37PM','202303141',NULL,'','','202303141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJMTSABAD2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJMTSABAD2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJMTSABAD2','D10','dbo.U_EJMTSABAD2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EJMTSABAD2_Audit
-----------

IF OBJECT_ID('U_EJMTSABAD2_Audit') IS NULL
CREATE TABLE [dbo].[U_EJMTSABAD2_Audit] (
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
-- Create table U_EJMTSABAD2_AuditFields
-----------

IF OBJECT_ID('U_EJMTSABAD2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EJMTSABAD2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EJMTSABAD2_drvTbl
-----------

IF OBJECT_ID('U_EJMTSABAD2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EJMTSABAD2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubjectUserName] varchar(52) NULL,
    [drvManagerUsername] varchar(258) NULL,
    [drvHRRepUsername] varchar(10) NOT NULL,
    [drvCareerCoach] varchar(3) NOT NULL,
    [drvFirstname] varchar(102) NULL,
    [drvLastname] varchar(102) NULL,
    [drvEmail] varchar(52) NULL,
    [drvEmployeeID] varchar(11) NULL,
    [drvHireDate] varchar(32) NULL,
    [drvLastPromotionDate] varchar(32) NOT NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvDepartment] varchar(8000) NULL,
    [drvDivision] varchar(8000) NULL,
    [drvCompany] varchar(8000) NULL,
    [drvLocation] varchar(34) NULL,
    [drvJobCode] varchar(8000) NULL,
    [drvBaseSalary] nvarchar(4000) NULL,
    [drvVariablePayBonusTarget] varchar(3) NOT NULL,
    [drvDeactivateUser] varchar(3) NOT NULL,
    [drvJobDescriptionID] varchar(3) NOT NULL,
    [drvHoursWorkedPerYear] varchar(6) NOT NULL,
    [drvHourlyRate] nvarchar(4000) NOT NULL,
    [drvHourlyBaseSalaryPayType] varchar(1) NOT NULL,
    [drvCurrencyISOcode] varchar(5) NOT NULL,
    [drvDayFormCode] varchar(3) NOT NULL,
    [drvFormCode] varchar(3) NOT NULL,
    [drvCorporateTitle] varchar(27) NULL,
    [drvPreviousRate] nvarchar(4000) NOT NULL,
    [drvPreviousEffectiveDate] varchar(32) NOT NULL,
    [drvndPreviousRate] nvarchar(4000) NOT NULL,
    [drvndEffectiveDate] varchar(32) NOT NULL,
    [drvGLCodeDepartment] varchar(8000) NULL,
    [drvGLCodeOffice] varchar(8000) NULL,
    [drvPhone] varchar(52) NOT NULL,
    [drvMiddleInitial] varchar(3) NOT NULL,
    [drvTerminationDate] varchar(32) NOT NULL,
    [drvSalaryType] varchar(11) NULL,
    [drvEmpStatus] varchar(47) NULL
);

-----------
-- Create table U_EJMTSABAD2_EEList
-----------

IF OBJECT_ID('U_EJMTSABAD2_EEList') IS NULL
CREATE TABLE [dbo].[U_EJMTSABAD2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EJMTSABAD2_File
-----------

IF OBJECT_ID('U_EJMTSABAD2_File') IS NULL
CREATE TABLE [dbo].[U_EJMTSABAD2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJMTSABAD2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Johnson, Mirmiran & Thompson, Inc

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 02/16/2023
Service Request Number: TekP-2022-12-08-01

Purpose: Saba Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EJMTSABAD2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EJMTSABAD2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EJMTSABAD2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EJMTSABAD2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EJMTSABAD2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJMTSABAD2', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJMTSABAD2', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJMTSABAD2', 'SCH_EJMTSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EJMTSABAD2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EJMTSABAD2';

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
    DELETE FROM dbo.U_EJMTSABAD2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EJMTSABAD2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
           

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EJMTSABAD2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EJMTSABAD2_AuditFields;
    CREATE TABLE dbo.U_EJMTSABAD2_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EJMTSABAD2_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EJMTSABAD2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EJMTSABAD2_Audit;
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
    INTO dbo.U_EJMTSABAD2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EJMTSABAD2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND audNewValue = 'T' ;
    -- Create Index
   
   CREATE CLUSTERED INDEX CDX_U_EJMTSABAD2_Audit ON dbo.U_EJMTSABAD2_Audit (audEEID,audKey2);
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EJMTSABAD2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EJMTSABAD2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EJMTSABAD2_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EC.EecEmpNo
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSubjectUserName = '"'+ LOWER(CASE  WHEN EecEmpNo = '03412' then 'nimiller' ELSE SUBSTRING (EepAddressEMail,0, CHARINDEX('@', EepAddressEMail)) END) +'"'
        ,drvManagerUsername = '"'+ LOWER(CASE WHEN JbcDesc = 'President'  THEN '' 
                                 WHEN dbo.dsi_fnlib_GetSupervisorField_v2(EecCOID, EecEEID, 'EmpNo') = '03412'  THEN  'nimiller'
                                 WHEN dbo.dsi_fnlib_GetSupervisorField_v2(EecCOID, EecEEID, 'EmpNo') <> '03412' THEN SUBSTRING (dbo.dsi_fnlib_GetSupervisorField_v2('', EC.EecEEID, 'AddressEMail') ,0, CHARINDEX('@', (dbo.dsi_fnlib_GetSupervisorField_v2('', EC.EecEEID, 'AddressEMail')) )) END) +'"'--, CHARINDEX('@', (dbo.dsi_fnlib_GetSupervisorField_v2('', EecEEID, 'AddressEMail'))
        ,drvHRRepUsername = CASE WHEN Eeceeid = 'BA1Y6X0300K0' THEN '"'+''+'"' ELSE '"'+'jjameson'+'"' END --MW Changed From Jameson per request
        ,drvCareerCoach = '"'+''+'"'
        ,drvFirstname = '"'+CASE WHEN ISNULL(EepNamePreferred, '') <> '' then  EepNamePreferred else EepNameFirst END +'"'
        ,drvLastname = '"'+ EepNameLast +'"'
        ,drvEmail = '"'+ EepAddressEMail +'"'
        ,drvEmployeeID =  '"' +CASE WHEN Left(EC.EecEmpNo, 1 ) NOT IN ('9','C') THEN RTrim(EC.EecEmpNo)  END +'"'  -- EecEmpNo  --CASE WHEN Left(eepEEID, 1 ) NOT IN ('9', 'C') THEN eepEEID  Else '' END
        ,drvHireDate = '"'+ Convert(varchar,EecDateOfLastHire, 101) +'"'
        ,drvLastPromotionDate = '"'+ ISNULL(Convert(varchar,PromotionDate,101), '')+'"' --PEJH.EjhJobEffDate --when EjhReason = 300
        ,drvJobTitle = '"' + REPLACE(JbcDesc, ',','') +'"'
        ,drvDepartment =  '"'+ REPLACE(OrgDesc11, ',','') +'"' --where OrgCode = EecOrgLvl1
        ,drvDivision = '"'+ REPLACE(OrgDesc12, ',','') +'"'--where OrgCode = EecOrgLvl2
        ,drvCompany = '"'+ CASE When CmpCOID <> '3L7Uw' THEN REPLACE(Ltrim(rtrim(cmpcompanycode)), ',','')  END+'"' --REPLACE(CmpCompanyName, ',','')-- REPLACE(CmpCOID, ',','')  END+'"'
        ,drvLocation = '"'+ LocCode + '–' + LocDesc  +'"'
        ,drvJobCode = '"'+ REPLACE(RTRIm(EC.EecJobCode), ',','') +'"'
        ,drvBaseSalary = '"'+ Format(EC.Eecannsalary, '0.00') +'"'
        ,drvVariablePayBonusTarget = '"'+''+'"'
        ,drvDeactivateUser = '"'+CASE WHEN AudDateTime is not null then 'Y' ELSE 'N' END+'"'
        ,drvJobDescriptionID = '"'+''+'"'
        ,drvHoursWorkedPerYear = '"'+'2080'+'"'
        ,drvHourlyRate = '"'+ ISNULL(Format(EecHourlyPayRate, '0.00'),'')+'"'-- '"'+ ISNULL(Format(EJH.EjhHourlyPayRate, '0.00'),'')+'"'
        ,drvHourlyBaseSalaryPayType = 'Y'    -- KDR hard-coded to 'Y' per client request 11/29/2023
                                            --'"'+ ISNULL(CASE WHEN EC.EecSalaryOrHourly = 'S' THEN  'N'
                                            --     WHEN EC.EecSalaryOrHourly = 'H' THEN  'Y'
                                            --  END ,'') +'"'  
        ,drvCurrencyISOcode = '"'+ 'USD' +'"'
        ,drvDayFormCode = '"'+''+'"'
        ,drvFormCode = '"'+''+'"'
        ,drvCorporateTitle ='"'+ RTrim(AwardDesc) +'"'  --'"'+ Pcf.Employment_CorporateTitle  +'"' --'"'+ ISNULL(REPLACE(JbcJobCode + '–' + JbcDesc, ',',''),'') +'"' -- REPLACE(Convert(varchar,EecDateInJob, 101), ',','')
        ,drvPreviousRate = '"'+ ISNULL(Format(EJH.EjhHourlyPayRate, '0.00'),'') +'"'
        ,drvPreviousEffectiveDate = '"'+ ISNULL(Convert(varchar,EJH.EjhJobEffDate, 101), '')+'"'
        ,drvndPreviousRate =  '"'+ ISNULL(FORMaT(PJH.EjhHourlyPayRate, '0.00'),'') +'"' --Previous where EjhIsRateChange = Y
        ,drvndEffectiveDate = '"'+ Isnull(Convert(varchar,PJH.EjhJobEffDate, 101), '')+'"'-- Previous where EjhIsRateChange = Y
        ,drvGLCodeDepartment = '"'+ REPLACE(Ltrim(RTrim(OrgGLSegment1)), ',','') +'"'--OrgGLSegment for EecOrgLvl1
        ,drvGLCodeOffice = '"'+ REPLACE(LTrim(RTrim(OrgGLSegment2)), ',','') +'"'--OrgGLSegment for EecOrgLvl2
        ,drvPhone = '"'+ ISNULL(LTrim(RTrim(EC.EecPhoneBusinessNumber)), '') +'"'
        ,drvMiddleInitial = '"'+ ISNULL(LEFT(EepNameMiddle,1), '')+'"'
        ,drvTerminationDate = '"'+ ISNULL(CASE WHEN EC.EecEmplStatus = 'T' THEN Convert(varchar,EC.EecDateOfTermination,101) END, '')+'"'
        ,drvSalaryType = '"'+ CASE WHEN JbcFLSAType = 'N' THEN 'NonExempt'
                                   WHEN JbcFLSAType = 'E' THEN 'Exempt' END +'"'
        ,drvEmpStatus = '"' + codDesc + '"'
        
    INTO dbo.U_EJMTSABAD2_drvTbl
    FROM dbo.U_EJMTSABAD2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EC WITH (NOLOCK)
        ON EC.EecEEID = xEEID 
        AND EC.EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
     LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours ,EjhHourlyPayRate
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhHourlyPayRate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)
                    WHERE EjhIsRateChange = 'Y') AS X
            WHERE RN = 2) AS EJH
        ON EJH.EjhEEID = xEEID
        AND EJH.EjhCOID = xCOID
        AND EJH.EjhJobCode = EecJobCode
      --LEFT JOIN (
   --          SELECT EjhEEID, EjhCOID, EjhJObCode, EjhJobDesc, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhHourlyPayRate, EjhIsPromotion, EjhReason
   --         FROM (
   --                 SELECT EjhEEID, EjhCOID, EjhJObCode, EjhJobDesc, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhHourlyPayRate, EjhIsPromotion, EjhReason, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
   --                 FROM dbo.EmpHJob WITH (NOLOCK)
   --                 WHERE EjhReason = '201') AS X
   --         WHERE RN = 1) AS PEJH
   --     ON PEJH.EjhEEID = xEEID
   --     AND PEJH.EjhCOID = xCOID
   --    -- AND PEJH.EjhJobCode = EecJobCode
     LEFT JOIN (
             SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours ,EjhHourlyPayRate
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours,  EjhHourlyPayRate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)  WHERE EjhIsRateChange = 'Y') AS X
            WHERE RN = 3) AS PJH
        ON PJH.EjhEEID = xEEID
        AND PJH.EjhCOID = xCOID
       AND PJH.EjhJobCode = EecJobCode
    LEFT JOIN (
            SELECT DISTINCT OrgCode as OrgCode11, OrgDesc AS OrgDesc11, OrgGLSegment as OrgGLSegment1
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 1
            ) AS Org3
        ON OrgCode11 = EecOrgLvl1
    LEFT JOIN (
            SELECT DISTINCT OrgCode as OrgCode12 , OrgDesc AS OrgDesc12 , OrgGLSegment as OrgGLSegment2
            FROM dbo.OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
         ON OrgCode12 = EecOrgLvl2
        JOIN dbo.LOCATION WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = XCOID
    LEFT JOIN dbo.U_EJMTSABAD2_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
     JOIN dbo.Codes WITH (NOLOCK)
        ON CodCode = EecEEType
        AND CodTable = 'EMPTYPE'
    --LEFT JOIN [dbo].[fn_MP_CustomFields_Empcomp_Export]  (NULL,NULL,NULL,NULL) pcf 
 --       ON pcf.eecEEID = EC.EecEeid
 LEFT JOIN (  SELECT EmployeeID, AwardDesc, PromotionDate
                FROM ( SELECT EmployeeID ,AwardDesc , Date as PromotionDate ,ROW_NUMBER() OVER(PARTITION BY EmployeeID ORDER BY Date DESC) AS RN
                         FROM dbo.ENTITY_Award
                       WHERE awarddesc IN ('Associate','Chairman of the Board','Executive Vice President','President','Senior Associate','Senior Vice President','Vice President','Associate Vice President','Associate Vice President')
                      Group by EmployeeID
                      ,AwardID
                      ,AwardDesc
                      ,Date 
                   ) X
                Where RN = 1
             ) Pro
            ON EmployeeID = XEEID
     Where CmpCOID <> '3L7Uw' and Left(EC.EecEmpNo, 1 ) NOT IN ('9','C') and ( EecEmplStatus <> 'T' OR (EecEmplStatus = 'T'  AND eectermreason <>'TRO'  AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate))
 
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
ALTER VIEW dbo.dsi_vwEJMTSABAD2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EJMTSABAD2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EJMTSABAD2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302091'
       ,expStartPerControl     = '202302091'
       ,expLastEndPerControl   = '202302169'
       ,expEndPerControl       = '202302169'
WHERE expFormatCode = 'EJMTSABAD2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEJMTSABAD2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EJMTSABAD2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EJMTSABAD2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EJMTSABAD2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EJMTSABAD2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EJMTSABAD2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EJMTSABAD2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EJMTSABAD2', 'UseFileName', 'V', 'Y'


-- End ripout