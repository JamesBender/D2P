/**********************************************************************************

EASUMRFSAE: UMR FSA FSADC Export

FormatCode:     EASUMRFSAE
Project:        UMR FSA FSADC Export
Client ID:      USG1000
Date/time:      2024-01-23 16:33:05.557
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EASUMRFSAE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EASUMRFSAE_SavePath') IS NOT NULL DROP TABLE dbo.U_EASUMRFSAE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EASUMRFSAE'


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
WHERE FormatCode = 'EASUMRFSAE'
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
WHERE ExpFormatCode = 'EASUMRFSAE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EASUMRFSAE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EASUMRFSAE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EASUMRFSAE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EASUMRFSAE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EASUMRFSAE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EASUMRFSAE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EASUMRFSAE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EASUMRFSAE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EASUMRFSAE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EASUMRFSAE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEASUMRFSAE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASUMRFSAE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASUMRFSAE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASUMRFSAE];
GO
IF OBJECT_ID('U_EASUMRFSAE_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_Trailer];
GO
IF OBJECT_ID('U_EASUMRFSAE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_PEarHist];
GO
IF OBJECT_ID('U_EASUMRFSAE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_PDedHist];
GO
IF OBJECT_ID('U_EASUMRFSAE_Header') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_Header];
GO
IF OBJECT_ID('U_EASUMRFSAE_File') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_File];
GO
IF OBJECT_ID('U_EASUMRFSAE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_EEList];
GO
IF OBJECT_ID('U_EASUMRFSAE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_drvTbl];
GO
IF OBJECT_ID('U_EASUMRFSAE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_DedList];
GO
IF OBJECT_ID('U_EASUMRFSAE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_AuditFields];
GO
IF OBJECT_ID('U_EASUMRFSAE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASUMRFSAE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EASUMRFSAE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASUMRFSAE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASUMRFSAE','UMR FSA FSADC Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EASUMRFSAEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASUMRFSAEZ0','1','H','01','1',NULL,'Record Type ',NULL,NULL,'"H"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASUMRFSAEZ0','4','H','01','2',NULL,'Client Number ',NULL,NULL,'"drvClientNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASUMRFSAEZ0','30','H','01','3',NULL,'Client Name ',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASUMRFSAEZ0','30','H','01','4',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASUMRFSAEZ0','10','H','01','5',NULL,'Product Type ',NULL,NULL,'"drvProductType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASUMRFSAEZ0','20','H','01','6',NULL,'Process Type ',NULL,NULL,'"drvProcessType"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASUMRFSAEZ0','8','H','01','7',NULL,'File Creation Date ',NULL,NULL,'"drvFileCreation"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASUMRFSAEZ0','397','H','01','8',NULL,'Filler ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASUMRFSAEZ0','9','D','10','1',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSsn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASUMRFSAEZ0','20','D','10','2',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASUMRFSAEZ0','14','D','10','3',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASUMRFSAEZ0','8','D','10','4',NULL,'Payroll Date',NULL,NULL,'"drvPayrollDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASUMRFSAEZ0','7','D','10','5',NULL,'Employer Health Care Contribution',NULL,NULL,'"drvEmployerContributionHC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASUMRFSAEZ0','7','D','10','6',NULL,'Employee Health Care Contribution',NULL,NULL,'"drvEmployeeContributionHC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASUMRFSAEZ0','7','D','10','7',NULL,'Employer Dependent Care Contribution',NULL,NULL,'"drvEmployerContributionDC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASUMRFSAEZ0','7','D','10','8',NULL,'Employee Dependent Care Contribution',NULL,NULL,'"drvEmployeeContributionDC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASUMRFSAEZ0','3','D','10','9',NULL,'Limited Purpose FSA Indicator',NULL,NULL,'"drvLimitedIndicator"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASUMRFSAEZ0','4','D','10','10',NULL,'Group Location Code',NULL,NULL,'"drvGroupCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASUMRFSAEZ0','1','D','10','11',NULL,'Payroll Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASUMRFSAEZ0','2','D','10','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASUMRFSAEZ0','6','D','10','13',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASUMRFSAEZ0','30','D','10','14',NULL,'Address',NULL,NULL,'"drvAddressAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASUMRFSAEZ0','25','D','10','15',NULL,'Address 2',NULL,NULL,'"drvAddressAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASUMRFSAEZ0','20','D','10','16',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASUMRFSAEZ0','2','D','10','17',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASUMRFSAEZ0','9','D','10','18',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASUMRFSAEZ0','8','D','10','19',NULL,'Employee Coverage Effective Date – Health Care',NULL,NULL,'"drvEmployeeCovEffDateHC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASUMRFSAEZ0','8','D','10','20',NULL,'Employee Coverage Termination Date – Health Care',NULL,NULL,'"drvEmployeeCovTermDateHC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASUMRFSAEZ0','7','D','10','21',NULL,'Employee Annual Health Care Election Amount',NULL,NULL,'"drvEmpAnnHCElecAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASUMRFSAEZ0','8','D','10','22',NULL,'Automatic Reimbursement/Debit Card Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EASUMRFSAEZ0','1','D','10','23',NULL,'Automatic Reimbursement/Debit Card Indicator',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EASUMRFSAEZ0','8','D','10','24',NULL,'Employee Coverage Effective Date – Dep Care',NULL,NULL,'"drvEmployeeCovEffDateDC"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EASUMRFSAEZ0','8','D','10','25',NULL,'Employee Coverage Termination Date – Dep Care',NULL,NULL,'"drvEmployeeCovTermDateDC"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EASUMRFSAEZ0','7','D','10','26',NULL,'Employee Annual Dependent Care Election Amount',NULL,NULL,'"drvEmpAnnDCElecAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EASUMRFSAEZ0','15','D','10','27',NULL,'Bank Routing Transit Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EASUMRFSAEZ0','15','D','10','28',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EASUMRFSAEZ0','1','D','10','29',NULL,'Type of Bank Account',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EASUMRFSAEZ0','10','D','10','30',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EASUMRFSAEZ0','17','D','10','31',NULL,'Employee Bank Account Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EASUMRFSAEZ0','32','D','10','32',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EASUMRFSAEZ0','7','D','10','33',NULL,'Employer Annual Health Care Contribution Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EASUMRFSAEZ0','7','D','10','34',NULL,'Employer Annual Dependent Care Contribution Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EASUMRFSAEZ0','7','D','10','35',NULL,'Employee Parking Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EASUMRFSAEZ0','8','D','10','36',NULL,'Employee Coverage Effective Date – Parking',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EASUMRFSAEZ0','8','D','10','37',NULL,'Employee Coverage Termination Date – Parking',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EASUMRFSAEZ0','7','D','10','38',NULL,'Employee Transit Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EASUMRFSAEZ0','8','D','10','39',NULL,'Employee Coverage Effective Date – Transit',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EASUMRFSAEZ0','8','D','10','40',NULL,'Employee Coverage Termination Date – Transit',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EASUMRFSAEZ0','7','D','10','41',NULL,'Employer Parking Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EASUMRFSAEZ0','7','D','10','42',NULL,'Employer Transit Contribution',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EASUMRFSAEZ0','9','D','10','43',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EASUMRFSAEZ0','3','D','10','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EASUMRFSAEZ0','30','D','10','45',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EASUMRFSAEZ0','8','D','10','46',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EASUMRFSAEZ0','1','D','10','47',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EASUMRFSAEZ0','1','D','10','48',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EASUMRFSAEZ0','10','D','10','49',NULL,'Phone Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EASUMRFSAEZ0','1','D','10','50',NULL,'Middle Initial',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EASUMRFSAEZ0','9','D','10','51',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EASUMRFSAEZ0','7','D','10','52',NULL,'Employee Parking Monthly Election Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EASUMRFSAEZ0','7','D','10','53',NULL,'Employee Transit Monthly Election Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EASUMRFSAEZ0','7','D','10','54',NULL,'Employer Parking Monthly Contribution Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EASUMRFSAEZ0','7','D','10','55',NULL,'Employer Transit Monthly Contribution Amount',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASUMRFSAEZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"T"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASUMRFSAEZ0','8','T','90','2',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASUMRFSAEZ0','11','T','90','3',NULL,'Total Employer Health Contributions for this pay c',NULL,NULL,'"drvTotalERHCCont"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASUMRFSAEZ0','11','T','90','4',NULL,'Total Employee Health Contributions for this pay c',NULL,NULL,'"drvTotalEmpHCCont"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASUMRFSAEZ0','11','T','90','5',NULL,'Total Employer Dependent Care Contributions for th',NULL,NULL,'"drvTotalERDepCareCont"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASUMRFSAEZ0','11','T','90','6',NULL,'Total Employee Dependent Care Contributions for th',NULL,NULL,'"drvTotalEEDepCareCont"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASUMRFSAEZ0','11','T','90','7',NULL,'Total Employee Health Care Annual Amounts',NULL,NULL,'"drvTotalEEHCAnnualAmts"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASUMRFSAEZ0','11','T','90','8',NULL,'Total Employee Dependent Care Annual Amount',NULL,NULL,'"drvTotalEEDpeCareAnnAmts"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASUMRFSAEZ0','11','T','90','9',NULL,'Total Employer Health Care Annual Amounts',NULL,NULL,'"drvTotalERHCAnnAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASUMRFSAEZ0','11','T','90','10',NULL,'Total Employer Dependent Care Annual Amount',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASUMRFSAEZ0','11','T','90','11',NULL,'Total Employee Parking Contributions',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASUMRFSAEZ0','11','T','90','12',NULL,'Total Employee Transit Contributions',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASUMRFSAEZ0','11','T','90','13',NULL,'Total Employer Parking Contributions',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASUMRFSAEZ0','11','T','90','14',NULL,'Total Employer Transit Contributions',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASUMRFSAEZ0','360','T','90','15',NULL,'filler',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EASUMRFSAE_20240123.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202401239','EMPEXPORT','OEACTIVE',NULL,'EASUMRFSAE',NULL,NULL,NULL,'202401239','Jan 23 2024  3:33PM','Jan 23 2024  3:33PM','202401231',NULL,'','','202401231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202401239','EMPEXPORT','OEPASSIVE',NULL,'EASUMRFSAE',NULL,NULL,NULL,'202401239','Jan 23 2024  3:33PM','Jan 23 2024  3:33PM','202401231',NULL,'','','202401231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UMR FSA FSADC Export','202401239','EMPEXPORT','ONDEM_XOE',NULL,'EASUMRFSAE',NULL,NULL,NULL,'202401239','Jan 23 2024  3:33PM','Jan 23 2024  3:33PM','202401231',NULL,'','','202401231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UMR FSA FSADC Export-Sched','202401239','EMPEXPORT','SCH_EASUMR',NULL,'EASUMRFSAE',NULL,NULL,NULL,'202401239','Jan 23 2024  3:33PM','Jan 23 2024  3:33PM','202401231',NULL,'','','202401231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UMR FSA FSADC Export-Test','202401239','EMPEXPORT','TEST_XOE',NULL,'EASUMRFSAE',NULL,NULL,NULL,'202401239','Jan 23 2024  3:33PM','Jan 23 2024  3:33PM','202401231',NULL,'','','202401231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASUMRFSAE','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASUMRFSAE','H01','dbo.U_EASUMRFSAE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASUMRFSAE','D10','dbo.U_EASUMRFSAE_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASUMRFSAE','T90','dbo.U_EASUMRFSAE_Trailer',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EASUMRFSAE
-----------

IF OBJECT_ID('U_dsi_BDM_EASUMRFSAE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASUMRFSAE] (
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
-- Create table U_EASUMRFSAE_Audit
-----------

IF OBJECT_ID('U_EASUMRFSAE_Audit') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_Audit] (
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
-- Create table U_EASUMRFSAE_AuditFields
-----------

IF OBJECT_ID('U_EASUMRFSAE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EASUMRFSAE_DedList
-----------

IF OBJECT_ID('U_EASUMRFSAE_DedList') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EASUMRFSAE_drvTbl
-----------

IF OBJECT_ID('U_EASUMRFSAE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeSsn] char(11) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvPayrollDate] varchar(8) NULL,
    [drvEmployerContributionHC] varchar(1) NOT NULL,
    [drvEmployeeContributionHC] nvarchar(4000) NULL,
    [drvEmployerContributionDC] varchar(1) NOT NULL,
    [drvEmployeeContributionDC] nvarchar(4000) NULL,
    [drvLimitedIndicator] varchar(1) NOT NULL,
    [drvGroupCode] varchar(3) NOT NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvAddressAddress1] varchar(8000) NULL,
    [drvAddressAddress2] varchar(1) NOT NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(8000) NULL,
    [drvEmployeeCovEffDateHC] varchar(8) NULL,
    [drvEmployeeCovTermDateHC] varchar(8) NULL,
    [drvEmpAnnHCElecAmt] nvarchar(4000) NULL,
    [drvEmployeeCovEffDateDC] varchar(8) NULL,
    [drvEmployeeCovTermDateDC] varchar(8) NULL,
    [drvEmpAnnDCElecAmt] nvarchar(4000) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvDOB] varchar(8) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL
);

-----------
-- Create table U_EASUMRFSAE_EEList
-----------

IF OBJECT_ID('U_EASUMRFSAE_EEList') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EASUMRFSAE_File
-----------

IF OBJECT_ID('U_EASUMRFSAE_File') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EASUMRFSAE_Header
-----------

IF OBJECT_ID('U_EASUMRFSAE_Header') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_Header] (
    [drvClientNumber] varchar(4) NOT NULL,
    [drvClientName] varchar(24) NOT NULL,
    [drvProductType] varchar(4) NOT NULL,
    [drvProcessType] varchar(6) NOT NULL,
    [drvFileCreation] varchar(8) NULL
);

-----------
-- Create table U_EASUMRFSAE_PDedHist
-----------

IF OBJECT_ID('U_EASUMRFSAE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFSA] nvarchar(4000) NULL,
    [PdhFSADC] nvarchar(4000) NULL
);

-----------
-- Create table U_EASUMRFSAE_PEarHist
-----------

IF OBJECT_ID('U_EASUMRFSAE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] varchar(8) NULL,
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
-- Create table U_EASUMRFSAE_Trailer
-----------

IF OBJECT_ID('U_EASUMRFSAE_Trailer') IS NULL
CREATE TABLE [dbo].[U_EASUMRFSAE_Trailer] (
    [drvRecordCount] int NULL,
    [drvTotalERHCCont] varchar(11) NOT NULL,
    [drvTotalEmpHCCont] money NULL,
    [drvTotalERDepCareCont] varchar(11) NOT NULL,
    [drvTotalEEDepCareCont] money NULL,
    [drvTotalEEHCAnnualAmts] money NULL,
    [drvTotalEEDpeCareAnnAmts] money NULL,
    [drvTotalERHCAnnAmt] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASUMRFSAE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Associated Feed & Supply

Created By: Marie Waters
Business Analyst: Alex Bowan
Create Date: 01/23/2024
Service Request Number: TekP-2023-12-05-02

Purpose: UMR FSA FSADC Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2024     SR-2024-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASUMRFSAE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASUMRFSAE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASUMRFSAE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASUMRFSAE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASUMRFSAE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASUMRFSAE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASUMRFSAE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASUMRFSAE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASUMRFSAE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASUMRFSAE', 'SCH_EASUMR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASUMRFSAE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EASUMRFSAE', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8);

    -- Set FormatCode
    SELECT @FormatCode = 'EASUMRFSAE';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EASUMRFSAE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASUMRFSAE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EASUMRFSAE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_AuditFields;
    CREATE TABLE dbo.U_EASUMRFSAE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EASUMRFSAE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EASUMRFSAE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_Audit;
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
    INTO dbo.U_EASUMRFSAE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EASUMRFSAE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE' 
    AND audNewValue = 'T' ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EASUMRFSAE_Audit ON dbo.U_EASUMRFSAE_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EASUMRFSAE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EASUMRFSAE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC';

    IF OBJECT_ID('U_EASUMRFSAE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASUMRFSAE_DedList
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
    IF OBJECT_ID('U_EASUMRFSAE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFSA     = FORMAT(SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END), '0.00')
        ,PdhFSADC     = FORMAT(SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END), '0.00')
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EASUMRFSAE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASUMRFSAE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EASUMRFSAE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = CONVERT(VARCHAR(8),MAX(PrgPayDate),112)
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
    INTO dbo.U_EASUMRFSAE_PEarHist
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
    -- DETAIL RECORD - U_EASUMRFSAE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASUMRFSAE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeSsn = eepSSN
        ,drvLastName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o'), ',','')
        ,drvFirstName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')
        ,drvPayrollDate = PrgPayDate 
        ,drvEmployerContributionHC = ''
        ,drvEmployeeContributionHC = PdhFSA
        ,drvEmployerContributionDC = ''
        ,drvEmployeeContributionDC = PdhFSADC
        ,drvLimitedIndicator = ''
        ,drvGroupCode = '001'
        ,drvPayrollFrequency = CASE WHEN PgrPayFrequency  IN ('W', 'B') THEN PgrPayFrequency END
        ,drvAddressAddress1 = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o'), ',','')
        ,drvAddressAddress2 = ''
        ,drvCity = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o'), ',','')
        ,drvState = EepAddressState
        ,drvZipCode = REPLACE(EepAddressZipCode, '-','')
        ,drvEmployeeCovEffDateHC = CONVERT(VARCHAR(8),CASE WHEN Bdmdedcode = 'FSA' THEN CASE WHEN @ExportCode LIKE 'OE%' THEN Cast(Year(@StartDate)+1 as varchar) + '0101'                                       
                                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX', (Cast(Year(@StartDate) as varchar) + '0101') , BdmBenStartDate)
                                                        END 
                                                END, 112) 
        ,drvEmployeeCovTermDateHC = CONVERT(VARCHAR(8),CASE WHEN Bdmdedcode = 'FSA' THEN 
                                                            CASE WHEN @ExportCode LIKE 'OE%' THEN Cast(Year(@StartDate)+1 as varchar) + '1231'                                       
                                                                  WHEN @ExportCode NOT LIKE 'OE%' and BdmBenStopDate is not null then BdmBenStopDate else (Cast(Year(@StartDate) as varchar) + '1231')
                                                                END 
                                                        END, 112) 
        ,drvEmpAnnHCElecAmt = CASE WHEN Bdmdedcode = 'FSA' THEN FORMAT(BdmEEGoalAmt, '0.00') END
        ,drvEmployeeCovEffDateDC = CONVERT(VARCHAR(8),CASE WHEN Bdmdedcode = 'FSADC' THEN CASE WHEN @ExportCode LIKE 'OE%' THEN Cast(Year(@StartDate)+1 as varchar) + '0101'                                       
                                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX', (Cast(Year(@StartDate) as varchar) + '0101') , BdmBenStartDate) 
                                                        END 
                                                END, 112)
        ,drvEmployeeCovTermDateDC = CONVERT(VARCHAR(8),CASE WHEN Bdmdedcode = 'FSADC' THEN 
                                                            CASE WHEN @ExportCode LIKE 'OE%' THEN Cast(Year(@StartDate)+1 as varchar) + '1231'                                       
                                                                  WHEN @ExportCode NOT LIKE 'OE%' and BdmBenStopDate is not null then BdmBenStopDate else (Cast(Year(@StartDate) as varchar) + '1231')
                                                                END 
                                                        END, 112) 
        ,drvEmpAnnDCElecAmt = CASE WHEN Bdmdedcode = 'FSADC' THEN FORMAT(BdmEEGoalAmt, '0.00')END
        ,drvEmployeeID = EecEmpNo
        ,drvDOB = CONVERT(VARCHAR(8),EepDateOfBirth, 112)
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('W','M','S','D') THEN eepMaritalStatus ELSE 'U' END
        ,drvGender = EepGender
    INTO dbo.U_EASUMRFSAE_drvTbl
    FROM dbo.U_EASUMRFSAE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EASUMRFSAE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EASUMRFSAE_PEarHist WITH (NOLOCK)
        ON peheeid = XEEID
    LEFT JOIN dbo.U_EASUMRFSAE_PDedHist WITH (NOLOCK)
        ON pdheeid = XEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    Left Join dbo.U_EASUMRFSAE_Audit
        ON audeeid = xeeid
        and audKey2 = xcoid
           WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and (auddatetime is not null  
            or (PdhFSA > 0.00 or PdhFSADC > 0.00 )) ))

    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASUMRFSAE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_Header;
    SELECT DISTINCT
         drvClientNumber = '3196'
        ,drvClientName = 'Associated Feed & Supply'
        ,drvProductType = 'FLEX'
        ,drvProcessType = 'UPDATE'
        ,drvFileCreation = @RunDate
    INTO dbo.U_EASUMRFSAE_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASUMRFSAE_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EASUMRFSAE_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EASUMRFSAE_drvTbl) 
        ,drvTotalERHCCont = '00000000000'
        ,drvTotalEmpHCCont = (SELECT SUM(cast(drvEmployeeContributionHC AS MONEY)) FROM dbo.U_EASUMRFSAE_drvTbl) 
        ,drvTotalERDepCareCont = '00000000000'
        ,drvTotalEEDepCareCont = (SELECT SUM(cast(drvEmployeeContributionDC AS MONEY)) FROM dbo.U_EASUMRFSAE_drvTbl)
        ,drvTotalEEHCAnnualAmts = (SELECT SUM(cast(drvEmpAnnHCElecAmt AS MONEY)) FROM dbo.U_EASUMRFSAE_drvTbl)
        ,drvTotalEEDpeCareAnnAmts = (SELECT SUM(cast(drvEmpAnnDCElecAmt AS MONEY)) FROM dbo.U_EASUMRFSAE_drvTbl)
        ,drvTotalERHCAnnAmt = '00000000000'
    INTO dbo.U_EASUMRFSAE_Trailer
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
ALTER VIEW dbo.dsi_vwEASUMRFSAE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASUMRFSAE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EASUMRFSAE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202401161'
       ,expStartPerControl     = '202401161'
       ,expLastEndPerControl   = '202401239'
       ,expEndPerControl       = '202401239'
WHERE expFormatCode = 'EASUMRFSAE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASUMRFSAE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EASUMRFSAE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EASUMRFSAE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EASUMRFSAE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EASUMRFSAE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASUMRFSAE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EASUMRFSAE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASUMRFSAE', 'UseFileName', 'V', 'Y'


-- End ripout