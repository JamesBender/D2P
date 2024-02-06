/**********************************************************************************

EBENEXDEMO: Benefit Express Census Export

FormatCode:     EBENEXDEMO
Project:        Benefit Express Census Export
Client ID:      REF1001
Date/time:      2024-02-06 11:00:08.527
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
Web Filename:   REF1001_XAC7C_EEHISTORY_EBENEXDEMO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
UTF8Path:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBENEXDEMO_SavePath') IS NOT NULL DROP TABLE dbo.U_EBENEXDEMO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBENEXDEMO'


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
WHERE FormatCode = 'EBENEXDEMO'
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
WHERE ExpFormatCode = 'EBENEXDEMO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBENEXDEMO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBENEXDEMO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBENEXDEMO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBENEXDEMO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBENEXDEMO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBENEXDEMO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBENEXDEMO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBENEXDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBENEXDEMO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBENEXDEMO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBENEXDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBENEXDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENEXDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXDEMO];
GO
IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_PEarHist12Mth];
GO
IF OBJECT_ID('U_EBENEXDEMO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_PEarHist];
GO
IF OBJECT_ID('U_EBENEXDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_File];
GO
IF OBJECT_ID('U_EBENEXDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_EEList];
GO
IF OBJECT_ID('U_EBENEXDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_drvTbl];
GO
IF OBJECT_ID('U_EBENEXDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_AuditFields];
GO
IF OBJECT_ID('U_EBENEXDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBENEXDEMO','Benefit Express Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EBENEXDEMOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBENEXDEMOZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL,'"Social Security Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBENEXDEMOZ0','50','H','01','2',NULL,'Payroll Key',NULL,NULL,'"Payroll Key"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBENEXDEMOZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBENEXDEMOZ0','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBENEXDEMOZ0','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBENEXDEMOZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBENEXDEMOZ0','50','H','01','7',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBENEXDEMOZ0','50','H','01','8',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBENEXDEMOZ0','50','H','01','9',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBENEXDEMOZ0','50','H','01','10',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBENEXDEMOZ0','50','H','01','11',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBENEXDEMOZ0','50','H','01','12',NULL,'Work State',NULL,NULL,'"Work State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBENEXDEMOZ0','50','H','01','13',NULL,'Province',NULL,NULL,'"Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBENEXDEMOZ0','50','H','01','14',NULL,'Country Mailing Address',NULL,NULL,'"Country Mailing Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBENEXDEMOZ0','50','H','01','15',NULL,'Country of Citizenship',NULL,NULL,'"Country of Citizenship"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBENEXDEMOZ0','50','H','01','16',NULL,'Country of Employment',NULL,NULL,'"Country of Employment"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBENEXDEMOZ0','50','H','01','17',NULL,'Home Zip Code',NULL,NULL,'"Home Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBENEXDEMOZ0','50','H','01','18',NULL,'Work Zip Code',NULL,NULL,'"Work Zip Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBENEXDEMOZ0','50','H','01','19',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBENEXDEMOZ0','50','H','01','20',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBENEXDEMOZ0','50','H','01','21',NULL,'Home Email',NULL,NULL,'"Home Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBENEXDEMOZ0','50','H','01','22',NULL,'Work Email',NULL,NULL,'"Work Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBENEXDEMOZ0','50','H','01','23',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBENEXDEMOZ0','50','H','01','24',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBENEXDEMOZ0','50','H','01','25',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBENEXDEMOZ0','50','H','01','26',NULL,'Married to Another Employee',NULL,NULL,'"Married to Another Employee"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBENEXDEMOZ0','50','H','01','27',NULL,'Spouse SSN',NULL,NULL,'"Spouse SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBENEXDEMOZ0','50','H','01','28',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBENEXDEMOZ0','50','H','01','29',NULL,'Employment Status Date',NULL,NULL,'"Employment Status Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBENEXDEMOZ0','50','H','01','30',NULL,'Employment Status Change Reason',NULL,NULL,'"Employment Status Change Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBENEXDEMOZ0','50','H','01','31',NULL,'Date of Original Hire',NULL,NULL,'"Date of Original Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBENEXDEMOZ0','50','H','01','32',NULL,'Date of ReHire',NULL,NULL,'"Date of ReHire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBENEXDEMOZ0','50','H','01','33',NULL,'Date of Leave',NULL,NULL,'"Date of Leave"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBENEXDEMOZ0','50','H','01','34',NULL,'Date of Termination',NULL,NULL,'"Date of Termination"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBENEXDEMOZ0','50','H','01','35',NULL,'Termination Reason',NULL,NULL,'"Termination Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBENEXDEMOZ0','50','H','01','36',NULL,'Date of Retirement',NULL,NULL,'"Date of Retirement"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBENEXDEMOZ0','50','H','01','37',NULL,'Medicare Eligible Flag',NULL,NULL,'"Medicare Eligible Flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBENEXDEMOZ0','50','H','01','38',NULL,'Medicare Eligible Date',NULL,NULL,'"Medicare Eligible Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBENEXDEMOZ0','50','H','01','39',NULL,'Benefit Eligible Date',NULL,NULL,'"Benefit Eligible Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBENEXDEMOZ0','50','H','01','40',NULL,'Location ID Change Date',NULL,NULL,'"Location ID Change Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBENEXDEMOZ0','50','H','01','41',NULL,'Salary Change Date',NULL,NULL,'"Salary Change Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBENEXDEMOZ0','50','H','01','42',NULL,'User Date 4',NULL,NULL,'"User Date 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBENEXDEMOZ0','50','H','01','43',NULL,'User Date 5',NULL,NULL,'"User Date 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBENEXDEMOZ0','50','H','01','44',NULL,'EIN',NULL,NULL,'"EIN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBENEXDEMOZ0','50','H','01','45',NULL,'Company Code',NULL,NULL,'"Company Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBENEXDEMOZ0','50','H','01','46',NULL,'Department Code',NULL,NULL,'"Department Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBENEXDEMOZ0','50','H','01','47',NULL,'Branch Code',NULL,NULL,'"Branch Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBENEXDEMOZ0','50','H','01','48',NULL,'Division Code',NULL,NULL,'"Division Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBENEXDEMOZ0','50','H','01','49',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBENEXDEMOZ0','50','H','01','50',NULL,'Position Code',NULL,NULL,'"Position Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBENEXDEMOZ0','50','H','01','51',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBENEXDEMOZ0','50','H','01','52',NULL,'Org Level 1',NULL,NULL,'"Org Level 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBENEXDEMOZ0','50','H','01','53',NULL,'Direct Bill Flag',NULL,NULL,'"Direct Bill Flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBENEXDEMOZ0','50','H','01','54',NULL,'Company Code',NULL,NULL,'"Org Level 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBENEXDEMOZ0','50','H','01','55',NULL,'Department Code',NULL,NULL,'"Org Level 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBENEXDEMOZ0','50','H','01','56',NULL,'Org Level 5',NULL,NULL,'"Org Level 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBENEXDEMOZ0','50','H','01','57',NULL,'Work Basis',NULL,NULL,'"Work Basis"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBENEXDEMOZ0','50','H','01','58',NULL,'Hourly Salaried',NULL,NULL,'"Hourly Salaried"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBENEXDEMOZ0','50','H','01','59',NULL,'Exempt Flag',NULL,NULL,'"Exempt Flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBENEXDEMOZ0','50','H','01','60',NULL,'Union Flag',NULL,NULL,'"Union Flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBENEXDEMOZ0','50','H','01','61',NULL,'Union Local Number',NULL,NULL,'"Union Local Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBENEXDEMOZ0','50','H','01','62',NULL,'Scheduled Hours',NULL,NULL,'"Scheduled Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBENEXDEMOZ0','50','H','01','63',NULL,'Pay Periods Per Annum',NULL,NULL,'"Pay Periods Per Annum"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBENEXDEMOZ0','50','H','01','64',NULL,'Flex Pay Periods',NULL,NULL,'"Flex Pay Periods"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBENEXDEMOZ0','50','H','01','65',NULL,'Payroll Schedule',NULL,NULL,'"Payroll Schedule"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBENEXDEMOZ0','50','H','01','66',NULL,'Pay Rate',NULL,NULL,'"Pay Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBENEXDEMOZ0','50','H','01','67',NULL,'Pay Rate Frequency',NULL,NULL,'"Pay Rate Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBENEXDEMOZ0','50','H','01','68',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBENEXDEMOZ0','50','H','01','69',NULL,'Frozen Salary',NULL,NULL,'"Frozen Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBENEXDEMOZ0','50','H','01','70',NULL,'January1Earnings',NULL,NULL,'"January1Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBENEXDEMOZ0','50','H','01','71',NULL,'Money Field 1',NULL,NULL,'"Money Field 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBENEXDEMOZ0','50','H','01','72',NULL,'Money Field 2',NULL,NULL,'"Money Field 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBENEXDEMOZ0','50','H','01','73',NULL,'Money Field 3',NULL,NULL,'"Money Field 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBENEXDEMOZ0','50','H','01','74',NULL,'Money Field 4',NULL,NULL,'"Money Field 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBENEXDEMOZ0','50','H','01','75',NULL,'Money Field 5',NULL,NULL,'"Money Field 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBENEXDEMOZ0','50','H','01','76',NULL,'Workers Compensation Group',NULL,NULL,'"Workers Compensation Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBENEXDEMOZ0','50','H','01','77',NULL,'Numeric 1',NULL,NULL,'"Numeric 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBENEXDEMOZ0','50','H','01','78',NULL,'Numeric 2',NULL,NULL,'"Numeric 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBENEXDEMOZ0','50','H','01','79',NULL,'Numeric 3',NULL,NULL,'"Numeric 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBENEXDEMOZ0','50','H','01','80',NULL,'Numeric 4',NULL,NULL,'"Numeric 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBENEXDEMOZ0','50','H','01','81',NULL,'Numeric 5',NULL,NULL,'"Numeric 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBENEXDEMOZ0','50','H','01','82',NULL,'NVarChar 1',NULL,NULL,'"NVarChar 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBENEXDEMOZ0','50','H','01','83',NULL,'NVarChar 2',NULL,NULL,'"NVarChar 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBENEXDEMOZ0','50','H','01','84',NULL,'NVarChar 3',NULL,NULL,'"NVarChar 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBENEXDEMOZ0','50','H','01','85',NULL,'NVarChar 4',NULL,NULL,'"NVarChar 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBENEXDEMOZ0','50','H','01','86',NULL,'NVarChar 5',NULL,NULL,'"NVarChar 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBENEXDEMOZ0','50','H','01','87',NULL,'Language Preference',NULL,NULL,'"Language Preference"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBENEXDEMOZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBENEXDEMOZ0','50','D','10','2',NULL,'Payroll Key',NULL,NULL,'"drvPayrollKey"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBENEXDEMOZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBENEXDEMOZ0','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBENEXDEMOZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBENEXDEMOZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBENEXDEMOZ0','50','D','10','7',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBENEXDEMOZ0','50','D','10','8',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBENEXDEMOZ0','50','D','10','9',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBENEXDEMOZ0','50','D','10','10',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBENEXDEMOZ0','50','D','10','11',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBENEXDEMOZ0','50','D','10','12',NULL,'Work State',NULL,NULL,'"drvWorkState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBENEXDEMOZ0','50','D','10','13',NULL,'Province',NULL,NULL,'"drvProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBENEXDEMOZ0','50','D','10','14',NULL,'Country Mailing Address',NULL,NULL,'"drvCountryMailingAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBENEXDEMOZ0','50','D','10','15',NULL,'Country of Citizenship',NULL,NULL,'"drvCountryofCitizenship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBENEXDEMOZ0','50','D','10','16',NULL,'Country of Employment',NULL,NULL,'"drvCountryofEmployment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBENEXDEMOZ0','50','D','10','17',NULL,'Home Zip Code',NULL,NULL,'"drvHomeZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBENEXDEMOZ0','50','D','10','18',NULL,'Work Zip Code',NULL,NULL,'"drvWorkZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBENEXDEMOZ0','50','D','10','19',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBENEXDEMOZ0','50','D','10','20',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBENEXDEMOZ0','50','D','10','21',NULL,'Home Email',NULL,NULL,'"drvHomeEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBENEXDEMOZ0','50','D','10','22',NULL,'Work Email',NULL,NULL,'"drvWorkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBENEXDEMOZ0','50','D','10','23',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBENEXDEMOZ0','50','D','10','24',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBENEXDEMOZ0','50','D','10','25',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBENEXDEMOZ0','50','D','10','26',NULL,'Married to Another Employee',NULL,NULL,'"drvMarriedtoAnotherEmployee"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBENEXDEMOZ0','50','D','10','27',NULL,'Spouse SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBENEXDEMOZ0','50','D','10','28',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBENEXDEMOZ0','50','D','10','29',NULL,'Employment Status Date',NULL,NULL,'"drvEmploymentStatusDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBENEXDEMOZ0','50','D','10','30',NULL,'Employment Status Change Reason',NULL,NULL,'"drvEmpStatusChangeReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBENEXDEMOZ0','50','D','10','31',NULL,'Date of Original Hire',NULL,NULL,'"drvDateofOriginalHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBENEXDEMOZ0','50','D','10','32',NULL,'Date of ReHire',NULL,NULL,'"drvDateofReHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBENEXDEMOZ0','50','D','10','33',NULL,'Date of Leave',NULL,NULL,'"drvDateofLeave"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBENEXDEMOZ0','50','D','10','34',NULL,'Date of Termination',NULL,NULL,'"drvDateofTermination"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBENEXDEMOZ0','50','D','10','35',NULL,'Termination Reason',NULL,NULL,'"drvTerminationReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBENEXDEMOZ0','50','D','10','36',NULL,'Date of Retirement',NULL,NULL,'"drvDateofRetirement"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBENEXDEMOZ0','50','D','10','37',NULL,'Medicare Eligible Flag',NULL,NULL,'"drvMedicareEligibleFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBENEXDEMOZ0','50','D','10','38',NULL,'Medicare Eligible Date',NULL,NULL,'"drvMedicareEligibleDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBENEXDEMOZ0','50','D','10','39',NULL,'Benefit Eligible Date',NULL,NULL,'"drvBenefitEligibleDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBENEXDEMOZ0','50','D','10','40',NULL,'Location ID Change Date',NULL,NULL,'"drvLocationIDChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBENEXDEMOZ0','50','D','10','41',NULL,'Salary Change Date',NULL,NULL,'"drvSalaryChangeDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBENEXDEMOZ0','50','D','10','42',NULL,'User Date 4',NULL,NULL,'"drvUserDate4"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EBENEXDEMOZ0','50','D','10','43',NULL,'User Date 5',NULL,NULL,'"drvUserDate5"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EBENEXDEMOZ0','50','D','10','44',NULL,'EIN',NULL,NULL,'"drvEIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EBENEXDEMOZ0','50','D','10','45',NULL,'Company Code',NULL,NULL,'"drvCompanyCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EBENEXDEMOZ0','50','D','10','46',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EBENEXDEMOZ0','50','D','10','47',NULL,'Branch Code',NULL,NULL,'"drvBranchCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EBENEXDEMOZ0','50','D','10','48',NULL,'Division Code',NULL,NULL,'"drvDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EBENEXDEMOZ0','50','D','10','49',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EBENEXDEMOZ0','50','D','10','50',NULL,'Position Code',NULL,NULL,'"drvPositionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EBENEXDEMOZ0','50','D','10','51',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EBENEXDEMOZ0','50','D','10','52',NULL,'Org Level 1',NULL,NULL,'"drvOrgLevel1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EBENEXDEMOZ0','50','D','10','53',NULL,'Direct Bill Flag',NULL,NULL,'"drvDirectBillFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EBENEXDEMOZ0','50','D','10','54',NULL,'Company Code',NULL,NULL,'"drvCompanyCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EBENEXDEMOZ0','50','D','10','55',NULL,'Department Code',NULL,NULL,'"drvDepartmentCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EBENEXDEMOZ0','50','D','10','56',NULL,'Org Level 5',NULL,NULL,'"drvOrgLevel5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EBENEXDEMOZ0','50','D','10','57',NULL,'Work Basis',NULL,NULL,'"drvWorkBasis"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EBENEXDEMOZ0','50','D','10','58',NULL,'Hourly Salaried',NULL,NULL,'"drvHourlySalaried"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EBENEXDEMOZ0','50','D','10','59',NULL,'Exempt Flag',NULL,NULL,'"drvExemptFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EBENEXDEMOZ0','50','D','10','60',NULL,'Union Flag',NULL,NULL,'"drvUnionFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EBENEXDEMOZ0','50','D','10','61',NULL,'Union Local Number',NULL,NULL,'"drvUnionLocalNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EBENEXDEMOZ0','50','D','10','62',NULL,'Scheduled Hours',NULL,NULL,'"drvScheduledHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EBENEXDEMOZ0','50','D','10','63',NULL,'Pay Periods Per Annum',NULL,NULL,'"drvPayPeriodsPerAnnum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EBENEXDEMOZ0','50','D','10','64',NULL,'Flex Pay Periods',NULL,NULL,'"drvFlexPayPeriods"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EBENEXDEMOZ0','50','D','10','65',NULL,'Payroll Schedule',NULL,NULL,'"drvPayrollSchedule"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EBENEXDEMOZ0','50','D','10','66',NULL,'Pay Rate',NULL,NULL,'"drvPayRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EBENEXDEMOZ0','50','D','10','67',NULL,'Pay Rate Frequency',NULL,NULL,'"drvPayRateFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EBENEXDEMOZ0','50','D','10','68',NULL,'Annual Salary',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EBENEXDEMOZ0','50','D','10','69',NULL,'Frozen Salary',NULL,NULL,'"drvFrozenSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EBENEXDEMOZ0','50','D','10','70',NULL,'January1Earnings',NULL,NULL,'"drvJanuary1Earnings"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EBENEXDEMOZ0','50','D','10','71',NULL,'Money Field 1',NULL,NULL,'"drvMoneyField1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EBENEXDEMOZ0','50','D','10','72',NULL,'Money Field 2',NULL,NULL,'"drvMoneyField2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EBENEXDEMOZ0','50','D','10','73',NULL,'Money Field 3',NULL,NULL,'"drvMoneyField3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EBENEXDEMOZ0','50','D','10','74',NULL,'Money Field 4',NULL,NULL,'"drvMoneyField4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EBENEXDEMOZ0','50','D','10','75',NULL,'Money Field 5',NULL,NULL,'"drvMoneyField5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EBENEXDEMOZ0','50','D','10','76',NULL,'Workers Compensation Group',NULL,NULL,'"drvWorkersCompensationGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EBENEXDEMOZ0','50','D','10','77',NULL,'Numeric 1',NULL,NULL,'"drvNumeric1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EBENEXDEMOZ0','50','D','10','78',NULL,'Numeric 2',NULL,NULL,'"drvNumeric2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EBENEXDEMOZ0','50','D','10','79',NULL,'Numeric 3',NULL,NULL,'"drvNumeric3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EBENEXDEMOZ0','50','D','10','80',NULL,'Numeric 4',NULL,NULL,'"drvNumeric4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EBENEXDEMOZ0','50','D','10','81',NULL,'Numeric 5',NULL,NULL,'"drvNumeric5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EBENEXDEMOZ0','50','D','10','82',NULL,'NVarChar 1',NULL,NULL,'"drvNVarChar1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EBENEXDEMOZ0','50','D','10','83',NULL,'NVarChar 2',NULL,NULL,'"drvNVarChar2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EBENEXDEMOZ0','50','D','10','84',NULL,'NVarChar 3',NULL,NULL,'"drvNVarChar3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EBENEXDEMOZ0','50','D','10','85',NULL,'NVarChar 4',NULL,NULL,'"drvNVarChar4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EBENEXDEMOZ0','50','D','10','86',NULL,'NVarChar 5',NULL,NULL,'"drvNVarChar5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EBENEXDEMOZ0','50','D','10','87',NULL,'Language Preference',NULL,NULL,'"drvLanguagePreference"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBENEXDEMO_20240206.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census-Wed 6am','202108119','EMPEXPORT','ONDEM_XOE','Aug 12 2021  5:54AM','EBENEXDEMO',NULL,NULL,NULL,'202401319','Aug 11 2021 12:00AM','Dec 30 1899 12:00AM','202401241','4203','','','202108041',dbo.fn_GetTimedKey(),NULL,'JBENDER10',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census-Mon 6am','202103059','EMPEXPORT','SCH_EBENEX','Aug 12 2021  5:55AM','EBENEXDEMO',NULL,NULL,NULL,'202402059','Mar  5 2021  7:49AM','Mar  5 2021  7:49AM','202401291','4175','','','202103051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census E-Test','202208169','EMPEXPORT','TEST_XOE','Aug 16 2022 12:14PM','EBENEXDEMO',NULL,NULL,NULL,'202208169','Aug 16 2022 12:00AM','Dec 30 1899 12:00AM','202208021','5361','','','202208021',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','IsUTF8','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','UseFileName','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','UTF8Path','V',NULL);

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXDEMO','D10','dbo.U_EBENEXDEMO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBENEXDEMO_Audit
-----------

IF OBJECT_ID('U_EBENEXDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_Audit] (
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
    [audEmpStatusStartChanged] varchar(1) NOT NULL,
    [audLocationChanged] varchar(1) NOT NULL,
    [audjobReason100] varchar(1) NOT NULL
);

-----------
-- Create table U_EBENEXDEMO_AuditFields
-----------

IF OBJECT_ID('U_EBENEXDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBENEXDEMO_drvTbl
-----------

IF OBJECT_ID('U_EBENEXDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvPayrollKey] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvCountryMailingAddress] varchar(3) NOT NULL,
    [drvCountryofCitizenship] varchar(1) NOT NULL,
    [drvCountryofEmployment] varchar(1) NOT NULL,
    [drvHomeZipCode] varchar(50) NULL,
    [drvWorkZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvHomeEmail] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvMarriedtoAnotherEmployee] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(8) NOT NULL,
    [drvEmploymentStatusDate] datetime NULL,
    [drvEmpStatusChangeReason] char(6) NULL,
    [drvDateofOriginalHire] datetime NULL,
    [drvDateofReHire] datetime NULL,
    [drvDateofLeave] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvTerminationReason] varchar(25) NULL,
    [drvDateofRetirement] datetime NULL,
    [drvMedicareEligibleFlag] varchar(1) NOT NULL,
    [drvMedicareEligibleDate] varchar(1) NOT NULL,
    [drvBenefitEligibleDate] varchar(1) NOT NULL,
    [drvLocationIDChangeDate] datetime NULL,
    [drvSalaryChangeDate] datetime NULL,
    [drvUserDate4] datetime NULL,
    [drvUserDate5] datetime NULL,
    [drvEIN] char(9) NULL,
    [drvCompanyCode1] varchar(1) NOT NULL,
    [drvDepartmentCode1] varchar(1) NOT NULL,
    [drvBranchCode] varchar(1) NOT NULL,
    [drvDivisionCode] varchar(1) NOT NULL,
    [drvLocationCode] varchar(6) NULL,
    [drvPositionCode] char(3) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvOrgLevel1] varchar(1) NOT NULL,
    [drvDirectBillFlag] varchar(1) NOT NULL,
    [drvCompanyCode2] char(5) NULL,
    [drvDepartmentCode2] varchar(8000) NULL,
    [drvOrgLevel5] varchar(50) NULL,
    [drvWorkBasis] char(1) NULL,
    [drvHourlySalaried] char(1) NULL,
    [drvExemptFlag] varchar(1) NOT NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvUnionLocalNumber] varchar(12) NULL,
    [drvScheduledHours] varchar(30) NULL,
    [drvPayPeriodsPerAnnum] varchar(2) NULL,
    [drvFlexPayPeriods] varchar(2) NULL,
    [drvPayrollSchedule] char(6) NULL,
    [drvPayRate] varchar(30) NULL,
    [drvPayRateFrequency] char(1) NULL,
    [drvAnnualSalary] varchar(30) NULL,
    [drvFrozenSalary] varchar(1) NOT NULL,
    [drvJanuary1Earnings] varchar(1) NOT NULL,
    [drvMoneyField1] varchar(1) NOT NULL,
    [drvMoneyField2] varchar(1) NOT NULL,
    [drvMoneyField3] varchar(1) NOT NULL,
    [drvMoneyField4] varchar(1) NOT NULL,
    [drvMoneyField5] varchar(1) NOT NULL,
    [drvWorkersCompensationGroup] varchar(1) NOT NULL,
    [drvNumeric1] varchar(30) NULL,
    [drvNumeric2] varchar(1) NOT NULL,
    [drvNumeric3] varchar(1) NOT NULL,
    [drvNumeric4] varchar(1) NOT NULL,
    [drvNumeric5] varchar(1) NOT NULL,
    [drvNVarChar1] varchar(201) NULL,
    [drvNVarChar2] char(9) NULL,
    [drvNVarChar3] varchar(201) NULL,
    [drvNVarChar4] char(9) NULL,
    [drvNVarChar5] varchar(1) NOT NULL,
    [drvLanguagePreference] varchar(1) NOT NULL
);

-----------
-- Create table U_EBENEXDEMO_EEList
-----------

IF OBJECT_ID('U_EBENEXDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBENEXDEMO_File
-----------

IF OBJECT_ID('U_EBENEXDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EBENEXDEMO_PEarHist
-----------

IF OBJECT_ID('U_EBENEXDEMO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_PEarHist] (
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

-----------
-- Create table U_EBENEXDEMO_PEarHist12Mth
-----------

IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_PEarHist12Mth] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurHrsMiscErn] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 03/05/2021
Service Request Number: TekP-2021-02-02-0001

Purpose: Benefit Express Census Export

Revision History
----------------
Update By           Date           Request Num            Desc
TekPartners         12/16/2021                            Corrected Numeric1 field back to send actual hours
Darren Collard      08/08/2022     TekP-2022-08-01-01    Prevent filtering if no supervisor
Darren Collard      08/08/2022     TekP-2022-08-01-01    Update logic for Salary Change Date
LeaK                01/08/2024        TekP-2023-09-18-01    Updated emp status and emp status date fields

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENEXDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENEXDEMO' ORDER BY RunID DESC;

\\us.saas\E4\Public\REF1001\Exports\Test\

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'SCH_EBENEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBENEXDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@StartYearPerControl VARCHAR(9) 
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EBENEXDEMO';

    SELECT @StartYearPerControl = CONCAT(YEAR(GETDATE()), '01','011')

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBENEXDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENEXDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- delete SSN that start with 999
    DELETE FROM dbo.U_EBENEXDEMO_EEList WHERE xEEID IN (SELECT Eepeeid FROM dbo.emppers WITH (NOLOCK) WHERE Eepssn like ('999%'))


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBENEXDEMO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_AuditFields;
    CREATE TABLE dbo.U_EBENEXDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecEmplstatus');
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecLocation');
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecEmplStatusStartDate')
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecJobChangeReason')
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecAnnSalary')

    ;

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBENEXDEMO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_Audit;
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
        ,audEmpStatusStartChanged = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatusStartDate' AND audNewValue is not null  THEN 'Y' ELSE 'N' END
        ,audLocationChanged = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecLocation' AND audNewValue is not null  THEN 'Y' ELSE 'N' END
        ,audjobReason100 = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecJobChangeReason' AND audNewValue ='100'  THEN 'Y' ELSE 'N' END
        --,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

    INTO dbo.U_EBENEXDEMO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBENEXDEMO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(D, -60, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBENEXDEMO_Audit ON dbo.U_EBENEXDEMO_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EBENEXDEMO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBENEXDEMO_Audit WHERE audEEID = xEEID AND audRowNo = 1);


-----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBENEXDEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EBENEXDEMO_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarncode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl between @StartYearPerControl and  @EndPerControl 
    and PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    -----------------------------
    -- Working Table - PEarHist12Mth
    -----------------------------
    IF OBJECT_ID('U_EBENACAEXP_PEarHist_52_P','U') IS NOT NULL
        DROP TABLE dbo.U_EBENACAEXP_PEarHist_52_P;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate         = MAX(PrgPayDate)
        ,PehCurHrsMiscErn   = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol and PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  --SUM(CASE WHEN PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  
    INTO dbo.U_EBENACAEXP_PEarHist_52_P
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    
    -- IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth','U') IS NOT NULL
 --       DROP TABLE dbo.U_EBENEXDEMO_PEarHist12Mth;
 --   SELECT DISTINCT
 --        PehEEID
 --       ,PrgPayDate             = MAX(PrgPayDate)
    --    ,PehCurHrsMiscErn        = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol and PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  --SUM(CASE WHEN PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)     
 --   INTO dbo.U_EBENEXDEMO_PEarHist12Mth
 --   FROM dbo.vw_int_PayReg WITH (NOLOCK)
 --   JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
 --       ON PehGenNumber = PrgGenNumber
    --JOIN dbo.EarnCode WITH (NOLOCK)
    --    ON PehEarnCode = ErnEarncode
 --   WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
 --   AND PehPerControl between CONCAT((CONVERT(VARCHAR, DATEADD(M, -12,@EndDate), 112)),'1') and  @EndPerControl 
 --   --AND PehPerControl between @StartYearPerControl and  @EndPerControl 
 --   and PehPerControl <= @EndPerControl
 --   GROUP BY PehEEID
 --   HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENEXDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENEXDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSocialSecurityNumber = EMPP.EepSSN
        ,drvPayrollKey = EMPC.Eecempno
        ,drvEmployeeID = EMPC.EecEmpNo
        --,drvLastName = (SELECT CONVERT(nvarchar, EepNameLast) COLLATE SQL_Latin1_General_Cp1251_CS_AS  from Emppers where eepeeid = xEEID) --CONVERT(varchar, EMPP.EepNameLast) COLLATE SQL_Latin1_General_Cp1251_CS_AS 
        --,drvFirstName =  (SELECT CONVERT(nvarchar, EepNameFirst) COLLATE SQL_Latin1_General_Cp1251_CS_AS from Emppers where eepeeid = xEEID)--CONVERT(varchar, EMPP.EepNameFirst) COLLATE SQL_Latin1_General_Cp1251_CS_AS

        ,drvLastName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EMPP.EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u') --CONVERT(NVARCHAR,EMPP.EepNameLast)
        ,drvFirstName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EMPP.EepNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u') --CONVERT(NVARCHAR,EMPP.EepNameFirst)

        --,drvLastName = CONVERT(nvarchar, EMPP.EepNameLast) COLLATE SQL_Latin1_General_Cp1_CS_AS 
        --,drvFirstName =  CONVERT(nvarchar, EMPP.EepNameFirst) COLLATE SQL_Latin1_General_Cp1_CS_AS


        ,drvMiddleName = EMPP.EepNameMiddle
        ,drvSuffix = EMPP.EepNameSuffix
        ,drvAddress1 = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressLine1)
        ,drvAddress2 = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressLine2)
        ,drvCity = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressCity) 
        ,drvState = EMPP.EepAddressState
        ,drvWorkState = LocAddressState
        ,drvProvince = '' -- leave blank
        ,drvCountryMailingAddress = 'USA'
        ,drvCountryofCitizenship = '' -- leave blank
        ,drvCountryofEmployment = '' -- leave blank
        ,drvHomeZipCode = EMPP.EepAddressZipCode
        ,drvWorkZipCode = LocAddresszipcode
        ,drvHomePhone = EMPP.EepPhoneHomeNumber
        ,drvWorkPhone = EMPC.EecPhoneBusinessNumber
        ,drvHomeEmail = EMPP.EepAddressEMailAlternate
        ,drvWorkEmail = CASE WHEN EMPP.EepAddressEMail = ''  or EMPP.EepAddressEmail is null THEN EMPP.EepAddressEMailAlternate ELSE EMPP.EepAddressEMail END
        ,drvGender = EMPP.EepGender
        ,drvBirthDate = EMPP.EepDateOfBirth
        ,drvMaritalStatus = CASE EMPP.EepMaritalStatus WHEN 'Z' THEN '' ELSE EMPP.EepMaritalStatus END
        ,drvMarriedtoAnotherEmployee = '' --leave blank
        ,drvSpouseSSN = '' --leave blank
        ,drvEmploymentStatus = CASE WHEN EMPC.EecEmplStatus = 'L' THEN 'LEAVE' 
                                    --WHEN EMPC.EecEmplStatus = 'T' and eectermreason = '202' THEN 'RETIREE'
                                    WHEN EMPC.EecEmplStatus = 'T' and EMPC.eectermreason = '203' THEN 'DECEASED'
                                    WHEN EMPC.EecEmplStatus = 'T'and EMPC.eectermreason not in ('203') THEN 'TERM'
                                ELSE 'ACTIVE'
                               END
        ,drvEmploymentStatusDate = CASE 
                                        WHEN EMPC.Eecemplstatus = 'T' THEN EMPC.Eecdateoftermination
                                        --WHEN EMPC.Eecemplstatus = 'L' THEN EMPC.EecEmplStatusStartDate
                                        WHEN audStat.audEmpStatusStartChanged = 'Y' THEN EMPC.EecEmplStatusStartDate 
                                        ELSE EjhJobEffDate                                         
                                    END
        ,drvEmpStatusChangeReason = CASE WHEN EMPC.EecEmplstatus = 'L' THEN EMPC.EecLeaveReason END
        ,drvDateofOriginalHire = EMPC.EecDateOfOriginalHire


        ,drvDateofReHire = CASE WHEN audJob.audjobReason100 = 'Y' AND Employee_DateOfAcquisition IS NOT NULL AND Employee_DateOfAcquisition BETWEEN @StartDate AND @EndDate THEN EMPC.EecDateOfLastHire ELSE EMPC.EecDateOfBenefitSeniority END
        
        
        ,drvDateofLeave = CASE WHEN EMPC.Eecemplstatus = 'L' THEN EMPC.EecEmplStatusStartDate ELSE NULL END
        ,drvDateofTermination = CASE WHEN EMPC.EecEmplStatus = 'T' THEN EMPC.EecDateOfTermination ELSE NULL END
        ,drvTerminationReason = CASE WHEN EMPC.EecEmplStatus = 'T' THEN TchDesc END
        ,drvDateofRetirement = CASE WHEN  EMPC.Eecemplstatus = 'T' and EMPC.Eectermreason = '202' THEN EMPC.Eecdateoftermination ELSE NULL END
        ,drvMedicareEligibleFlag = '' -- leave blank
        ,drvMedicareEligibleDate = '' -- leave blank
        ,drvBenefitEligibleDate = '' -- leave blank
        ,drvLocationIDChangeDate = CASE WHEN audLoc.audLocationChanged = 'Y' THEN audLoc.audDateTime ELSE NULL END --Most recent audit date of eeclocation
        ,drvSalaryChangeDate =  [dbo].[dsi_fnGetMinMaxDates]('MAX',[dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate](xEEID, xCOID, GETDATE(), EMPC.EecDateOfLastHire), EMPC.EecDateOfLastHire)
                            --[dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate](xEEID, xCOID, @StartDate, EMPC.EecDateOfLastHire)
                                --dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EMPC.EecEEID, EMPC.EecCOID, GETDATE(),EecDateOfLastHire)  
                                --, CONVERT(DATETIME,CONCAT(YEAR(GETDATE()), '-01','-01')))  
                                --CONVERT(DATETIME,CONCAT(YEAR(GETDATE()), '-01','-01')) 
        ,drvUserDate4 = Employee_DateOfTempToHire
        ,drvUserDate5 = Employee_DateOfAcquisition
        ,drvEIN = CmpFedTaxID
        ,drvCompanyCode1 = '' -- leave blank --CmpCompanyName
        ,drvDepartmentCode1 = '' -- leave blank
        ,drvBranchCode = '' -- leave blank
        ,drvDivisionCode = '' -- leave blank
        ,drvLocationCode = CASE WHEN LEFT(EMPC.Eeclocation,2) = 'HB' THEN 'HB' else  EMPC.Eeclocation END
        ,drvPositionCode = EMPC.EecEEType
        ,drvJobTitle =  dbo.fn_AddDoubleQuotes(JbcDesc)
        ,drvOrgLevel1 = '' --leave blank
        ,drvDirectBillFlag = '' -- leave blank
        ,drvCompanyCode2 = CmpCompanyCode
        ,drvDepartmentCode2 =  dbo.fn_AddDoubleQuotes(OrgDesc)
        ,drvOrgLevel5 = NciEmailAddress 
                            --(SELECT top 1 EepAddressEmail from dbo.empcomp WITH (NOLOCK)
       --                         JOIN dbo.Emppers WITH (NOLOCK) on eeceeid = eepeeid
       --                         JOIN dbo.Codes WITH (NOLOCK)
       --                             ON EecLocation = CodCode
       --                             AND codtable = 'CO_HRMANAGERBYLOCATI'
       --                             AND CodDesc = EecEmpNo WHERE eecLocation = EMPC.EecLocation) 
                                    --SUPP.EepAddressEMail --dbo.dsi_fnlib_GetSupervisorField(EMPC.EecCoid, EMPC.EecEEID, 'AddressEMail')   --eepaddressemail from EecSupervisorID
        ,drvWorkBasis = EMPC.EecFullTimeOrPartTime
        ,drvHourlySalaried = EMPC.EecSalaryOrHourly
        ,drvExemptFlag = '' -- Leave blank
        ,drvUnionFlag = '' -- leave blank
        ,drvUnionLocalNumber = CASE WHEN EMPC.EecUnionLocal IN ('N','') THEN 'N' ELSE EMPC.EecUnionLocal END
        ,drvScheduledHours = CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),EMPC.EecScheduledWorkHrs))
        ,drvPayPeriodsPerAnnum = CASE EMPC.EecPayPeriod WHEN 'W' THEN '52' WHEN 'B' THEN '26' END
        ,drvFlexPayPeriods = CASE EMPC.EecPayPeriod WHEN 'W' THEN '52' WHEN 'B' THEN '26' END
        ,drvPayrollSchedule = EMPC.EecPaygroup
        ,drvPayRate = CONVERT(VARCHAR,convert(money,EMPC.EecHourlyPayRate))
        ,drvPayRateFrequency = EMPC.EecPayPeriod
        ,drvAnnualSalary = CONVERT(VARCHAR, CONVERT(MONEY,EMPC.Eecannsalary))
        ,drvFrozenSalary = '' -- leave blank
        ,drvJanuary1Earnings = '' -- leave blank
        ,drvMoneyField1 = '' -- leave blank
        ,drvMoneyField2 = '' -- leave blank
        ,drvMoneyField3 = '' -- leave blank
        ,drvMoneyField4 = '' -- leave blank
        ,drvMoneyField5 = '' -- leave blank
        ,drvWorkersCompensationGroup = '' -- leave blank
        ,drvNumeric1 = CASE WHEN (
                                    Employee_DateOfTempToHire IS NOT NULL 
                                    AND DATEADD(M, -12, Employee_DateOfTempToHire) < DATEADD(M, -12, GETDATE())
                                ) 
                            OR (
                                    Employee_DateOfAcquisition IS NOT NULL 
                                    AND (
                                            (
                                                Employee_DateOfAcquisition > GETDATE()
                                            )
                                        OR    (
                                                Employment_DecemberHoursWorked is not NULL 
                                                AND DATEADD(M, -12, Employee_DateOfAcquisition) < DATEADD(M, -12, GETDATE())
                                            )
                                        )
                                ) 
                            THEN CONVERT(VARCHAR, CONVERT(MONEY, ISNULL(PehCurHrsMiscErn, 0.00)) + CONVERT(MONEY,ISNULL(Employment_DecemberHoursWorked, 0.00)))   -- '1' 
                            WHEN Employee_DateOfTempToHire IS NULL or Employee_DateOfAcquisition is NULL THEN CONVERT(VARCHAR,(CONVERT(MONEY, ISNULL(PehCurHrsMiscErn, 0.00)))) 
                            ELSE CONVERT(VARCHAR,(CONVERT(MONEY, ISNULL(PehCurHrsMiscErn, 0.00)))) --'2'
                       END
                       --ISNULL(CAST(CONVERT(INT,PehCurHrsYTD) as VARCHAR(7)),'0') 
                       --(SELECT top 1 efoPhoneNumber from EmpMPhon where efoEEID =xEEID and efoPhoneType = 'CEL') --if efoPhoneType is CEL, send efoPhoneNumber from table EmpMPhon
        ,drvNumeric2 = '' -- leave blank
        ,drvNumeric3 = '' -- leave blank
        ,drvNumeric4 = '' -- leave blank
        ,drvNumeric5 = '' -- leave blank
        ,drvNVarChar1 =    NciNameFirst + ' ' + NciNameLast
        ,drvNVarChar2 = NciEmpNo  
        ,drvNVarChar3 = NcaNameFirst + ' ' + NcaNameLast 
        ,drvNVarChar4 = NcaEmpNo 
        ,drvNVarChar5 = '' /*(SELECT top 1 eepAddressEmail from dbo.empcomp WITH (NOLOCK)
                                JOIN dbo.Emppers WITH (NOLOCK) on eeceeid = eepeeid
                                JOIN dbo.Codes WITH (NOLOCK)
                                    ON EecLocation = CodCode
                                    AND codtable = 'CO_HRASSISTANTBYLOCA'
                                    AND CodDesc = EecEmpNo WHERE eecLocation = EMPC.EecLocation) --SUPP.EepAddressEMail --EepEmailAddress where EecSupervisorID = EecEEID where CodDesc FROM dbo.Codes = EecEmpNo AND codCode FROM dbo.Codes = EecLocation where codTable = 'CO_HRMANAGERBYLOCATI' see coding used in export EMSHEDEMXP*/
        ,drvLanguagePreference = '' -- leave blank
    INTO dbo.U_EBENEXDEMO_drvTbl
    FROM dbo.U_EBENEXDEMO_EEList WITH (NOLOCK)
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID 
    --    AND EecCoID = xCoID
    JOIN dbo.vw_int_EmpComp EMPC WITH (NOLOCK)
        ON EMPC.EecEEID = xEEID 
        AND EMPC.EecCoID = xCoID and EecEEtype <> 'TES'
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers EMPP WITH (NOLOCK)
        ON EMPP.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EMPC.EecJobCode
    JOIN dbo.Location WITH (NOLOCK) 
        on LocCode = EMPC.EecLocation and LocAddressCountry <> 'CAN' 
    LEFT JOIN dbo.TrmReasn with (nolock)
        on tchCode = EMPC.EecTermReason
    --JOIN dbo.vw_int_EmpComp SUPC WITH (NOLOCK)
    --    ON SUPC.EecEEID = EMPC.EecSupervisorId
    --    AND SUPC.EecCOID = xCOID
    LEFT JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.EepEEID = EMPC.EecSupervisorId
    LEFT JOIN dbo.Codes WITH (NOLOCK)
        ON EMPC.EecLocation = CodCode
        AND codtable IN ('CO_HRMANAGERBYLOCATI', 'CO_HRASSISTANTBYLOCA')
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audStat with (nolock)
        ON audeeid = xEEID and audKey2 = xCOID and  audEmpStatusStartChanged = 'Y' and audStat.audRowNo = 1
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audLoc with (nolock)
        ON audLoc.audeeid = xEEID and audLoc.audKey2 = xCOID and  audLoc.audLocationChanged = 'Y' and audLoc.audRowNo = 1
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audJob with (nolock)
        ON audJob.audeeid = xEEID and audJob.audKey2 = xCOID and  audJob.audjobReason100 = 'Y' and audJob.audRowNo = 1
    LEFT JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EMPC.EecOrgLvl1 and OrgLvl = 1
    LEFT JOIN dbo.fn_MP_CustomFields_EmpPers_Export (NULL,NULL,NULL,NULL) pcfEmppers
        ON pcfEmppers.EEID = xEEID
    LEFT JOIN dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL) pcfEmpComp
        ON pcfEmpComp.EecEEID = xEEID    and pcfEmpComp.EecCOID = xCOID
    LEFT JOIN dbo.U_EBENACAEXP_PEarHist_52_P WITH (NOLOCK)
        ON pehEEID = xEEID
    LEFT JOIN (
                SELECT EepNameLast AS NciNameLast, EepNameFirst AS NciNameFirst, EecEmpNo AS NciEmpNo, EepAddressEmail AS NciEmailAddress, CodCode AS NciLocationCode 
                FROM dbo.EmpComp WITH (NOLOCK)    
                    JOIN dbo.EmpPers WITH (NOLOCK)
                        ON EecEEID = EepEEID        
                    JOIN dbo.Codes WITH (NOLOCK)
                        ON CodDesc = EecEmpNo
                WHERE CodTable = 'CO_HRMANAGERBYLOCATI') AS HRI
                        ON NciLocationCode = EMPC.EecLocation

    LEFT JOIN (
                SELECT EepNameLast AS NcaNameLast, EepNameFirst AS NcaNameFirst, EecEmpNo AS NcaEmpNo, CodCode AS NcaLocationCode 
                FROM dbo.EmpComp WITH (NOLOCK)    
                    JOIN dbo.EmpPers WITH (NOLOCK)
                        ON EecEEID = EepEEID        
                    JOIN dbo.Codes WITH (NOLOCK)
                        ON CodDesc = EecEmpNo
                WHERE CodTable = 'CO_HRASSISTANTBYLOCA') AS HRA
                        ON NcaLocationCode = EMPC.EecLocation
    --AND CodCode = 'DPOC' -- replace with rows EecLoaction
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID,EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON EjhEEID = EecEEID
                            --AND EjhJObEffDate = EecDateOfLastHire
                         
                        ) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID        
        AND EjhCOID = xCOID


     WHERE 
           EMPC.EecEmplStatus in ('A', 'L','S')  
           OR EMPC.EecEmplStatus in ('T') and EMPC.EecTermReason <> 'TRO' AND EMPC.EecDateOfTermination between (DATEADD( D,-60, @enddate)) and @enddate
           
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.REFRESCO.OG.CEN.csv '
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '.REFRESCO.OG.CEN.csv '
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBENEXDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENEXDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENEXDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202208011'
       ,expLastEndPerControl   = '202208089'
       ,expEndPerControl       = '202208089'
       ,expCOIDList            = 'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX'
       ,expAscFileName         = CONCAT('\\us.saas\E4\Public\REF1001\Exports\BenefitExpress\'
                                 ,RTRIM(expFormatCode),'_',RTRIM(expExportCode),'_',REPLACE(REPLACE(REPLACE(CONVERT(varchar(100), GETDATE(), 120),':',''),'-',''),' ','_'),'.txt')
WHERE expFormatCode = 'EBENEXDEMO'
and ExpExportCode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBENEXDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBENEXDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBENEXDEMO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBENEXDEMO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBENEXDEMO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBENEXDEMO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBENEXDEMO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBENEXDEMO', 'UseFileName', 'V', 'Y'


-- End ripout