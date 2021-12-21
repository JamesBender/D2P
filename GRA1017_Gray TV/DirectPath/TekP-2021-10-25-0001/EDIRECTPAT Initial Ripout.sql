/**********************************************************************************

EDIRECTPAT: Direct Path Census Export

FormatCode:     EDIRECTPAT
Project:        Direct Path Census Export
Client ID:      GRA1017
Date/time:      2021-12-18 10:33:25.710
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_GRYT
Web Filename:   GRA1017_6Q6LQ_EEHISTORY_EDIRECTPAT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
OEPath:        
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDIRECTPAT_SavePath') IS NOT NULL DROP TABLE dbo.U_EDIRECTPAT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDIRECTPAT'


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
WHERE FormatCode = 'EDIRECTPAT'
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
WHERE ExpFormatCode = 'EDIRECTPAT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDIRECTPAT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDIRECTPAT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDIRECTPAT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDIRECTPAT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDIRECTPAT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDIRECTPAT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDIRECTPAT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDIRECTPAT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDIRECTPAT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDIRECTPAT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDIRECTPAT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDIRECTPAT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDIRECTPAT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDIRECTPAT];
GO
IF OBJECT_ID('U_EDIRECTPAT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_PEarHist];
GO
IF OBJECT_ID('U_EDIRECTPAT_File') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_File];
GO
IF OBJECT_ID('U_EDIRECTPAT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_EEList];
GO
IF OBJECT_ID('U_EDIRECTPAT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_drvTbl];
GO
IF OBJECT_ID('U_EDIRECTPAT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_AuditFields];
GO
IF OBJECT_ID('U_EDIRECTPAT_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDIRECTPAT_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDIRECTPAT','Direct Path Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EDIRECTPATZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDIRECTPATZ0','50','H','01','1',NULL,'Client Code',NULL,NULL,'"Client Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDIRECTPATZ0','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDIRECTPATZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDIRECTPATZ0','50','H','01','4',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDIRECTPATZ0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDIRECTPATZ0','50','H','01','6',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDIRECTPATZ0','50','H','01','7',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDIRECTPATZ0','50','H','01','8',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDIRECTPATZ0','50','H','01','9',NULL,'Benefit Class',NULL,NULL,'"Benefit Class"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDIRECTPATZ0','50','H','01','10',NULL,'Location Name',NULL,NULL,'"Location Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDIRECTPATZ0','50','H','01','11',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDIRECTPATZ0','50','H','01','12',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDIRECTPATZ0','50','H','01','13',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDIRECTPATZ0','50','H','01','14',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDIRECTPATZ0','50','H','01','15',NULL,'ReHire Date',NULL,NULL,'"ReHire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDIRECTPATZ0','50','H','01','16',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDIRECTPATZ0','50','H','01','17',NULL,'Termination Reason',NULL,NULL,'"Termination Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDIRECTPATZ0','50','H','01','18',NULL,'Term Code',NULL,NULL,'"Term Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDIRECTPATZ0','50','H','01','19',NULL,'Status Change Date',NULL,NULL,'"Status Change Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDIRECTPATZ0','50','H','01','20',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDIRECTPATZ0','50','H','01','21',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDIRECTPATZ0','50','H','01','22',NULL,'Benefits Base Salary',NULL,NULL,'"Benefits Base Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDIRECTPATZ0','50','H','01','23',NULL,'Compensation Date',NULL,NULL,'"Compensation Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDIRECTPATZ0','50','H','01','24',NULL,'Pay Frequency',NULL,NULL,'"Pay Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDIRECTPATZ0','50','H','01','25',NULL,'Deduction Frequency',NULL,NULL,'"Deduction Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDIRECTPATZ0','50','H','01','26',NULL,'Work Hours Per Week',NULL,NULL,'"Work Hours Per Week"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDIRECTPATZ0','50','H','01','27',NULL,'Department Name',NULL,NULL,'"Department Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDIRECTPATZ0','50','H','01','28',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDIRECTPATZ0','50','H','01','29',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDIRECTPATZ0','50','H','01','30',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDIRECTPATZ0','50','H','01','31',NULL,'State Code',NULL,NULL,'"State Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDIRECTPATZ0','50','H','01','32',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDIRECTPATZ0','50','H','01','33',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDIRECTPATZ0','50','H','01','34',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDIRECTPATZ0','50','H','01','35',NULL,'Home Email',NULL,NULL,'"Home Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDIRECTPATZ0','50','H','01','36',NULL,'Other Email',NULL,NULL,'"Other Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDIRECTPATZ0','50','H','01','37',NULL,'Preferred Email Type',NULL,NULL,'"Preferred Email Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDIRECTPATZ0','50','H','01','38',NULL,'Tobacco User',NULL,NULL,'"Tobacco User"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDIRECTPATZ0','50','H','01','39',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDIRECTPATZ0','50','H','01','40',NULL,'Department Effective Date',NULL,NULL,'"Department Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDIRECTPATZ0','50','H','01','41',NULL,'Department 2 Code',NULL,NULL,'"Department 2 Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDIRECTPATZ0','50','H','01','42',NULL,'Department 3 Code',NULL,NULL,'"Department 3 Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDIRECTPATZ0','50','H','01','43',NULL,'Division Code',NULL,NULL,'"Division Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EDIRECTPATZ0','50','H','01','44',NULL,'Division Effective Date',NULL,NULL,'"Division Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EDIRECTPATZ0','50','H','01','45',NULL,'Region Code',NULL,NULL,'"Region Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EDIRECTPATZ0','50','H','01','46',NULL,'Region Effective Date',NULL,NULL,'"Region Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EDIRECTPATZ0','50','H','01','47',NULL,'Business Unit Code',NULL,NULL,'"Business Unit Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EDIRECTPATZ0','50','H','01','48',NULL,'Business Unit Effective Date',NULL,NULL,'"Business Unit Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EDIRECTPATZ0','50','H','01','49',NULL,'Employment Field 1',NULL,NULL,'"Employment Field 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EDIRECTPATZ0','50','H','01','50',NULL,'Employment Field 1 Effective Date',NULL,NULL,'"Employment Field 1 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EDIRECTPATZ0','50','H','01','51',NULL,'Employment Field 2',NULL,NULL,'"Employment Field 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EDIRECTPATZ0','50','H','01','52',NULL,'Employment Field 2 Effective Date',NULL,NULL,'"Employment Field 2 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EDIRECTPATZ0','50','H','01','53',NULL,'Employment Field 3',NULL,NULL,'"Employment Field 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EDIRECTPATZ0','50','H','01','54',NULL,'Employment Field 3 Effective Date',NULL,NULL,'"Employment Field 3 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EDIRECTPATZ0','50','H','01','55',NULL,'Employment Field 4',NULL,NULL,'"Employment Field 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EDIRECTPATZ0','50','H','01','56',NULL,'Employment Field 4 Effective Date',NULL,NULL,'"Employment Field 4 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EDIRECTPATZ0','50','H','01','57',NULL,'Employment Field 5',NULL,NULL,'"Employment Field 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EDIRECTPATZ0','50','H','01','58',NULL,'Employment Field 5 Effective Date',NULL,NULL,'"Employment Field 5 Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EDIRECTPATZ0','50','H','01','59',NULL,'FEIN',NULL,NULL,'"FEIN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EDIRECTPATZ0','50','H','01','60',NULL,'FEIN Effective Date',NULL,NULL,'"FEIN Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EDIRECTPATZ0','50','H','01','61',NULL,'Location Effective Date',NULL,NULL,'"Location Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EDIRECTPATZ0','50','H','01','62',NULL,'LOA Start Date',NULL,NULL,'"LOA Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EDIRECTPATZ0','50','H','01','63',NULL,'LOA End Date',NULL,NULL,'"LOA End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EDIRECTPATZ0','50','H','01','64',NULL,'LOA Status',NULL,NULL,'"LOA Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EDIRECTPATZ0','50','H','01','65',NULL,'Benefits Experience',NULL,NULL,'"Benefits Experience"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EDIRECTPATZ0','50','H','01','66',NULL,'Retiree Status',NULL,NULL,'"Retiree Status"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDIRECTPATZ0','50','D','10','1',NULL,'Client Code',NULL,NULL,'"GRAY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDIRECTPATZ0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDIRECTPATZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDIRECTPATZ0','50','D','10','4',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDIRECTPATZ0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDIRECTPATZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDIRECTPATZ0','50','D','10','7',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDIRECTPATZ0','50','D','10','8',NULL,'Employee Type',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDIRECTPATZ0','50','D','10','9',NULL,'Benefit Class',NULL,NULL,'"drvBenefitClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDIRECTPATZ0','50','D','10','10',NULL,'Location Name',NULL,NULL,'"drvLocationName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDIRECTPATZ0','50','D','10','11',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDIRECTPATZ0','50','D','10','12',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDIRECTPATZ0','50','D','10','13',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDIRECTPATZ0','50','D','10','14',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDIRECTPATZ0','50','D','10','15',NULL,'ReHire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDIRECTPATZ0','50','D','10','16',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDIRECTPATZ0','50','D','10','17',NULL,'Termination Reason',NULL,NULL,'"drvTerminationReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDIRECTPATZ0','50','D','10','18',NULL,'Term Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDIRECTPATZ0','50','D','10','19',NULL,'Status Change Date',NULL,NULL,'"drvStatusChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDIRECTPATZ0','50','D','10','20',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDIRECTPATZ0','50','D','10','21',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDIRECTPATZ0','50','D','10','22',NULL,'Benefits Base Salary',NULL,NULL,'"drvBenefitsBaseSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDIRECTPATZ0','50','D','10','23',NULL,'Compensation Date',NULL,NULL,'"drvCompensationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDIRECTPATZ0','50','D','10','24',NULL,'Pay Frequency',NULL,NULL,'"26"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDIRECTPATZ0','50','D','10','25',NULL,'Deduction Frequency',NULL,NULL,'"24"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDIRECTPATZ0','50','D','10','26',NULL,'Work Hours Per Week',NULL,NULL,'"drvWorkHrsPerWeek"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDIRECTPATZ0','50','D','10','27',NULL,'Department Name',NULL,NULL,'"drvDepartmentName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDIRECTPATZ0','50','D','10','28',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDIRECTPATZ0','50','D','10','29',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDIRECTPATZ0','50','D','10','30',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDIRECTPATZ0','50','D','10','31',NULL,'State Code',NULL,NULL,'"drvStateCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDIRECTPATZ0','50','D','10','32',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDIRECTPATZ0','50','D','10','33',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDIRECTPATZ0','50','D','10','34',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDIRECTPATZ0','50','D','10','35',NULL,'Home Email',NULL,NULL,'"drvHomeEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDIRECTPATZ0','50','D','10','36',NULL,'Other Email',NULL,NULL,'"drvOtherEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDIRECTPATZ0','50','D','10','37',NULL,'Preferred Email Type',NULL,NULL,'"Home"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDIRECTPATZ0','50','D','10','38',NULL,'Tobacco User',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDIRECTPATZ0','50','D','10','39',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDIRECTPATZ0','50','D','10','40',NULL,'Department Effective Date',NULL,NULL,'"drvDepartmentEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDIRECTPATZ0','50','D','10','41',NULL,'Department 2 Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDIRECTPATZ0','50','D','10','42',NULL,'Department 3 Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDIRECTPATZ0','50','D','10','43',NULL,'Division Code',NULL,NULL,'"drvDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EDIRECTPATZ0','50','D','10','44',NULL,'Division Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EDIRECTPATZ0','50','D','10','45',NULL,'Region Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EDIRECTPATZ0','50','D','10','46',NULL,'Region Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EDIRECTPATZ0','50','D','10','47',NULL,'Business Unit Code',NULL,NULL,'"GRAY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EDIRECTPATZ0','50','D','10','48',NULL,'Business Unit Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EDIRECTPATZ0','50','D','10','49',NULL,'Employment Field 1',NULL,NULL,'"drvEmploymentField1"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EDIRECTPATZ0','50','D','10','50',NULL,'Employment Field 1 Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EDIRECTPATZ0','50','D','10','51',NULL,'Employment Field 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EDIRECTPATZ0','50','D','10','52',NULL,'Employment Field 2 Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EDIRECTPATZ0','50','D','10','53',NULL,'Employment Field 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EDIRECTPATZ0','50','D','10','54',NULL,'Employment Field 3 Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EDIRECTPATZ0','50','D','10','55',NULL,'Employment Field 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EDIRECTPATZ0','50','D','10','56',NULL,'Employment Field 4 Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EDIRECTPATZ0','50','D','10','57',NULL,'Employment Field 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EDIRECTPATZ0','50','D','10','58',NULL,'Employment Field 5 Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EDIRECTPATZ0','50','D','10','59',NULL,'FEIN',NULL,NULL,'"drvFEIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EDIRECTPATZ0','50','D','10','60',NULL,'FEIN Effective Date',NULL,NULL,'"drvFEINeffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EDIRECTPATZ0','50','D','10','61',NULL,'Location Effective Date',NULL,NULL,'"drvLocationEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EDIRECTPATZ0','50','D','10','62',NULL,'LOA Start Date',NULL,NULL,'"drvLOAstartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EDIRECTPATZ0','50','D','10','63',NULL,'LOA End Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EDIRECTPATZ0','50','D','10','64',NULL,'LOA Status',NULL,NULL,'"drvLOAstatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EDIRECTPATZ0','50','D','10','65',NULL,'Benefits Experience',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EDIRECTPATZ0','50','D','10','66',NULL,'Retiree Status',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDIRECTPAT_20211218.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',RW4WR,S92SH,WSGTJ,S92PR,S92N5,K2WNB,14CGB',NULL,NULL,NULL,'Direct Path Census Export','202102249','EMPEXPORT','ONDEM_XOE','Oct 18 2021 12:00AM','EDIRECTPAT',NULL,NULL,NULL,'202102249','Feb 24 2021 12:00AM','Dec 30 1899 12:00AM','202102011',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'MBUTTIMER01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','RW4WR,S92VK,S92SH,S92PR,90P54,S92N5,K2WNB',NULL,NULL,NULL,'Direct Path Census Scheduled','202102239','EMPEXPORT','SCH_EDIREC',NULL,'EDIRECTPAT',NULL,NULL,NULL,'202112159','Jan 27 2020  6:01PM','Jan 27 2020  6:01PM','202112081',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Direct Path Census Test','202107079','EMPEXPORT','TEST_XOE','Jul  8 2021 12:00AM','EDIRECTPAT',NULL,NULL,NULL,'202107079','Jul  7 2021 12:00AM','Dec 30 1899 12:00AM','202106301',NULL,'','','202106301',dbo.fn_GetTimedKey(),NULL,'ULTI_GRYT',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','InitialSort','C','drvInitialSortLastName');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','OEPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','SubSort','C','drvSubSortFirstName');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDIRECTPAT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDIRECTPAT','D10','dbo.U_EDIRECTPAT_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EDIRECTPAT_Audit
-----------

IF OBJECT_ID('U_EDIRECTPAT_Audit') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_Audit] (
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
-- Create table U_EDIRECTPAT_AuditFields
-----------

IF OBJECT_ID('U_EDIRECTPAT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EDIRECTPAT_drvTbl
-----------

IF OBJECT_ID('U_EDIRECTPAT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSortLastName] varchar(100) NULL,
    [drvSubSortFirstName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvMiddleInitial] varchar(8000) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvEmployeeType] char(1) NULL,
    [drvBenefitClass] varchar(6) NOT NULL,
    [drvLocationName] varchar(10) NULL,
    [drvLocationCode] varchar(10) NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationReason] varchar(2) NULL,
    [drvStatusChangeDate] datetime NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvAnnualSalary] money NULL,
    [drvBenefitsBaseSalary] nvarchar(4000) NULL,
    [drvCompensationDate] nvarchar(4000) NULL,
    [drvWorkHrsPerWeek] nvarchar(4000) NULL,
    [drvDepartmentName] varchar(10) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvHomeEmail] varchar(8000) NULL,
    [drvOtherEmail] varchar(8000) NULL,
    [drvDepartmentCode] varchar(10) NULL,
    [drvDepartmentEffectiveDate] date NULL,
    [drvDivisionCode] char(5) NULL,
    [drvFEIN] varchar(10) NULL,
    [drvFEINeffectiveDate] datetime NULL,
    [drvLocationEffectiveDate] date NULL,
    [drvLOAstartDate] datetime NULL,
    [drvLOAstatus] varchar(2) NULL,
    [drvEmploymentField1] datetime NULL
);

-----------
-- Create table U_EDIRECTPAT_EEList
-----------

IF OBJECT_ID('U_EDIRECTPAT_EEList') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDIRECTPAT_File
-----------

IF OBJECT_ID('U_EDIRECTPAT_File') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EDIRECTPAT_PEarHist
-----------

IF OBJECT_ID('U_EDIRECTPAT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDIRECTPAT_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt] money NULL,
    [PehCurHrsLast2] decimal NULL,
    [PehCurAmtLast4] numeric NULL,
    [PehCurAmtLast8] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDIRECTPAT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gray Television, Inc.

Created By: Luis Gutierrez
Business Analyst: Lindsay Wright
Create Date: 01/27/2020
Service Request Number: SR-2019-00252112

Purpose: Direct Path Census Export

Revision History
----------------
Update By           Date           Request Num        Desc
NKowalchuk       03/05/2021        SF 20780739        Correct logic to send all active employees, regardless of YTD earnings
Rishabh Verma     06/10/2021        SR-2021-00314848   Added drvEmploymentField1 and Updated BenefitsClass
Rishabh Verma     07/27/2021        SR-2021-00317414   Updated the Termination Reason Field

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDIRECTPAT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDIRECTPAT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDIRECTPAT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDIRECTPAT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDIRECTPAT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDIRECTPAT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDIRECTPAT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDIRECTPAT', 'SCH_EDIREC';

--========= Ripout Script Version Updated Verison 7.2 from Base Version ================--

EXEC dbo._dsi_usp_ExportRipOut_v7 @FormatCode = 'EDIRECTPAT', @AllObjects = 'Y',@FilePath = '', @IsWeb = 'Y', @NewFormatCode = '' 
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
    SELECT @FormatCode = 'EDIRECTPAT';

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
    DELETE FROM dbo.U_EDIRECTPAT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDIRECTPAT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EDIRECTPAT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDIRECTPAT_AuditFields;
    CREATE TABLE dbo.U_EDIRECTPAT_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EDIRECTPAT_AuditFields VALUES ('EmpComp','EecDedGroupCode');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EDIRECTPAT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EDIRECTPAT_Audit;
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
    INTO dbo.U_EDIRECTPAT_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EDIRECTPAT_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDIRECTPAT_Audit ON dbo.U_EDIRECTPAT_Audit (audEEID,audKey2);

    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDIRECTPAT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDIRECTPAT_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCurAmt = SUM(PehCurAmt)
        ,PehCurHrsLast2 = SUM(CASE WHEN PrgPayDate BETWEEN DATEADD(DAY,-14,GETDATE()) AND GETDATE() THEN PehCurHrs END)
        ,PehCurAmtLast4 = SUM(CASE WHEN PrgPayDate BETWEEN DATEADD(DAY,-28,GETDATE()) AND GETDATE() THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtLast8 = SUM(CASE WHEN PrgPayDate BETWEEN DATEADD(DAY,-56,GETDATE()) AND GETDATE() THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_EDIRECTPAT_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    GROUP BY PehEEID;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDIRECTPAT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDIRECTPAT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDIRECTPAT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSortLastName = EepNameLast
        ,drvSubSortFirstName = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvSSN = EepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvFirstName = REPLACE(EepNameFirst,',','')
        ,drvLastName = REPLACE(EepNameLast,',','')
        ,drvMiddleInitial = REPLACE(LEFT(EepNameMiddle,1),',','')
        ,drvSuffix = EepNameSuffix
        ,drvEmployeeType = EecFullTimeOrPartTime
        ,drvBenefitClass = CASE EecDedGroupCode ---- BenefitClass Updated SR-2021-00314848
                                WHEN 'EXEC' THEN 'FTEXEX'
                                WHEN 'ALL' THEN 'FTALL'
                                WHEN 'KHNL' THEN
                                (CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'KHNL'
                                WHEN EecFullTimeOrPartTime = 'P' AND PehCurHrsLast2 > 40 THEN 'HACA' ELSE 'NBE' END )
                                ELSE 'NBE'
                            END
        ,drvLocationName = EecOrgLvl1
        ,drvLocationCode = EecOrgLvl1
        ,drvGender = EepGender
        ,drvBirthDate = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReason = CASE                                                            --Updated by Rishabh Verma SR-2021-00317414
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('N107','N115') THEN '1'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('V123','202') THEN '2'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('N105','203') THEN '4'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('N101','N102','N108') THEN '5'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I121' THEN '6'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I110' THEN '7'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'V112' THEN '9'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'V116' THEN '10'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('I106','I126','I127') THEN '12'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('V113', 'V118','V122') THEN '14'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I114' THEN '15'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'V111' THEN '17'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I119' THEN '18'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I117' THEN '19'
                                    WHEN EecEmplStatus = 'T' AND TchCode IN ('I104', 'N124') THEN '27'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'N125' THEN '28'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'V103' THEN '29'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'V120' THEN '30'
                                    WHEN EecEmplStatus = 'T' AND TchCode = 'I109' THEN '31'
                                END
        ,drvStatusChangeDate = (SELECT MAX(AudDateTime) FROM dbo.U_EDIRECTPAT_Audit WHERE AudEEID = xEEID AND AudFieldName = 'EecDedGroupCode') --Most recent effective date of audited EhcDedGroupCode record
        ,drvJobTitle = JbcDesc 
        ,drvAnnualSalary = CASE WHEN EecEEType IN ('CMD','CMS') THEN 
                                CASE
                                    WHEN YEAR(@EndDate) = '2020' AND ISNULL(EecUDField09,'') <> '' THEN EecUDField09
                                    --WHEN YEAR(@EndDate) = '2020' THEN EecUDField09
                                    WHEN priorYr.fitWages > EecAnnSalary THEN priorYr.fitWages
                                    ELSE EecAnnSalary
                                END
                                ELSE EecAnnSalary
                           END
        ,drvBenefitsBaseSalary = CASE WHEN LocAddressState IN ('HI', 'NY') THEN FORMAT(PehCurAmtLast8,'0.00') END
        ,drvCompensationDate = '1/1/' + FORMAT(@EndDate,'yyyy') --1/1/XXXX WHERE XXXX = current year
        ,drvWorkHrsPerWeek = FORMAT(EecScheduledWorkHrs,'0.00')
        ,drvDepartmentName = EecOrgLvl2 --(SELECT TOP 1 CodDesc FROM dbo.Codes WITH (NOLOCK) WHERE org2.OrgLvl = '2' AND CodCode = EecOrgLvl2) 
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',','')
        ,drvCity = EepAddressCity
        ,drvStateCode = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvHomeEmail = REPLACE(EepAddressEMail,',','')
        ,drvOtherEmail = REPLACE(EepAddressEMail,',','')
        ,drvDepartmentCode = EecOrgLvl2
        ,drvDepartmentEffectiveDate = (SELECT MAX(EffDate) FROM dbo.dsi_fnlib_JobHistoryTable3('EjhOrgLvl2') WHERE EEID = xEEID)--Most recent date of EecOrgLvl2 
        ,drvDivisionCode = CmpCompanyCode
        ,drvFEIN = LEFT(LTRIM(RTRIM(CmpFedTaxID)),2) + '-' + RIGHT(LTRIM(RTRIM(CmpFedTaxID)),7)
        ,drvFEINeffectiveDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire ELSE EecDateOfOriginalHire END
        ,drvLocationEffectiveDate = (SELECT MAX(EffDate) FROM dbo.dsi_fnlib_JobHistoryTable3('EjhOrgLvl1') WHERE EEID = xEEID)--Most recent date of EecOrgLvl1
        ,drvLOAstartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvLOAstatus = CASE WHEN EecEmplStatus = 'L' AND LchFMLAQualified = 'Y' THEN '01' END
        ,drvEmploymentField1 = pcf.Employment_AcquisitionDate   ------ Populated AcquisitionDate(PlatForm Configurable Field)- SR-2021-00314848
    INTO dbo.U_EDIRECTPAT_drvTbl
    FROM dbo.U_EDIRECTPAT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.LOAReasn WITH (NOLOCK)
        ON LchCode = EecLeaveReason
    LEFT JOIN dbo.U_EDIRECTPAT_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.vw_int_OrgLevel org2 WITH (NOLOCK)
        ON org2.OrgCode = EecOrgLvl2
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN (SELECT YesEEID, SUM(YesUSFITTaxableWages) fitWages
               FROM dbo.vw_int_YREESum WITH (NOLOCK)
               WHERE YesTaxYear = YEAR(@EndDate) - 1
               GROUP BY YesEEID) priorYr
        ON priorYr.YesEEID = xEEID
    LEFT JOIN [dbo].[fn_MP_CustomFields_EmpComp_Export] (NULL, NULL, NULL, NULL) pcf   --- Left Join to Populate the Acquisition Date SR-2021-00314848
        ON pcf.EecEEID = xEEID 
        AND pcf.EecCoID = xCoID 
    WHERE (EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T' AND TchCode <> 'N108' AND EecDateOfTermination >= DATEADD(DAY,-180,@StartDate)))
            AND CmpCompanyCode NOT IN ('GTG', 'TEST')
            --NK 03/05/2021 SF 20780739 AND PehEEID IS NOT NULL
            ;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'EDIRECTPAT_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEDIRECTPAT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDIRECTPAT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDIRECTPAT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009291'
       ,expStartPerControl     = '202009291'
       ,expLastEndPerControl   = '202009299'
       ,expEndPerControl       = '202009299'
WHERE expFormatCode = 'EDIRECTPAT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDIRECTPAT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDIRECTPAT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDIRECTPAT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDIRECTPAT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDIRECTPAT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDIRECTPAT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDIRECTPAT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDIRECTPAT', 'UseFileName', 'V', 'Y'


-- End ripout