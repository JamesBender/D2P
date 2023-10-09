/**********************************************************************************

EBRSUSALFE: USAble Life Enrollment Export

FormatCode:     EBRSUSALFE
Project:        USAble Life Enrollment Export
Client ID:      BRS1000
Date/time:      2023-09-06 11:04:09.937
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP1DB04
Database:       ULTIPRO_WPBRSM
Web Filename:   BRS1000_WBW59_EEHISTORY_EBRSUSALFE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBRSUSALFE_SavePath') IS NOT NULL DROP TABLE dbo.U_EBRSUSALFE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBRSUSALFE'


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
WHERE FormatCode = 'EBRSUSALFE'
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
WHERE ExpFormatCode = 'EBRSUSALFE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBRSUSALFE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBRSUSALFE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBRSUSALFE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBRSUSALFE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBRSUSALFE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBRSUSALFE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBRSUSALFE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBRSUSALFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBRSUSALFE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBRSUSALFE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBRSUSALFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBRSUSALFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBRSUSALFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBRSUSALFE];
GO
IF OBJECT_ID('U_EBRSUSALFE_Header') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_Header];
GO
IF OBJECT_ID('U_EBRSUSALFE_File') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_File];
GO
IF OBJECT_ID('U_EBRSUSALFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_EEList];
GO
IF OBJECT_ID('U_EBRSUSALFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_drvTbl];
GO
IF OBJECT_ID('U_EBRSUSALFE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_DedList];
GO
IF OBJECT_ID('U_EBRSUSALFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_AuditFields];
GO
IF OBJECT_ID('U_EBRSUSALFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBRSUSALFE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBRSUSALFE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBRSUSALFE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBRSUSALFE','USAble Life Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EBRSUSALFEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBRSUSALFEZ0','50','H','01','1',NULL,'Group Number',NULL,NULL,'"Group Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBRSUSALFEZ0','50','H','01','2',NULL,'Employee SSN',NULL,NULL,'"Employee SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBRSUSALFEZ0','50','H','01','3',NULL,'Employee Id',NULL,NULL,'"Employee Id"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBRSUSALFEZ0','50','H','01','4',NULL,'Dependent SSN',NULL,NULL,'"Dependent SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBRSUSALFEZ0','50','H','01','5',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBRSUSALFEZ0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBRSUSALFEZ0','50','H','01','7',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBRSUSALFEZ0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBRSUSALFEZ0','50','H','01','9',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBRSUSALFEZ0','50','H','01','10',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBRSUSALFEZ0','50','H','01','11',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBRSUSALFEZ0','50','H','01','12',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBRSUSALFEZ0','50','H','01','13',NULL,'Dependent Relationship',NULL,NULL,'"Dependent Relationship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBRSUSALFEZ0','50','H','01','14',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBRSUSALFEZ0','50','H','01','15',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBRSUSALFEZ0','50','H','01','16',NULL,'Salary Effective Date',NULL,NULL,'"Salary Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBRSUSALFEZ0','50','H','01','17',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBRSUSALFEZ0','50','H','01','18',NULL,'Status Effective Date',NULL,NULL,'"Status Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBRSUSALFEZ0','50','H','01','19',NULL,'Smoker Status',NULL,NULL,'"Smoker Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBRSUSALFEZ0','50','H','01','20',NULL,'Hours worked',NULL,NULL,'"Hours worked"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBRSUSALFEZ0','50','H','01','21',NULL,'Class',NULL,NULL,'"Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBRSUSALFEZ0','50','H','01','22',NULL,'Bill Group',NULL,NULL,'"Bill Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBRSUSALFEZ0','50','H','01','23',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBRSUSALFEZ0','50','H','01','24',NULL,'L&D Benefit 1 Description',NULL,NULL,'"L&D Benefit 1 Description"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBRSUSALFEZ0','50','H','01','25',NULL,'L&D Benefit 1 Election/Volume',NULL,NULL,'"L&D Benefit 1 Election/Volume"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBRSUSALFEZ0','50','H','01','26',NULL,'L&D Benefit 1 Effective Date',NULL,NULL,'"L&D Benefit 1 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBRSUSALFEZ0','50','H','01','27',NULL,'L&D Benefit 1 Cancellation Effective Date',NULL,NULL,'"drvLDCanEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBRSUSALFEZ0','50','H','01','28',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBRSUSALFEZ0','50','H','01','29',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBRSUSALFEZ0','50','H','01','30',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBRSUSALFEZ0','50','H','01','31',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBRSUSALFEZ0','50','H','01','32',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBRSUSALFEZ0','50','H','01','33',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBRSUSALFEZ0','50','D','10','1',NULL,'Group Number',NULL,NULL,'"drvGroupNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBRSUSALFEZ0','50','D','10','2',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBRSUSALFEZ0','50','D','10','3',NULL,'Employee Id',NULL,NULL,'"drvEmployeeId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBRSUSALFEZ0','50','D','10','4',NULL,'Dependent SSN',NULL,NULL,'"drvDependentSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBRSUSALFEZ0','50','D','10','5',NULL,'Title',NULL,NULL,'"drvTitleTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBRSUSALFEZ0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBRSUSALFEZ0','50','D','10','7',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBRSUSALFEZ0','50','D','10','8',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBRSUSALFEZ0','50','D','10','9',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBRSUSALFEZ0','50','D','10','10',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBRSUSALFEZ0','50','D','10','11',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBRSUSALFEZ0','50','D','10','12',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBRSUSALFEZ0','50','D','10','13',NULL,'Dependent Relationship',NULL,NULL,'"drvDependentRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBRSUSALFEZ0','50','D','10','14',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBRSUSALFEZ0','50','D','10','15',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBRSUSALFEZ0','50','D','10','16',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBRSUSALFEZ0','50','D','10','17',NULL,'Status',NULL,NULL,'"drvStatusStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBRSUSALFEZ0','50','D','10','18',NULL,'Status Effective Date',NULL,NULL,'"drvStatusDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBRSUSALFEZ0','50','D','10','19',NULL,'Smoker Status',NULL,NULL,'"drvSmokerStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBRSUSALFEZ0','50','D','10','20',NULL,'Hours worked',NULL,NULL,'"drvHoursworked"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBRSUSALFEZ0','50','D','10','21',NULL,'Class',NULL,NULL,'"drvClassClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBRSUSALFEZ0','50','D','10','22',NULL,'Bill Group',NULL,NULL,'"drvBillGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBRSUSALFEZ0','50','D','10','23',NULL,'Department',NULL,NULL,'"drvDepartmentDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBRSUSALFEZ0','50','D','10','24',NULL,'L&D Benefit 1 Description',NULL,NULL,'"drvLDDescription"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBRSUSALFEZ0','50','D','10','25',NULL,'L&D Benefit 1 Election/Volume',NULL,NULL,'"drvLDElectionVolume"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBRSUSALFEZ0','50','D','10','26',NULL,'L&D Benefit 1 Effective Date',NULL,NULL,'"drvLDEFFDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBRSUSALFEZ0','50','D','10','27',NULL,'L&D Benefit 1 Cancellation Effective Date',NULL,NULL,'"drvLDCanEffDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBRSUSALFEZ0','50','D','10','28',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBRSUSALFEZ0','50','D','10','29',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBRSUSALFEZ0','50','D','10','30',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBRSUSALFEZ0','50','D','10','31',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBRSUSALFEZ0','50','D','10','32',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBRSUSALFEZ0','50','D','10','33',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBRSUSALFE_20230906.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202307149','EMPEXPORT','OEACTIVE',NULL,'EBRSUSALFE',NULL,NULL,NULL,'202307149','Jul 14 2023 11:58AM','Jul 14 2023 11:58AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202307149','EMPEXPORT','OEPASSIVE',NULL,'EBRSUSALFE',NULL,NULL,NULL,'202307149','Jul 14 2023 11:58AM','Jul 14 2023 11:58AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'USAble Life Enrollment Export','202307149','EMPEXPORT','ONDEM_XOE',NULL,'EBRSUSALFE',NULL,NULL,NULL,'202307149','Jul 14 2023 11:58AM','Jul 14 2023 11:58AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'USAble Life Enrollment E-Sched','202307149','EMPEXPORT','SCH_EBRSUS',NULL,'EBRSUSALFE',NULL,NULL,NULL,'202307149','Jul 14 2023 11:58AM','Jul 14 2023 11:58AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'USAble Life Enrollment E-Test','202307149','EMPEXPORT','TEST_XOE',NULL,'EBRSUSALFE',NULL,NULL,NULL,'202307149','Jul 14 2023 11:58AM','Jul 14 2023 11:58AM','202307141',NULL,'','','202307141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBRSUSALFE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBRSUSALFE','H01','dbo.U_EBRSUSALFE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBRSUSALFE','D10','dbo.U_EBRSUSALFE_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBRSUSALFE
-----------

IF OBJECT_ID('U_dsi_BDM_EBRSUSALFE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBRSUSALFE] (
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
-- Create table U_EBRSUSALFE_Audit
-----------

IF OBJECT_ID('U_EBRSUSALFE_Audit') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_Audit] (
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
-- Create table U_EBRSUSALFE_AuditFields
-----------

IF OBJECT_ID('U_EBRSUSALFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBRSUSALFE_DedList
-----------

IF OBJECT_ID('U_EBRSUSALFE_DedList') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBRSUSALFE_drvTbl
-----------

IF OBJECT_ID('U_EBRSUSALFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvGroupNumber] varchar(8) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvDependentSSN] varchar(11) NULL,
    [drvTitleTitle] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleName] varchar(6000) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvSuffix] varchar(6000) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvBirthDate] varchar(10) NULL,
    [drvGender] varchar(1) NULL,
    [drvDependentRelationship] varchar(6) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvAnnualSalary] money NULL,
    [drvSalaryDate] varchar(10) NULL,
    [drvStatusStatus] varchar(6) NULL,
    [drvStatusDate] varchar(10) NULL,
    [drvSmokerStatus] varchar(1) NULL,
    [drvHoursworked] nvarchar(4000) NULL,
    [drvClassClass] varchar(7) NULL,
    [drvBillGroup] varchar(6) NULL,
    [drvDepartmentDepartment] varchar(1) NOT NULL,
    [drvLDDescription] varchar(6) NULL,
    [drvLDElectionVolume] money NULL,
    [drvLDEFFDate] varchar(10) NULL,
    [drvLDCanEffDate] varchar(10) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_EBRSUSALFE_EEList
-----------

IF OBJECT_ID('U_EBRSUSALFE_EEList') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBRSUSALFE_File
-----------

IF OBJECT_ID('U_EBRSUSALFE_File') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EBRSUSALFE_Header
-----------

IF OBJECT_ID('U_EBRSUSALFE_Header') IS NULL
CREATE TABLE [dbo].[U_EBRSUSALFE_Header] (
    [drvLDCanEffDate] varchar(41) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBRSUSALFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: B & R SUPERMARKET INC

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 07/14/2023
Service Request Number: SR-2023-00408993

Purpose: USAble Life Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBRSUSALFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBRSUSALFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBRSUSALFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBRSUSALFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBRSUSALFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBRSUSALFE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBRSUSALFE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBRSUSALFE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBRSUSALFE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBRSUSALFE', 'SCH_EBRSUS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBRSUSALFE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBRSUSALFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBRSUSALFE';

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
    DELETE FROM dbo.U_EBRSUSALFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBRSUSALFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBRSUSALFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBRSUSALFE_AuditFields;
    CREATE TABLE dbo.U_EBRSUSALFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBRSUSALFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBRSUSALFE_Audit;
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
    INTO dbo.U_EBRSUSALFE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBRSUSALFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBRSUSALFE_Audit ON dbo.U_EBRSUSALFE_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EBRSUSALFE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBRSUSALFE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_EBRSUSALFE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBRSUSALFE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBRSUSALFE_DedList
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
  EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;
    
    --Insert missing Dep into BDM

             INSERT INTO dbo.U_dsi_BDM_EBRSUSALFE
         (  BdmRecType
         ,  BdmCOID
         ,  BdmEEID
         ,  BdmDepRecID
         ,  BdmSystemID
         ,  BdmRunID
         ,  BdmDedRowStatus
         ,  BdmRelationship
         ,  BdmDateOfBirth
         ,  BdmDedCode
         ,  BdmDedType
         ,  BdmBenOption
         ,  BdmBenStatus
         ,  BdmBenStartDate
         ,  BdmBenStopDate
         ,  BdmBenStatusDate
         ,  BdmBenOptionDate
         ,  BdmChangeReason
         ,  BdmStartDate
         ,  BdmStopDate
         ,  BdmIsCobraCovered
         ,  BdmCobraReason
         ,  BdmDateOfCOBRAEvent
         ,  BdmIsPQB
         ,  BdmIsChildOldest
         ,  BdmUSGField1
         ,  BdmUSGField2
         ,  BdmUSGDate1
         ,  BdmUSGDate2
         ,  BdmTVStartDate
         ,  BdmSessionID
         ,  BdmEEAmt
         ,  BdmEECalcRateOrPct
         ,  BdmEEGoalAmt
         ,  BdmEEMemberOrCaseNo
         ,  BdmERAmt
         ,  BdmNumSpouses
         ,  BdmNumChildren
         ,  BdmNumDomPartners
         ,  BdmNumDPChildren
         )              
 
            SELECT             
             BdmRecType = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN 'DEP'
                               WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN 'DEP' END        
            , eedcoid = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN ee.eedcoid
                             WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN ee.eedcoid END
            , eedeeid = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN ee.eedeeid
                            WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN ee.eedeeid END
            ,consystemid = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN consystemid
                                WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN consystemid END
            , NULL
            , NULL
            , NULL
            , conRelationship = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN conrelationship
                                     WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN conrelationship END
            , ConDateofBirth = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN ConDateofBirth
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN ConDateofBirth END
            , eeddedcode = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.eeddedcode
                                WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eeddedcode END
            , DedDedType = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.DedDedType
                                WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.DedDedType END
            , eedbenoption = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.eedbenoption
                                 WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedbenoption END
            , eedbenstatus = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.eedbenstatus
                                 WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedbenstatus END
            , eedbenstartdate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.eedbenstartdate
                                     WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedbenstartdate END
            , eedbenstopdate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.eedbenstopdate
                                   WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedbenstopdate END
            , EedBenStatusDate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.EedBenStatusDate
                                     WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedBenStatusDate END
            , EedBenOptionDate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedBenOptionDate
                                     WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedBenOptionDate END
            , EedChangeReason = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedChangeReason
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedChangeReason END
            , eedbenstartdate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.eedbenstartdate 
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN ee.eedbenstartdate  END
            , eedbenstopdate = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.eedbenstopdate
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedbenstopdate END
            , eedvalidforexport = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.eedvalidforexport
                                        WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.eedvalidforexport END
            , EedCobraReason = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN  ee.EedCobraReason 
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN ee.EedCobraReason  END
            , EedDateOfCOBRAEvent = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedDateOfCOBRAEvent
                                         WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedDateOfCOBRAEvent END
            , EedIsPQB = CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedIsPQB
                              WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedIsPQB END
            , NULL
            , NULL
            , NULL
            , NULL
            , NULL
            , EedTVStartDate  =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedTVStartDate
                                    WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedTVStartDate END
            , EedSessionID =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedSessionID
                                 WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedSessionID END
            , EedBenAmt =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedBenAmt
                              WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedBenAmt END
            , EedEECalcRateOrPct =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedEECalcRateOrPct
                                       WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedEECalcRateOrPct  END
            , EedEEGoalAmt =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedEEGoalAmt
                                 WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedEEGoalAmt END
            , NULL
            , EedERAmt =CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN   ee.EedERAmt
                             WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN  ee.EedERAmt END
             , BdmNumSpouses= CASE WHEN conrelationship IN ('SPS', 'DP') then 1 else 0 end
            , BdmNumChildren = CASE WHEN conrelationship IN ('CHL', 'DPC', 'STC') then (SELECT count(*) FROM Contacts a where a.ConRelationship IN ('CHL', 'DPC', 'STC') and a.coneeid = ee.eedeeid)  else 0 end
            , 0
            , 0

         FROM dbo.empded ed WITH (nolock)
         JOIN dbo.emppers WITH (nolock) ON eepeeid = ed.eedeeid
         JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (nolock) 
            ON ee.eedeeid = ed.eedeeid 
            AND ee.eedcoid = ed.eedcoid
            AND eedFormatCode = 'EBRSUSALFE' --AND eedValidForExport = 'Y'
            AND ee.eeddedcode = ed.eeddedcode
        JOIN dbo.contacts WITH (nolock) 
            ON ee.eedeeid = coneeid
            WHERE ISnull(ee.eeddedcode, '')  IN ('LIFES', 'LIFEC')
            and ConRelationship IN ('SPS', 'DP' , 'CHL') and ConIsDependent = 'Y'
            and ee.EedBenStatus NOT In ('W', 'C')
            and (ee.EedBenStatus <> 'T' or ( ee.EedBenStatus = 'T' and ee.eedbenstopdate Between @StartDate and @EndDate))
            and  CASE WHEN conrelationship IN ('SPS', 'DP') and ee.eeddedcode = 'LIFES' THEN 'DEP'
                            WHEN conrelationship IN ('CHL', 'DPC', 'STC') and ee.eeddedcode = 'LIFEC'THEN 'DEP' END is not null 
                            and  consystemid not in (SELECT BdmDepRecID FROM dbo.U_dsi_BDM_EBRSUSALFE where BdmDepRecID  is not null and BdmDedCode IN ('LIFES', 'LIFEC'))

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBRSUSALFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBRSUSALFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBRSUSALFE_drvTbl;
  SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvGroupNumber = '50053349'
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvDependentSSN = '' --CASE WHEN BdmRecType = 'DEP' THEN ConSSN
                            --END
        ,drvTitleTitle = dbo.dsi_fnRemoveChars(',/-',CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END)
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                   -- WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvMiddleName = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                        --    WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvLastName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  -- WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvSuffix = dbo.dsi_fnRemoveChars(',/-',CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix END)
        ,drvMaritalStatus = CASE WHEN BdmRecType = 'EMP'THEN eepMaritalStatus END 
        ,drvBirthDate = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),EepDateOfBirth,101)
                                        -- WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(10),ConDateOfBirth,101)
                                    END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('F','M') THEN EepGender
                                   --  WHEN BdmRecType = 'DEP' AND ConGender IN ('F','M') THEN ConGender
                                     ELSE 'U'
                                END
        ,drvDependentRelationship = ''--Case WHEN BdmRecType = 'DEP'  and  ConRelationship in ('DP', 'SPS') then 'Spouse'
                                     --    WHEN BdmRecType = 'DEP'  and  ConRelationship in  ('CHL', 'DPC', 'STC') then 'Child' 
                                     --   END
        ,drvHireDate =  CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(10),EecDateOfLastHire,101)
                                        ELSE CONVERT(VARCHAR(10),EecDateOfOriginalHire,101)                                           
                                        END
                               END
        ,drvAnnualSalary = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvSalaryDate = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), 101) END
        ,drvStatusStatus = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN  EecEmplStatus in ('A', 'L') THEN 'Active'Else 'T' END END
        ,drvStatusDate = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),EecDateInJob, 101) END
        ,drvSmokerStatus = Case WHEN BdmRecType = 'EMP'  THEN 
                                    CASE WHEN EepIsSmoker ='Y' THEN 'Y'
                                         WHEN EepIsSmoker ='N' THEN 'N'
                                        END
                                END

        ,drvHoursworked = CASE WHEN BdmRecType = 'EMP' THEN
                                    FORMAT(CASE When eecPayPeriod = 'W' then EecScheduledWorkHrs
                                         When eecPayPeriod= 'B' then EecScheduledWorkHrs / 2
                                         When eecPayPeriod ='S' then EecScheduledWorkHrs * 24 / 52
                                         When eecPayPeriod ='M' then EecScheduledWorkHrs * 12 / 52 
                                    END , '0')
                                END
        ,drvClassClass = CASE WHEN BdmRecType = 'EMP' THEN '4217362' END
        ,drvBillGroup = CASE WHEN BdmRecType = 'EMP' THEN '462017'END
        ,drvDepartmentDepartment = ''    
        ,drvLDDescription = BdmDedcode
        ,drvLDElectionVolume = BcaBenAmt                                
        ,drvLDEFFDate = CONVERT(VARCHAR(10),BdmStartDate, 101)
        ,drvLDCanEffDate = CONVERT(VARCHAR(10),BdmBenStopDate, 101)
        ,drvAddress1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 END
        ,drvAddress2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 END
        ,drvCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity END
        ,drvState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState END
        ,drvZip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode END
        ,drvEmailAddress =CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
    INTO dbo.U_EBRSUSALFE_drvTbl
    FROM dbo.U_EBRSUSALFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (SELECT BdmEEID
      ,BDMRecType
      ,BDMCoid
      ,BdmDedcode = CASE WHEN BdmDedcode = 'GTL'  THEN 'GTL' 
                         WHEN BdmDedcode ='LIFEE' THEN 'VGTL' 
                         END
                         ,BcaBenAmt
   
      ,BdmStartDate = MAX(BdmStartDate)
      ,BdmBenStopDate = MAX(BdmBenStopDate)
      ,BdmBenStatus = MAX(BdmBenStatus)
  FROM dbo.U_dsi_BDM_EBRSUSALFE  WITH (NOLOCK)
  LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK) ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
       AND bdmdedcode = bcadedcode  and  bcaFormatcode = 'EBRSUSALFE'  
       where BdmDedcode IN ('LIFEE','GTL')
   Group by BdmEEID
      ,BDMRecType
      ,BDMCoid
      ,BdmDedcode 
      ,BcaBenAmt

      Union

      SELECT BdmEEID
      ,BDMRecType
      ,BDMCoid
      ,BdmDedcode = CASE WHEN BdmDedcode = 'GTL'  THEN 'ADD' 
                         WHEN BdmDedcode ='LIFEE' THEN 'VADD' 
                        END
      ,BcaBenAmt
      ,BdmStartDate = MAX(BdmStartDate)
      ,BdmBenStopDate = MAX(BdmBenStopDate)
      ,BdmBenStatus =  MAX(BdmBenStatus)
  FROM dbo.U_dsi_BDM_EBRSUSALFE  WITH (NOLOCK)
  LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK) ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
       AND bdmdedcode = bcadedcode  and  bcaFormatcode = 'EBRSUSALFE'
       Where BdmDedcode IN ('LIFEE','GTL')
    Group by BdmEEID
      ,BDMRecType
      ,BDMCoid
      ,BdmDedcode 
      ,BcaBenAmt
) BDM
        ON BDM.BdmEEID = xEEID 
        AND BDM.BdmCoID = xCoID   
  
        Where EecEETYPE <> 'TES' and ( EecEmplstatus <> 'T' or  (EecEmplstatus ='T'  and EecDateOfTermination Between @Startdate and @EndDate))
    

        Union 

        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvGroupNumber = '50053349'
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvDependentSSN = CASE WHEN BdmRecType = 'DEP' THEN ConSSN
                            END
        ,drvTitleTitle = dbo.dsi_fnRemoveChars(',/-',CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END)
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/-',
                               CASE --WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvMiddleName = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE --WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvLastName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE --WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvSuffix = dbo.dsi_fnRemoveChars(',/-',CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix END)
        ,drvMaritalStatus = ''--CASE WHEN BdmRecType = 'EMP'THEN eepMaritalStatus END 
        ,drvBirthDate = CASE --WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),EepDateOfBirth,101)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(10),ConDateOfBirth,101)
                                    END
        ,drvGender = CASE -- WHEN BdmRecType = 'EMP' AND EepGender IN ('F','M') THEN EepGender
                                     WHEN BdmRecType = 'DEP' AND ConGender IN ('F','M') THEN ConGender
                                     ELSE 'U'
                                END
        ,drvDependentRelationship = Case WHEN BdmRecType = 'DEP'  and  ConRelationship in ('DP', 'SPS') then 'Spouse'
                                         WHEN BdmRecType = 'DEP'  and  ConRelationship in  ('CHL', 'DPC', 'STC') then 'Child' 
                                        END
        ,drvHireDate =  CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(10),EecDateOfLastHire,101)
                                        ELSE CONVERT(VARCHAR(10),EecDateOfOriginalHire,101)                                           
                                        END
                               END
        ,drvAnnualSalary = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvSalaryDate = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), 101) END
        ,drvStatusStatus = ''--CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN  EecEmplStatus in ('A', 'L') THEN 'Active'Else 'T' END END
        ,drvStatusDate = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(10),EecDateInJob, 101) END
        ,drvSmokerStatus = ''--Case WHEN BdmRecType = 'EMP'  THEN 
                                 --   CASE WHEN EepIsSmoker ='Y' THEN 'Y'
                                    --     WHEN EepIsSmoker ='N' THEN 'N'
                                     --   END
                               -- END

        ,drvHoursworked = '' -- CASE WHEN BdmRecType = 'EMP' THEN
                               --     FORMAT(CASE When eecPayPeriod = 'W' then EecScheduledWorkHrs
                                --         When eecPayPeriod= 'B' then EecScheduledWorkHrs / 2
                                --         When eecPayPeriod ='S' then EecScheduledWorkHrs * 24 / 52
                                --         When eecPayPeriod ='M' then EecScheduledWorkHrs * 12 / 52 
                                --    END , '0')
                                --END
        ,drvClassClass = ''--CASE WHEN BdmRecType = 'EMP' THEN '4217362' END
        ,drvBillGroup = ''--CASE WHEN BdmRecType = 'EMP' THEN '462017'END
        ,drvDepartmentDepartment = ''
    
        ,drvLDDescription = CASE --When BDM1.BdmDedcode = 'GTL' THEN 'Basic Employee AD&D'
        --                         When BDM1.BdmDedcode ='LIFEE' THEN 'Employee Supplemental AD&D'
        --                         When BDM1.BdmDedcode ='LIFES' THEN 'Spousal Supplemental AD&D'
                                 --When BDM1.BdmDedcode = 'LIFEC'THEN 'Child Supplemental AD&D'
                                
                                -- When BDM2.BdmDedcode = 'GTL'  THEN 'GTL'
                              --   When BDM2.BdmDedcode ='LIFEE' THEN 'VGTL'
                                 When BdmDedcode ='LIFES' THEN 'VGTLSP'
                                 When BdmDedcode = 'LIFEC'THEN 'VGTLCH'
                                END
        ,drvLDElectionVolume = CASE  --When BDM2.BdmDedcode = 'GTL'  THEN BcaBenAmt
                               -- When BDM2.BdmDedcode ='LIFEE' THEN BcaBenAmt
                                 When BdmDedcode ='LIFES' THEN BcaBenAmt
                                 When BdmDedcode = 'LIFEC'THEN BcaBenAmt
                                 END
        ,drvLDEFFDate = CONVERT(VARCHAR(10),CASE --When BDM1.BdmDedcode = 'GTL' THEN Bdm1.BdmStartDate
                                 --When BDM1.BdmDedcode ='LIFEE' THEN Bdm1.BdmStartDate
                                 --When BDM1.BdmDedcode ='LIFES' THEN Bdm1.BdmStartDate
                                 --When BDM1.BdmDedcode = 'LIFEC'THEN Bdm1.BdmStartDate
                               --  When BDM2.BdmDedcode = 'GTL'  THEN Bdm2.BdmStartDate
                                -- When BDM2.BdmDedcode ='LIFEE' THEN Bdm2.BdmStartDate
                                 When BdmDedcode ='LIFES' THEN BdmStartDate
                                 When BdmDedcode = 'LIFEC'THEN BdmStartDate
                                END, 101)
        ,drvLDCanEffDate = CONVERT(VARCHAR(10),CASE --When BDM1.BdmDedcode = 'GTL' THEN Bdm1.BdmBenStopDate
                                 --When BDM1.BdmDedcode ='LIFEE' THEN Bdm1.BdmBenStopDate
                                 --When BDM1.BdmDedcode ='LIFES' THEN Bdm1.BdmBenStopDate
                                 --When BDM1.BdmDedcode = 'LIFEC'THEN Bdm1.BdmBenStopDate
                                -- When BDM2.BdmDedcode = 'GTL'  THEN Bdm2.BdmBenStopDate
                               --  When BDM2.BdmDedcode ='LIFEE' THEN Bdm2.BdmBenStopDate
                                 When BdmDedcode ='LIFES' THEN BdmBenStopDate
                                 When BdmDedcode = 'LIFEC'THEN BdmBenStopDate
                                END, 101)
        ,drvAddress1 = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 END
        ,drvAddress2 = ''--''CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 END
        ,drvCity =''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity END
        ,drvState = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressState END
        ,drvZip = ''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode END
        ,drvEmailAddress =''--CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
  --  INTO dbo.U_EBRSUSALFE_drvTbl
    FROM dbo.U_EBRSUSALFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBRSUSALFE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
         AND (bdmbenstatus = 'A' or (bdmbenstatus = 'T' and bdmbenstopdate IS not null))
         and BdmDedcode In ('LIFES','LIFEC')
    --JOIN (SELECT BdmEEID
 --                    ,BDMCoid
 --                    , BDMDedCode
 --                    , BdmStartDate
 --                    , BdmBenStopDate
 --                   FROM dbo.U_dsi_BDM_EBRSUSALFE  WITH (NOLOCK)
 --  Where (bdmbenstatus = 'A' or (bdmbenstatus = 'T' and bdmbenstopdate IS not null)
 --  and BdmDedcode In ('LIFES','LIFEC'))
 --           ) AS BDM2
 --       ON BDM2.BdmEEID = xEEID 
 --       AND BDM2.BdmCoID = xCoID
    --JOIN dbo.DedCode WITH (NOLOCK)
    --ON DedDedcode = Bdmdedcode
   LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK) ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
       AND bdmdedcode = bcadedcode  and  bcaFormatcode = 'EBRSUSALFE'
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conEEID = xeeid
        and ConSystemID = bdmDepRecID
        and bdmDepRecID IS NOT NULL
    Where EecEETYPE <> 'TES' and ( EecEmplstatus <> 'T' or  (EecEmplstatus ='T'  and EecDateOfTermination Between @Startdate and @EndDate))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBRSUSALFE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBRSUSALFE_Header;
    SELECT DISTINCT
        drvLDCanEffDate = 'L&D Benefit 1 Cancellation Effective Date'
    INTO dbo.U_EBRSUSALFE_Header
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
ALTER VIEW dbo.dsi_vwEBRSUSALFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBRSUSALFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBRSUSALFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307071'
       ,expStartPerControl     = '202307071'
       ,expLastEndPerControl   = '202307149'
       ,expEndPerControl       = '202307149'
WHERE expFormatCode = 'EBRSUSALFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBRSUSALFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBRSUSALFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBRSUSALFE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBRSUSALFE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBRSUSALFE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBRSUSALFE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBRSUSALFE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBRSUSALFE', 'UseFileName', 'V', 'Y'


-- End ripout