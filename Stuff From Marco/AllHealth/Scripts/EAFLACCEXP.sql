/**********************************************************************************

EAFLACCEXP: Aflac ACC/HOSP/CRIT Illness Export

FormatCode:     EAFLACCEXP
Project:        Aflac ACC/HOSP/CRIT Illness Export
Client ID:      ARA1003
Date/time:      2022-01-12 18:32:04.377
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB01
Database:       ULTIPRO_WPADMHN
Web Filename:   ARA1003_14868_EEHISTORY_EAFLACCEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAFLACCEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EAFLACCEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAFLACCEXP'


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
WHERE FormatCode = 'EAFLACCEXP'
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
WHERE ExpFormatCode = 'EAFLACCEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAFLACCEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAFLACCEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAFLACCEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAFLACCEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAFLACCEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAFLACCEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAFLACCEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAFLACCEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAFLACCEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAFLACCEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAFLACCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAFLACCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAFLACCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLACCEXP];
GO
IF OBJECT_ID('U_EAFLACCEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_PEarHist];
GO
IF OBJECT_ID('U_EAFLACCEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_PDedHist];
GO
IF OBJECT_ID('U_EAFLACCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_File];
GO
IF OBJECT_ID('U_EAFLACCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_EEList];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblProd2') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblProd2];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblProd') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblProd];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblMeta];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblEmp];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblDep') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblDep];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblBen') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblBen];
GO
IF OBJECT_ID('U_EAFLACCEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_DedList];
GO
IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_BdmConsolidated];
GO
IF OBJECT_ID('U_dsi_BDM_EAFLACCEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAFLACCEXP];
GO
IF OBJECT_ID('dboU_EAFLACCEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[dboU_EAFLACCEXP_BdmConsolidated];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAFLACCEXP','Aflac ACC/HOSP/CRIT Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','5000','S','N','EAFLACCEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAFLACCEXPZ0','50','D','10','1',NULL,'Record Discriminator',NULL,NULL,'"drvEmpRecDisc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAFLACCEXPZ0','50','D','10','2',NULL,'Record Type',NULL,NULL,'"drvEmpRecType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAFLACCEXPZ0','50','D','10','3',NULL,'Underwriting Company',NULL,NULL,'"drvEmpUnComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAFLACCEXPZ0','50','D','10','4',NULL,'Employee ID/SSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAFLACCEXPZ0','50','D','10','5',NULL,'Employee Last Name',NULL,NULL,'"drvEmpLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAFLACCEXPZ0','50','D','10','6',NULL,'Employee First Name',NULL,NULL,'"drvEmpFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAFLACCEXPZ0','50','D','10','7',NULL,'Employee Middle Initial',NULL,NULL,'"drvEmpMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAFLACCEXPZ0','50','D','10','8',NULL,'Address 1',NULL,NULL,'"drvEmpAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAFLACCEXPZ0','50','D','10','9',NULL,'Address 2',NULL,NULL,'"drvEmpAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAFLACCEXPZ0','50','D','10','10',NULL,'Address 3',NULL,NULL,'"drvEmpAddressLine3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAFLACCEXPZ0','50','D','10','11',NULL,'City',NULL,NULL,'"drvEmpCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAFLACCEXPZ0','50','D','10','12',NULL,'State',NULL,NULL,'"drvEmpState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAFLACCEXPZ0','50','D','10','13',NULL,'Zip Code',NULL,NULL,'"drvEmpZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAFLACCEXPZ0','50','D','10','14',NULL,'Employee Gender',NULL,NULL,'"drvEmpGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAFLACCEXPZ0','50','D','10','15',NULL,'Employee Date of Birth',NULL,NULL,'"drvEmpDateofBirth"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAFLACCEXPZ0','50','D','10','16',NULL,'Location Name or Number',NULL,NULL,'"drvEmpLocationName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAFLACCEXPZ0','50','D','10','17',NULL,'Termination Date',NULL,NULL,'"drvEmpTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAFLACCEXPZ0','50','D','10','18',NULL,'Date of Hire',NULL,NULL,'"drvEmpDateofHire"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAFLACCEXPZ0','50','D','10','19',NULL,'Benefit Eligible Date',NULL,NULL,'"drvEmpBenefitEligibleDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAFLACCEXPZ0','50','D','10','20',NULL,'Home Phone Number',NULL,NULL,'"drvEmpHomePhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAFLACCEXPZ0','50','D','10','21',NULL,'Annual Salary',NULL,NULL,'"drvEmpAnnSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAFLACCEXPZ0','50','D','10','22',NULL,'Hours Worked per Week',NULL,NULL,'"drvEmpHoursWorkedPerWeek"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAFLACCEXPZ0','50','D','10','23',NULL,'Salary Mode (Pay Frequency)',NULL,NULL,'"drvEmpSalaryMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAFLACCEXPZ0','50','D','10','24',NULL,'EE''s Billing Frequency',NULL,NULL,'"drvEmpBillingFreq"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAFLACCEXPZ0','50','D','10','25',NULL,'Employer',NULL,NULL,'"drvEmpEmployer"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAFLACCEXPZ0','50','D','10','26',NULL,'Employee''s Occupation',NULL,NULL,'"drvEmpOccupation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAFLACCEXPZ0','50','D','10','27',NULL,'Height',NULL,NULL,'"drvEmpHeight"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAFLACCEXPZ0','50','D','10','28',NULL,'Weight',NULL,NULL,'"drvEmpWeight"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAFLACCEXPZ0','50','D','10','29',NULL,'Response to EE Actively at Work Question',NULL,NULL,'"drvEmpResponse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAFLACCEXPZ0','50','D','10','30',NULL,'Employee''s Email Address',NULL,NULL,'"drvEmpEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAFLACCEXPZ0','50','D','10','31',NULL,'Group Number',NULL,NULL,'"drvEmpGroupNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAFLACCEXPZ0','50','D','20','1',NULL,'Record Discriminator',NULL,NULL,'"drvDEPRecDisc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAFLACCEXPZ0','50','D','20','2',NULL,'Record Type',NULL,NULL,'"drvDepRecType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAFLACCEXPZ0','50','D','20','3',NULL,'Employee SSN/ID',NULL,NULL,'"drvDepSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAFLACCEXPZ0','50','D','20','4',NULL,'Dependent Last Name',NULL,NULL,'"drvDepNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAFLACCEXPZ0','50','D','20','5',NULL,'Dependent First Name',NULL,NULL,'"drvDEPNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAFLACCEXPZ0','50','D','20','6',NULL,'Dependent Middle Initial',NULL,NULL,'"drvDepNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAFLACCEXPZ0','50','D','20','7',NULL,'Dependent Date of Birth',NULL,NULL,'"drvDepDateofBirth"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAFLACCEXPZ0','50','D','20','8',NULL,'Dependent Gender',NULL,NULL,'"drvDepGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAFLACCEXPZ0','50','D','20','9',NULL,'Dependent ID',NULL,NULL,'"drvDepDependentId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAFLACCEXPZ0','50','D','20','10',NULL,'Dependent Weight',NULL,NULL,'"drvDepWeight"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAFLACCEXPZ0','50','D','20','11',NULL,'Dependent Height',NULL,NULL,'"drvDepHeight"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAFLACCEXPZ0','50','D','20','12',NULL,'Response to SP Are you now disabled or unable to w',NULL,NULL,'"drvDepResponse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAFLACCEXPZ0','50','D','20','13',NULL,'Dependent''s Email address',NULL,NULL,'"drvDepEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAFLACCEXPZ0','50','D','20','14',NULL,'Group Number',NULL,NULL,'"drvDepGroupNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAFLACCEXPZ0','50','D','30','1',NULL,'Record Discriminator',NULL,NULL,'"drvProdRecDisc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAFLACCEXPZ0','50','D','30','2',NULL,'Record Indicator',NULL,NULL,'"drvProdRecInd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAFLACCEXPZ0','50','D','30','3',NULL,'Record Type',NULL,NULL,'"drvProdRecType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAFLACCEXPZ0','50','D','30','4',NULL,'Employee SSN/ID',NULL,NULL,'"drvProdEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAFLACCEXPZ0','50','D','30','5',NULL,'Benefit Face Amount',NULL,NULL,'"drvProdBenAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAFLACCEXPZ0','50','D','30','6',NULL,'Premium',NULL,NULL,'"drvProdBenPrm"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAFLACCEXPZ0','50','D','30','7',NULL,'Coverage Option',NULL,NULL,'"drvProdCovOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAFLACCEXPZ0','50','D','30','8',NULL,'Coverage Tier',NULL,NULL,'"drvProdCovTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAFLACCEXPZ0','50','D','30','9',NULL,'Application Date',NULL,NULL,'"drvProdApplicationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAFLACCEXPZ0','50','D','30','10',NULL,'Effective Date',NULL,NULL,'"drvProdEffectiveDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAFLACCEXPZ0','50','D','30','11',NULL,'Termination Date',NULL,NULL,'"drvProdTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAFLACCEXPZ0','50','D','30','12',NULL,'Verify Terminating Coverage Option',NULL,NULL,'"drvProdTeminatingCovOption"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAFLACCEXPZ0','50','D','30','13',NULL,'Change - Adding Coverage',NULL,NULL,'"drvProdAddCov"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAFLACCEXPZ0','50','D','30','14',NULL,'Change - Benefit Changes',NULL,NULL,'"drvProdBenefitChange"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAFLACCEXPZ0','50','D','30','15',NULL,'Change - Demographic Changes',NULL,NULL,'"drvProdDemoChanges"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAFLACCEXPZ0','50','D','30','16',NULL,'Change - Employee Status Change',NULL,NULL,'"drvProdEmpStatsChange"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAFLACCEXPZ0','50','D','30','17',NULL,'Change - Employee Status Change Reason',NULL,NULL,'"drvProdEmplStatChangeReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAFLACCEXPZ0','50','D','30','18',NULL,'Change - Employee Status Change Date',NULL,NULL,'"drvProdEmpStatusChangeDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAFLACCEXPZ0','50','D','30','19',NULL,'Rollover',NULL,NULL,'"drvProdRollOver"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAFLACCEXPZ0','50','D','30','20',NULL,'Rollover Benefit Face Amount',NULL,NULL,'"drvProdRollOverBenAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAFLACCEXPZ0','50','D','30','21',NULL,'Record Set',NULL,NULL,'"drvProdRecordSet"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAFLACCEXPZ0','50','D','30','22',NULL,'Section 125',NULL,NULL,'"drvProdSection125"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAFLACCEXPZ0','50','D','30','23',NULL,'FT or PT',NULL,NULL,'"drvProdFTPT"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAFLACCEXPZ0','50','D','30','24',NULL,'Hourly or Salaried',NULL,NULL,'"drvProdHourlySalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAFLACCEXPZ0','50','D','30','25',NULL,'Class Code',NULL,NULL,'"drvProdClassCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAFLACCEXPZ0','50','D','30','26',NULL,'First Deduction Date',NULL,NULL,'"drvProdFirstDeductionDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAFLACCEXPZ0','50','D','30','27',NULL,'SOE - State of Enrollment',NULL,NULL,'"drvProdStateofEnrollment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAFLACCEXPZ0','50','D','30','28',NULL,'Enrolling Agent Name',NULL,NULL,'"drvProdAgentName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAFLACCEXPZ0','50','D','30','29',NULL,'Enrolling Agent Number',NULL,NULL,'"drvProdAgentNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAFLACCEXPZ0','50','D','30','30',NULL,'Employee Signature Method',NULL,NULL,'"drvProdEmpSignatureMethod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAFLACCEXPZ0','50','D','30','31',NULL,'Enrollment Type/Method',NULL,NULL,'"drvProdEnrollmentTypeMethod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EAFLACCEXPZ0','50','D','30','32',NULL,'Rider 1',NULL,NULL,'"drvProdRider1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EAFLACCEXPZ0','50','D','30','33',NULL,'Rider 2',NULL,NULL,'"drvProdRider2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EAFLACCEXPZ0','50','D','30','34',NULL,'Rider 3',NULL,NULL,'"drvProdRider3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EAFLACCEXPZ0','50','D','30','35',NULL,'Rider 4',NULL,NULL,'"drvProdRider4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EAFLACCEXPZ0','50','D','30','36',NULL,'Rider 5',NULL,NULL,'"drvProdRider5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EAFLACCEXPZ0','50','D','30','37',NULL,'Response to Replacement Question',NULL,NULL,'"drvProdResponse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EAFLACCEXPZ0','50','D','30','38',NULL,'Prior Carrier''s Name',NULL,NULL,'"drvProdCarriersName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EAFLACCEXPZ0','50','D','30','39',NULL,'Prior Carrier''s Certificate Number',NULL,NULL,'"drvProdCertNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EAFLACCEXPZ0','50','D','30','40',NULL,'HQ 1 - TOB',NULL,NULL,'"drvProdHQ1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EAFLACCEXPZ0','50','D','30','41',NULL,'HQ 2 - AIDS',NULL,NULL,'"drvProdHQ2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EAFLACCEXPZ0','50','D','30','42',NULL,'HQ 3 - CANCER',NULL,NULL,'"drvProdHQ3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EAFLACCEXPZ0','50','D','30','43',NULL,'HQ 4 - MED',NULL,NULL,'"drvProdHQ4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EAFLACCEXPZ0','50','D','30','44',NULL,'HQ 5 - 5 DAYS',NULL,NULL,'"drvProdHQ5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EAFLACCEXPZ0','50','D','30','45',NULL,'HQ 6 - RX',NULL,NULL,'"drvProdHQ6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EAFLACCEXPZ0','50','D','30','46',NULL,'HQ 7 - ALCOHOL',NULL,NULL,'"drvProdHQ7"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EAFLACCEXPZ0','50','D','30','47',NULL,'HQ 8 - HOS TREAT',NULL,NULL,'"drvProdHQ8"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EAFLACCEXPZ0','50','D','30','48',NULL,'HQ 9 - MAJ HLTH',NULL,NULL,'"drvProdHQ9"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EAFLACCEXPZ0','50','D','30','49',NULL,'HQ 10 - MEDICAID',NULL,NULL,'"drvProdHQ10"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EAFLACCEXPZ0','50','D','30','50',NULL,'Elimination Period',NULL,NULL,'"drvProdElimPeriod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EAFLACCEXPZ0','50','D','30','51',NULL,'Benefit Period',NULL,NULL,'"drvProdBenPeriod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EAFLACCEXPZ0','50','D','30','52',NULL,'Product Optional Benefit Indicator',NULL,NULL,'"drvProdOptionalBenefitInd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EAFLACCEXPZ0','50','D','30','53',NULL,'Dependent ID',NULL,NULL,'"drvProdDependentId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EAFLACCEXPZ0','50','D','30','54',NULL,'RIDER Premium Indicator',NULL,NULL,'"drvProdRiderIndc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EAFLACCEXPZ0','50','D','30','55',NULL,'PREMIUM MODE',NULL,NULL,'"drvProdPremiumMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EAFLACCEXPZ0','50','D','30','56',NULL,'UNION',NULL,NULL,'"drvProdUnion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EAFLACCEXPZ0','50','D','30','57',NULL,'Roll Over Coverage',NULL,NULL,'"drvProdRollOverCov"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EAFLACCEXPZ0','50','D','30','58',NULL,'HQ 11 - Major Medical',NULL,NULL,'"drvProdHQ11"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EAFLACCEXPZ0','50','D','30','59',NULL,'HQ 12 - Other Coverage',NULL,NULL,'"drvProdHQ12"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EAFLACCEXPZ0','50','D','30','60',NULL,'HQ 12 - Company',NULL,NULL,'"drvProdHQ12C"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EAFLACCEXPZ0','50','D','30','61',NULL,'HQ 12 - PolicyType',NULL,NULL,'"drvProdHQ12CP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EAFLACCEXPZ0','50','D','30','62',NULL,'HQ 12 - Benefit',NULL,NULL,'"drvProdHQ12B"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EAFLACCEXPZ0','50','D','30','63',NULL,'HQ 13 - Medical Condition',NULL,NULL,'"drvProdHQ13"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EAFLACCEXPZ0','50','D','30','64',NULL,'HQ 14 - Vehicle',NULL,NULL,'"drvProdHQ14"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EAFLACCEXPZ0','50','D','30','65',NULL,'HQ 15 - Mental',NULL,NULL,'"drvProdHQ15"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EAFLACCEXPZ0','50','D','30','66',NULL,'HQ 16 - Joint',NULL,NULL,'"drvProdHQ16"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EAFLACCEXPZ0','50','D','30','67',NULL,'Minimum Annual Pay question',NULL,NULL,'"drvProdMinAnnPayQuestion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EAFLACCEXPZ0','50','D','30','68',NULL,'Workers Compensation Question',NULL,NULL,'"drvProdWorkCompQuestion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EAFLACCEXPZ0','50','D','30','69',NULL,'Prior Effective Date',NULL,NULL,'"drvProdPriorEffectiveDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EAFLACCEXPZ0','50','D','30','70',NULL,'HQ 17 -Comp Health Benefit',NULL,NULL,'"drvProdHQ17"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EAFLACCEXPZ0','50','D','30','71',NULL,'HQ 18 -Existing CI Policy',NULL,NULL,'"drvProdHQ18"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EAFLACCEXPZ0','50','D','30','72',NULL,'HQ 19 - Number of CI Policies',NULL,NULL,'"drvProdHQ19"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EAFLACCEXPZ0','50','D','30','73',NULL,'HQ 20 - Medicaid Eligibility',NULL,NULL,'"drvProdHQ20"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EAFLACCEXPZ0','50','D','30','74',NULL,'Aflac Individual ARO Replacement Question',NULL,NULL,'"drvProdAflacARO"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EAFLACCEXPZ0','50','D','30','75',NULL,'Individual Policy being replaced',NULL,NULL,'"drvProdIndPolicyReplace"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EAFLACCEXPZ0','50','D','30','76',NULL,'TDI States Coverage Question',NULL,NULL,'"drvProdTDIQuestion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EAFLACCEXPZ0','50','D','30','77',NULL,'Group Number',NULL,NULL,'"drvProdGroupNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EAFLACCEXPZ0','50','D','30','78',NULL,'HQ 21 - Disorder Nerv System',NULL,NULL,'"drvProdHQ21"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EAFLACCEXPZ0','50','D','30','79',NULL,'HQ 22 - Unconsciousness',NULL,NULL,'"drvProdHQ22"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EAFLACCEXPZ0','50','D','30','80',NULL,'HQ 23 - Prog Disease',NULL,NULL,'"drvProdHQ23"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EAFLACCEXPZ0','50','D','30','81',NULL,'HQ 24 - Results Not Received',NULL,NULL,'"drvProdHQ24"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EAFLACCEXPZ0','50','D','30','82',NULL,'HQ 25 - Blood Pressure',NULL,NULL,'"drvProdHQ26"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAFLACCEXPZ0','50','D','40','1',NULL,'Record Discriminator',NULL,NULL,'"drvBenRecordDisc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAFLACCEXPZ0','50','D','40','2',NULL,'Product Indicator',NULL,NULL,'"drvBenProdInd"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAFLACCEXPZ0','50','D','40','3',NULL,'Record Type',NULL,NULL,'"drvBenRecType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAFLACCEXPZ0','50','D','40','4',NULL,'Employee ID/SSN',NULL,NULL,'"drvBenEmpSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAFLACCEXPZ0','50','D','40','5',NULL,'Beneficiary Full Name',NULL,NULL,'"drvBenFullName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAFLACCEXPZ0','50','D','40','6',NULL,'Beneficiary''s SSN',NULL,NULL,'"drvBenSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAFLACCEXPZ0','50','D','40','7',NULL,'Beneficiary''s Percentage',NULL,NULL,'"drvBenPercentage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAFLACCEXPZ0','50','D','40','8',NULL,'Relationship',NULL,NULL,'"drvBenRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAFLACCEXPZ0','50','D','40','9',NULL,'Group Number',NULL,NULL,'"drvBenGroupNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAFLACCEXPZ0','50','D','50','1',NULL,'Record Discriminator',NULL,NULL,'"drvMetaRecDisc"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAFLACCEXPZ0','50','D','50','2',NULL,'Group Number',NULL,NULL,'"drvMetaGroupNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAFLACCEXPZ0','50','D','50','3',NULL,'Vendor ID',NULL,NULL,'"drvMetaVendorId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAFLACCEXPZ0','50','D','50','4',NULL,'File Type',NULL,NULL,'"drvMetaFileType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAFLACCEXPZ0','50','D','50','5',NULL,'File Status',NULL,NULL,'"drvMetaFileStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAFLACCEXPZ0','50','D','50','6',NULL,'Enrollment Type',NULL,NULL,'"drvMetaEnrollmentType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAFLACCEXPZ0','50','D','50','7',NULL,'File Layout Version',NULL,NULL,'"drvMetaFileLayoutVersion"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAFLACCEXP_20220112.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OR763',NULL,NULL,NULL,'Active Open Enrollment Export','202201089','EMPEXPORT','OEACTIVE','Dec 14 2021  3:35PM','EAFLACCEXP',NULL,NULL,NULL,'202201089','Jan  8 2022 12:00AM','Dec 30 1899 12:00AM','202201011','283','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3lKiARA1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','OR763',NULL,NULL,NULL,'Passive Open Enrollment Export','202201089','EMPEXPORT','OEPASSIVE','Nov 19 2021  9:44AM','EAFLACCEXP',NULL,NULL,NULL,'202201089','Jan  8 2022 12:00AM','Dec 30 1899 12:00AM','202201011','260','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3lKiARA1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Aflac Enrollment ONDEMAND','201912129','EMPEXPORT','ONDEMAND','Jun 26 2020 12:00AM','EAFLACCEXP',NULL,NULL,NULL,'201912129','Dec 12 2019 12:00AM','Dec 30 1899 12:00AM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',OR763',NULL,NULL,NULL,'AFLAC - monthly on 20th','201912129','EMPEXPORT','SCH_AFLXP',NULL,'EAFLACCEXP',NULL,NULL,NULL,'201912129','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202201109','EMPEXPORT','TEST','Jan 10 2022  1:53PM','EAFLACCEXP',NULL,NULL,NULL,'202201109','Jan 10 2022 12:00AM','Dec 30 1899 12:00AM','202201031','392','','','202201031',dbo.fn_GetTimedKey(),NULL,'us3lKiARA1003',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D10','dbo.U_EAFLACCEXP_drvTblEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D20','dbo.U_EAFLACCEXP_drvTblDep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D30','dbo.U_EAFLACCEXP_drvTblProd',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D40','dbo.U_EAFLACCEXP_drvTblBen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D50','dbo.U_EAFLACCEXP_drvTblMeta',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table dboU_EAFLACCEXP_BdmConsolidated
-----------

IF OBJECT_ID('dboU_EAFLACCEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[dboU_EAFLACCEXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL,
    [bdmbenstatatus] varchar(10) NULL
);

-----------
-- Create table U_dsi_BDM_EAFLACCEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EAFLACCEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAFLACCEXP] (
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
-- Create table U_EAFLACCEXP_BdmConsolidated
-----------

IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL,
    [bdmbenstatus] char(1) NULL
);

-----------
-- Create table U_EAFLACCEXP_DedList
-----------

IF OBJECT_ID('U_EAFLACCEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblBen
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblBen') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblBen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvBenRecordDisc] varchar(4) NOT NULL,
    [drvBenProdInd] varchar(4) NULL,
    [drvBenRecType] varchar(1) NOT NULL,
    [drvBenEmpSSN] char(11) NULL,
    [drvBenFullName] varchar(201) NULL,
    [drvBenSSN] varchar(11) NULL,
    [drvBenPercentage] varchar(3) NULL,
    [drvBenRelationship] varchar(2) NOT NULL,
    [drvBenGroupNumber] varchar(6) NOT NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblDep
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblDep') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblDep] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDEPRecDisc] varchar(4) NOT NULL,
    [drvDepRecType] varchar(1) NOT NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepSSN] char(11) NULL,
    [drvDepNameLast] varchar(100) NULL,
    [drvDEPNameFirst] varchar(100) NULL,
    [drvDepNameMiddle] varchar(1) NULL,
    [drvDepDateofBirth] datetime NULL,
    [drvDepGender] char(1) NULL,
    [drvDepDependentId] char(11) NULL,
    [drvDepWeight] varchar(1) NOT NULL,
    [drvDepHeight] varchar(1) NOT NULL,
    [drvDepResponse] varchar(1) NOT NULL,
    [drvDepEmailAddress] varchar(1) NOT NULL,
    [drvDepGroupNumber] varchar(6) NOT NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblEmp
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpRecDisc] varchar(4) NOT NULL,
    [drvEmpRecType] varchar(1) NOT NULL,
    [drvEmpUnComp] varchar(3) NOT NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpLastName] varchar(131) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvEmpAddressLine1] varchar(255) NULL,
    [drvEmpAddressLine2] varchar(255) NULL,
    [drvEmpAddressLine3] varchar(1) NOT NULL,
    [drvEmpCity] varchar(255) NULL,
    [drvEmpState] varchar(255) NULL,
    [drvEmpZipCode] varchar(50) NULL,
    [drvEmpGender] char(1) NULL,
    [drvEmpDateofBirth] datetime NULL,
    [drvEmpLocationName] varchar(1) NOT NULL,
    [drvEmpTerminationDate] datetime NULL,
    [drvEmpDateofHire] datetime NULL,
    [drvEmpBenefitEligibleDate] varchar(1) NOT NULL,
    [drvEmpHomePhoneNumber] varchar(50) NULL,
    [drvEmpAnnSalary] varchar(1) NOT NULL,
    [drvEmpHoursWorkedPerWeek] varchar(2) NOT NULL,
    [drvEmpSalaryMode] varchar(1) NOT NULL,
    [drvEmpBillingFreq] varchar(1) NOT NULL,
    [drvEmpEmployer] varchar(17) NOT NULL,
    [drvEmpOccupation] varchar(1) NOT NULL,
    [drvEmpHeight] varchar(1) NOT NULL,
    [drvEmpWeight] varchar(1) NOT NULL,
    [drvEmpResponse] varchar(1) NOT NULL,
    [drvEmpEmailAddress] varchar(1) NOT NULL,
    [drvEmpGroupNumber] varchar(6) NOT NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblMeta
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblMeta] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(14) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvMetaRecDisc] varchar(4) NOT NULL,
    [drvMetaGroupNumber] varchar(6) NOT NULL,
    [drvMetaVendorId] varchar(6) NOT NULL,
    [drvMetaFileType] varchar(1) NOT NULL,
    [drvMetaFileStatus] varchar(1) NOT NULL,
    [drvMetaEnrollmentType] varchar(2) NOT NULL,
    [drvMetaFileLayoutVersion] varchar(6) NOT NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblProd
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblProd') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblProd] (
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvProdRecDisc] varchar(4) NULL,
    [drvProdRecInd] varchar(4) NULL,
    [drvProdRecType] varchar(1) NOT NULL,
    [drvProdEmpSSN] char(11) NULL,
    [drvProdBenAmt] varchar(24) NULL,
    [drvProdBenAmtRaw] money NULL,
    [drvProdBenPrm] varchar(24) NULL,
    [drvProdBenPrmRaw] money NULL,
    [drvProdCovOption] varchar(1) NULL,
    [drvProdCovTier] varchar(1) NOT NULL,
    [drvProdApplicationDate] datetime NULL,
    [drvProdEffectiveDate] datetime NULL,
    [drvProdTerminationDate] datetime NULL,
    [drvProdTeminatingCovOption] varchar(1) NULL,
    [drvProdAddCov] varchar(1) NOT NULL,
    [drvProdBenefitChange] varchar(1) NOT NULL,
    [drvProdDemoChanges] varchar(1) NOT NULL,
    [drvProdEmpStatsChange] varchar(1) NOT NULL,
    [drvProdEmplStatChangeReason] varchar(1) NOT NULL,
    [drvProdEmpStatusChangeDate] varchar(1) NOT NULL,
    [drvProdRollOver] varchar(1) NOT NULL,
    [drvProdRollOverBenAmt] varchar(1) NOT NULL,
    [drvProdRecordSet] varchar(1) NOT NULL,
    [drvProdSection125] varchar(1) NOT NULL,
    [drvProdFTPT] varchar(2) NULL,
    [drvProdHourlySalary] char(1) NULL,
    [drvProdClassCode] varchar(1) NOT NULL,
    [drvProdFirstDeductionDate] varchar(1) NOT NULL,
    [drvProdStateofEnrollment] varchar(255) NULL,
    [drvProdAgentName] varchar(19) NOT NULL,
    [drvProdAgentNumber] varchar(4) NOT NULL,
    [drvProdEmpSignatureMethod] varchar(1) NOT NULL,
    [drvProdEnrollmentTypeMethod] varchar(1) NOT NULL,
    [drvProdRider1] varchar(1) NOT NULL,
    [drvProdRider2] varchar(1) NOT NULL,
    [drvProdRider3] varchar(1) NOT NULL,
    [drvProdRider4] varchar(1) NOT NULL,
    [drvProdRider5] varchar(1) NOT NULL,
    [drvProdResponse] varchar(1) NOT NULL,
    [drvProdCarriersName] varchar(1) NOT NULL,
    [drvProdCertNumber] varchar(1) NOT NULL,
    [drvProdHQ1] varchar(1) NOT NULL,
    [drvProdHQ2] varchar(1) NOT NULL,
    [drvProdHQ3] varchar(1) NOT NULL,
    [drvProdHQ4] varchar(1) NOT NULL,
    [drvProdHQ5] varchar(1) NOT NULL,
    [drvProdHQ6] varchar(1) NOT NULL,
    [drvProdHQ7] varchar(1) NOT NULL,
    [drvProdHQ8] varchar(1) NOT NULL,
    [drvProdHQ9] varchar(1) NOT NULL,
    [drvProdHQ10] varchar(1) NOT NULL,
    [drvProdElimPeriod] varchar(1) NOT NULL,
    [drvProdBenPeriod] varchar(1) NOT NULL,
    [drvProdOptionalBenefitInd] varchar(1) NOT NULL,
    [drvProdDependentId] char(11) NULL,
    [drvProdRiderIndc] varchar(1) NOT NULL,
    [drvProdPremiumMode] varchar(2) NOT NULL,
    [drvProdUnion] varchar(1) NOT NULL,
    [drvProdRollOverCov] varchar(1) NOT NULL,
    [drvProdHQ11] varchar(1) NOT NULL,
    [drvProdHQ12] varchar(1) NOT NULL,
    [drvProdHQ12C] varchar(1) NOT NULL,
    [drvProdHQ12CP] varchar(1) NOT NULL,
    [drvProdHQ12B] varchar(1) NOT NULL,
    [drvProdHQ13] varchar(1) NOT NULL,
    [drvProdHQ14] varchar(1) NOT NULL,
    [drvProdHQ15] varchar(1) NOT NULL,
    [drvProdHQ16] varchar(1) NOT NULL,
    [drvProdMinAnnPayQuestion] varchar(1) NOT NULL,
    [drvProdWorkCompQuestion] varchar(1) NOT NULL,
    [drvProdPriorEffectiveDate] varchar(1) NOT NULL,
    [drvProdHQ17] varchar(1) NOT NULL,
    [drvProdHQ18] varchar(1) NOT NULL,
    [drvProdHQ19] varchar(1) NOT NULL,
    [drvProdHQ20] varchar(1) NOT NULL,
    [drvProdAflacARO] varchar(1) NOT NULL,
    [drvProdIndPolicyReplace] varchar(1) NOT NULL,
    [drvProdTDIQuestion] varchar(1) NOT NULL,
    [drvProdGroupNumber] varchar(6) NOT NULL,
    [drvProdHQ21] varchar(1) NOT NULL,
    [drvProdHQ22] varchar(1) NOT NULL,
    [drvProdHQ23] varchar(1) NOT NULL,
    [drvProdHQ24] varchar(1) NOT NULL,
    [drvProdHQ26] varchar(1) NOT NULL,
    [drvEEDateOfBirth] datetime NULL,
    [drvSpDateOfBirth] datetime NULL,
    [drvEEGender] char(1) NULL,
    [drvDedcode] char(5) NULL
);

-----------
-- Create table U_EAFLACCEXP_drvTblProd2
-----------

IF OBJECT_ID('U_EAFLACCEXP_drvTblProd2') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblProd2] (
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvProdRecDisc] varchar(4) NULL,
    [drvProdRecInd] varchar(4) NULL,
    [drvProdRecType] varchar(1) NOT NULL,
    [drvProdEmpSSN] char(11) NULL,
    [drvProdBenAmt] varchar(24) NULL,
    [drvProdBenAmtRaw] money NULL,
    [drvProdBenPrm] varchar(24) NULL,
    [drvProdBenPrmRaw] money NULL,
    [drvProdCovOption] varchar(1) NULL,
    [drvProdCovTier] varchar(1) NOT NULL,
    [drvProdApplicationDate] datetime NULL,
    [drvProdEffectiveDate] datetime NULL,
    [drvProdTerminationDate] datetime NULL,
    [drvProdTeminatingCovOption] varchar(1) NULL,
    [drvProdAddCov] varchar(1) NOT NULL,
    [drvProdBenefitChange] varchar(1) NOT NULL,
    [drvProdDemoChanges] varchar(1) NOT NULL,
    [drvProdEmpStatsChange] varchar(1) NOT NULL,
    [drvProdEmplStatChangeReason] varchar(1) NOT NULL,
    [drvProdEmpStatusChangeDate] varchar(1) NOT NULL,
    [drvProdRollOver] varchar(1) NOT NULL,
    [drvProdRollOverBenAmt] varchar(1) NOT NULL,
    [drvProdRecordSet] varchar(1) NOT NULL,
    [drvProdSection125] varchar(1) NOT NULL,
    [drvProdFTPT] varchar(2) NULL,
    [drvProdHourlySalary] char(1) NULL,
    [drvProdClassCode] varchar(1) NOT NULL,
    [drvProdFirstDeductionDate] varchar(1) NOT NULL,
    [drvProdStateofEnrollment] varchar(255) NULL,
    [drvProdAgentName] varchar(19) NOT NULL,
    [drvProdAgentNumber] varchar(4) NOT NULL,
    [drvProdEmpSignatureMethod] varchar(1) NOT NULL,
    [drvProdEnrollmentTypeMethod] varchar(1) NOT NULL,
    [drvProdRider1] varchar(1) NOT NULL,
    [drvProdRider2] varchar(1) NOT NULL,
    [drvProdRider3] varchar(1) NOT NULL,
    [drvProdRider4] varchar(1) NOT NULL,
    [drvProdRider5] varchar(1) NOT NULL,
    [drvProdResponse] varchar(1) NOT NULL,
    [drvProdCarriersName] varchar(1) NOT NULL,
    [drvProdCertNumber] varchar(1) NOT NULL,
    [drvProdHQ1] varchar(1) NOT NULL,
    [drvProdHQ2] varchar(1) NOT NULL,
    [drvProdHQ3] varchar(1) NOT NULL,
    [drvProdHQ4] varchar(1) NOT NULL,
    [drvProdHQ5] varchar(1) NOT NULL,
    [drvProdHQ6] varchar(1) NOT NULL,
    [drvProdHQ7] varchar(1) NOT NULL,
    [drvProdHQ8] varchar(1) NOT NULL,
    [drvProdHQ9] varchar(1) NOT NULL,
    [drvProdHQ10] varchar(1) NOT NULL,
    [drvProdElimPeriod] varchar(1) NOT NULL,
    [drvProdBenPeriod] varchar(1) NOT NULL,
    [drvProdOptionalBenefitInd] varchar(1) NOT NULL,
    [drvProdDependentId] char(11) NULL,
    [drvProdRiderIndc] varchar(1) NOT NULL,
    [drvProdPremiumMode] varchar(2) NOT NULL,
    [drvProdUnion] varchar(1) NOT NULL,
    [drvProdRollOverCov] varchar(1) NOT NULL,
    [drvProdHQ11] varchar(1) NOT NULL,
    [drvProdHQ12] varchar(1) NOT NULL,
    [drvProdHQ12C] varchar(1) NOT NULL,
    [drvProdHQ12CP] varchar(1) NOT NULL,
    [drvProdHQ12B] varchar(1) NOT NULL,
    [drvProdHQ13] varchar(1) NOT NULL,
    [drvProdHQ14] varchar(1) NOT NULL,
    [drvProdHQ15] varchar(1) NOT NULL,
    [drvProdHQ16] varchar(1) NOT NULL,
    [drvProdMinAnnPayQuestion] varchar(1) NOT NULL,
    [drvProdWorkCompQuestion] varchar(1) NOT NULL,
    [drvProdPriorEffectiveDate] varchar(1) NOT NULL,
    [drvProdHQ17] varchar(1) NOT NULL,
    [drvProdHQ18] varchar(1) NOT NULL,
    [drvProdHQ19] varchar(1) NOT NULL,
    [drvProdHQ20] varchar(1) NOT NULL,
    [drvProdAflacARO] varchar(1) NOT NULL,
    [drvProdIndPolicyReplace] varchar(1) NOT NULL,
    [drvProdTDIQuestion] varchar(1) NOT NULL,
    [drvProdGroupNumber] varchar(6) NOT NULL,
    [drvProdHQ21] varchar(1) NOT NULL,
    [drvProdHQ22] varchar(1) NOT NULL,
    [drvProdHQ23] varchar(1) NOT NULL,
    [drvProdHQ24] varchar(1) NOT NULL,
    [drvProdHQ26] varchar(1) NOT NULL,
    [drvEEDateOfBirth] datetime NULL,
    [drvSpDateOfBirth] datetime NULL,
    [drvEEGender] char(1) NULL,
    [drvDedcode] char(5) NULL
);

-----------
-- Create table U_EAFLACCEXP_EEList
-----------

IF OBJECT_ID('U_EAFLACCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAFLACCEXP_File
-----------

IF OBJECT_ID('U_EAFLACCEXP_File') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EAFLACCEXP_PDedHist
-----------

IF OBJECT_ID('U_EAFLACCEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EAFLACCEXP_PEarHist
-----------

IF OBJECT_ID('U_EAFLACCEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLACCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: AllHealth Network

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 08/24/2021
Service Request Number: TekP-2021-07-09-0001

Purpose: Aflac ACC/HOSP/CRIT Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAFLACCEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAFLACCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAFLACCEXP';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'EAFLACCEXP', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@FileMinCovDate    DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EAFLACCEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate = CAST('1/1/2022' as datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EAFLACCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAFLACCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================


    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'AFACC,AHAL2,AHAL3,AHALL,AHBA2,AHBA3,AHBAS,AHEB2,AHEB3,AHEBR,AHOS1,AHOS2,AHOS3,AHSU2,AHSU3,AHSUR,GACC,GHOS,GCIEE,GCISP';

    IF OBJECT_ID('U_EAFLACCEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAFLACCEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;
   DELETE FROM dbo.U_dsi_bdm_BCAConfiguration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct',@DedList);
        -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RateEffDate',@EndDate)  
 
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



      --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_bdm_EAFLACCEXP

        SET BdmUSGField2 = EedEmpDedTVID

    FROM dbo.U_dsi_bdm_EAFLACCEXP

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with        BPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_bdm_EAFLACCEXP

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_bdm_EAFLACCEXP

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================

    UPDATE dbo.U_dsi_bdm_EAFLACCEXP

        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)

    FROM dbo.U_dsi_bdm_EAFLACCEXP

    JOIN dbo.EmpDedFull WITH (NOLOCK)

        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAFLACCEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EAFLACCEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAFLACCEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EAFLACCEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_PEarHist;
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
    INTO dbo.U_EAFLACCEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_BdmConsolidated;
    select bdmeeid,
          bdmcoid,
          bdmrectype,
          bdmrelationship,
          bdmdedcode,
          bdmdeprecid,
          bdmbenoption,max(BdmUSGField1) as BdmUSGField1,
          max(bdmBenStartDate) as bdmBenStartDate, 
          max(bdmBenStopDate) as bdmBenStopDate,
          max(bdmbenstatus) as bdmbenstatus
          INTO dbo.U_EAFLACCEXP_BdmConsolidated
          from dbo.U_dsi_BDM_EAFLACCEXP 
        group by bdmeeid,bdmcoid,bdmrectype,bdmrelationship,bdmdedcode,bdmdeprecid,bdmbenoption
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblEmp
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpRecDisc = 'EMPL'
        ,drvEmpRecType = 'A'
        ,drvEmpUnComp = 'CAI'
        ,drvInitialSort = eepSSN
        ,drvSubSort = '2'
        ,drvEmpSSN = eepSSN
        ,drvEmpLastName = EepNameLast + ' ' + ISNULL(EepNameSuffix,'')
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleName = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvEmpAddressLine1 = EepAddressLine1
        ,drvEmpAddressLine2 = EepAddressLine2
        ,drvEmpAddressLine3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpState = EepAddressState
        ,drvEmpZipCode = EepAddressZipCode
        ,drvEmpGender = EepGender
        ,drvEmpDateofBirth = EepDateOfBirth
        ,drvEmpLocationName = ''
        ,drvEmpTerminationDate = CASE WHEN eecEmplStatus = 'T' THEN eecdateoftermination END
        ,drvEmpDateofHire = EecDateOfLastHire    
        ,drvEmpBenefitEligibleDate = '' --CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire then EecDateOfLastHire Else EecDateOfOriginalHire END
        ,drvEmpHomePhoneNumber = EepPhoneHomeNumber
        ,drvEmpAnnSalary = ''
        ,drvEmpHoursWorkedPerWeek = '30'
        ,drvEmpSalaryMode = 'S'

        ,drvEmpBillingFreq = ''
        ,drvEmpEmployer = 'Allhealth Network'
        ,drvEmpOccupation =  '' --REPLACE(REPLACE((SELECT Top 1JbcDesc FROM JobCode where JbcJobCode = EecJobCode), CHAR(13), ''), CHAR(10), '')
        ,drvEmpHeight = ''
        ,drvEmpWeight = ''
        ,drvEmpResponse = 'Y'
        ,drvEmpEmailAddress = ''
        ,drvEmpGroupNumber = '343569'
    INTO dbo.U_EAFLACCEXP_drvTblEmp
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (select bdmeeid,bdmcoid,max(bdmbenstartdate ) as bdmbenstartdate from dbo.U_dsi_BDM_EAFLACCEXP WITH (NOLOCK) --Where bdmRecType = 'EMP'
group by bdmeeid,bdmcoid ) as bdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblDep
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblDep','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblDep;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvDEPRecDisc = CASE WHEN ConRelationship IN ('SPS','DP') THEN 'SPSE'
                              ELSE 'DPDT'
                         END
        ,drvDepRecType = 'A'
        ,drvInitialSort = eepSSN
        ,drvSubSort = '3'
        ,drvDepSSN = eepSSN
        ,drvDepNameLast = ConNameLast
        ,drvDEPNameFirst = ConNameFirst
        ,drvDepNameMiddle = LEFT(ISNULL(ConNameMiddle,''),1)
        ,drvDepDateofBirth = ConDateOfBirth
        ,drvDepGender = ConGender
        ,drvDepDependentId = ConSSN
        ,drvDepWeight = ''
        ,drvDepHeight = ''
        ,drvDepResponse = CASE WHEN ConRelationship IN ('SPS','DP') THEN 'N'
                              ELSE ''
                         END
        ,drvDepEmailAddress = ''
        ,drvDepGroupNumber = '343569'
    INTO dbo.U_EAFLACCEXP_drvTblDep
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAFLACCEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    Where bdmRecType = 'DEP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblProd
    ---------------------------------
   
    IF OBJECT_ID('U_EAFLACCEXP_drvTblProd','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblProd;
    SELECT DISTINCT
        drvInitialSort = eepSSN
        ,drvSubSort = '4'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ''
        -- standard fields above and additional driver fields below


        ,drvProdRecDisc = CASE WHEN BdmDedCode IN ('AFACC', 'GACC') THEN 'ACCD'
                             WHEN BdmDedCode IN ('AHAL2','AHAL3', 'AHALL','AHBA2', 'AHBA3','AHBAS', 'AHEB2','AHEB3', 'AHEBR','AHOS1', 'AHOS2','AHOS3', 'AHSU2','AHSU3','AHSUR','GHOS') THEN 'HIPL'
                              WHEN BdmDedCode IN ('GCIEE','GCISP') THEN 'CRIT'
                                     

                END 
        ,drvProdRecInd = CASE WHEN bdmRecType = 'EMP' THEN 'EMPL'
                              WHEN bdmRecType = 'DEP' THEN
                                CASE WHEN bdmrelationship IN ('SPS','DP') THEN 'SPSE'
                                    ELSE 'DPDT'
                                END
                         END
        ,drvProdRecType = 'A'
        ,drvProdEmpSSN = eepSSN
        ,drvProdBenAmt = dbo.dsi_fnPadZero(CAST(Isnull(BdmUSGField1,0) as money) ,7,0)   /*CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' )  THEN  dbo.dsi_fnPadZero(CAST(Isnull(BdmUSGField1,0) as money) ,7,0)  
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN dbo.dsi_fnPadZero(CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLACCEXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)  ,7,0)
                              END*/
        ,drvProdBenAmtRaw = CAST(Isnull(BdmUSGField1,0) as money)  /*CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' ) THEN  CAST(Isnull(BdmUSGField1,0) as money) 
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLACCEXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)
                              END*/
        ,drvProdBenPrm =  CASE WHEN bcaeeamt is not null then dbo.dsi_fnPadZero( bcaeeamt *100 , 7,0)
                              ELSE
                                CASE WHEN BdmDedCode IN ('GCISP') THEN dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100, 7,0)
                                    WHEN bdmdedcode = 'GCIEE' and bdmdedcode <> 'GCISP' THEN  dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100 , 7,0)
                                 ELSE '-1'
                            END
                          END 
                    /*CASE WHEN BdmDedCode IN ('AFLCA') THEN  dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100 , 7,0)
                             WHEN BdmDedCode IN ('AFLCH') THEN dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100, 7,0)
                          END*/ 
                                      
        ,drvProdBenPrmRaw =  bcaeeamt /*CASE WHEN BdmDedCode IN ('AFLCA') THEN   (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) 
                             WHEN BdmDedCode IN ('AFLCH') THEN  (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption)
                          END */

                            /*
                           If EedBenOption = EE or EEPLUS send 1
If EedBenOption = EES or EEDP send 2
If EedBenOption = EEC or EEDPC send 3 
If EedBenOption = EEF, EEDPF or FMPLUS send 4                    
                            */
        ,drvProdCovOption = CASE 
                                WHEN bdmdedcode = 'GCISP' then '2'
                                WHEN bdmdedcode = 'GCIEE' and bdmdedcode <> 'GCISP' then '1'
                                WHEN bdmBenOption IN ('EE','EEPLUS') THEN '1'
                                WHEN bdmBenOption IN ('EES','EEDP') THEN '2'
                                WHEN bdmBenOption IN ('EEC','EEDPC') THEN '3'
                                WHEN bdmBenOption IN ('EEF', 'EEDPF','FMPLUS') THEN '4'
                                

                    END 
        ,drvProdCovTier = ''
        ,drvProdApplicationDate = CASE WHEN @ExportCode LIKE '%PASSIVE' or @ExportCode LIKE '%ACTIVE' THEN DateAdd(Day,-1,GETDATE())
                                    ELSE DateAdd(Day,-1,dbo.dsi_fnGetMinMaxDates('MAX',bdmBenStartDate, @FileMinCovDate) )
                                   END
        ,drvProdEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmBenStartDate, @FileMinCovDate)

        ,drvProdTerminationDate = CASE WHEN eecemplstatus = 'T' THEN bdmBenStopDate END
        /*
            if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (SPS, DP, CHL, DPC, STC) send 4
                if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (SPS, DP) and not (CHL, DPC, STC) send 2

            if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (CHL, DPC, STC) and not (SPS, DP) send 3 : TODO
        */
        ,drvProdTeminatingCovOption = CASE WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' and bdmrelationship = 'SPS' and bdmrelationship not in ('CHD','DPC','STC') THEN '2'
                                           WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' and bdmrelationship in ('CHD','DPC','STC') and bdmrelationship <> 'SPS' THEN '3'
                                           WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' and bdmrelationship in ('SPS','CHD','DPC','STC') THEN '4'
                                      END
        ,drvProdAddCov = ''
        ,drvProdBenefitChange = ''
        ,drvProdDemoChanges = ''
        ,drvProdEmpStatsChange = ''
        ,drvProdEmplStatChangeReason = ''
        ,drvProdEmpStatusChangeDate = ''
        ,drvProdRollOver = ''
        ,drvProdRollOverBenAmt = ''
        ,drvProdRecordSet = ''
        ,drvProdSection125 = case when bdmdedcode in  ('AFACC', 'AHAL2','AHAL3', 'AHALL', 'AHBA2', 'AHBA3','AHBAS', 'AHEB2', 'AHEB3', 'AHEBR','AHOS1', 'AHOS2',
                                     'AHOS3', 'AHSU2','AHSU3', 'AHSUR','GACC','GHOS') THEN 'Y' ELSE 'N' END 
        ,drvProdFTPT = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                            WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                        END
        ,drvProdHourlySalary = EecSalaryOrHourly
        ,drvProdClassCode = ''
        ,drvProdFirstDeductionDate = ''
        ,drvProdStateofEnrollment = EepAddressState
        ,drvProdAgentName = 'Internet Enrollment'
        ,drvProdAgentNumber = '1000'
        ,drvProdEmpSignatureMethod = '1'
        ,drvProdEnrollmentTypeMethod = '3'
        ,drvProdRider1 = ''
        ,drvProdRider2 = ''
        ,drvProdRider3 = ''
        ,drvProdRider4 = ''
        ,drvProdRider5 = ''
        ,drvProdResponse = ''
        ,drvProdCarriersName = ''
        ,drvProdCertNumber = ''
        ,drvProdHQ1 = 'N' /*CASE WHEN BdmRecType = 'EMP' THEN EepIsSmoker  
                           WHEN BdmRecType = 'DEP' THEN  (
                                CASE WHEN bdmrelationship = 'SPS' THEN
                                    (Select top 1 conIsSmoker from contacts where conrelationship = 'SPS' and coneeid =  bdmeeid)
                                ELSE 
                                 (Select top 1 conIsSmoker from contacts where conrelationship <> 'SPS' and coneeid =  bdmeeid)
                            END 
                           )
                      END*/
        ,drvProdHQ2 = ''
        ,drvProdHQ3 = ''
        ,drvProdHQ4 = ''
        ,drvProdHQ5 = ''
        ,drvProdHQ6 = ''
        ,drvProdHQ7 = ''
        ,drvProdHQ8 = ''
        ,drvProdHQ9 = ''
        ,drvProdHQ10 = ''
        ,drvProdElimPeriod = ''
        ,drvProdBenPeriod = ''
        ,drvProdOptionalBenefitInd = ''
        ,drvProdDependentId = ConSSN

        ,drvProdRiderIndc = CASE WHEN BdmDedCode IN ('GACC', 'GHOS','AFACC', 'AHAL2','AHAL3', 'AHALL', 'AHBA2', 'AHBA3','AHBAS', 'AHEB2', 'AHEB3', 'AHEBR','AHOS1', 'AHOS2', 'AHOS3', 'AHSU2','AHSU3', 'AHSUR') THEN 'N'
                                 ELSE 'Y'
                            END
        ,drvProdPremiumMode ='26'
        ,drvProdUnion = ''
        ,drvProdRollOverCov = ''
        ,drvProdHQ11 = ''
        ,drvProdHQ12 = ''
        ,drvProdHQ12C = ''
        ,drvProdHQ12CP = ''
        ,drvProdHQ12B = ''
        ,drvProdHQ13 = ''
        ,drvProdHQ14 = ''
        ,drvProdHQ15 = ''
        ,drvProdHQ16 = ''
        ,drvProdMinAnnPayQuestion = ''
        ,drvProdWorkCompQuestion = ''
        ,drvProdPriorEffectiveDate = ''
        ,drvProdHQ17 = ''
        ,drvProdHQ18 = ''
        ,drvProdHQ19 = ''
        ,drvProdHQ20 = ''
        /*if edhdedcode = AFACC, AHAL2,
AHAL3, AHALL, AHBA2, AHBA3,
AHBAS, AHEB2, AHEB3, AHEBR,
AHOS1, AHOS2, AHOS3, AHSU2,
AHSU3, AHSUR or XXXX and edhbenstatus = T
and eeddedcode = XXX send Y else send N
        */
        ,drvProdAflacARO = CASE WHEN BdmDedCode IN ('GACC', 'GHOS') and (BdmDedCode IN ('AFACC', 'AHAL2','AHAL3', 'AHALL', 'AHBA2', 'AHBA3','AHBAS', 'AHEB2', 'AHEB3', 'AHEBR','AHOS1', 'AHOS2',
                                     'AHOS3', 'AHSU2','AHSU3', 'AHSUR') and BdmBenStatus = 'T') THEN 'Y'
                                --WHEN BdmDedCode IN ('AFACC', 'AHAL2','AHAL3', 'AHALL', 'AHBA2', 'AHBA3','AHBAS', 'AHEB2', 'AHEB3', 'AHEBR','AHOS1', 'AHOS2',
        --                             'AHOS3', 'AHSU2','AHSU3', 'AHSUR') and BdmBenStatus = 'T' THEN
                                 ELSE 'N'
                            END
                            --CASE WHEN bdmdedcode in ('AFACC', 'AHAL2','AHAL3', 'AHALL', 'AHBA2', 'AHBA3','AHBAS', 'AHEB2', 'AHEB3', 
       --                                            'AHEBR','AHOS1', 'AHOS2', 'AHOS3', 'AHSU2','AHSU3', 'AHSUR' , 'GACC','GHOS' ) 
                            --                       and bdmbenstatus ='T' 
                                                   
                            --                       THEN 'Y'
       --                         ELSE 'N'
       --                     END
        ,drvProdIndPolicyReplace = ''
        ,drvProdTDIQuestion = ''
        ,drvProdGroupNumber = '343569'
        ,drvProdHQ21 = ''
        ,drvProdHQ22 = ''
        ,drvProdHQ23 = ''
        ,drvProdHQ24 = ''
        ,drvProdHQ26 = ''
        ,drvEEDateOfBirth = eepdateofbirth
        ,drvSpDateOfBirth =  case when bdmrelationship in ('SPS','DP') THEN 
                                (Select top 1 condateofbirth from contacts where conrelationship in ('SPS','DP') and coneeid =  bdmeeid)
                             end 
        ,drvEEGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender  
                           WHEN BdmRecType = 'DEP' THEN (
                            CASE WHEN bdmrelationship in ('SPS','DP') THEN
                                    (Select top 1 congender from contacts where conrelationship in ('SPS','DP') and coneeid =  bdmeeid)
                                ELSE 
                                 (Select top 1 congender from contacts where conrelationship not in ('SPS','DP') and coneeid =  bdmeeid)
                            END 
                           )
                      END
        ,drvDedcode = BdmDedCode
        
    INTO dbo.U_EAFLACCEXP_drvTblProd
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EAFLACCEXP_BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
   LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
    AND ConSystemID = BdmDepRecID
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
    AND bdmdedcode = bcadedcode --and bcaeeamt is not null

    Delete from dbo.U_EAFLACCEXP_drvTblProd where  drvProdRecDisc is null
    Delete from U_EAFLACCEXP_drvTblProd where drvProdBenPrm = '-1'



    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblBen
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblBen','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblBen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = '5'
                -- standard fields above and additional driver fields below
        ,drvBenRecordDisc = 'BENE'
        ,drvBenProdInd = CASE WHEN BfpDedCode IN ('AFACC', 'GACC') THEN 'ACCD' 
                              WHEN BfpDedCode IN ('GCIEE', 'GCISP') THEN 'CRIT'
                              --When BfpDedCode IN ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A',  'AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S' ) THEN 'CRIT'
                         END
        ,drvBenRecType = 'A'
        ,drvBenEmpSSN = eepSSN
        ,drvBenFullName = ConNameFirst + ' ' + ConNameLast
        ,drvBenSSN = CASE WHEN ISNULL(ConSSN,'') = '' THEN '0000000000' ELSE CONSSN END
        ,drvBenPercentage = CAST(CONVERT(DECIMAL(3,0),BfpPctToAlloc) as varchar(3))
        ,drvBenRelationship = CASE WHEN ConRelationship in ('BRO') THEN '18'
                                   WHEN ConRelationship in ('SIS') THEN '18'
                                   WHEN ConRelationship in ('DAD') THEN '03'
                                   WHEN ConRelationship in ('EST') THEN '41'
                                   WHEN ConRelationship in ('MOM') THEN '04'
                                   WHEN ConRelationship in ('NIC') THEN '26'
                                   WHEN ConRelationship in ('SIS') THEN '19'
                                   WHEN ConRelationship in ('STF') THEN '14'
                                   WHEN ConRelationship in ('CHL') and ConGender = 'M' THEN '05'
                                   WHEN ConRelationship in ('CHL') and ConGender = 'F' THEN '06'
                                   WHEN ConRelationship in ('GRC') and ConGender = 'M' THEN '07'
                                   WHEN ConRelationship in ('GRC') and ConGender = 'F' THEN '08'
                                   WHEN ConRelationship in ('SPS') and ConGender = 'M' THEN '01'
                                   WHEN ConRelationship in ('SPS') and ConGender = 'F' THEN '02'
                                   WHEN ConRelationship in ('DP') and ConGender = 'M' THEN '21'
                                   WHEN ConRelationship in ('DP') and ConGender = 'F' THEN '20'
                                   WHEN ConRelationship in ('STM')  THEN '15'
                                   WHEN ConRelationship in ('STF')  THEN '14'
                                   WHEN ConRelationship in ('STC') and ConGender = 'M' THEN '11'
                                   WHEN ConRelationship in ('STC') and ConGender = 'F' THEN '12'
                                   WHEN ConRelationship in ('FIA') and ConGender = 'M' THEN '22'
                                   WHEN ConRelationship in ('FIA') and ConGender = 'F' THEN '23'
                                   WHEN ConRelationship in ('PAR')  THEN '10'
                                   WHEN ConRelationship in ('EST')  THEN '41'
                                   WHEN ConRelationship in ('DPC') and ConGender = 'M' THEN '13'
                                   WHEN ConRelationship in ('DPC') and ConGender = 'F' THEN '12'
                                   ELSE '27'
                              END
        ,drvBenGroupNumber = '343569'
    INTO dbo.U_EAFLACCEXP_drvTblBen
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.BnfBPlan WITH (NOLOCK)
        ON BfpEEID = xEEID 
     JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BfpConRecID
    JOIN dbo.U_EAFLACCEXP_drvTblEmp WITH (NOLOCK)
        ON drvEEID = eepEEID
    WHERE ConIsBeneficiary = 'Y' and bfpdedcode in ('AFACC','GACC', 'GCIEE', 'GCISP')
    ;

    /*
    Update D set drvProdBenPrm = dbo.dsi_fnPadZero( (CASE WHEN drvProdRecInd = 'EMPL' THEN A.EmpPremAmount ELSE A.SpsPremAmt END) *100,7,0)
FROM U_EAFLACCEXP_drvTblProd D 
JOIN (
select drveeid,
    DateDiff(year,drvSpDateOfBirth,drvProdEffectiveDate) as SpsAge,
    DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) as EmpAge,
    drvProdHQ1,
    EmpPremAmount = ISNULL((CASE WHEN drvProdBenAmtRaw IS NOT NULL THEN (
            CASE WHEN IsSmoke = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge  and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
            END
    ) 
    END * (drvProdBenAmtRaw / 1000)),0)  ,

     SpsPremAmt = ISNULL((CASE WHEN drvProdBenAmtRaw IS NOT NULL THEN (
            CASE WHEN IsSmoke = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge  and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN IsSmoke = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode in ('GCIEE','GCISP') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
            END
    ) 
    END * (drvProdBenAmtRaw / 1000)),0)   

 from U_EAFLACCEXP_drvTblProd where drvProdRecDisc not IN ('ACCD','HIPL') ) A

  ON A.drveeid = D.drveeid
 and drvProdBenPrm is  null;
    */
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblMeta
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblMeta;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort = '99999999999999'
        ,drvSubSort = '6'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvMetaRecDisc = 'META'
        ,drvMetaGroupNumber = '343569'
        ,drvMetaVendorId = '100055'
        ,drvMetaFileType = 'F'
        ,drvMetaFileStatus = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' ELSE 'P' END
        ,drvMetaEnrollmentType = CASE WHEN @ExportCode LIKE 'OE%' THEN 'AE' ELSE 'NH' END
        ,drvMetaFileLayoutVersion = 'CSV2.6'
    INTO dbo.U_EAFLACCEXP_drvTblMeta
 
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
ALTER VIEW dbo.dsi_vwEAFLACCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLACCEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAFLACCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912051'
       ,expStartPerControl     = '201912051'
       ,expLastEndPerControl   = '201912129'
       ,expEndPerControl       = '201912129'
WHERE expFormatCode = 'EAFLACCEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAFLACCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLACCEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAFLACCEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAFLACCEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAFLACCEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAFLACCEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAFLACCEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAFLACCEXP', 'UseFileName', 'V', 'Y'


-- End ripout