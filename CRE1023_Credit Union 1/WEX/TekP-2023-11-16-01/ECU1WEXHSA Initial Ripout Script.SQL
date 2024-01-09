/**********************************************************************************

ECU1WEXHSA: WEX HSA Export

FormatCode:     ECU1WEXHSA
Project:        WEX HSA Export
Client ID:      USG1000
Date/time:      2024-01-09 14:38:41.707
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ECU1WEXHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECU1WEXHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECU1WEXHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECU1WEXHSA'


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
WHERE FormatCode = 'ECU1WEXHSA'
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
WHERE ExpFormatCode = 'ECU1WEXHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECU1WEXHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECU1WEXHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECU1WEXHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECU1WEXHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECU1WEXHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECU1WEXHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECU1WEXHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECU1WEXHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECU1WEXHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECU1WEXHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECU1WEXHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECU1WEXHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECU1WEXHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECU1WEXHSA];
GO
IF OBJECT_ID('U_ECU1WEXHSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_Trailer];
GO
IF OBJECT_ID('U_ECU1WEXHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_PEarHist];
GO
IF OBJECT_ID('U_ECU1WEXHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_PDedHist];
GO
IF OBJECT_ID('U_ECU1WEXHSA_Header') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_Header];
GO
IF OBJECT_ID('U_ECU1WEXHSA_File') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_File];
GO
IF OBJECT_ID('U_ECU1WEXHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_EEList];
GO
IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_drvTbl_PT];
GO
IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_drvTbl_EN];
GO
IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_drvTbl_CT];
GO
IF OBJECT_ID('U_ECU1WEXHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_DedList];
GO
IF OBJECT_ID('U_ECU1WEXHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_AuditFields];
GO
IF OBJECT_ID('U_ECU1WEXHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECU1WEXHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECU1WEXHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECU1WEXHSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECU1WEXHSA','WEX HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECU1WEXHSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECU1WEXHSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECU1WEXHSAZ0','3','H','01','2',NULL,'Administrator Code',NULL,NULL,'"drvAdministratorCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECU1WEXHSAZ0','6','H','01','3',NULL,'Employer Code',NULL,NULL,'"drvEmployerCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECU1WEXHSAZ0','1','H','01','4',NULL,'Synchronize Flag',NULL,NULL,'"drvSynchronizeFlag"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECU1WEXHSAZ0','8','H','01','5',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECU1WEXHSAZ0','6','H','01','6',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECU1WEXHSAZ0','6','H','01','7',NULL,'File Version',NULL,NULL,'"drvFileVersion"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECU1WEXHSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECU1WEXHSAZ0','50','D','10','2',NULL,'Participant File Import ID',NULL,NULL,'"drvParticipantFileImportID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECU1WEXHSAZ0','20','D','10','3',NULL,'Employer Employee ID',NULL,NULL,'"drvEmployerEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECU1WEXHSAZ0','15','D','10','4',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECU1WEXHSAZ0','30','D','10','5',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECU1WEXHSAZ0','30','D','10','6',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECU1WEXHSAZ0','1','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECU1WEXHSAZ0','1','D','10','8',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECU1WEXHSAZ0','1','D','10','9',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECU1WEXHSAZ0','50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL,'"drvMothersMaidenDame"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECU1WEXHSAZ0','8','D','10','11',NULL,'Date Of Birth',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECU1WEXHSAZ0','9','D','10','12',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECU1WEXHSAZ0','50','D','10','13',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECU1WEXHSAZ0','50','D','10','14',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECU1WEXHSAZ0','50','D','10','15',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECU1WEXHSAZ0','50','D','10','16',NULL,'Address Line 4',NULL,NULL,'"drvAddressLine4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECU1WEXHSAZ0','30','D','10','17',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECU1WEXHSAZ0','2','D','10','18',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECU1WEXHSAZ0','10','D','10','19',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECU1WEXHSAZ0','2','D','10','20',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECU1WEXHSAZ0','10','D','10','21',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECU1WEXHSAZ0','10','D','10','22',NULL,'Work Phone',NULL,NULL,'"drvWorkPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECU1WEXHSAZ0','6','D','10','23',NULL,'Work Phone Extension',NULL,NULL,'"drvWorkPhoneExtension"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECU1WEXHSAZ0','125','D','10','24',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECU1WEXHSAZ0','100','D','10','25',NULL,'Username',NULL,NULL,'"drvUsername"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECU1WEXHSAZ0','100','D','10','26',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECU1WEXHSAZ0','8','D','10','27',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECU1WEXHSAZ0','100','D','10','28',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECU1WEXHSAZ0','2','D','10','29',NULL,'Hours Per Week',NULL,NULL,'"drvHoursPerWeek"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECU1WEXHSAZ0','100','D','10','30',NULL,'Employee Class',NULL,NULL,'"drvEmployeeClass"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECU1WEXHSAZ0','100','D','10','31',NULL,'Payroll  Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECU1WEXHSAZ0','8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL,'"drvPayrollFrequencyEffDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECU1WEXHSAZ0','20','D','10','33',NULL,'Participant Status',NULL,NULL,'"drvParticipantStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECU1WEXHSAZ0','8','D','10','34',NULL,'Status Effective Date',NULL,NULL,'"drvStatusEffictiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECU1WEXHSAZ0','1','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL,'"drvHoldPayroilDeductions"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECU1WEXHSAZ0','1','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL,'"drvHoldEmployerContributions"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECU1WEXHSAZ0','1','D','10','37',NULL,'Incur Services',NULL,NULL,'"drvIncurServices"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECU1WEXHSAZ0','8','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL,'"drvFinalPayrollProcessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECU1WEXHSAZ0','8','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL,'"drvFinalContribProcessDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECU1WEXHSAZ0','100','D','10','40',NULL,'HSA Custodian',NULL,NULL,'"drvHSACustodian"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECU1WEXHSAZ0','1','D','10','41',NULL,'Medicare Beneficiary',NULL,NULL,'"drvMedicareBeneficiary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECU1WEXHSAZ0','12','D','10','42',NULL,'Medicare ID',NULL,NULL,'"drvMedicareID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECU1WEXHSAZ0','50','D','10','43',NULL,'Exchange Integration ID',NULL,NULL,'"drvExchangeIntegrationID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECU1WEXHSAZ0','100','D','10','44',NULL,'Reporting Hierarchy Level 1',NULL,NULL,'"drvReportingHierarchyLevel1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECU1WEXHSAZ0','100','D','10','45',NULL,'Reporting Hierarchy Level 2',NULL,NULL,'"drvReportingHierarchyLevel2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECU1WEXHSAZ0','100','D','10','46',NULL,'Reporting Hierarchy Level 3',NULL,NULL,'"drvReportingHierarchyLevel3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECU1WEXHSAZ0','100','D','10','47',NULL,'Reporting Hierarchy Level 4',NULL,NULL,'"drvReportingHierarchyLevel4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECU1WEXHSAZ0','20','D','10','48',NULL,'CDD_Citizenshi p',NULL,NULL,'"drvCDDCitizenship"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECU1WEXHSAZ0','2','D','10','49',NULL,'CDD_Country',NULL,NULL,'"drvCDDCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECU1WEXHSAZ0','20','D','10','50',NULL,'CDD_Employm entStatus',NULL,NULL,'"drvCDDEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECU1WEXHSAZ0','30','D','10','51',NULL,'CDD_Employer',NULL,NULL,'"drvCDDEmployer"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECU1WEXHSAZ0','30','D','10','52',NULL,'CDD_JobTitle',NULL,NULL,'"drvCDDJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECU1WEXHSAZ0','8','D','10','53',NULL,'Class Effective Date',NULL,NULL,'"drvClassEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECU1WEXHSAZ0','20','D','10','54',NULL,'ID_Identification Type',NULL,NULL,'"drvIDIdentificationType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECU1WEXHSAZ0','30','D','10','55',NULL,'ID_Identification Number',NULL,NULL,'"drvIDIdentificationNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECU1WEXHSAZ0','2','D','10','56',NULL,'ID_IssuingState',NULL,NULL,'"drvIDIssuingState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECU1WEXHSAZ0','50','D','10','57',NULL,'ID_Issuer',NULL,NULL,'"drvIDIssuer"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECU1WEXHSAZ0','8','D','10','58',NULL,'ID_IssueDate',NULL,NULL,'"drvIDIssueDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECU1WEXHSAZ0','8','D','10','59',NULL,'ID_ExpirationDa te',NULL,NULL,'"drvIDExpirationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECU1WEXHSAZ0','20','D','10','60',NULL,'Mobile Carrier',NULL,NULL,'"drvMobileCarrier"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECU1WEXHSAZ0','10','D','10','61',NULL,'Mobile Number',NULL,NULL,'"drvMobileNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECU1WEXHSAZ0','15','D','10','62',NULL,'Time Zone',NULL,NULL,'"drvTimeZone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECU1WEXHSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECU1WEXHSAZ0','50','D','20','2',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantFileImportID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECU1WEXHSAZ0','100','D','20','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECU1WEXHSAZ0','8','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL,'"drvEnrollmentEffectiveDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECU1WEXHSAZ0','8','D','20','5',NULL,'Participant Election Amount',NULL,NULL,'"drvParticipantElectionAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECU1WEXHSAZ0','8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL,'"drvEmployerTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECU1WEXHSAZ0','10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL,'"drvEmployerContibLevel"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECU1WEXHSAZ0','8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL,'"drvEmployerContribAmt"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECU1WEXHSAZ0','30','D','20','9',NULL,'Primary Reimbursement',NULL,NULL,'"drvPrimaryReimbursement"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECU1WEXHSAZ0','30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL,'"drvAlternateReimbursement"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECU1WEXHSAZ0','1','D','20','11',NULL,'Enrolled In Claims',NULL,NULL,'"drvEnrolledInClaims"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECU1WEXHSAZ0','8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL,'"drvElectionAmtInd"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECU1WEXHSAZ0','6','D','20','13',NULL,'HDHP  Coverage Level',NULL,NULL,'"drvHDHP"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECU1WEXHSAZ0','8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL,'"drvPlanYearStartDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECU1WEXHSAZ0','1','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL,'"drvTermsCondtionsAccepted"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECU1WEXHSAZ0','8','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL,'"drvDateTermsCondAccepted"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECU1WEXHSAZ0','6','D','20','17',NULL,'Time Terms  Conditions  Accepted',NULL,NULL,'"drvTimeTerms"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECU1WEXHSAZ0','8','D','20','18',NULL,'Change Date',NULL,NULL,'"drvChangeDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECU1WEXHSAZ0','1','D','20','19',NULL,'Spend Down',NULL,NULL,'"drvSpendDown"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECU1WEXHSAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECU1WEXHSAZ0','50','D','30','2',NULL,'Participant File Import Id',NULL,NULL,'"drvParticipantFileImportID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECU1WEXHSAZ0','100','D','30','3',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECU1WEXHSAZ0','8','D','30','4',NULL,'Contribution Date',NULL,NULL,'"drvContribDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECU1WEXHSAZ0','30','D','30','5',NULL,'Contribution Description',NULL,NULL,'"drvContribDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECU1WEXHSAZ0','9','D','30','6',NULL,'Contribution Amount',NULL,NULL,'"drvContribAmt"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECU1WEXHSAZ0','6','D','30','7',NULL,'Amount Type',NULL,NULL,'"drvAmountType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECU1WEXHSAZ0','7','D','30','8',NULL,'Tax Year',NULL,NULL,'"drvTaxYear"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECU1WEXHSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECU1WEXHSAZ0','20','T','90','2',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECU1WEXHSAZ0','3','T','90','3',NULL,'Administrator Code',NULL,NULL,'"drvAdministratorCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECU1WEXHSAZ0','6','T','90','4',NULL,'Employer Code',NULL,NULL,'"drvEmployerCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECU1WEXHSAZ0','8','T','90','5',NULL,'Submitted Date',NULL,NULL,'"drvSubmittedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECU1WEXHSAZ0','6','T','90','6',NULL,'Submitted Time',NULL,NULL,'"drvSubmittedTime"','(''UA''=''T|'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECU1WEXHSA_20240109.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202401099','EMPEXPORT','OEACTIVE',NULL,'ECU1WEXHSA',NULL,NULL,NULL,'202401099','Jan  9 2024  1:35PM','Jan  9 2024  1:35PM','202401091',NULL,'','','202401091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202401099','EMPEXPORT','OEPASSIVE',NULL,'ECU1WEXHSA',NULL,NULL,NULL,'202401099','Jan  9 2024  1:35PM','Jan  9 2024  1:35PM','202401091',NULL,'','','202401091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX HSA Export','202401099','EMPEXPORT','ONDEM_XOE',NULL,'ECU1WEXHSA',NULL,NULL,NULL,'202401099','Jan  9 2024  1:35PM','Jan  9 2024  1:35PM','202401091',NULL,'','','202401091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX HSA Export-Sched','202401099','EMPEXPORT','SCH_ECREWE',NULL,'ECU1WEXHSA',NULL,NULL,NULL,'202401099','Jan  9 2024  1:35PM','Jan  9 2024  1:35PM','202401091',NULL,'','','202401091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WEX HSA Export-Test','202401099','EMPEXPORT','TEST_XOE',NULL,'ECU1WEXHSA',NULL,NULL,NULL,'202401099','Jan  9 2024  1:35PM','Jan  9 2024  1:35PM','202401091',NULL,'','','202401091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECU1WEXHSA','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECU1WEXHSA','H01','dbo.U_ECU1WEXHSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECU1WEXHSA','D10','dbo.U_ECU1WEXHSA_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECU1WEXHSA','D20','dbo.U_ECU1WEXHSA_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECU1WEXHSA','D30','dbo.U_ECU1WEXHSA_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECU1WEXHSA','T90','dbo.U_ECU1WEXHSA_Trailer',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECU1WEXHSA
-----------

IF OBJECT_ID('U_dsi_BDM_ECU1WEXHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECU1WEXHSA] (
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
-- Create table U_ECU1WEXHSA_Audit
-----------

IF OBJECT_ID('U_ECU1WEXHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_Audit] (
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
-- Create table U_ECU1WEXHSA_AuditFields
-----------

IF OBJECT_ID('U_ECU1WEXHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECU1WEXHSA_DedList
-----------

IF OBJECT_ID('U_ECU1WEXHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECU1WEXHSA_drvTbl_CT
-----------

IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_CT') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_drvTbl_CT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] varchar(22) NOT NULL,
    [drvContribDate] varchar(8000) NULL,
    [drvContribDesc] varchar(17) NOT NULL,
    [drvContribAmt] nvarchar(4000) NULL,
    [drvAmountType] varchar(7) NOT NULL,
    [drvTaxYear] varchar(8) NOT NULL
);

-----------
-- Create table U_ECU1WEXHSA_drvTbl_EN
-----------

IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvPlanName] varchar(22) NOT NULL,
    [drvEnrollmentEffectiveDate] varchar(8000) NULL,
    [drvParticipantElectionAmount] nvarchar(4000) NULL,
    [drvEmployerTerminationDate] varchar(8000) NULL,
    [drvEmployerContibLevel] varchar(1) NOT NULL,
    [drvEmployerContribAmt] varchar(1) NOT NULL,
    [drvPrimaryReimbursement] varchar(1) NOT NULL,
    [drvAlternateReimbursement] varchar(1) NOT NULL,
    [drvEnrolledInClaims] varchar(1) NOT NULL,
    [drvElectionAmtInd] varchar(6) NOT NULL,
    [drvHDHP] varchar(6) NULL,
    [drvPlanYearStartDate] varchar(1) NOT NULL,
    [drvTermsCondtionsAccepted] varchar(1) NOT NULL,
    [drvDateTermsCondAccepted] varchar(1) NOT NULL,
    [drvTimeTerms] varchar(1) NOT NULL,
    [drvChangeDate] varchar(1) NOT NULL,
    [drvSpendDown] varchar(1) NOT NULL
);

-----------
-- Create table U_ECU1WEXHSA_drvTbl_PT
-----------

IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_PT') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_drvTbl_PT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvParticipantFileImportID] char(11) NULL,
    [drvEmployerEmployeeID] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvMothersMaidenDame] varchar(1) NOT NULL,
    [drvDateOfBirth] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressLine4] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExtension] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvUsername] varchar(1) NOT NULL,
    [drvPassword] varchar(1) NOT NULL,
    [drvHireDate] varchar(8000) NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvHoursPerWeek] varchar(1) NOT NULL,
    [drvEmployeeClass] varchar(1) NOT NULL,
    [drvPayrollFrequency] varchar(7) NOT NULL,
    [drvPayrollFrequencyEffDate] varchar(1) NOT NULL,
    [drvParticipantStatus] varchar(10) NOT NULL,
    [drvStatusEffictiveDate] varchar(8000) NULL,
    [drvHoldPayroilDeductions] varchar(1) NOT NULL,
    [drvHoldEmployerContributions] varchar(1) NOT NULL,
    [drvIncurServices] varchar(1) NOT NULL,
    [drvFinalPayrollProcessDate] varchar(8000) NULL,
    [drvFinalContribProcessDate] varchar(8000) NULL,
    [drvHSACustodian] varchar(1) NOT NULL,
    [drvMedicareBeneficiary] varchar(1) NOT NULL,
    [drvMedicareID] varchar(1) NOT NULL,
    [drvExchangeIntegrationID] varchar(1) NOT NULL,
    [drvReportingHierarchyLevel1] varchar(1) NOT NULL,
    [drvReportingHierarchyLevel2] varchar(1) NOT NULL,
    [drvReportingHierarchyLevel3] varchar(1) NOT NULL,
    [drvReportingHierarchyLevel4] varchar(1) NOT NULL,
    [drvCDDCitizenship] varchar(1) NOT NULL,
    [drvCDDCountry] varchar(1) NOT NULL,
    [drvCDDEmploymentStatus] varchar(1) NOT NULL,
    [drvCDDEmployer] varchar(1) NOT NULL,
    [drvCDDJobTitle] varchar(1) NOT NULL,
    [drvClassEffectiveDate] varchar(1) NOT NULL,
    [drvIDIdentificationType] varchar(1) NOT NULL,
    [drvIDIdentificationNumber] varchar(1) NOT NULL,
    [drvIDIssuingState] varchar(1) NOT NULL,
    [drvIDIssuer] varchar(1) NOT NULL,
    [drvIDIssueDate] varchar(1) NOT NULL,
    [drvIDExpirationDate] varchar(1) NOT NULL,
    [drvMobileCarrier] varchar(1) NOT NULL,
    [drvMobileNumber] varchar(1) NOT NULL,
    [drvTimeZone] varchar(1) NOT NULL
);

-----------
-- Create table U_ECU1WEXHSA_EEList
-----------

IF OBJECT_ID('U_ECU1WEXHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECU1WEXHSA_File
-----------

IF OBJECT_ID('U_ECU1WEXHSA_File') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECU1WEXHSA_Header
-----------

IF OBJECT_ID('U_ECU1WEXHSA_Header') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_Header] (
    [drvRecordType] varchar(2) NOT NULL,
    [drvAdministratorCode] varchar(3) NOT NULL,
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSynchronizeFlag] varchar(1) NOT NULL,
    [drvSubmittedDate] varchar(8) NULL,
    [drvSubmittedTime] varchar(6) NULL,
    [drvFileVersion] varchar(3) NOT NULL
);

-----------
-- Create table U_ECU1WEXHSA_PDedHist
-----------

IF OBJECT_ID('U_ECU1WEXHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL
);

-----------
-- Create table U_ECU1WEXHSA_PEarHist
-----------

IF OBJECT_ID('U_ECU1WEXHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_PEarHist] (
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
-- Create table U_ECU1WEXHSA_Trailer
-----------

IF OBJECT_ID('U_ECU1WEXHSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECU1WEXHSA_Trailer] (
    [drvRecordType] varchar(2) NOT NULL,
    [drvRecordCount] int NULL,
    [drvAdministratorCode] varchar(3) NOT NULL,
    [drvEmployerCode] varchar(5) NOT NULL,
    [drvSubmittedDate] varchar(8) NULL,
    [drvSubmittedTime] varchar(6) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECU1WEXHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Credit Union 1

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/09/2024
Service Request Number: TekP-2023-11-16-01

Purpose: WEX HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2024     SR-2024-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECU1WEXHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECU1WEXHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECU1WEXHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECU1WEXHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECU1WEXHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECU1WEXHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECU1WEXHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECU1WEXHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECU1WEXHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECU1WEXHSA', 'SCH_ECREWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECU1WEXHSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECU1WEXHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(6)         
            ,@PlanYearStart     DATETIME
            ,@FileMinCovDate    DATETIME;


    -- Set FormatCode
    SELECT @FormatCode = 'ECU1WEXHSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = REPLACE(CONVERT (CHAR(10),GETDATE(), 101),'/','')
        ,@RunTime         = format(getdate(),'HHmmss')
        ,@FileMinCovDate  = '01/01/2024'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECU1WEXHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECU1WEXHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECU1WEXHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_AuditFields;
    CREATE TABLE dbo.U_ECU1WEXHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_ECU1WEXHSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECU1WEXHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_Audit;
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
    INTO dbo.U_ECU1WEXHSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECU1WEXHSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECU1WEXHSA_Audit ON dbo.U_ECU1WEXHSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ECU1WEXHSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECU1WEXHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAI,HSAF,HSAER,HSACI,HSACF';

    IF OBJECT_ID('U_ECU1WEXHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECU1WEXHSA_DedList
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
    IF OBJECT_ID('U_ECU1WEXHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ECU1WEXHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECU1WEXHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    and PdhDedCode IN  ('HSAI', 'HSAF', 'HSACI', 'HSACF', 'HSAER')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_PEarHist;
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
    INTO dbo.U_ECU1WEXHSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECU1WEXHSA_drvTbl_PT
    ---------------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2'
        ,drvSubSort = xeeid
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'PT'
        ,drvParticipantFileImportID = eepssn
        ,drvEmployerEmployeeID = ''
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = dbo.dsi_fnRemoveChars('.,/-',EepNameLast)
        ,drvFirstName = dbo.dsi_fnRemoveChars('.,/-',EepNameFirst)
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvMaritalStatus = ''
        ,drvMothersMaidenDame = ''
        ,drvDateOfBirth = REPLACE(CONVERT (CHAR(10),EepDateOfBirth, 101),'/','')
        ,drvSSN = eepSSN
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',CASE WHEN Eepaddressline1 LIKE 'Po%' and eepaddressline2 is not null THEN  eepaddressline2 
                                ELSE Eepaddressline1
                            END)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',CASE WHEN Eepaddressline1 NOT LIKE 'Po%' and eepaddressline2 is null THEN  eepaddressline2                                 
                            END)
        ,drvAddressLine3 = ''
        ,drvAddressLine4 = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = 'US'
        ,drvHomePhone = ''--EepPhoneHomeNumber
        ,drvWorkPhone = ''--EecPhoneBusinessNumber
        ,drvWorkPhoneExtension = ''--EecPhoneBusinessNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvUsername = ''
        ,drvPassword = ''
        ,drvHireDate = REPLACE(CONVERT (CHAR(10),EecDateOfLastHire, 101),'/','')
        ,drvDivision = ''
        ,drvHoursPerWeek = ''
        ,drvEmployeeClass = 'E'
        ,drvPayrollFrequency = 'Payroll'
        ,drvPayrollFrequencyEffDate = ''
        ,drvParticipantStatus = CASE WHEN eecemplstatus = 'T' THEN 'Terminated' else  'Active' END
        ,drvStatusEffictiveDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination ELSE eecdateoflasthire END, 101),'/','')
        ,drvHoldPayroilDeductions = ''
        ,drvHoldEmployerContributions = ''
        ,drvIncurServices = ''
        ,drvFinalPayrollProcessDate =  REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination)END, 101),'/','')
        ,drvFinalContribProcessDate = REPLACE(CONVERT (CHAR(10),CASE WHEN eecemplstatus = 'T' THEN DATEADD(DAY, 30, EecDateOfTermination)END, 101),'/','')
        ,drvHSACustodian = ''
        ,drvMedicareBeneficiary = ''
        ,drvMedicareID = ''
        ,drvExchangeIntegrationID = ''
        ,drvReportingHierarchyLevel1 = ''
        ,drvReportingHierarchyLevel2 = ''
        ,drvReportingHierarchyLevel3 = ''
        ,drvReportingHierarchyLevel4 = ''
        ,drvCDDCitizenship = ''
        ,drvCDDCountry = ''--EepAddressCountry
        ,drvCDDEmploymentStatus = ''
        ,drvCDDEmployer = ''
        ,drvCDDJobTitle = ''
        ,drvClassEffectiveDate = ''
        ,drvIDIdentificationType = ''
        ,drvIDIdentificationNumber = ''
        ,drvIDIssuingState = ''--EepAddressState
        ,drvIDIssuer = ''
        ,drvIDIssueDate = ''
        ,drvIDExpirationDate = ''
        ,drvMobileCarrier = ''
        ,drvMobileNumber = ''
        ,drvTimeZone = ''
    INTO dbo.U_ECU1WEXHSA_drvTbl_PT
    FROM dbo.U_ECU1WEXHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ECU1WEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECU1WEXHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    LEFT JOIN dbo.U_ECU1WEXHSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
       WHERE (((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL)))
     OR ISNULL(PdhEECurAmt, 0.00) > 0.00)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECU1WEXHSA_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '3'
        ,drvSubSort = Xeeid
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'EN'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName =  'Health Savings Account' 
        ,drvEnrollmentEffectiveDate = REPLACE(CONVERT (CHAR(10),dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate), 101),'/','')
        ,drvParticipantElectionAmount = FORMAT(BdmEEGoalAmt, '0.00')
        ,drvEmployerTerminationDate = CASE WHEN EecEmplStatus <> 'T' AND BdmBenStopDate is not null  THEN REPLACE(CONVERT (CHAR(10), BdmBenStopDate, 101),'/','') END
        ,drvEmployerContibLevel = ''
        ,drvEmployerContribAmt = ''
        ,drvPrimaryReimbursement = ''
        ,drvAlternateReimbursement = ''
        ,drvEnrolledInClaims = ''
        ,drvElectionAmtInd = 'PerPay'
        ,drvHDHP = CASE WHEN Bdmdedcode in ('HSAI', 'HSACI', 'HSAER')  and Bdmbenoption = 'EE' THEN 'Single'
                        WHEN BdmDedCode in ('HSAF', 'HSACF')  and Bdmbenoption <> 'EE' THEN  'Family'
                    END
        ,drvPlanYearStartDate = ''
        ,drvTermsCondtionsAccepted = ''
        ,drvDateTermsCondAccepted = ''
        ,drvTimeTerms = ''
        ,drvChangeDate = ''
        ,drvSpendDown = ''
    INTO dbo.U_ECU1WEXHSA_drvTbl_EN
    FROM dbo.U_ECU1WEXHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECU1WEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode in ('HSAI', 'HSAF', 'HSACI', 'HSACF', 'HSAER')  
    LEFT JOIN dbo.U_ECU1WEXHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    LEFT JOIN dbo.U_ECU1WEXHSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID    
    WHERE (((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL)))
     OR ISNULL(PdhEECurAmt, 0.00) > 0.00)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECU1WEXHSA_drvTbl_CT
    ---------------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '4'
        ,drvSubSort = xeeid
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'CT'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName =  'Health Savings Account'
        ,drvContribDate = REPLACE(CONVERT (CHAR(10),PrgPayDate, 101),'/','')
        ,drvContribDesc = 'Payroll Deduction'
        ,drvContribAmt = CASE WHEN PdhEECurAmt > 0.00  then FORMAT(PdhEECurAmt, '0.00') END
        ,drvAmountType = 'Actual '
        ,drvTaxYear = 'Current '
    INTO dbo.U_ECU1WEXHSA_drvTbl_CT
    FROM dbo.U_ECU1WEXHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECU1WEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
       JOIN dbo.U_ECU1WEXHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    JOIN dbo.U_ECU1WEXHSA_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.U_ECU1WEXHSA_Audit WITH (NOLOCK)
        ON audEEID = xEEID
     WHERE (((eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' AND AudDateTime IS NOT NULL)))
     OR ISNULL(PdhEECurAmt, 0.00) > 0.00)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_Header;
    SELECT DISTINCT
         drvRecordType = 'FH'
        ,drvAdministratorCode = 'DBI'
        ,drvEmployerCode = '47326'
        ,drvSynchronizeFlag = 'N'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
        ,drvFileVersion = '3.5'
    INTO dbo.U_ECU1WEXHSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECU1WEXHSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECU1WEXHSA_Trailer;
    SELECT DISTINCT
         drvRecordType = 'FF'
        ,drvRecordCount = (SELECT COUNT(1) FROM dbo.U_ECU1WEXHSA_drvTbl_PT) +
                          (SELECT COUNT(1) FROM dbo.U_ECU1WEXHSA_drvTbl_EN) +
                          (SELECT COUNT(1) FROM dbo.U_ECU1WEXHSA_drvTbl_CT) 
        ,drvAdministratorCode = 'DBI'
        ,drvEmployerCode = '47326'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunTime
    INTO dbo.U_ECU1WEXHSA_Trailer
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
ALTER VIEW dbo.dsi_vwECU1WEXHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECU1WEXHSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECU1WEXHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202401021'
       ,expStartPerControl     = '202401021'
       ,expLastEndPerControl   = '202401099'
       ,expEndPerControl       = '202401099'
WHERE expFormatCode = 'ECU1WEXHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECU1WEXHSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECU1WEXHSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECU1WEXHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECU1WEXHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECU1WEXHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECU1WEXHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECU1WEXHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECU1WEXHSA', 'UseFileName', 'V', 'Y'


-- End ripout