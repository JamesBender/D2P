/**********************************************************************************

EAMFLEXHSA: Ameriflex HSA Contributions Export

FormatCode:     EAMFLEXHSA
Project:        Ameriflex HSA Contributions Export
Client ID:      BET1008
Date/time:      2023-09-25 15:21:36.883
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP7DB03
Database:       ULTIPRO_WPBETB
Web Filename:   BET1008_SC6HO_EEHISTORY_EAMFLEXHSA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAMFLEXHSA_SavePath') IS NOT NULL DROP TABLE dbo.U_EAMFLEXHSA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAMFLEXHSA'


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
WHERE FormatCode = 'EAMFLEXHSA'
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
WHERE ExpFormatCode = 'EAMFLEXHSA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAMFLEXHSA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAMFLEXHSA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAMFLEXHSA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAMFLEXHSA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAMFLEXHSA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAMFLEXHSA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAMFLEXHSA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAMFLEXHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAMFLEXHSA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAMFLEXHSA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAMFLEXHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAMFLEXHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAMFLEXHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMFLEXHSA];
GO
IF OBJECT_ID('U_EAMFLEXHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_PDedHist];
GO
IF OBJECT_ID('U_EAMFLEXHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_File];
GO
IF OBJECT_ID('U_EAMFLEXHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_EEList];
GO
IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_drvTbl_EN];
GO
IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_CONT') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_drvTbl_CONT];
GO
IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_AC') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_drvTbl_AC];
GO
IF OBJECT_ID('U_EAMFLEXHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_DedList];
GO
IF OBJECT_ID('U_EAMFLEXHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_AuditFields];
GO
IF OBJECT_ID('U_EAMFLEXHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAMFLEXHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EAMFLEXHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAMFLEXHSA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAMFLEXHSA','Ameriflex HSA Contributions Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EAMFLEXHSAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAMFLEXHSAZ0','2','D','10','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAMFLEXHSAZ0','6','D','10','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAMFLEXHSAZ0','9','D','10','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAMFLEXHSAZ0','9','D','10','18',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAMFLEXHSAZ0','5','D','10','27',NULL,'Prefix',NULL,NULL,'"drvPrefix"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAMFLEXHSAZ0','26','D','10','32',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAMFLEXHSAZ0','19','D','10','58',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAMFLEXHSAZ0','1','D','10','77',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAMFLEXHSAZ0','19','D','10','78',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAMFLEXHSAZ0','36','D','10','97',NULL,'Address Line 1',NULL,NULL,'"drvAddressLIne1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAMFLEXHSAZ0','36','D','10','133',NULL,'Address Line 2',NULL,NULL,'"drvAddressLIne2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAMFLEXHSAZ0','20','D','10','169',NULL,'City',NULL,NULL,'"drvACity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAMFLEXHSAZ0','2','D','10','189',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAMFLEXHSAZ0','9','D','10','191',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAMFLEXHSAZ0','3','D','10','200',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAMFLEXHSAZ0','8','D','10','203',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAMFLEXHSAZ0','1','D','10','211',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAMFLEXHSAZ0','12','D','10','212',NULL,'HICN',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAMFLEXHSAZ0','1','D','10','224',NULL,'Reimbursement Method*',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAMFLEXHSAZ0','50','D','10','225',NULL,'Bank Name*',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAMFLEXHSAZ0','9','D','10','275',NULL,'ABA Routing Number*',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAMFLEXHSAZ0','20','D','10','284',NULL,'Bank Account Number*',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAMFLEXHSAZ0','1','D','10','304',NULL,'ACH Account Type*',NULL,NULL,'"~"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAMFLEXHSAZ0','100','D','10','305',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAMFLEXHSAZ0','20','D','10','405',NULL,'Location Code',NULL,NULL,'"Betenbough Companies"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAMFLEXHSAZ0','1','D','10','425',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAMFLEXHSAZ0','8','D','10','426',NULL,'Eligibility Date',NULL,NULL,'"drvEligibilityDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAMFLEXHSAZ0','8','D','10','434',NULL,'Benefit Termination Date',NULL,NULL,'"drvBenTermDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAMFLEXHSAZ0','9','D','10','442',NULL,'New SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAMFLEXHSAZ0','30','D','10','451',NULL,'Health Plan ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAMFLEXHSAZ0','1','D','10','481',NULL,'filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAMFLEXHSAZ0','2','D','20','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAMFLEXHSAZ0','6','D','20','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAMFLEXHSAZ0','9','D','20','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAMFLEXHSAZ0','10','D','20','18',NULL,'Plan ID',NULL,NULL,'"drvPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAMFLEXHSAZ0','9','D','20','28',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAMFLEXHSAZ0','3','D','20','37',NULL,'Account Type',NULL,NULL,'"drvAccountType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAMFLEXHSAZ0','8','D','20','40',NULL,'Plan Year Start date',NULL,NULL,'"drvPlanYearStartdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAMFLEXHSAZ0','8','D','20','48',NULL,'Plan Year End date',NULL,NULL,'"drvPlanYearEnddate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAMFLEXHSAZ0','1','D','20','56',NULL,'Account Status',NULL,NULL,'"drvAccountStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAMFLEXHSAZ0','18','D','20','57',NULL,'Original Prefund / Annual Election/Goal Amount',NULL,NULL,'"drvOriginalPrefundGoalAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAMFLEXHSAZ0','18','D','20','75',NULL,'Enrollee Deposit Amount',NULL,NULL,'"drvEnrolleeDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAMFLEXHSAZ0','18','D','20','93',NULL,'Employer Deposit Amount',NULL,NULL,'"drvEmployerDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAMFLEXHSAZ0','8','D','20','111',NULL,'Benefit Start Date',NULL,NULL,'"drvBenefitStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAMFLEXHSAZ0','8','D','20','119',NULL,'Benefit End Date',NULL,NULL,'"drvBenefitEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAMFLEXHSAZ0','8','D','20','127',NULL,'Auto-Deposit Start Date',NULL,NULL,'"drvAutoDepositStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAMFLEXHSAZ0','18','D','20','135',NULL,'Calendar ID',NULL,NULL,'"drvCalendarID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAMFLEXHSAZ0','1','D','20','153',NULL,'Auto Add All Dependents',NULL,NULL,'"drvAutoAddAllDependents"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAMFLEXHSAZ0','1','D','20','154',NULL,'Space Fill',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAMFLEXHSAZ0','2','D','30','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAMFLEXHSAZ0','6','D','30','3',NULL,'TPA ID',NULL,NULL,'"drvTPAID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAMFLEXHSAZ0','9','D','30','9',NULL,'Group Code',NULL,NULL,'"drvGroupCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAMFLEXHSAZ0','3','D','30','18',NULL,'Account Type',NULL,NULL,'"drvAccountType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAMFLEXHSAZ0','8','D','30','21',NULL,'Plan Year Start date',NULL,NULL,'"drvPlanYearStartdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAMFLEXHSAZ0','8','D','30','29',NULL,'Plan Year End date',NULL,NULL,'"drvPlanYearEnddate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAMFLEXHSAZ0','9','D','30','37',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAMFLEXHSAZ0','18','D','30','46',NULL,'Enrollee Deposit Amount',NULL,NULL,'"drvEnrolleeDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAMFLEXHSAZ0','18','D','30','64',NULL,'Employer Deposit Amount',NULL,NULL,'"drvEmployerDepositAmount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAMFLEXHSAZ0','8','D','30','82',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAMFLEXHSA_20230925.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202308029','EMPEXPORT','OEACTIVE',NULL,'EAMFLEXHSA',NULL,NULL,NULL,'202308029','Aug  2 2023  3:40PM','Aug  2 2023  3:40PM','202307011',NULL,'','','202307011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202308029','EMPEXPORT','OEPASSIVE',NULL,'EAMFLEXHSA',NULL,NULL,NULL,'202308029','Aug  2 2023  3:40PM','Aug  2 2023  3:40PM','202307011',NULL,'','','202307011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ameriflex HSA Contributions Ex','202308029','EMPEXPORT','ONDEM_XOE',NULL,'EAMFLEXHSA',NULL,NULL,NULL,'202308029','Aug  2 2023  3:40PM','Aug  2 2023  3:40PM','202307011',NULL,'','','202307011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ameriflex HSA Contributi-Sched','202308029','EMPEXPORT','SCH_EAMFLE',NULL,'EAMFLEXHSA',NULL,NULL,NULL,'202308029','Aug  2 2023  3:40PM','Aug  2 2023  3:40PM','202307011',NULL,'','','202307011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Ameriflex HSA Contributi-Test','202308029','EMPEXPORT','TEST_XOE',NULL,'EAMFLEXHSA',NULL,NULL,NULL,'202308029','Aug  2 2023  3:40PM','Aug  2 2023  3:40PM','202307011',NULL,'','','202307011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMFLEXHSA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLEXHSA','D10','dbo.U_EAMFLEXHSA_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLEXHSA','D20','dbo.U_EAMFLEXHSA_drvTbl_AC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMFLEXHSA','D30','dbo.U_EAMFLEXHSA_drvTbl_CONT',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAMFLEXHSA
-----------

IF OBJECT_ID('U_dsi_BDM_EAMFLEXHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAMFLEXHSA] (
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
-- Create table U_EAMFLEXHSA_Audit
-----------

IF OBJECT_ID('U_EAMFLEXHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_Audit] (
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
-- Create table U_EAMFLEXHSA_AuditFields
-----------

IF OBJECT_ID('U_EAMFLEXHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAMFLEXHSA_DedList
-----------

IF OBJECT_ID('U_EAMFLEXHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAMFLEXHSA_drvTbl_AC
-----------

IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_AC') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_drvTbl_AC] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvPlanID] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvAccountType] varchar(3) NOT NULL,
    [drvPlanYearStartdate] varchar(34) NULL,
    [drvPlanYearEnddate] varchar(34) NULL,
    [drvAccountStatus] varchar(1) NOT NULL,
    [drvOriginalPrefundGoalAmount] varchar(24) NULL,
    [drvEnrolleeDepositAmount] varchar(24) NULL,
    [drvEmployerDepositAmount] varchar(18) NOT NULL,
    [drvBenefitStartDate] varchar(30) NULL,
    [drvBenefitEndDate] varchar(30) NULL,
    [drvAutoDepositStartDate] varchar(1) NOT NULL,
    [drvCalendarID] varchar(1) NOT NULL,
    [drvAutoAddAllDependents] varchar(1) NOT NULL
);

-----------
-- Create table U_EAMFLEXHSA_drvTbl_CONT
-----------

IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_CONT') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_drvTbl_CONT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvAccountType] varchar(3) NOT NULL,
    [drvPlanYearStartdate] varchar(34) NULL,
    [drvPlanYearEnddate] varchar(34) NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvEnrolleeDepositAmount] varchar(24) NULL,
    [drvEmployerDepositAmount] varchar(24) NULL,
    [drvEffectiveDate] varchar(30) NULL
);

-----------
-- Create table U_EAMFLEXHSA_drvTbl_EN
-----------

IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordID] varchar(2) NOT NULL,
    [drvTPAID] varchar(6) NOT NULL,
    [drvGroupCode] varchar(9) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPrefix] varchar(30) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvPhone] varchar(50) NULL,
    [drvAddressLIne1] varchar(255) NULL,
    [drvAddressLIne2] varchar(255) NULL,
    [drvACity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] varchar(3) NOT NULL,
    [drvDOB] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvEmail] varchar(50) NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvEligibilityDate] varchar(30) NULL,
    [drvBenTermDate] varchar(30) NULL
);

-----------
-- Create table U_EAMFLEXHSA_EEList
-----------

IF OBJECT_ID('U_EAMFLEXHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAMFLEXHSA_File
-----------

IF OBJECT_ID('U_EAMFLEXHSA_File') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAMFLEXHSA_PDedHist
-----------

IF OBJECT_ID('U_EAMFLEXHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAMFLEXHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhHSAEE] numeric NULL,
    [PdhHSAER] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMFLEXHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Betenbough Companies

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 08/02/2023
Service Request Number: SR-2023-00410046

Purpose: Ameriflex HSA Contributions Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAMFLEXHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAMFLEXHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAMFLEXHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAMFLEXHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAMFLEXHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLEXHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLEXHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLEXHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLEXHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMFLEXHSA', 'SCH_EAMFLE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAMFLEXHSA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAMFLEXHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAMFLEXHSA';

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
    DELETE FROM dbo.U_EAMFLEXHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAMFLEXHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
    ---- Audit Section
    ----==========================================
    ---- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EAMFLEXHSA_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EAMFLEXHSA_AuditFields;
    --CREATE TABLE dbo.U_EAMFLEXHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EAMFLEXHSA_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EAMFLEXHSA_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EAMFLEXHSA_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --JOIN dbo.U_EAMFLEXHSA_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE';

    ---- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EAMFLEXHSA_Audit ON dbo.U_EAMFLEXHSA_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EAMFLEXHSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EAMFLEXHSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSA';

    IF OBJECT_ID('U_EAMFLEXHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLEXHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAMFLEXHSA_DedList
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
    IF OBJECT_ID('U_EAMFLEXHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLEXHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhHSAEE     = SUM(CASE WHEN PdhDedCode IN ('HSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSAER     = SUM(CASE WHEN PdhDedCode IN ('HSA') THEN PdhERCurAmt ELSE 0.00 END)
        --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        --,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EAMFLEXHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAMFLEXHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    AND PdhDedCode IN ('HSA')
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAMFLEXHSA_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLEXHSA_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvRecordID = 'IB'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvSSN = eepSSN
        ,drvPrefix = Case When EepNamePrefix <> 'Z' THEN EepNamePrefix END
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvPhone = EepPhoneHomeNumber
        ,drvAddressLIne1 = EepAddressLine1
        ,drvAddressLIne2 = EepAddressLine2
        ,drvACity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountry = 'USA'
        ,drvDOB = Convert( Varchar,EepDateOfBirth, 112)
        ,drvGender = EepGender
        ,drvEmail = EepAddressEMail
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvEligibilityDate = Convert( Varchar,EecDateOfLastHire, 112)
        ,drvBenTermDate = CASE WHEN EecEmplStatus = 'T' THEN Convert( Varchar,EecDateOfTermination,112) END
    INTO dbo.U_EAMFLEXHSA_drvTbl_EN
    FROM dbo.U_EAMFLEXHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAMFLEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT  JOIN dbo.U_EAMFLEXHSA_PDedHist WITH (NOLOCK)
       ON PdhEEID = XEEID
        Where EecEEType <> 'TES'
            and  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (format(PdhHSAEE, '0.00') <> '0.00' or format(PdhHSAER, '0.00') <> '0.00' )))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAMFLEXHSA_drvTbl_AC
    ---------------------------------
    IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_AC','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLEXHSA_drvTbl_AC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvRecordID = 'IC'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvPlanID = 'BETENB'
        ,drvSSN = eepSSN
        ,drvAccountType = 'ABH'
        ,drvPlanYearStartdate = CASE WHEN Year(@Startdate) = '2023' THEN '20230401'
                                     WHEN Year(@startdate) <> '2023'  THEN Cast(Year(@StartDate) as varchar) + '0101'
                                     END
        ,drvPlanYearEnddate = CASE WHEN Year(@Startdate) = '2023' THEN '20231231'
                                     WHEN Year(@startdate) <> '2023'  THEN Cast(Year(@StartDate) as varchar) + '1231'
                                     END
        ,drvAccountStatus = CASE When eecemplstatus = 'T' THEN 'T'  Else 'A' END
        ,drvOriginalPrefundGoalAmount = dbo.dsi_fnpadzero(BdmEEGoalAmt, 18, 2)
        ,drvEnrolleeDepositAmount = dbo.dsi_fnpadzero( BdmEEAmt, 18, 2)
        ,drvEmployerDepositAmount = '000000000000000.00'
        ,drvBenefitStartDate = Convert( Varchar, BdmBenStartdate , 112)
        ,drvBenefitEndDate = Convert( Varchar, BdmBenStopdate , 112)
        ,drvAutoDepositStartDate = ''
        ,drvCalendarID = ''
        ,drvAutoAddAllDependents = ''
    INTO dbo.U_EAMFLEXHSA_drvTbl_AC
    FROM dbo.U_EAMFLEXHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EAMFLEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT  JOIN dbo.U_EAMFLEXHSA_PDedHist WITH (NOLOCK)
       ON PdhEEID = XEEID
        Where EecEEType <> 'TES' and  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (format(PdhHSAEE, '0.00') <> '0.00' or format(PdhHSAER, '0.00') <> '0.00' )))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAMFLEXHSA_drvTbl_CONT
    ---------------------------------
    IF OBJECT_ID('U_EAMFLEXHSA_drvTbl_CONT','U') IS NOT NULL
        DROP TABLE dbo.U_EAMFLEXHSA_drvTbl_CONT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvRecordID = 'IH'
        ,drvTPAID = 'AMF001'
        ,drvGroupCode = 'AMFBETENB'
        ,drvAccountType =  'ABH' 
        ,drvPlanYearStartdate = CASE WHEN Year(@Startdate) = '2023' THEN '20230401'
                                     WHEN Year(@startdate) <> '2023'  THEN Cast(Year(@StartDate) as varchar) + '0101'
                                     END
        ,drvPlanYearEnddate = CASE WHEN Year(@Startdate) = '2023' THEN '20231231'
                                     WHEN Year(@startdate) <> '2023'  THEN Cast(Year(@StartDate) as varchar) + '1231'
                                     END
        ,drvSocialSecurityNumber = EepSSN
        ,drvEnrolleeDepositAmount = dbo.dsi_fnpadzero(PdhHSAEE , 18, 2)
        ,drvEmployerDepositAmount = dbo.dsi_fnpadzero(PdhHSAER , 18, 2)
        ,drvEffectiveDate = Convert( Varchar,GetDate(), 112)
    INTO dbo.U_EAMFLEXHSA_drvTbl_CONT
    FROM dbo.U_EAMFLEXHSA_EEList WITH (NOLOCK)
        JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAMFLEXHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_EAMFLEXHSA_PDedHist WITH (NOLOCK)
       ON PdhEEID = XEEID
        Where BdmDedcode = 'HSA'
        and EecEEType <> 'TES' and  (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (format(PdhHSAEE, '0.00') <> '0.00' or format(PdhHSAER, '0.00') <> '0.00' )))
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
ALTER VIEW dbo.dsi_vwEAMFLEXHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAMFLEXHSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAMFLEXHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307011'
       ,expStartPerControl     = '202307011'
       ,expLastEndPerControl   = '202308029'
       ,expEndPerControl       = '202308029'
WHERE expFormatCode = 'EAMFLEXHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAMFLEXHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAMFLEXHSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAMFLEXHSA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAMFLEXHSA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAMFLEXHSA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMFLEXHSA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAMFLEXHSA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMFLEXHSA', 'UseFileName', 'V', 'Y'


-- End ripout