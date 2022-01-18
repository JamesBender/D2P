/**********************************************************************************

EWECIRDEM: Web Benefits Demo Export

FormatCode:     EWECIRDEM
Project:        Web Benefits Demo Export
Client ID:      CIR1001
Date/time:      2022-01-18 16:50:58.430
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N12
Server:         N1SUP2DB54
Database:       ULTIPRO_CIRCO
Web Filename:   CIR1001_00142_EEHISTORY_EWECIRDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWECIRDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_EWECIRDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWECIRDEM'


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
WHERE FormatCode = 'EWECIRDEM'
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
WHERE ExpFormatCode = 'EWECIRDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWECIRDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWECIRDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWECIRDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWECIRDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWECIRDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWECIRDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWECIRDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWECIRDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWECIRDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWECIRDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWECIRDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWECIRDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWECIRDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWECIRDEM];
GO
IF OBJECT_ID('U_EWECIRDEM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWECIRDEM_PEarHist];
GO
IF OBJECT_ID('U_EWECIRDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EWECIRDEM_File];
GO
IF OBJECT_ID('U_EWECIRDEM_EmpUnion') IS NOT NULL DROP TABLE [dbo].[U_EWECIRDEM_EmpUnion];
GO
IF OBJECT_ID('U_EWECIRDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWECIRDEM_EEList];
GO
IF OBJECT_ID('U_EWECIRDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWECIRDEM_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWECIRDEM','Web Benefits Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EWECIRDEM0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWECIRDEM0Z0','50','H','01','1',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWECIRDEM0Z0','50','H','01','2',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWECIRDEM0Z0','50','H','01','3',NULL,'Case ID',NULL,NULL,'"Case ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWECIRDEM0Z0','50','H','01','4',NULL,'Individual Payroll',NULL,NULL,'"Individual Payroll"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWECIRDEM0Z0','50','H','01','5',NULL,'Eligibility Status',NULL,NULL,'"Eligibility Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWECIRDEM0Z0','50','H','01','6',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWECIRDEM0Z0','50','H','01','7',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWECIRDEM0Z0','50','H','01','8',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWECIRDEM0Z0','50','H','01','9',NULL,'MI',NULL,NULL,'"MI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWECIRDEM0Z0','50','H','01','10',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWECIRDEM0Z0','50','H','01','11',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWECIRDEM0Z0','50','H','01','12',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWECIRDEM0Z0','50','H','01','13',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWECIRDEM0Z0','50','H','01','14',NULL,'Address2',NULL,NULL,'"Address2 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWECIRDEM0Z0','50','H','01','15',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWECIRDEM0Z0','50','H','01','16',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWECIRDEM0Z0','50','H','01','17',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWECIRDEM0Z0','50','H','01','18',NULL,'Work Phone',NULL,NULL,'"Work Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWECIRDEM0Z0','50','H','01','19',NULL,'Mobile Phone',NULL,NULL,'"Mobile Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWECIRDEM0Z0','50','H','01','20',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWECIRDEM0Z0','50','H','01','21',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWECIRDEM0Z0','50','H','01','22',NULL,'Alt Email',NULL,NULL,'"per_emailalt"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWECIRDEM0Z0','50','H','01','23',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWECIRDEM0Z0','50','H','01','24',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWECIRDEM0Z0','50','H','01','25',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWECIRDEM0Z0','50','H','01','26',NULL,'Benefit Seniority Date',NULL,NULL,'"Benefits Seniority Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWECIRDEM0Z0','50','H','01','27',NULL,'ACA Employment Classification',NULL,NULL,'"ACA Employment Classification"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWECIRDEM0Z0','50','H','01','28',NULL,'Salary Grade',NULL,NULL,'"Job Level"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EWECIRDEM0Z0','50','H','01','29',NULL,'HR Representative',NULL,NULL,'"HR Representative"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EWECIRDEM0Z0','50','H','01','30',NULL,'HR Representative ID',NULL,NULL,'"HR Representative ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EWECIRDEM0Z0','50','H','01','31',NULL,'Company Name',NULL,NULL,'"Company Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EWECIRDEM0Z0','50','H','01','32',NULL,'Paygroup',NULL,NULL,'"Paygroup"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EWECIRDEM0Z0','50','H','01','33',NULL,'Union',NULL,NULL,'"Union"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EWECIRDEM0Z0','50','H','01','34',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EWECIRDEM0Z0','50','H','01','35',NULL,'Dept',NULL,NULL,'"Department"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EWECIRDEM0Z0','50','H','01','36',NULL,'Worksite',NULL,NULL,'"Worksite"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EWECIRDEM0Z0','50','H','01','37',NULL,'Manager',NULL,NULL,'"Manager"','(''DA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWECIRDEM0Z0','50','H','01','38',NULL,'Manager ID',NULL,NULL,'"Manager ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWECIRDEM0Z0','50','H','01','38',NULL,'Ethnicity',NULL,NULL,'"Ethnicity"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EWECIRDEM0Z0','50','H','01','39',NULL,'Salary or Hourly',NULL,NULL,'"Hourly/Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EWECIRDEM0Z0','50','H','01','40',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EWECIRDEM0Z0','50','H','01','41',NULL,'Termination Reason',NULL,NULL,'"Termination Reason"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWECIRDEM0Z0','50','D','10','1',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWECIRDEM0Z0','50','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmpId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWECIRDEM0Z0','50','D','10','3',NULL,'Case ID',NULL,NULL,'"drvCaseId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWECIRDEM0Z0','50','D','10','4',NULL,'Individual Payroll',NULL,NULL,'"drvIndPayroll"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWECIRDEM0Z0','50','D','10','5',NULL,'Eligibility Status',NULL,NULL,'"drvEligStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWECIRDEM0Z0','50','D','10','6',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWECIRDEM0Z0','50','D','10','7',NULL,'First Name',NULL,NULL,'"drvFName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWECIRDEM0Z0','50','D','10','8',NULL,'Last Name',NULL,NULL,'"drvLName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWECIRDEM0Z0','50','D','10','9',NULL,'MI',NULL,NULL,'"drvMI"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWECIRDEM0Z0','54','D','10','10',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWECIRDEM0Z0','50','D','10','11',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWECIRDEM0Z0','50','D','10','12',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWECIRDEM0Z0','50','D','10','13',NULL,'Address',NULL,NULL,'"drvAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWECIRDEM0Z0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWECIRDEM0Z0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWECIRDEM0Z0','50','D','10','16',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWECIRDEM0Z0','50','D','10','17',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWECIRDEM0Z0','53','D','10','18',NULL,'Work Phone',NULL,NULL,'"drvWorkPh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWECIRDEM0Z0','51','D','10','19',NULL,'Mobile Phone',NULL,NULL,'"drvMobilePh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWECIRDEM0Z0','50','D','10','20',NULL,'Home Phone',NULL,NULL,'"drvHomePh"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWECIRDEM0Z0','52','D','10','21',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWECIRDEM0Z0','54','D','10','22',NULL,'Alt Email',NULL,NULL,'"drvAltEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWECIRDEM0Z0','54','D','10','23',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWECIRDEM0Z0','54','D','10','24',NULL,'Date of Hire',NULL,NULL,'"drvDOH"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWECIRDEM0Z0','54','D','10','25',NULL,'Original Hire Date',NULL,NULL,'"drvOrigHireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWECIRDEM0Z0','54','D','10','26',NULL,'Benefit Seniority Date',NULL,NULL,'"drvBenSenDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWECIRDEM0Z0','54','D','10','27',NULL,'ACA Employment Classification',NULL,NULL,'"drvACAEmpClass"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWECIRDEM0Z0','54','D','10','28',NULL,'Salary Grade',NULL,NULL,'"drvSalaryGrade"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EWECIRDEM0Z0','54','D','10','29',NULL,'HR Representative',NULL,NULL,'"drvHRRep"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EWECIRDEM0Z0','54','D','10','30',NULL,'HR Representative ID',NULL,NULL,'"drvHRRepID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EWECIRDEM0Z0','54','D','10','31',NULL,'Company Name',NULL,NULL,'"drvCompName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EWECIRDEM0Z0','54','D','10','32',NULL,'Pay Group Code',NULL,NULL,'"drvPayGroupCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EWECIRDEM0Z0','54','D','10','33',NULL,'Union',NULL,NULL,'"drvUnion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EWECIRDEM0Z0','54','D','10','34',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EWECIRDEM0Z0','54','D','10','35',NULL,'Dept',NULL,NULL,'"drvDept"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EWECIRDEM0Z0','54','D','10','36',NULL,'Work Site',NULL,NULL,'"drvWorkSite"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EWECIRDEM0Z0','54','D','10','37',NULL,'Manager',NULL,NULL,'"drvManager"','(''UA''=''T,'')');
--INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWECIRDEM0Z0','54','D','10','38',NULL,'Manager ID',NULL,NULL,'"drvManagerId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWECIRDEM0Z0','54','D','10','38',NULL,'Ethnicity',NULL,NULL,'"drvEthnicity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EWECIRDEM0Z0','54','D','10','39',NULL,'Salary Or Hourly',NULL,NULL,'"drvSalaryOrHourly"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EWECIRDEM0Z0','54','D','10','40',NULL,'Termination Date',NULL,NULL,'"drvTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EWECIRDEM0Z0','54','D','10','41',NULL,'Termination Reason',NULL,NULL,'"drvTermReason"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWECIRDEM_20220118.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Web Benefits Demo Export','202110089','EMPEXPORT','ONDEM_XOE',NULL,'EWECIRDEM',NULL,NULL,NULL,'202110089','Oct  8 2021  5:28PM','Oct  8 2021  5:28PM','202110081',NULL,'','','202110081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','MMJ37,MVE4T,Y4YH6,MVFPD,0LS4D,0LS19,0LRVT,0LSBZ,0LS7T,HV5X7,MVG8K,HVF94,MVGCA,MMJVT,0LSFJ,MVEZ4,MVGGU,HVEXF,MVG1H',NULL,NULL,NULL,'Web Benefits Demo - Thur 1pm','202110089','EMPEXPORT','SCH_EWECI2',NULL,'EWECIRDEM',NULL,NULL,NULL,'202201139','Oct  8 2021  5:28PM','Oct  8 2021  5:28PM','202201061',NULL,'','','202110081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','MMJ37,MVE4T,Y4YH6,MVFPD,0LS4D,0LS19,0LRVT,0LSBZ,0LS7T,HV5X7,MVG8K,HVF94,MVGCA,MMJVT,0LSFJ,MVEZ4,MVGGU,HVEXF,MVG1H',NULL,NULL,NULL,'Web Benefits Demo - Tues 1pm','202110089','EMPEXPORT','SCH_EWECIR',NULL,'EWECIRDEM',NULL,NULL,NULL,'202201189','Oct  8 2021  5:28PM','Oct  8 2021  5:28PM','202201111',NULL,'','','202110081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','NZ7MV,MMJ37,MVE4T,Y4YH6,MVFPD,0LS4D,0LS19,0LRVT,0LSBZ,0LS7T,HV5X7,MVG8K,HVF94,MVGCA,MMJVT,0LSFJ,MVEZ4,MVGGU,HVEXF,MVG1H',NULL,NULL,NULL,'Web Benefits Demo Export-Test','202201189','EMPEXPORT','TEST_XOE','Jan 18 2022  3:59PM','EWECIRDEM',NULL,NULL,NULL,'202201189','Jan 18 2022 12:00AM','Dec 30 1899 12:00AM','202201041','1296','','','202201041',dbo.fn_GetTimedKey(),NULL,'us3lKiCIR1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWECIRDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWECIRDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWECIRDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWECIRDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWECIRDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWECIRDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWECIRDEM','D10','dbo.U_EWECIRDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EWECIRDEM_drvTbl
-----------

IF OBJECT_ID('U_EWECIRDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWECIRDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvCaseId] varchar(2) NULL,
    [drvIndPayroll] varchar(9) NULL,
    [drvEligStatus] varchar(10) NOT NULL,
    [drvDOB] datetime NULL,
    [drvFName] varchar(100) NULL,
    [drvLName] varchar(100) NULL,
    [drvMI] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(2) NULL,
    [drvAddress] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(5) NULL,
    [drvHomePh] varchar(50) NULL,
    [drvMobilePh] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvWorkPh] varchar(50) NULL,
    [drvSalary] varchar(30) NULL,
    [drvDOH] datetime NULL,
    [drvACAEmpClass] varchar(10) NOT NULL,
    [drvTermDate] varchar(30) NOT NULL,
    [drvTermReason] varchar(24) NULL,
    [drvAltEmail] varchar(50) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvDept] varchar(38) NULL,
    [drvManager] varchar(201) NULL,
    [drvHRRep] varchar(201) NULL,
    [drvHRRepID] char(9) NULL,
    [drvCompName] varchar(8000) NULL,
    [drvSalaryGrade] varchar(21) NULL,
    [drvWorkSite] varchar(25) NULL,
    [drvBenSenDate] varchar(30) NOT NULL,
   -- [drvManagerId] char(12) NULL,
    [drvOrigHireDate] varchar(30) NOT NULL,
    [drvSuffix] varchar(30) NULL,
    [drvUnion] char(15) NULL,
    [drvEthnicity] varchar(45) NULL,
    [drvPayGroupCode] varchar(8000) NULL,
    [drvSalaryOrHourly] char(1) NULL
);

-----------
-- Create table U_EWECIRDEM_EEList
-----------

IF OBJECT_ID('U_EWECIRDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EWECIRDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWECIRDEM_EmpUnion
-----------

IF OBJECT_ID('U_EWECIRDEM_EmpUnion') IS NULL
CREATE TABLE [dbo].[U_EWECIRDEM_EmpUnion] (
    [TABLE] varchar(6) NOT NULL,
    [unioncode] char(12) NOT NULL,
    [unishortdesc] char(15) NULL,
    [unilongdesc] varchar(80) NULL
);

-----------
-- Create table U_EWECIRDEM_File
-----------

IF OBJECT_ID('U_EWECIRDEM_File') IS NULL
CREATE TABLE [dbo].[U_EWECIRDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EWECIRDEM_PEarHist
-----------

IF OBJECT_ID('U_EWECIRDEM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWECIRDEM_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PgrPayFrequency] char(1) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWECIRDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Circor International

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/08/2021
Service Request Number: TekP-2021-08-24-0002

Purpose: Web Benefits Demo Export

Revision History
----------------
10/20/2021 by AP:
    - Wrapped SSN, Company Name, Job Title in quotes.
    - Removed commas from address1 and address2.
    - Updated department, hr rep, salary grade and work site output.
    - Benefit seniority date and manager id fields added.
    - Cleaned up logic for Case ID and Eligibility status.

11/02/2021 by AP:
    - Fixed duplicate SSN issue (problem with orgs not filtering on orglevel number).
    - Set zip to first 5 digits.
    - Termination reason updated with new values.
    - Manager and Manager ID issue fixed (sometimes manager is not in the same company id as employee).
    - Removed commas from company name.
    - HR Rep updated.
    - Manager name formatting updated.
    - Added original hire date to output and fixed missing header values.
    - 90 day terms removed from file.
    - Case ID updated.
    - Only REG or INC employees.

11/10/2021 by AP:
    - Renamed a few header columns.
    - Adjusted logic for ACA Employment Classification and Termination Reason.
    - Added 5 new fields at end of file (fields 37-41).

11/23/2021 by AP:
    - Added paygroup code + '-' + pay group description.
    - Fixed WHERE clause logic of driver table.
    - Fixed eligibility status.

12/01/2021 by AP:
    - Updated employment classification logic.
    - Updated worksite field.
    - Job level logic might need to revisited as some employees are showing with BLANK EjhSalaryGrade.

12/08/2021 by AP:
    - Set email field to eepaddressemailalternate.
    - Set per_emailalt to eepaddressemail.
    - Changed Work Site to Worksite for header.
    - Updated Union field logic.
    - Changed Pay Group to Paygroup for header.
    - Removed middle initial for manager.

12/13/2021 by AP:
    - Added new scheduled session SCH_EWCI2.

01/05/2021 by AP:
    - Removed the use of the PEarnHist table which was dropping some employees.
    - Fixed the mobile phone field.
    - Changed column order by request.

01/17/2022 by AP:
    - Updated salary logic.
    - Updated HR rep logic.
    - Added HR rep id logic.
    - Updated manager id.
    - Added EecTermReason = 202 logic to termination reason.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWECIRDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWECIRDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWECIRDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'SCH_EWECIR';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWECIRDEM', 'SCH_EWECI2';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWECIRDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWECIRDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWECIRDEM';

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
    DELETE FROM dbo.U_EWECIRDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWECIRDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EWECIRDEM_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EWECIRDEM_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EWECIRDEM_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EWECIRDEM_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EWECIRDEM_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_EWECIRDEM_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_EWECIRDEM_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    IF OBJECT_ID('U_EWECIRDEM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWECIRDEM_PEarHist;
    SELECT DISTINCT
         PehEEID
      --  ,PehCOID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PgrPayFrequency        = MAX(PgrPayFrequency)
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
    INTO dbo.U_EWECIRDEM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID--, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;

    ---- Employee Union Table Creation ----
     IF OBJECT_ID('U_EWECIRDEM_EmpUnion','U') IS NOT NULL
     DROP TABLE dbo.U_EWECIRDEM_EmpUnion;

    select 'UNIONS' as 'TABLE',
    unicode AS unioncode, unishortdesc, unilongdesc 
    into dbo.U_EWECIRDEM_EmpUnion
    from LabUnion

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWECIRDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWECIRDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWECIRDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = pers.EepSSN
        ,drvEmpId = Ec.EecEmpNo
        ,drvCaseId = CASE WHEN Ec.EecDedGroupCode = 'CORC2' THEN '06'
                            WHEN Ec.EecDedGroupCode = 'CORE2' THEN '05'
                            WHEN Ec.EecEEType = 'INC' OR Ec.EecFullTimeOrPartTime = 'P' THEN '07'
                            WHEN Ec.EecPayGroup IN ('CIR20', 'CIR25') THEN '04'
                            WHEN EjhSalaryGrade IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState = 'CA' THEN '08'
                            WHEN EjhSalaryGrade IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState <> 'CA' THEN '02'
                            WHEN EjhSalaryGrade NOT IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState = 'CA' THEN '01'
                            WHEN EjhSalaryGrade NOT IN ('L1', 'L2', 'L3', 'P1') AND pers.EepAddressState <> 'CA' THEN '03'
                             END
        --Ec.EecDedGroupCode
        ,drvIndPayroll = CASE WHEN Ec.EecPayPeriod = 'B' THEN 'Bi-Weekly'
                                WHEN Ec.EecPayPeriod = 'M' THEN 'Monthly'
                                WHEN Ec.EecPayPeriod = 'W' THEN 'Weekly' END 
        --CASE WHEN PgrPayFrequency = 'B' THEN 'Bi-Weekly'
  --                              WHEN PgrPayFrequency = 'M' THEN 'Monthly'
  --                              WHEN PgrPayFrequency = 'W' THEN 'Weekly' END
        ,drvEligStatus = CASE WHEN Ec.EecEmplStatus = 'T' THEN 'Inactive'
                                WHEN Ec.EecFullTimeOrPartTime = 'P' THEN 'Ineligible'
                                WHEN Ec.EecDedGroupCode IN ('NONE', 'NOELI') THEN 'Ineligible'
                                WHEN Ec.EecEEType IN ('CTP', 'INC') AND pers.EepAddressCountry = 'USA' THEN 'Ineligible'
                                ELSE 'Active' END
        ,drvDOB = pers.EepDateOfBirth
        ,drvFName = pers.EepNameFirst
        ,drvLName = pers.EepNameLast
        ,drvMI = pers.EepNameMiddle
        ,drvGender = pers.EepGender
        ,drvMaritalStatus = CASE WHEN pers.EepMaritalStatus = 'C' THEN 'DP'
                                    WHEN pers.EepMaritalStatus = 'Z' THEN ''
                                    ELSE pers.EepMaritalStatus END 
        ,drvAddress = REPLACE(pers.EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(pers.EepAddressLine2, ',', '')
        ,drvCity = pers.EepAddressCity
        ,drvState = pers.EepAddressState
        ,drvZip = LEFT(pers.EepAddressZipCode, 5)
        ,drvHomePh = pers.EepPhoneHomeNumber
        ,drvMobilePh = EfoPhoneNumber
        ,drvEmail = pers.EepAddressEmailAlternate
        ,drvWorkPh = Ec.EecPhoneBusinessNumber
        ,drvSalary = CAST(CAST(CASE WHEN EjhOtherRate3 <> '' THEN (EjhOtherRate3 * 2080) --+ Ec.EecAnnSalary
                            ELSE Ec.EecAnnSalary END AS DECIMAL(11,2)) AS VARCHAR)
        ,drvDOH = Ec.EecDateOfLastHire
        ,drvACAEmpClass = CASE WHEN Ec.EecEEType = 'R' THEN 'Retiree'
                                WHEN Ec.EecDedGroupCode IN ('NONE', 'NOELI') THEN 'Ineligible'
                                WHEN Ec.EecEEType IN ('CTP', 'INC') AND pers.EepAddressCountry = 'USA' THEN 'Ineligible'
                                WHEN Ec.EecFullTimeOrPartTime = 'P' THEN 'Ineligible'
                                ELSE 'Full-Time' END
        ,drvTermDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN Ec.EecEmplStatus = 'T' THEN Ec.EecDateOfTermination END), 101), '')
        ,drvTermReason = CASE WHEN Ec.EecEmplStatus = 'T' THEN 
                            CASE WHEN Ec.EecTermReason = '203' THEN 'Death of Employee'
                                    WHEN EjhReason = '401' AND Ec.EecDateOfTermination BETWEEN @StartDate AND @EndDate THEN 'Reduction in Hours'
                                    WHEN Ec.EecTermReason <> '203' AND Ec.EecTermType = 'I' THEN 'Termination: Involuntary'
									WHEN Ec.EecTermReason = '202' THEN 'Retirement' ELSE '' END
                                    WHEN Ec.EecTermType = 'V' THEN 'Termination: Voluntary' 
                                    WHEN Ec.EecTermType IN ('I', 'N') THEN 'Termination: Involuntary'
                                END
        ,drvAltEmail = pers.EepAddressEmail
        ,drvJobTitle = JbcDesc
        ,drvDept = LTRIM(RTRIM(Ec.EecOrgLvl2)) + ' ' + '-' + ' ' + O2.OrgDesc
        ,drvManager = LTRIM(RTRIM(pers2.EepNameLast)) + ' ' + LTRIM(RTRIM(pers2.EepNameFirst))
        --pers2.EepNameFirst + ' ' + pers2.EepNameLast
        ,drvHRRep = LTRIM(RTRIM(HR.EepNameFirst)) + '.' + LTRIM(RTRIM(HR.EepNameLast))
        ,drvHRRepID = HRID.EecEmpNo
        --LTRIM(RTRIM(O4.OrgDesc))
        ,drvCompName = REPLACE(CmpCompanyName, ',', '')
        ,drvSalaryGrade = LTRIM(RTRIM(SlgSalGrade)) + ' ' + '-' + ' ' + LTRIM(RTRIM(SlgDesc))
        ,drvWorkSite = O1.OrgDesc
        --LTRIM(RTRIM(Ec.EecOrgLvl1)) + ' ' + '-' + ' ' + O1.OrgDesc
        ,drvBenSenDate = ISNULL(CONVERT(VARCHAR, Ec.EecDateOfSeniority, 101), '')
       -- ,drvManagerId = O4.OrgManagerID
        --Ec2.EecEmpNo
        ,drvOrigHireDate = ISNULL(CONVERT(VARCHAR, Ec.EecDateOfOriginalHire, 101), '')
        ,drvSuffix = CASE WHEN pers.EepNameSuffix = 'Z' THEN '' ELSE pers.EepNameSuffix END
        ,drvUnion = CASE WHEN Ec.EecUnionLocal IS NOT NULL OR Ec.EecUnionNational IS NOT NULL THEN unishortdesc END
        --CASE WHEN Ec.EecUnionLocal <> '' THEN Ec.EecUnionLocal
  --                          WHEN Ec.EecUnionNational <> '' THEN Ec.EecUnionNational END
        ,drvEthnicity = CodDesc
        ,drvPayGroupCode = LTRIM(RTRIM(PgrPayGroup)) + ' - ' + REPLACE(LTRIM(RTRIM(PgrDesc)), ',', '') 
        ,drvSalaryOrHourly = Ec.EecSalaryOrHourly
        --,drvTerminationDate = ISNULL(CONVERT(VARCHAR, Ec.EecDateOfTermination, 101), '')
        --,drvTerminationReason = CASE WHEN Ec.EecTermReason = '203' THEN 'Death of Employee'
        --                                WHEN EjhReason = '401' THEN 'Reduction in Hours'
        --                                WHEN Ec.EecTermReason <> '203' AND Ec.EecTermType IN ('I', 'N') THEN 'Termination: Involuntary'
        --                                WHEN Ec.EecTermReason = '202' THEN 'Retirement'
        --                                WHEN Ec.EecTermType = 'V' THEN 'Termination: Voluntary'
        --                                ELSE '' END
    INTO dbo.U_EWECIRDEM_drvTbl
    FROM dbo.U_EWECIRDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp Ec WITH (NOLOCK)
        ON Ec.EecEEID = xEEID 
        AND Ec.EecCoID = xCoID
    JOIN dbo.EmpPers pers WITH (NOLOCK)
        ON pers.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = Ec.EecJobCode
    JOIN dbo.Company WITH(NOLOCK)
        ON xCOID = CmpCOID
    --JOIN dbo.U_EWECIRDEM_PEarHist WITH(NOLOCK)
    --    ON PehEEID = xEEID
    --    AND PehCOID = xCOID
    OUTER APPLY (SELECT TOP 1* FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhDateTimeCreated DESC) Ejh
    --JOIN dbo.U_dsi_BDM_EWECIRDEM WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    OUTER APPLY (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL' AND EfoEEID = xEEID) M
    LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
    ON EC2.EecEEID = Ec.EecSupervisorID  
  --  AND Ec2.EecCOID = Ec.EecCOID  
        --AND SUP.EecEmplStatus <> 'T' 
    LEFT JOIN dbo.EmpPers pers2 WITH(NOLOCK)
    ON Ec2.EecEEID = pers2.EepEEID
    LEFT JOIN dbo.OrgLevel O1 WITH(NOLOCK)
    ON O1.OrgCode = Ec.EecOrgLvl1
    AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH(NOLOCK)
    ON O2.OrgCode = Ec.EecOrgLvl2
    AND O2.OrgLvl = '2'
    LEFT JOIN dbo.OrgLevel O4 WITH(NOLOCK)
    ON O4.OrgCode = Ec.EecOrgLvl4
    AND O4.OrgLvl = '4'
    LEFT JOIN dbo.EmpPers HR WITH(NOLOCK)
    ON HR.EepEEID = O4.OrgManagerID
    LEFT JOIN dbo.EmpComp HRID WITH(NOLOCK)
    ON HRID.EecEEID = HR.EepEEID
    Left JOIN dbo.SalGrade    
    ON slgsalgrade=jbcsalarygrade
    LEFT JOIN dbo.Codes WITH(NOLOCK)
    ON CodCode = pers.EepEthnicId
    AND CodTable = 'ETHNICCODE'
    LEFT JOIN dbo.PayGroup WITH(NOLOCK)
    ON PgrPayGroup = Ec.EecPayGroup
    LEFT JOIN dbo.U_EWECIRDEM_EmpUnion WITH(NOLOCK)
    ON ISNULL(Ec.eecunionlocal, Ec.eecunionnational) = unioncode
    WHERE (Ec.EecDateOfTermination IS NULL OR CAST(Ec.EecDateOfTermination AS DATE) >= DATEADD(day, -90, CAST(GETDATE() AS DATE)))
    AND Ec.EecEEType IN ('REG', 'INC', 'CTP')
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEWECIRDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWECIRDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWECIRDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110011'
       ,expStartPerControl     = '202110011'
       ,expLastEndPerControl   = '202110089'
       ,expEndPerControl       = '202110089'
WHERE expFormatCode = 'EWECIRDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWECIRDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EWECIRDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWECIRDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWECIRDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWECIRDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWECIRDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWECIRDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWECIRDEM', 'UseFileName', 'V', 'Y'


-- End ripout