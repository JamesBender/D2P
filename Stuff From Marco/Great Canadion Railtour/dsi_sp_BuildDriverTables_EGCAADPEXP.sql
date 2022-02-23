/**********************************************************************************

EGCAADPEXP: ADP 401K Export

FormatCode:     EGCAADPEXP
Project:        ADP 401K Export
Client ID:      GRE5000
Date/time:      2021-12-16 21:57:04.010
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    TWP
Server:         TW1WUP1DB02
Database:       ULTIPRO_WPGCRC
Web Filename:   GRE5000_MZTO2_EEHISTORY_EGCAADPEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGCAADPEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EGCAADPEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGCAADPEXP'


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
WHERE FormatCode = 'EGCAADPEXP'
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
WHERE ExpFormatCode = 'EGCAADPEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGCAADPEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGCAADPEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGCAADPEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGCAADPEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGCAADPEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGCAADPEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGCAADPEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGCAADPEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGCAADPEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGCAADPEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGCAADPEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGCAADPEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGCAADPEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGCAADPEXP];
GO
IF OBJECT_ID('U_EGCAADPEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_PEarHist];
GO
IF OBJECT_ID('U_EGCAADPEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_PDedHist];
GO
IF OBJECT_ID('U_EGCAADPEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_File];
GO
IF OBJECT_ID('U_EGCAADPEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_EEList];
GO
IF OBJECT_ID('U_EGCAADPEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_drvTbl];
GO
IF OBJECT_ID('U_EGCAADPEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_DedList];
GO
IF OBJECT_ID('U_EGCAADPEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_AuditFields];
GO
IF OBJECT_ID('U_EGCAADPEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EGCAADPEXP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGCAADPEXP','ADP 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EGCAADPEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGCAADPEXPZ0','50','H','01','1',NULL,'Check Date',NULL,NULL,'"Check Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGCAADPEXPZ0','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGCAADPEXPZ0','50','H','01','3',NULL,'Employee Name',NULL,NULL,'"Employee Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGCAADPEXPZ0','50','H','01','4',NULL,'Address Line 1',NULL,NULL,'"Address Line 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGCAADPEXPZ0','50','H','01','5',NULL,'Address Line 2',NULL,NULL,'"Address Line 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGCAADPEXPZ0','50','H','01','6',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGCAADPEXPZ0','50','H','01','7',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGCAADPEXPZ0','50','H','01','8',NULL,'ZIP Code',NULL,NULL,'"ZIP Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGCAADPEXPZ0','50','H','01','9',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGCAADPEXPZ0','50','H','01','10',NULL,'Date of Hire',NULL,NULL,'"Date of Hire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGCAADPEXPZ0','50','H','01','11',NULL,'Date of Termination',NULL,NULL,'"Date of Termination"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGCAADPEXPZ0','50','H','01','12',NULL,'Date of Rehire',NULL,NULL,'"Date of Rehire"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGCAADPEXPZ0','50','H','01','13',NULL,'HCE Code',NULL,NULL,'"HCE Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGCAADPEXPZ0','50','H','01','14',NULL,'Employee Status',NULL,NULL,'"Employee Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGCAADPEXPZ0','50','H','01','15',NULL,'YTD Gross Compensation',NULL,NULL,'"YTD Gross Compensation"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGCAADPEXPZ0','50','H','01','16',NULL,'Pretax Elective Deferral $',NULL,NULL,'"Pretax Elective Deferral $ "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGCAADPEXPZ0','50','H','01','17',NULL,'Roth Elective Deferrals $',NULL,NULL,'"Roth Elective Deferrals $ "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGCAADPEXPZ0','50','H','01','18',NULL,'Date of Plan Eligibility',NULL,NULL,'"Date of Plan Eligibility"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGCAADPEXPZ0','50','H','01','19',NULL,'Plan Compensation PTD',NULL,NULL,'"Plan Compensation PTD "','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGCAADPEXPZ0','50','H','01','20',NULL,'Gross Compensation PTD',NULL,NULL,'"Gross Compensation PTD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGCAADPEXPZ0','50','H','01','21',NULL,'Eligible Gross Compensation YTD',NULL,NULL,'"Eligible Gross Compensation YTD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGCAADPEXPZ0','50','H','01','23',NULL,'Date of Match Eligibility',NULL,NULL,'"Date of Match Eligibility"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGCAADPEXPZ0','50','H','01','24',NULL,'Alt Eligibility Date',NULL,NULL,'"Alt Eligibility Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGCAADPEXPZ0','50','H','01','25',NULL,'Hours Worked PTD',NULL,NULL,'"Hours Worked PTD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGCAADPEXPZ0','50','H','01','26',NULL,'Hours Worked YTD',NULL,NULL,'"Hours Worked YTD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGCAADPEXPZ0','50','H','01','27',NULL,'Company Code',NULL,NULL,'"Company Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGCAADPEXPZ0','50','H','01','28',NULL,'Loan Number(s)',NULL,NULL,'"Loan Number(s)"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGCAADPEXPZ0','50','H','01','29',NULL,'Loan Repayment Amount 1',NULL,NULL,'"Loan Repayment Amount 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGCAADPEXPZ0','50','H','01','30',NULL,'Loan Repayment Amount 2',NULL,NULL,'"Loan Repayment Amount 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGCAADPEXPZ0','50','H','01','31',NULL,'Union Indicator',NULL,NULL,'"Union Indicator"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGCAADPEXPZ0','50','H','01','32',NULL,'Employer Match',NULL,NULL,'"Employer Match"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGCAADPEXPZ0','50','H','01','33',NULL,'Non-Elective Contributions',NULL,NULL,'"Non-Elective Contributions"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGCAADPEXPZ0','50','D','10','1',NULL,'Check Date',NULL,NULL,'"drvCheckDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGCAADPEXPZ0','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGCAADPEXPZ0','50','D','10','3',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGCAADPEXPZ0','50','D','10','4',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGCAADPEXPZ0','50','D','10','5',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGCAADPEXPZ0','50','D','10','6',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGCAADPEXPZ0','50','D','10','7',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGCAADPEXPZ0','50','D','10','8',NULL,'ZIP Code',NULL,NULL,'"drvZIPCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGCAADPEXPZ0','50','D','10','9',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGCAADPEXPZ0','50','D','10','10',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGCAADPEXPZ0','50','D','10','11',NULL,'Date of Termination',NULL,NULL,'"drvDateofTermination"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGCAADPEXPZ0','50','D','10','12',NULL,'Date of Rehire',NULL,NULL,'"drvDateofRehire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGCAADPEXPZ0','50','D','10','13',NULL,'HCE Code',NULL,NULL,'"drvHCECode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGCAADPEXPZ0','50','D','10','14',NULL,'Employee Status',NULL,NULL,'"drvEmployeeStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGCAADPEXPZ0','50','D','10','15',NULL,'YTD Gross Compensation',NULL,NULL,'"drvYTDGrossCompensation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGCAADPEXPZ0','50','D','10','16',NULL,'Pretax Elective Deferral $',NULL,NULL,'"drvPretaxElectiveDeferral"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGCAADPEXPZ0','50','D','10','17',NULL,'Roth Elective Deferrals $',NULL,NULL,'"drvRothElectiveDeferrals"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGCAADPEXPZ0','50','D','10','18',NULL,'Date of Plan Eligibility',NULL,NULL,'"drvDateofPlanEligibility"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGCAADPEXPZ0','50','D','10','19',NULL,'Plan Compensation PTD',NULL,NULL,'"drvPlanCompensationPTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGCAADPEXPZ0','50','D','10','20',NULL,'Gross Compensation PTD',NULL,NULL,'"drvGrossCompensationPTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGCAADPEXPZ0','50','D','10','21',NULL,'Eligible Gross',NULL,NULL,'"drvEligibleGrossCompensationYTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGCAADPEXPZ0','50','D','10','23',NULL,'Date of Match Eligibility',NULL,NULL,'"drvDateofMatchEligibility"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGCAADPEXPZ0','50','D','10','24',NULL,'Alt Eligibility Date',NULL,NULL,'"drvAltEligibilityDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGCAADPEXPZ0','50','D','10','25',NULL,'Hours Worked PTD',NULL,NULL,'"drvHoursWorkedPTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGCAADPEXPZ0','50','D','10','26',NULL,'Hours Worked YTD',NULL,NULL,'"drvHoursWorkedYTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGCAADPEXPZ0','50','D','10','27',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGCAADPEXPZ0','50','D','10','28',NULL,'Loan Number(s)',NULL,NULL,'"drvLoanNumbers"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGCAADPEXPZ0','50','D','10','29',NULL,'Loan Repayment Amount 1',NULL,NULL,'"drvLoanRepaymentAmount1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGCAADPEXPZ0','50','D','10','30',NULL,'Loan Repayment Amount 2',NULL,NULL,'"drvLoanRepaymentAmount2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGCAADPEXPZ0','50','D','10','31',NULL,'Union Indicator',NULL,NULL,'"drvUnionIndicator"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGCAADPEXPZ0','50','D','10','32',NULL,'Employer Match',NULL,NULL,'"drvEmployerMatch"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGCAADPEXPZ0','50','D','10','33',NULL,'Non-Elective Contributions',NULL,NULL,'"drvNonElectiveContributions"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EGCAADPEXP_20211216.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Export','202112169','EMPEXPORT','ONDEM_XOE','Dec 16 2021 12:00AM','EGCAADPEXP',NULL,NULL,NULL,'202112169','Dec 16 2021 12:00AM','Dec 30 1899 12:00AM','202112161',NULL,'','ARMSE,ARMFT,COBPAY,CPAY,RMAUS,RMCHN,RMUK,USPAY','202112161',dbo.fn_GetTimedKey(),NULL,'US3CPEGRE5000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Export-Sched','202112169','EMPEXPORT','SCH_EGCAAD','Dec 16 2021 12:00AM','EGCAADPEXP',NULL,NULL,NULL,'202112169','Dec 16 2021 12:00AM','Dec 30 1899 12:00AM','202112161',NULL,'',NULL,'202112161',dbo.fn_GetTimedKey(),NULL,'US3CPEGRE5000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'ADP 401K Export-Test','202112109','EMPEXPORT','TEST_XOE','Dec 16 2021  9:55PM','EGCAADPEXP',NULL,NULL,NULL,'202112109','Dec 10 2021 12:00AM','Dec 30 1899 12:00AM','202112031','750','eecPayGroup','','202112031',dbo.fn_GetTimedKey(),NULL,'US3CPEGRE5000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','IsUTF','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGCAADPEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGCAADPEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGCAADPEXP','D10','dbo.U_EGCAADPEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EGCAADPEXP_Audit
-----------

IF OBJECT_ID('U_EGCAADPEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EGCAADPEXP_AuditFields
-----------

IF OBJECT_ID('U_EGCAADPEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EGCAADPEXP_DedList
-----------

IF OBJECT_ID('U_EGCAADPEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EGCAADPEXP_drvTbl
-----------

IF OBJECT_ID('U_EGCAADPEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvCheckDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIPCode] varchar(5) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofHire] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvDateofRehire] datetime NULL,
    [drvHCECode] varchar(1) NOT NULL,
    [drvEmployeeStatus] varchar(10) NOT NULL,
    [drvYTDGrossCompensation] varchar(30) NULL,
    [drvPretaxElectiveDeferral] varchar(30) NULL,
    [drvRothElectiveDeferrals] varchar(30) NULL,
    [drvDateofPlanEligibility] varchar(1) NOT NULL,
    [drvPlanCompensationPTD] varchar(30) NULL,
    [drvGrossCompensationPTD] varchar(30) NULL,
    [drvEligibleGrossCompensationYTD] varchar(30) NULL,
    [drvDateofMatchEligibility] varchar(1) NOT NULL,
    [drvAltEligibilityDate] varchar(1) NOT NULL,
    [drvHoursWorkedPTD] varchar(30) NULL,
    [drvHoursWorkedYTD] varchar(30) NULL,
    [drvCompanyCode] varchar(5) NOT NULL,
    [drvLoanNumbers] varchar(1) NOT NULL,
    [drvLoanRepaymentAmount1] varchar(30) NULL,
    [drvLoanRepaymentAmount2] varchar(30) NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvEmployerMatch] varchar(30) NULL,
    [drvNonElectiveContributions] varchar(1) NOT NULL
);

-----------
-- Create table U_EGCAADPEXP_EEList
-----------

IF OBJECT_ID('U_EGCAADPEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGCAADPEXP_File
-----------

IF OBJECT_ID('U_EGCAADPEXP_File') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EGCAADPEXP_PDedHist
-----------

IF OBJECT_ID('U_EGCAADPEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTaxElective] numeric NULL,
    [PdhRothElective] numeric NULL,
    [PdhLoan1] numeric NULL,
    [PdhLoan2] numeric NULL,
    [PdhEmployerMatch] numeric NULL
);

-----------
-- Create table U_EGCAADPEXP_PEarHist
-----------

IF OBJECT_ID('U_EGCAADPEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EGCAADPEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGCAADPEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Great Canadian Railtour

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 12/16/2021
Service Request Number: TekP-2021-08-24-0003

Purpose: ADP 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGCAADPEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGCAADPEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGCAADPEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGCAADPEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGCAADPEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGCAADPEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGCAADPEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGCAADPEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGCAADPEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGCAADPEXP', 'SCH_EGCAAD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EGCAADPEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EGCAADPEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EGCAADPEXP';

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
    DELETE FROM dbo.U_EGCAADPEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EGCAADPEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ARPN1,ARPN2,ARPER,ULOAN,ULN2';

    IF OBJECT_ID('U_EGCAADPEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EGCAADPEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EGCAADPEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPreTaxElective     = SUM(CASE WHEN PdhDedCode IN ('ARPN1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothElective     = SUM(CASE WHEN PdhDedCode IN ('ARPN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan1    = SUM(CASE WHEN PdhDedCode IN ('ULOAN') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhLoan2     = SUM(CASE WHEN PdhDedCode IN ('ULN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhEmployerMatch     = SUM(CASE WHEN PdhDedCode IN ('ARPER') THEN PdhERCurAmt ELSE 0.00 END)
    INTO dbo.U_EGCAADPEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EGCAADPEXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EGCAADPEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND pehEarnCode not in ('UEXP') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN pehEarnCode not in ('UEXP') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EGCAADPEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    
    --Audit Table
    IF OBJECT_ID('U_EGCAADPEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_AuditFields;
    CREATE TABLE dbo.U_EGCAADPEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EGCAADPEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EGCAADPEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EGCAADPEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EGCAADPEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EGCAADPEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN CAST('01/01/' + CONVERT(varchar,YEAR(@EndDate)) as datetime) AND CAST('12/31/' + CONVERT(varchar,YEAR(@EndDate)) as datetime);
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EGCAADPEXP_Audit ON dbo.U_EGCAADPEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EGCAADPEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGCAADPEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGCAADPEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvCheckDate = CAST(PayDate as DATETIME)
        ,drvSSN = eepSSN
        ,drvEmployeeName = CONCAT(eepNameFirst, ' ' , isnull(eepNameLast,''))
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZIPCode = LEFT(EepAddressZipCode,5)
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateofHire = EecDateOfOriginalHire
        ,drvDateofTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateofRehire = CASE WHEN EecDateOfOriginalHire <> eecDateofLastHire THEN eecDateofLastHire END
        ,drvHCECode = CASE WHEN eecIsHighlyComp = 'Y' THEN 'Y' ElSE 'N' END
        ,drvEmployeeStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA'
                                  WHEN EecEmplStatus = 'T' THEN 'Terminated'
                                  ELSE 'Active'
                             END
        ,drvYTDGrossCompensation = CAST(CONVERT(DECIMAL(10,2),PehCurAmtYTD) as varchar)
        ,drvPretaxElectiveDeferral = CAST(CONVERT(DECIMAL(10,2),PdhPreTaxElective) as varchar)
        ,drvRothElectiveDeferrals = CAST(CONVERT(DECIMAL(10,2),PdhRothElective) as varchar)
        ,drvDateofPlanEligibility = ''
        ,drvPlanCompensationPTD = CAST(CONVERT(DECIMAL(10,2),PehInclInDefComp) as varchar)
        ,drvGrossCompensationPTD = CAST(CONVERT(DECIMAL(10,2),PehCurAmt) as varchar)
        ,drvEligibleGrossCompensationYTD = CAST(CONVERT(DECIMAL(10,2),PehCurAmtYTD) as varchar)
        ,drvDateofMatchEligibility = ''
        ,drvAltEligibilityDate = ''
        ,drvHoursWorkedPTD = CAST(CONVERT(DECIMAL(10,2),PehInclInDefCompHrs) as varchar)
        ,drvHoursWorkedYTD = CAST(CONVERT(DECIMAL(10,2),PehInclInDefCompHrsYTD) as varchar)
        ,drvCompanyCode = 'ARMUS'
        ,drvLoanNumbers = ''
        ,drvLoanRepaymentAmount1 = CAST(CONVERT(DECIMAL(10,2),PdhLoan1) as varchar) 
        ,drvLoanRepaymentAmount2 = CAST(CONVERT(DECIMAL(10,2),PdhLoan2) as varchar)
        ,drvUnionIndicator = ''
        ,drvEmployerMatch = CAST(CONVERT(DECIMAL(10,2),PdhEmployerMatch) as varchar)
        ,drvNonElectiveContributions = ''
    INTO dbo.U_EGCAADPEXP_drvTbl
    FROM dbo.U_EGCAADPEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EGCAADPEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EGCAADPEXP_PEarHist WITH (NOLOCK)
        on PehEEID  = xEEID 
    LEFT JOIN dbo.U_EGCAADPEXP_PDedHist  WITH (NOLOCK)
        on Pdheeid = xeeid
    LEFT JOIN (SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PD on eecpaygroup = PgpPayGroup
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
ALTER VIEW dbo.dsi_vwEGCAADPEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGCAADPEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EGCAADPEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112091'
       ,expStartPerControl     = '202112091'
       ,expLastEndPerControl   = '202112169'
       ,expEndPerControl       = '202112169'
WHERE expFormatCode = 'EGCAADPEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGCAADPEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGCAADPEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGCAADPEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGCAADPEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGCAADPEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGCAADPEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGCAADPEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGCAADPEXP', 'UseFileName', 'V', 'Y'


-- End ripout