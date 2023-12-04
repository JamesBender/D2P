/**********************************************************************************

EABDMA403B: Mutual of America 403b Export

FormatCode:     EABDMA403B
Project:        Mutual of America 403b Export
Client ID:      ABI1001
Date/time:      2023-11-30 06:55:53.460
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E11
Server:         E1SUP1DB52
Database:       ULTIPRO_ABIBD
Web Filename:   ABI1001_AE2C2_EEHISTORY_EABDMA403B_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EABDMA403B_SavePath') IS NOT NULL DROP TABLE dbo.U_EABDMA403B_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EABDMA403B'


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
WHERE FormatCode = 'EABDMA403B'
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
WHERE ExpFormatCode = 'EABDMA403B'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EABDMA403B')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EABDMA403B'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EABDMA403B'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EABDMA403B'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EABDMA403B'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EABDMA403B'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EABDMA403B'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EABDMA403B'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EABDMA403B'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EABDMA403B'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEABDMA403B_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEABDMA403B_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EABDMA403B') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EABDMA403B];
GO
IF OBJECT_ID('U_EABDMA403B_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_PEarHist];
GO
IF OBJECT_ID('U_EABDMA403B_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_PDedHist];
GO
IF OBJECT_ID('U_EABDMA403B_Header') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_Header];
GO
IF OBJECT_ID('U_EABDMA403B_File') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_File];
GO
IF OBJECT_ID('U_EABDMA403B_EEList') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_EEList];
GO
IF OBJECT_ID('U_EABDMA403B_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_drvTbl];
GO
IF OBJECT_ID('U_EABDMA403B_DedList') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_DedList];
GO
IF OBJECT_ID('U_EABDMA403B_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_AuditFields];
GO
IF OBJECT_ID('U_EABDMA403B_Audit') IS NOT NULL DROP TABLE [dbo].[U_EABDMA403B_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EABDMA403B') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EABDMA403B];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EABDMA403B','Mutual of America 403b Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','10000','S','N','EABDMA403BZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EABDMA403BZ0','50','H','01','1',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EABDMA403BZ0','50','H','01','2',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EABDMA403BZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EABDMA403BZ0','50','H','01','4',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EABDMA403BZ0','50','H','01','5',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EABDMA403BZ0','50','H','01','6',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EABDMA403BZ0','50','H','01','7',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EABDMA403BZ0','50','H','01','8',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EABDMA403BZ0','50','H','01','9',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EABDMA403BZ0','50','H','01','10',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EABDMA403BZ0','50','H','01','11',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EABDMA403BZ0','50','H','01','12',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EABDMA403BZ0','50','H','01','13',NULL,'Payroll Date',NULL,NULL,'"Payroll Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EABDMA403BZ0','50','H','01','14',NULL,'Plan Compensation',NULL,NULL,'"Plan Compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EABDMA403BZ0','50','H','01','15',NULL,'Hours',NULL,NULL,'"Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EABDMA403BZ0','50','H','01','16',NULL,'Excluded Earnings',NULL,NULL,'"Excluded Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EABDMA403BZ0','50','H','01','17',NULL,'Employee Deferral',NULL,NULL,'"Employee Deferral"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EABDMA403BZ0','50','H','01','18',NULL,'Employee Roth',NULL,NULL,'"Employee Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EABDMA403BZ0','50','H','01','19',NULL,'Employer Match',NULL,NULL,'"Employer Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EABDMA403BZ0','50','H','01','20',NULL,'Employer Base Contribution',NULL,NULL,'"Employer Base Contribution"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EABDMA403BZ0','50','H','01','21',NULL,'Plan YTD Plan Compensation',NULL,NULL,'"Plan YTD Plan Compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EABDMA403BZ0','50','H','01','22',NULL,'Plan YTD Hours',NULL,NULL,'"Plan YTD Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EABDMA403BZ0','50','H','01','23',NULL,'Plan YTD Employee Deferral',NULL,NULL,'"Plan YTD Employee Deferral"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EABDMA403BZ0','50','H','01','24',NULL,'Plan YTD Employee Roth',NULL,NULL,'"Plan YTD Employee Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EABDMA403BZ0','50','H','01','25',NULL,'Plan YTD Employer Match',NULL,NULL,'"Plan YTD Employer Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EABDMA403BZ0','50','H','01','26',NULL,'Plan YTD Employer Base',NULL,NULL,'"Plan YTD Employer Base"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EABDMA403BZ0','50','H','01','27',NULL,'Employer Number',NULL,NULL,'"Employer Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EABDMA403BZ0','50','H','01','28',NULL,'Plan Type',NULL,NULL,'"Plan Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EABDMA403BZ0','50','H','01','29',NULL,'Employee Deferral %',NULL,NULL,'"drvEmployeeDeferralpercent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EABDMA403BZ0','50','H','01','30',NULL,'Payroll Provider Company Code',NULL,NULL,'"Payroll Provider Company Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EABDMA403BZ0','50','H','01','31',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EABDMA403BZ0','50','H','01','32',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EABDMA403BZ0','50','H','01','33',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EABDMA403BZ0','50','H','01','34',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EABDMA403BZ0','50','H','01','35',NULL,'Pay Type',NULL,NULL,'"Pay Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EABDMA403BZ0','50','H','01','36',NULL,'Union Status',NULL,NULL,'"Union Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EABDMA403BZ0','50','H','01','37',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EABDMA403BZ0','50','H','01','38',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EABDMA403BZ0','50','H','01','39',NULL,'Adjusted Seniority Date',NULL,NULL,'"Adjusted Seniority Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EABDMA403BZ0','50','H','01','40',NULL,'Leave of Absence Begin Date',NULL,NULL,'"Leave of Absence Begin Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EABDMA403BZ0','50','H','01','41',NULL,'Leave of Absence End Date',NULL,NULL,'"Leave of Absence End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EABDMA403BZ0','50','H','01','42',NULL,'Payroll Begin Date',NULL,NULL,'"Payroll Begin Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EABDMA403BZ0','50','H','01','43',NULL,'Payroll End Date',NULL,NULL,'"Payroll End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EABDMA403BZ0','50','H','01','44',NULL,'Payroll Frequency',NULL,NULL,'"Payroll Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EABDMA403BZ0','50','H','01','45',NULL,'Cost Center 1 Code',NULL,NULL,'"Cost Center 1 Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EABDMA403BZ0','50','H','01','46',NULL,'Cost Center 2 Code',NULL,NULL,'"Cost Center 2 Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EABDMA403BZ0','50','H','01','47',NULL,'Cost Center 3 Code',NULL,NULL,'"Cost Center 3 Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EABDMA403BZ0','50','H','01','48',NULL,'Gross Earnings',NULL,NULL,'"Gross Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EABDMA403BZ0','50','H','01','49',NULL,'Section 125',NULL,NULL,'"Section 125"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EABDMA403BZ0','50','H','01','50',NULL,'Employee After Tax',NULL,NULL,'"Employee After Tax"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EABDMA403BZ0','51','H','01','51',NULL,'Safe Harbor Match',NULL,NULL,'"Safe Harbor Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EABDMA403BZ0','52','H','01','52',NULL,'Qualified Matching Contribution',NULL,NULL,'"drvQualifiedMatchingCon"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EABDMA403BZ0','53','H','01','53',NULL,'Safe Harbor Non-Elective',NULL,NULL,'"Safe Harbor Non-Elective"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EABDMA403BZ0','54','H','01','54',NULL,'Qualified Non-Elective Contribution',NULL,NULL,'"drvQualifiedNonElectiveCon"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EABDMA403BZ0','55','H','01','55',NULL,'Profit Sharing',NULL,NULL,'"Profit Sharing"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EABDMA403BZ0','56','H','01','56',NULL,'Money Purchase',NULL,NULL,'"Money Purchase"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EABDMA403BZ0','57','H','01','57',NULL,'Rollover',NULL,NULL,'"Rollover"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EABDMA403BZ0','58','H','01','58',NULL,'Rollover Roth',NULL,NULL,'"Rollover Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EABDMA403BZ0','59','H','01','59',NULL,'Loan Payment 1',NULL,NULL,'"Loan Payment 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EABDMA403BZ0','60','H','01','60',NULL,'Loan Number 1',NULL,NULL,'"Loan Number 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EABDMA403BZ0','61','H','01','61',NULL,'Loan Payment 2',NULL,NULL,'"Loan Payment 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EABDMA403BZ0','62','H','01','62',NULL,'Loan Number 2',NULL,NULL,'"Loan Number 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EABDMA403BZ0','63','H','01','63',NULL,'Loan Payment 3',NULL,NULL,'"Loan Payment 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EABDMA403BZ0','64','H','01','64',NULL,'Loan Number 3',NULL,NULL,'"Loan Number 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EABDMA403BZ0','65','H','01','65',NULL,'Loan Payment 4',NULL,NULL,'"Loan Payment 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EABDMA403BZ0','66','H','01','66',NULL,'Loan Number 4',NULL,NULL,'"Loan Number 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EABDMA403BZ0','67','H','01','67',NULL,'Loan Payment 5',NULL,NULL,'"Loan Payment 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EABDMA403BZ0','68','H','01','68',NULL,'Loan Number 5',NULL,NULL,'"Loan Number 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EABDMA403BZ0','69','H','01','69',NULL,'YTD Gross Earnings',NULL,NULL,'"YTD Gross Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EABDMA403BZ0','70','H','01','70',NULL,'Plan YTD Excluded Earnings',NULL,NULL,'"Plan YTD Excluded Earnings"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EABDMA403BZ0','71','H','01','71',NULL,'Plan YTD Section 125',NULL,NULL,'"Plan YTD Section 125"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EABDMA403BZ0','72','H','01','72',NULL,'Plan YTD Employee After Tax',NULL,NULL,'"Plan YTD Employee After Tax"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EABDMA403BZ0','73','H','01','73',NULL,'Plan YTD Safe Harbor Match',NULL,NULL,'"Plan YTD Safe Harbor Match"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EABDMA403BZ0','74','H','01','74',NULL,'Plan YTD Qualified Matching Contribution',NULL,NULL,'"drvPlanYTDQualifiedMatchCon"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EABDMA403BZ0','75','H','01','75',NULL,'Plan YTD Safe Harbor Non-Elective',NULL,NULL,'"drvPlanYTDSafeHarborNonElec"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EABDMA403BZ0','76','H','01','76',NULL,'Plan YTD Qualified Non-Elective Contribution',NULL,NULL,'"drvPlanYTDQualifiedNonElecCon"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EABDMA403BZ0','77','H','01','77',NULL,'Plan YTD Profit Sharing',NULL,NULL,'"Plan YTD Profit Sharing"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EABDMA403BZ0','78','H','01','78',NULL,'Plan YTD Money Purchase',NULL,NULL,'"Plan YTD Money Purchase"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EABDMA403BZ0','79','H','01','79',NULL,'Plan YTD Rollover',NULL,NULL,'"Plan YTD Rollover"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EABDMA403BZ0','80','H','01','80',NULL,'Plan YTD Rollover Roth',NULL,NULL,'"Plan YTD Rollover Roth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EABDMA403BZ0','81','H','01','81',NULL,'Employee Email Address',NULL,NULL,'"Employee Email Address"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EABDMA403BZ0','82','D','10','1',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EABDMA403BZ0','83','D','10','2',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EABDMA403BZ0','84','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EABDMA403BZ0','85','D','10','4',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EABDMA403BZ0','86','D','10','5',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EABDMA403BZ0','87','D','10','6',NULL,'Address 1',NULL,NULL,'"drvAddressline1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EABDMA403BZ0','89','D','10','7',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EABDMA403BZ0','90','D','10','8',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EABDMA403BZ0','91','D','10','9',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EABDMA403BZ0','92','D','10','10',NULL,'Birth Date',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EABDMA403BZ0','93','D','10','11',NULL,'Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EABDMA403BZ0','94','D','10','12',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EABDMA403BZ0','95','D','10','13',NULL,'Payroll Date',NULL,NULL,'"drvPayrollDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EABDMA403BZ0','96','D','10','14',NULL,'Plan Compensation',NULL,NULL,'"drvPlanCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EABDMA403BZ0','97','D','10','15',NULL,'Hours',NULL,NULL,'"drvHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EABDMA403BZ0','98','D','10','16',NULL,'Excluded Earnings',NULL,NULL,'"drvExcludedEarnings"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EABDMA403BZ0','99','D','10','17',NULL,'Employee Deferral',NULL,NULL,'"drvEmployeeDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EABDMA403BZ0','100','D','10','18',NULL,'Employee Roth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EABDMA403BZ0','101','D','10','19',NULL,'Employer Match',NULL,NULL,'"drvEmployerMatch"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EABDMA403BZ0','102','D','10','20',NULL,'Employer Base Contribution',NULL,NULL,'"drvEmployerBaseContribution"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EABDMA403BZ0','103','D','10','21',NULL,'Plan YTD Plan Compensation',NULL,NULL,'"drvPlanYTDPlanCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EABDMA403BZ0','104','D','10','22',NULL,'Plan YTD Hours',NULL,NULL,'"drvPlanYTDHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EABDMA403BZ0','105','D','10','23',NULL,'Plan YTD Employee Deferral',NULL,NULL,'"drvPlanYTDEmployeeDeferral"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EABDMA403BZ0','106','D','10','24',NULL,'Plan YTD Employee Roth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EABDMA403BZ0','107','D','10','25',NULL,'Plan YTD Employer Match',NULL,NULL,'"drvPlanYTDEmployerMatch"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EABDMA403BZ0','108','D','10','26',NULL,'Plan YTD Employer Base',NULL,NULL,'"drvPlanYTDEmployerBase"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EABDMA403BZ0','109','D','10','27',NULL,'Employer Number',NULL,NULL,'"drvEmployerNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EABDMA403BZ0','110','D','10','28',NULL,'Plan Type',NULL,NULL,'"drvPlanType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EABDMA403BZ0','111','D','10','29',NULL,'Employee Deferral %',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EABDMA403BZ0','112','D','10','30',NULL,'Payroll Provider Company Code',NULL,NULL,'"drvPayrollProviderCompanyCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EABDMA403BZ0','113','D','10','31',NULL,'Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EABDMA403BZ0','114','D','10','32',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EABDMA403BZ0','115','D','10','33',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EABDMA403BZ0','116','D','10','34',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EABDMA403BZ0','117','D','10','35',NULL,'Pay Type',NULL,NULL,'"drvPayType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EABDMA403BZ0','118','D','10','36',NULL,'Union Status',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EABDMA403BZ0','88','D','10','37',NULL,'Address 2',NULL,NULL,'"drvAddressline2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EABDMA403BZ0','119','D','10','38',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EABDMA403BZ0','120','D','10','39',NULL,'Adjusted Seniority Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EABDMA403BZ0','121','D','10','40',NULL,'Leave of Absence Begin Date',NULL,NULL,'"drvLeaveOfAbsenceBeginDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EABDMA403BZ0','122','D','10','41',NULL,'Leave of Absence End Date',NULL,NULL,'"drvLeaveOfAbsenceEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EABDMA403BZ0','123','D','10','42',NULL,'Payroll Begin Date',NULL,NULL,'"drvPayrollBeginDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EABDMA403BZ0','124','D','10','43',NULL,'Payroll End Date',NULL,NULL,'"drvPayrollEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EABDMA403BZ0','125','D','10','44',NULL,'Payroll Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EABDMA403BZ0','126','D','10','45',NULL,'Cost Center 1 Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EABDMA403BZ0','127','D','10','46',NULL,'Cost Center 2 Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EABDMA403BZ0','128','D','10','47',NULL,'Cost Center 3 Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EABDMA403BZ0','129','D','10','48',NULL,'Gross Earnings',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EABDMA403BZ0','130','D','10','49',NULL,'Section 125',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EABDMA403BZ0','131','D','10','50',NULL,'Employee After Tax',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EABDMA403BZ0','132','D','10','51',NULL,'Safe Harbor Match',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EABDMA403BZ0','133','D','10','52',NULL,'Qualified Matching Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EABDMA403BZ0','134','D','10','53',NULL,'Safe Harbor Non-Elective',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EABDMA403BZ0','135','D','10','54',NULL,'Qualified Non-Elective Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EABDMA403BZ0','136','D','10','55',NULL,'Profit Sharing',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EABDMA403BZ0','137','D','10','56',NULL,'Money Purchase',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EABDMA403BZ0','138','D','10','57',NULL,'Rollover',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EABDMA403BZ0','139','D','10','58',NULL,'Rollover Roth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EABDMA403BZ0','140','D','10','59',NULL,'Loan Payment 1',NULL,NULL,'"drvLoanPayment1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EABDMA403BZ0','141','D','10','60',NULL,'Loan Number 1',NULL,NULL,'"drvLoanNumber1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EABDMA403BZ0','142','D','10','61',NULL,'Loan Payment 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EABDMA403BZ0','143','D','10','62',NULL,'Loan Number 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EABDMA403BZ0','144','D','10','63',NULL,'Loan Payment 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EABDMA403BZ0','145','D','10','64',NULL,'Loan Number 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EABDMA403BZ0','146','D','10','65',NULL,'Loan Payment 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EABDMA403BZ0','147','D','10','66',NULL,'Loan Number 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EABDMA403BZ0','148','D','10','67',NULL,'Loan Payment 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EABDMA403BZ0','149','D','10','68',NULL,'Loan Number 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EABDMA403BZ0','150','D','10','69',NULL,'YTD Gross Earnings',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EABDMA403BZ0','151','D','10','70',NULL,'Plan YTD Excluded Earnings',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EABDMA403BZ0','152','D','10','71',NULL,'Plan YTD Section 125',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EABDMA403BZ0','153','D','10','72',NULL,'Plan YTD Employee After Tax',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EABDMA403BZ0','154','D','10','73',NULL,'Plan YTD Safe Harbor Match',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EABDMA403BZ0','155','D','10','74',NULL,'Plan YTD Qualified Matching Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EABDMA403BZ0','156','D','10','75',NULL,'Plan YTD Safe Harbor Non-Elective',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EABDMA403BZ0','157','D','10','76',NULL,'Plan YTD Qualified Non-Elective Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EABDMA403BZ0','158','D','10','77',NULL,'Plan YTD Profit Sharing',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EABDMA403BZ0','159','D','10','78',NULL,'Plan YTD Money Purchase',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EABDMA403BZ0','160','D','10','79',NULL,'Plan YTD Rollover',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EABDMA403BZ0','161','D','10','80',NULL,'Plan YTD Rollover Roth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EABDMA403BZ0','162','D','10','81',NULL,'Employee Email Address',NULL,NULL,'"drvEmployeeEmailAddress"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EABDMA403B_20231130.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',LJM60,LJLQQ,LJMEE',NULL,NULL,NULL,'Mutual of America 403b Export','202209029','EMPEXPORT','ONDEM_XOE',NULL,'EABDMA403B',NULL,NULL,NULL,'202209029','Aug 31 2022  2:37PM','Aug 31 2022  2:37PM','202208201',NULL,'eecPaygroup','CTSTFF,NYSTFF','202208201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','LJM60,LJLQQ',NULL,NULL,NULL,'Mutual of America 403b E-Sched','202308181','EMPEXPORT','SCH_EABDMA',NULL,'EABDMA403B',NULL,NULL,NULL,'202311279',NULL,NULL,'202311131',NULL,'eecPaygroup','CTSTFF,NYSTFF','202308051',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Mutual of America 403b E-Test','202307249','EMPEXPORT','TEST_XOE','Nov 13 2022  6:52PM','EABDMA403B',NULL,NULL,NULL,'202307249','Sep  2 2022 12:00AM','Dec 30 1899 12:00AM','202307111','1128','','','202307111',dbo.fn_GetTimedKey(),NULL,'us3lKiABI1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','InitialSort','C','drvInitalSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EABDMA403B','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EABDMA403B','H01','dbo.U_EABDMA403B_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EABDMA403B','D10','dbo.U_EABDMA403B_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EABDMA403B
-----------

IF OBJECT_ID('U_dsi_BDM_EABDMA403B') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EABDMA403B] (
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
-- Create table U_EABDMA403B_Audit
-----------

IF OBJECT_ID('U_EABDMA403B_Audit') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_Audit] (
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
-- Create table U_EABDMA403B_AuditFields
-----------

IF OBJECT_ID('U_EABDMA403B_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EABDMA403B_DedList
-----------

IF OBJECT_ID('U_EABDMA403B_DedList') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EABDMA403B_drvTbl
-----------

IF OBJECT_ID('U_EABDMA403B_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitalSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvAddressline1] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDOB] datetime NULL,
    [drvOriginalHireDate] nvarchar(10) NULL,
    [drvTerminationDate] datetime NULL,
    [drvPayrollDate] datetime NULL,
    [drvPlanCompensation] nvarchar(4000) NULL,
    [drvHours] nvarchar(4000) NULL,
    [drvExcludedEarnings] nvarchar(4000) NULL,
    [drvEmployeeDeferral] nvarchar(4000) NULL,
    [drvEmployerMatch] nvarchar(4000) NULL,
    [drvEmployerBaseContribution] nvarchar(4000) NULL,
    [drvPlanYTDPlanCompensation] nvarchar(4000) NULL,
    [drvPlanYTDHours] nvarchar(4000) NULL,
    [drvPlanYTDEmployeeDeferral] nvarchar(4000) NULL,
    [drvPlanYTDEmployerMatch] nvarchar(4000) NULL,
    [drvPlanYTDEmployerBase] nvarchar(4000) NULL,
    [drvEmployerNumber] varchar(6) NOT NULL,
    [drvPlanType] varchar(4) NOT NULL,
    [drvPayrollProviderCompanyCode] varchar(8000) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvTitle] varchar(8000) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeStatus] char(1) NULL,
    [drvPayType] char(1) NULL,
    [drvAddressline2] varchar(8000) NULL,
    [drvRehireDate] nvarchar(10) NULL,
    [drvLeaveOfAbsenceBeginDate] varchar(1) NOT NULL,
    [drvLeaveOfAbsenceEndDate] varchar(1) NOT NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvLoanPayment1] nvarchar(4000) NULL,
    [drvLoanNumber1] varchar(2) NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_EABDMA403B_EEList
-----------

IF OBJECT_ID('U_EABDMA403B_EEList') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EABDMA403B_File
-----------

IF OBJECT_ID('U_EABDMA403B_File') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EABDMA403B_Header
-----------

IF OBJECT_ID('U_EABDMA403B_Header') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_Header] (
    [drvEmployeeDeferralpercent] varchar(19) NOT NULL,
    [drvQualifiedMatchingCon] varchar(31) NOT NULL,
    [drvQualifiedNonElectiveCon] varchar(35) NOT NULL,
    [drvPlanYTDQualifiedMatchCon] varchar(40) NOT NULL,
    [drvPlanYTDSafeHarborNonElec] varchar(33) NOT NULL,
    [drvPlanYTDQualifiedNonElecCon] varchar(44) NOT NULL
);

-----------
-- Create table U_EABDMA403B_PDedHist
-----------

IF OBJECT_ID('U_EABDMA403B_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhEEDeff] numeric NULL,
    [PdhEMPMatch] numeric NULL,
    [PdhEMPBaseCon] numeric NULL,
    [PdhLoanAmnt] numeric NULL,
    [PdhLoanNum] varchar(2) NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhYTDEEDeff] numeric NULL,
    [PdhYTDEMPMatch] numeric NULL,
    [PdhYTDEMPBaseCon] numeric NULL,
    [PdhYTDEEDeferral] numeric NULL
);

-----------
-- Create table U_EABDMA403B_PEarHist
-----------

IF OBJECT_ID('U_EABDMA403B_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EABDMA403B_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefCompY] money NULL,
    [PehInclInDefCompHrsY] decimal NULL,
    [PehInclInDefCompN] money NOT NULL,
    [PehInclInDefCompYTD] money NOT NULL,
    [PehInclInDefCompHrsYTD] decimal NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EABDMA403B]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ability Beyond Disability

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 08/31/2022
Service Request Number: TekP-2022-07-26-01

Purpose: Mutual of America 403b Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        07/21/2023     TekP-2022-07-26-01 Added 9-15 loan codes and populated loan number field


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EABDMA403B';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EABDMA403B';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EABDMA403B';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EABDMA403B';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EABDMA403B' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EABDMA403B', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EABDMA403B', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EABDMA403B', 'SCH_EABDMA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EABDMA403B';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EABDMA403B', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EABDMA403B';

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
    DELETE FROM dbo.U_EABDMA403B_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EABDMA403B_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Removes invalid EE types
    DELETE dbo.U_EABDMA403B_EEList
    FROM dbo.U_EABDMA403B_EEList
    JOIN dbo.vw_int_EmpComp
    ON EecEEID = xEEID
    AND EecCoID = xCoID
    WHERE EecOrglvl1 not IN ('EMPL')
    --WHERE EecOrglvl1 IN ('CONT','CONS','INTERN')

    --Remove test employees
    DELETE FROM dbo.U_EABDMA403B_EEList where xEEID IN ('EDZ8GY000030','8NCIS90000K0','8P1GBV0000K0','8NLVUD0000K0','8P1GLK00A0K0','8P1GLK00A0K0')

    -- Removes test EE type
    DELETE dbo.U_EABDMA403B_EEList
    FROM dbo.U_EABDMA403B_EEList
    JOIN dbo.vw_int_EmpComp
    ON EecEEID = xEEID
    AND EecCoID = xCoID
    WHERE EecEEType = 'TES'       


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EABDMA403B_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_AuditFields;
    CREATE TABLE dbo.U_EABDMA403B_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     --INSERT INTO dbo.U_EABDMA403B_AuditFields VALUES ('EmpComp','EecDateofTermination');
     INSERT INTO dbo.U_EABDMA403B_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EABDMA403B_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_Audit;
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
    INTO dbo.U_EABDMA403B_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EABDMA403B_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime Between Dateadd(d, -30, @StartDate) and @EndDate  --BETWEEN '01/01/' + CONVERT(VARCHAR(4), DATEPART(yy, @StartDate))  AND @EndDate
   AND audAction = 'Update' and Ltrim(rtrim(audnewvalue)) = 'T';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EABDMA403B_Audit ON dbo.U_EABDMA403B_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EABDMA403B_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EABDMA403B_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '0003,0007,0015,0016,LOAN1,LOAN2,LOAN3,LOAN4,LOAN5,LOAN6,LOAN7,LOAN8,LOAN9,LOAN10,LOAN11,LOAN12,LOAN13,LOAN14,LOAN15';

    IF OBJECT_ID('U_EABDMA403B_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EABDMA403B_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EABDMA403B_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts

        ,PdhEECurAmt = SUM(Case WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEEDeff        = SUM(CASE WHEN PdhDedCode IN ('0003 ','0007') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEMPMatch    = SUM(CASE WHEN PdhDedCode IN ('0015') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhEMPBaseCon  = SUM(CASE WHEN PdhDedCode IN ('0016') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLoanAmnt = SUM(CASE WHEN PdhDedCode IN ('LOAN1', 'LOAN2', 'LOAN3', 'LOAN4', 'LOAN5', 'LOAN6','LOAN7','LOAN8','LOAN9', 'LOAN10', 'LOAN11', 'LOAN12','LOAN13','LOAN14','LOAN15') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END) 
        ,PdhLoanNum = Max(CASE WHEN PdhDedCode IN ('LOAN1', 'LOAN2', 'LOAN3', 'LOAN4', 'LOAN5', 'LOAN6','LOAN7','LOAN8','LOAN9', 'LOAN10', 'LOAN11', 'LOAN12','LOAN13','LOAN14','LOAN15') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl and PdhEECurAmt is not null THEN 
                                    CASE WHEN PdhDedCode = 'LOAN1' THEN '1' 
                                         WHEN PdhDedCode = 'LOAN2' THEN '2'
                                         WHEN PdhDedCode = 'LOAN3' THEN '3'
                                         WHEN PdhDedCode = 'LOAN4' THEN '4'
                                         WHEN PdhDedCode = 'LOAN5' THEN '5'
                                         WHEN PdhDedCode = 'LOAN6' THEN '6'
                                         WHEN PdhDedCode = 'LOAN7' THEN '7'
                                         WHEN PdhDedCode = 'LOAN8' THEN '8'
                                         WHEN PdhDedCode = 'LOAN9' THEN '9'
                                         WHEN PdhDedCode = 'LOAN10' THEN '10'
                                         WHEN PdhDedCode = 'LOAN11' THEN '11'
                                         WHEN PdhDedCode = 'LOAN12' THEN '12'
                                         WHEN PdhDedCode = 'LOAN13' THEN '13'
                                         WHEN PdhDedCode = 'LOAN14' THEN '14'
                                         WHEN PdhDedCode = 'LOAN15' THEN '15'
                                         END
                                        Else '1'
                                    END) 
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhYTDEEDeff      = SUM(CASE WHEN PdhDedCode IN ('0003 ','0007') and PdhPerControl  <= @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhYTDEMPMatch    = SUM(CASE WHEN PdhDedCode IN ('0015')  and PdhPerControl  <= @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhYTDEMPBaseCon  = SUM(CASE WHEN PdhDedCode IN ('0016') and PdhPerControl  <= @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhYTDEEDeferral  = SUM(CASE WHEN PdhDedCode IN ('0003 ','0007') and PdhPerControl  <= @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
       
    INTO dbo.U_EABDMA403B_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EABDMA403B_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND left(PdhPerControl,8) >= DATEADD(DAY, -365, Left(@StartPerControl, 8))
   -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EABDMA403B_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_PEarHist;
     SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN  PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN  PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefCompY       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrsY    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ,PehInclInDefCompN       = isnull(SUM(CASE WHEN PehInclInDefComp = 'N' AND PehPerControl >= @StartPerControl THEN PehCurAmt END), 0.00)
        --,PehInclInDefCompHrsN    = SUM(CASE WHEN PehInclInDefCompHrs = 'N' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = isnull(SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END), 0.00)
        ,PehInclInDefCompHrsYTD = isnull(SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END), 0.00)
    INTO dbo.U_EABDMA403B_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
   -- WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --and left(PehPerControl,8) >= DATEADD(DAY, -365, Left(@StartPerControl, 8))
     WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
      HAVING SUM(PehCurAmt)>= 0.00 OR SUM(PehCurHrs)>= 0.00;

   
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EABDMA403B_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EABDMA403B_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvAddressline1 = [dbo].[dsi_fnlib_AddDoubleQuotes] (EepAddressLine1)
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDOB = EepDateOfBirth
        ,drvOriginalHireDate = convert(nvarchar(10), EecDateOfOriginalHire, 101) 
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPayrollDate =  Cast(left(@EndPerControl,8)as Datetime)
        ,drvPlanCompensation = FORMAT(isnull(PehInclInDefCompY, 0.00),'#0.00')  
        ,drvHours = FORMAT(isnull(PehInclInDefCompHrsY,0.00),'#0.00')
        ,drvExcludedEarnings = FORMAT(isnull(PehInclInDefCompN, 0.00),'#0.00')
        ,drvEmployeeDeferral = FORMAT(isnull(PdhEEDeff, 0.00),'#0.00')
        ,drvEmployerMatch = FORMAT(isnull(PdhEMPMatch, 0.00),'#0.00') 
        ,drvEmployerBaseContribution = FORMAT(isnull(PdhEMPBaseCon, 0.00),'#0.00')
        ,drvPlanYTDPlanCompensation = FORMAT(isnull(PehInclInDefCompYTD, 0.00),'#0.00')
        ,drvPlanYTDHours = FORMAT(isnull(PehInclInDefCompHrsYTD,0.00),'#0.00')
        ,drvPlanYTDEmployeeDeferral = FORMAT(isnull(PdhYTDEEDeferral, 0.00),'#0.00') 
        ,drvPlanYTDEmployerMatch = FORMAT(isnull(PdhYTDEMPMatch, 0.00),'#0.00')
        ,drvPlanYTDEmployerBase = FORMAT(isnull(PdhYTDEMPBaseCon,0.00),'#0.00')
        ,drvEmployerNumber = '007295'
        ,drvPlanType = '403B'
        ,drvPayrollProviderCompanyCode = [dbo].[dsi_fnlib_AddDoubleQuotes](cmpcompanyname)  --cmpcompanyname
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvTitle = [dbo].[dsi_fnlib_AddDoubleQuotes] (JbcLongDesc)
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeStatus = EecEmplStatus
        ,drvPayType = EecSalaryOrHourly
        ,drvAddressline2 = [dbo].[dsi_fnlib_AddDoubleQuotes] (EepAddressLine2)
        ,drvRehireDate = CASE WHEN EjhReason IN ('500', 'TRO', 'TRI' , 'TRB')  then Null
                                         WHEN EecDateOfOriginalHire = EecDateOfLastHire THEN Null 
                                         ELSE convert(nvarchar(10), EecDateOfLastHire, 101)
                                        END 
        ,drvLeaveOfAbsenceBeginDate = '' --CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvLeaveOfAbsenceEndDate = ''  --CASE WHEN EecEmplStatus = 'A' and EshEmplStatus = 'L' THEN EshStatusStopDate END
        ,drvPayrollBeginDate = Cast(left(@StartPerControl,8)as Datetime)
        ,drvPayrollEndDate = Cast(left(@EndPerControl,8)as Datetime)
        ,drvPayrollFrequency = EecPayPeriod
        ,drvLoanPayment1 = FORMAT(isnull(PdhLoanAmnt, 0.00), '#0.00')
        ,drvLoanNumber1 = CASE WHEN PdhLoanNum is not null then PdhLoanNum ELSE '1' END
        ,drvEmployeeEmailAddress = EepAddressEMail
    INTO dbo.U_EABDMA403B_drvTbl
    FROM dbo.U_EABDMA403B_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
   LEFT JOIN dbo.U_dsi_BDM_EABDMA403B WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
      JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_EABDMA403B_PEarHist WITH (NOLOCK)    
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EABDMA403B_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup= EecPayGroup
     LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID,EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON EjhEEID = EecEEID
                            AND EjhJObEffDate = EecDateOfLastHire
                          
                        ) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID        
        AND EjhCOID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    Left Join dbo.U_EABDMA403B_Audit
        ON audeeid = xeeid
        and audKey2 = xcoid

    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((eecdateoftermination between DATEADD(d, -30, @StartDate) and @EndDate) 
            or (PehInclInDefCompY > 0.00 or PehInclInDefCompHrsY > 0.00 or PdhEEDeff > 0.00 or PehInclInDefCompN > 0.00 or PdhEMPMatch > 0.00 or PdhEMPBaseCon > 0.00)))
            and (PehCurAmt > 0.00 or PdhEECurAmt > 0.00 or PdhEECurAmtYTD > 0.00 or PehInclInDefCompYTD > 0.00))

    --WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and ((AudDateTime Between Dateadd(d,-30,@StartDate) and @EndDate) or (PehCurAmt > 0.00 or PdhEECurAmt > 0.00 or PdhEECurAmtYTD > 0.00)))
 --      and EecEEType <> 'TES' and (PehCurAmt > 0.00 or PdhEECurAmt > 0.00 or PdhEECurAmtYTD > 0.00))
  
        --    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND AudDateTime BETWEEN '01/01/' + CONVERT(VARCHAR(4), DATEPART(yy, @StartDate))  AND @EndDate  ))
        --and eecorglvl1 = 'EMPL' and EecEEType <> 'TES'
        --and ((PehCurAmt) > 0.00  OR (PdhEECurAmtYTD) > 0.00 )
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EABDMA403B_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EABDMA403B_Header;
    SELECT DISTINCT
         drvEmployeeDeferralpercent = 'Employee Deferral %'
        ,drvQualifiedMatchingCon = 'Qualified Matching Contribution'
        ,drvQualifiedNonElectiveCon = 'Qualified Non-Elective Contribution'
        ,drvPlanYTDQualifiedMatchCon = 'Plan YTD Qualified Matching Contribution'
        ,drvPlanYTDSafeHarborNonElec = 'Plan YTD Safe Harbor Non-Elective'
        ,drvPlanYTDQualifiedNonElecCon = 'Plan YTD Qualified Non-Elective Contribution'
    INTO dbo.U_EABDMA403B_Header
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
ALTER VIEW dbo.dsi_vwEABDMA403B_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EABDMA403B_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EABDMA403B%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307111'
       ,expStartPerControl     = '202307111'
       ,expLastEndPerControl   = '202307249'
       ,expEndPerControl       = '202307249'
WHERE expFormatCode = 'EABDMA403B' and expexportcode = 'TEST_XOE' ;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEABDMA403B_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EABDMA403B_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EABDMA403B' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EABDMA403B'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EABDMA403B'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EABDMA403B', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EABDMA403B', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EABDMA403B', 'UseFileName', 'V', 'Y'


-- End ripout