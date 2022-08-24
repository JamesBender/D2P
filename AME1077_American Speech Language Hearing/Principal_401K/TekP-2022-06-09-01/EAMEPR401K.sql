/**********************************************************************************

EAMEPR401K: Principal 401K

FormatCode:     EAMEPR401K
Project:        Principal 401K
Client ID:      AME1077
Date/time:      2022-08-24 16:42:48.627
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPASLHA
Web Filename:   AME1077_F3A0E_EEHISTORY_EAMEPR401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAMEPR401K_SavePath') IS NOT NULL DROP TABLE dbo.U_EAMEPR401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAMEPR401K'


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
WHERE FormatCode = 'EAMEPR401K'
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
WHERE ExpFormatCode = 'EAMEPR401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAMEPR401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAMEPR401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAMEPR401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAMEPR401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAMEPR401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAMEPR401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAMEPR401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAMEPR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAMEPR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAMEPR401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAMEPR401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAMEPR401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAMEPR401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMEPR401K];
GO
IF OBJECT_ID('U_EAMEPR401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_PEarHist];
GO
IF OBJECT_ID('U_EAMEPR401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_PDedHist];
GO
IF OBJECT_ID('U_EAMEPR401K_File') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_File];
GO
IF OBJECT_ID('U_EAMEPR401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_EEList];
GO
IF OBJECT_ID('U_EAMEPR401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_DedList];
GO
IF OBJECT_ID('U_EAMEPR401K_Contribution_Loan_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_Contribution_Loan_drvTbl];
GO
IF OBJECT_ID('U_EAMEPR401K_Contribution_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_Contribution_drvTbl];
GO
IF OBJECT_ID('U_EAMEPR401K_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_AuditFields];
GO
IF OBJECT_ID('U_EAMEPR401K_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAMEPR401K_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EAMEPR401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAMEPR401K];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EAMEPR401K','Principal 401K','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EAMEPR401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAMEPR401KZ0','8','D','10','1',NULL,'Plan Code',NULL,NULL,'"drvPlanCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAMEPR401KZ0','10','D','10','9',NULL,'Paycheck Date - Not Pay Period End Date',NULL,NULL,'"drvPaycheckDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAMEPR401KZ0','5','D','10','19',NULL,' Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAMEPR401KZ0','11','D','10','24',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAMEPR401KZ0','14','D','10','35',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAMEPR401KZ0','1','D','10','49',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAMEPR401KZ0','30','D','10','50',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAMEPR401KZ0','10','D','10','80',NULL,'Employee Number',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAMEPR401KZ0','30','D','10','90',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAMEPR401KZ0','30','D','10','120',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAMEPR401KZ0','23','D','10','150',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAMEPR401KZ0','2','D','10','173',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAMEPR401KZ0','10','D','10','175',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAMEPR401KZ0','23','D','10','185',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAMEPR401KZ0','12','D','10','208',NULL,'Phone Number (Optional)',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAMEPR401KZ0','40','D','10','220',NULL,'E-mail Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAMEPR401KZ0','5','D','10','260',NULL,'Division Code',NULL,NULL,'"drvDivisionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAMEPR401KZ0','5','D','10','265',NULL,' Filler2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAMEPR401KZ0','20','D','10','270',NULL,'Work Location (Optional)',NULL,NULL,'"drvWorkLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAMEPR401KZ0','4','D','10','290',NULL,'Participation Status',NULL,NULL,'"drvParticipationStatus "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAMEPR401KZ0','17','D','10','294',NULL,' Filler3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAMEPR401KZ0','10','D','10','311',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAMEPR401KZ0','10','D','10','321',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAMEPR401KZ0','10','D','10','331',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAMEPR401KZ0','10','D','10','341',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAMEPR401KZ0','20','D','10','351',NULL,' Filler4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAMEPR401KZ0','1','D','10','371',NULL,'Payroll Frequency',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAMEPR401KZ0','1','D','10','372',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAMEPR401KZ0','1','D','10','373',NULL,'Marital Status (Optional)',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAMEPR401KZ0','1','D','10','374',NULL,'Language Indicator (Optional)',NULL,NULL,'"drvLanguageIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAMEPR401KZ0','23','D','10','375',NULL,' Filler5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EAMEPR401KZ0','10','D','10','398',NULL,'Plan Compensation Amount - Plan YTD',NULL,NULL,'"drvPlanCompensationAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EAMEPR401KZ0','10','D','10','408',NULL,'W2 Compensation Amount - Plan YTD',NULL,NULL,'"drvW2CompensationAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EAMEPR401KZ0','10','D','10','418',NULL,'Annualized Salary Amount',NULL,NULL,'"drvAnnualizedSalaryAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EAMEPR401KZ0','10','D','10','428',NULL,'Allocation Compensation Amount - Plan YTD',NULL,NULL,'"drvAllocationCompensationAmt"','(''UNPN''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EAMEPR401KZ0','10','D','10','438',NULL,'Employee Pretax Deferral Contribution Amount (MT1)',NULL,NULL,'"drvEmployeePretaxDeferralContributionAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EAMEPR401KZ0','10','D','10','448',NULL,'Employer Match Contribution Amount (MT2)',NULL,NULL,'"drvEmployerMatchContributionAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EAMEPR401KZ0','30','D','10','478',NULL,' Filler6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EAMEPR401KZ0','10','D','10','488',NULL,'Pretax Catch Up Contribution Amount (MT6)',NULL,NULL,'"drvPretaxCatchUpContributionAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EAMEPR401KZ0','50','D','10','489',NULL,'Filler7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EAMEPR401KZ0','10','D','10','548',NULL,'Roth Deferral Contribution Amount (MT12)',NULL,NULL,'"drvRothDeferralContributionamt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EAMEPR401KZ0','10','D','10','558',NULL,'Roth Catch Up Contribution Amount (MT14)',NULL,NULL,'"drvRothCatchUpContributionAmt"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EAMEPR401KZ0','10','D','10','568',NULL,'Loan Repayment 1',NULL,NULL,'"drvLoanRepayment1"','(''UNT0''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EAMEPR401KZ0','657','D','10','578',NULL,' Filler8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EAMEPR401KZ0','2','D','10','1235',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'"drvNQContribution2DigitDeferralYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EAMEPR401KZ0','1','D','10','1237',NULL,'Filler9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EAMEPR401KZ0','9','D','10','1238',NULL,'NQ Contribution Amount',NULL,NULL,'"drvNQContributionAmount "','(''UNT2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EAMEPR401KZ0','2','D','10','1247',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'"drvNQContribution2DigitDeferralYr1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EAMEPR401KZ0','1','D','10','1249',NULL,'Filler10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EAMEPR401KZ0','9','D','10','1250',NULL,'NQ Contribution Amount',NULL,NULL,'"drvNQContributionAmount1"','(''UNT2''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EAMEPR401KZ0','2','D','10','1259',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'"drvNQContribution2DigitDeferralY22"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EAMEPR401KZ0','9','D','10','1261',NULL,'NQ Contribution Amount',NULL,NULL,'"drvNQContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EAMEPR401KZ0','2','D','10','1270',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'"drvNQContribution2DigitDeferralYr3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EAMEPR401KZ0','9','D','10','1272',NULL,'NQ Contribution Amount',NULL,NULL,'"drvNQContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EAMEPR401KZ0','1','D','10','1281',NULL,'Filler11',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EAMEPR401KZ0','2','D','10','1282',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'"drvNQContribution2DigitDeferralYr4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EAMEPR401KZ0','10','D','10','1284',NULL,'Filler12',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EAMEPR401KZ0','9','D','10','1294',NULL,'NQ Contribution Amount',NULL,NULL,'"drvNQContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EAMEPR401KZ0','268','D','10','1303',NULL,'Filler13',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EAMEPR401KZ0','1','D','10','1571',NULL,'NQ Director Flag',NULL,NULL,'"drvNQDirectorFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EAMEPR401KZ0','2','D','10','1572',NULL,'NQ Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EAMEPR401KZ0','1','D','10','1574',NULL,'Filler14',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EAMEPR401KZ0','9','D','10','1575',NULL,'NQ Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EAMEPR401KZ0','2','D','10','1584',NULL,'NQ  Contribution 2-Digit Deferral Year (#YY)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EAMEPR401KZ0','1','D','10','1586',NULL,'Filler15',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EAMEPR401KZ0','9','D','10','1587',NULL,'NQ Contribution Amount',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAMEPR401K_20220824.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208159','EMPEXPORT','OEACTIVE',NULL,'EAMEPR401K',NULL,NULL,NULL,'202208159','Aug 15 2022 10:03AM','Aug 15 2022 10:03AM','202208151',NULL,'','','202208151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208159','EMPEXPORT','OEPASSIVE',NULL,'EAMEPR401K',NULL,NULL,NULL,'202208159','Aug 15 2022 10:03AM','Aug 15 2022 10:03AM','202208151',NULL,'','','202208151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Principal 401K','202208159','EMPEXPORT','ONDEM_XOE',NULL,'EAMEPR401K',NULL,NULL,NULL,'202208159','Aug 15 2022 10:03AM','Aug 15 2022 10:03AM','202208151',NULL,'','','202208151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Principal 401K-Sched','202208159','EMPEXPORT','SCH_EAMEPR',NULL,'EAMEPR401K',NULL,NULL,NULL,'202208159','Aug 15 2022 10:03AM','Aug 15 2022 10:03AM','202208151',NULL,'','','202208151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Principal 401K-Test','202208129','EMPEXPORT','TEST_XOE','Aug 17 2022 12:00AM','EAMEPR401K',NULL,NULL,NULL,'202208129','Aug 12 2022 12:00AM','Dec 30 1899 12:00AM','202208121',NULL,'eecPayGroup','BIWKLY','202208121',dbo.fn_GetTimedKey(),NULL,'us3cPeAME1077',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAMEPR401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAMEPR401K','D10','dbo.U_EAMEPR401K_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAMEPR401K
-----------

IF OBJECT_ID('U_dsi_BDM_EAMEPR401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAMEPR401K] (
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
-- Create table U_EAMEPR401K_Audit
-----------

IF OBJECT_ID('U_EAMEPR401K_Audit') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_Audit] (
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
-- Create table U_EAMEPR401K_AuditFields
-----------

IF OBJECT_ID('U_EAMEPR401K_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EAMEPR401K_Contribution_drvTbl
-----------

IF OBJECT_ID('U_EAMEPR401K_Contribution_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_Contribution_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvNQContribution2DigitDeferralYear] varchar(1) NOT NULL,
    [drvNQContributionAmount] numeric NULL,
    [drvNQContribution2DigitDeferralYr1] varchar(1) NOT NULL,
    [drvNQContributionAmount1] numeric NULL,
    [drvNQContribution2DigitDeferralY22] varchar(1) NOT NULL,
    [drvNQContributionAmount2] varchar(1) NOT NULL,
    [drvNQContribution2DigitDeferralYr3] varchar(1) NOT NULL,
    [drvNQContributionAmount3] varchar(1) NOT NULL,
    [drvNQContribution2DigitDeferralYr4] varchar(1) NOT NULL,
    [drvNQContributionAmount4] varchar(1) NOT NULL
);

-----------
-- Create table U_EAMEPR401K_Contribution_Loan_drvTbl
-----------

IF OBJECT_ID('U_EAMEPR401K_Contribution_Loan_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_Contribution_Loan_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvEmployeePretaxDeferralContributionAmt] numeric NULL,
    [drvEmployerMatchContributionAmt] numeric NULL,
    [drvPretaxCatchUpContributionAmt] numeric NULL,
    [drvRothDeferralContributionamt] numeric NULL,
    [drvRothCatchUpContributionAmt] numeric NULL,
    [drvLoanRepayment1] numeric NULL
);

-----------
-- Create table U_EAMEPR401K_DedList
-----------

IF OBJECT_ID('U_EAMEPR401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAMEPR401K_EEList
-----------

IF OBJECT_ID('U_EAMEPR401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAMEPR401K_File
-----------

IF OBJECT_ID('U_EAMEPR401K_File') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EAMEPR401K_PDedHist
-----------

IF OBJECT_ID('U_EAMEPR401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayGroup] char(6) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401EEAmt] numeric NULL,
    [Pdh401ERAmt] numeric NULL,
    [Pdh401PreTaxAmt] numeric NULL,
    [PdhROTHAmt] numeric NULL,
    [PdhRTHAmt] numeric NULL,
    [Pdh401LAmt] numeric NULL,
    [PdhNQEEContribAmt] numeric NULL,
    [PdhNQERContribAmt] numeric NULL
);

-----------
-- Create table U_EAMEPR401K_PEarHist
-----------

IF OBJECT_ID('U_EAMEPR401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAMEPR401K_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAMEPR401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quorum Federal Credit Union

Created By: Marie Thomerson
Business Analyst: Cheryl Petitti
Create Date: 08/15/2022
Service Request Number: TekP-2022-06-09-01

Purpose: Principal 401K

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAMEPR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAMEPR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAMEPR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAMEPR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAMEPR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMEPR401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMEPR401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMEPR401K', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMEPR401K', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAMEPR401K', 'SCH_EAMEPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAMEPR401K';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAMEPR401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAMEPR401K';

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
    DELETE FROM dbo.U_EAMEPR401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAMEPR401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EAMEPR401K_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_AuditFields;
    CREATE TABLE dbo.U_EAMEPR401K_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EAMEPR401K_AuditFields VALUES ('EmpComp','EecDateofTermination');
    --INSERT INTO dbo.U_EAMEPR401K_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EAMEPR401K_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAMEPR401K_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_Audit;
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
    INTO dbo.U_EAMEPR401K_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EAMEPR401K_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN   DATEADD(yy, DATEDIFF(yy, 0, @StartDate), 0) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EAMEPR401K_Audit ON dbo.U_EAMEPR401K_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EAMEPR401K_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EAMEPR401K_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401F, 401P, MATER, 401CF, 401CP, ROTH, ROTHP, RTHCF, RTHCP, 401L, 457, 457B, 457ER';

    IF OBJECT_ID('U_EAMEPR401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAMEPR401K_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','401F, 401P, MATER, 401CF, 401CP, ROTH, ROTHP, RTHCF, RTHCP, 401L, 457, 457B, 457ER');
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

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAMEPR401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
         -- Add Pay Group here
         ,PdhPayGroup
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401EEAmt            = SUM(CASE WHEN PdhDedCode IN ('401DB', '401DC', '401F', '401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401ERAmt            = SUM(CASE WHEN PdhDedCode IN ('MATER') THEN PdhERCurAmt ELSE 0.00 END)
        ,Pdh401PreTaxAmt        = SUM(CASE WHEN PdhDedCode IN ('401CF', '401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhROTHAmt                = SUM(CASE WHEN PdhDedCode IN ('ROTH', 'ROTHP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRTHAmt                = SUM(CASE WHEN PdhDedCode IN ('RTHCF', 'RTHCP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401LAmt                = SUM(CASE WHEN PdhDedCode IN ('401L') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhNQEEContribAmt        = SUM(CASE WHEN PdhDedCode IN ('457', '457B', '457ER') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhNQERContribAmt        = SUM(CASE WHEN PdhDedCode IN ('457', '457B', '457ER') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EAMEPR401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAMEPR401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    --JOIN dbo.fn_ListToTable((SELECT expSelectByList FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode AND ExpSelectbyField = 'eecPayGroup'))
    --    ON Item = PdhPayGroup
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhPayGroup
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EAMEPR401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
		--,PehCurAmtYTD           = SUM(CASE WHEN PehEarnCode in ('401F', '401P', 'MATER', '401CF', '401CP', 'ROTH', 'ROTHP', 'RTHCF', 'RTHCP', '401L', '457', '457B', '457ER') THEN PehCurAmt END)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EAMEPR401K_PEarHist
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
    -- DETAIL RECORD - U_EAMEPR401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAMEPR401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAMEPR401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = ''
        -- standard fields above and additional driver fields below
        ,drvPlanCode = '538908'
        ,drvPaycheckDate = PrgPayDate
        ,drvSocialSecurityNumber = eepSSN
        ,drvFirstName = LTrim(EepNameFirst)
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = LTrim(EepNameLast)
        ,drvEmployeeNumber = EecEmpNo
        ,drvAddressLine1 = Rtrim(EepAddressLine1)
        ,drvAddressLine2 = Rtrim(EepAddressLine2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvDivisionCode = ''
        ,drvWorkLocation = LocAddressState
        ---LocAddressState where LocCode = EecLocation
        ,drvParticipationStatus = CASE WHEN EecEmplStatus = 'A' THEN 'ACTV'
                                        WHEN EecEmplStatus = 'L' THEN 'LEAV'
                                        WHEN EecEmplStatus = 'L' and EecLeaveReason = '300' THEN 'MILV'
                                        WHEN EecEmplStatus = 'T' and EecTermReason = '209' THEN 'DISB'
                                        WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'DTH'
                                        WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN  'RETD'
                                        WHEN EecEmplStatus = 'T' and EecTermReason not in ( '209', '203', '202') THEN 'TERM'
                                        END
        ,drvBirthDate = EepDateOfBirth
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire 
                                AND EecJobChangeReason = '101' 
                                then EecDateOfLastHire
                                Else null END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPayrollFrequency = '1'
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1'
                            WHEN EepGender = 'F' THEN '2'
                            ELSE '0' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'D' THEN '2'
                                WHEN eepMaritalStatus = 'M' THEN '1'
                                WHEN eepMaritalStatus = 'S' THEN '4'
                                WHEN eepMaritalStatus = 'W' THEN '5'
                                ELSE '0' END
        ,drvLanguageIndicator = CASE    WHEN EecLanguageCode = 'EN' THEN 'E'
                                        WHEN EecLanguageCode = 'SP' THEN 'S'
                                        else '' END
        ,drvPlanCompensationAmt = PehInclInDefCompYTD *100
        ,drvW2CompensationAmt = PehCurAmtYTD *100
        ,drvAnnualizedSalaryAmt = EecAnnSalary*100
        ,drvAllocationCompensationAmt = '0'
        ,drvEmployeePretaxDeferralContributionAmt = Pdh401EEAmt*100
        ,drvEmployerMatchContributionAmt = Pdh401ERAmt *100
        ,drvPretaxCatchUpContributionAmt = Pdh401PreTaxAmt *100
        ,drvRothDeferralContributionamt = PdhROTHAmt *100
        ,drvRothCatchUpContributionAmt = PdhRTHAmt *100
        ,drvLoanRepayment1 = Pdh401LAmt *100
        ,drvNQContribution2DigitDeferralYear = '1'--CASE WHEN BdmDedCode in ( '457', '457B', '457ER') THEN '1' END
        ,drvNQContributionAmount = PdhNQEEContribAmt *100
        ,drvNQContribution2DigitDeferralYr1 = '2'
        ,drvNQContributionAmount1 = PdhNQERContribAmt *100
        ,drvNQContribution2DigitDeferralY22 = ''
        ,drvNQContributionAmount2 = ''
        ,drvNQContribution2DigitDeferralYr3 = ''
        ,drvNQContributionAmount3 = ''
        ,drvNQContribution2DigitDeferralYr4 = ''
        ,drvNQContributionAmount4 = ''
        ,drvNQDirectorFlag = '1'
    INTO dbo.U_EAMEPR401K_drvTbl
    FROM dbo.U_EAMEPR401K_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EAMEPR401K WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
	LEFT JOIN dbo.Location WITH (NOLOCK)
		On LocCode = EecLocation
    JOIN dbo.U_EAMEPR401K_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
        JOIN dbo.U_EAMEPR401K_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID 
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Q1038_FSAElig_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss_TEST.txt.pgp'
                                  ELSE 'Q1038_HRAElig_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_hhmmss.txt.pgp'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEAMEPR401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAMEPR401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAMEPR401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208121'
       ,expStartPerControl     = '202208121'
       ,expLastEndPerControl   = '202208129'
       ,expEndPerControl       = '202208129'
WHERE expFormatCode = 'EAMEPR401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAMEPR401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAMEPR401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAMEPR401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAMEPR401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAMEPR401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMEPR401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAMEPR401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAMEPR401K', 'UseFileName', 'V', 'Y'


-- End ripout