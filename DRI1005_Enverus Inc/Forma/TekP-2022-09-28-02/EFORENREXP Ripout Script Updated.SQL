/**********************************************************************************

EFORENREXP: Forma Enrollment Export

FormatCode:     EFORENREXP
Project:        Forma Enrollment Export
Client ID:      DRI1005
Date/time:      2023-01-11 16:19:52.517
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP3DB01
Database:       ULTIPRO_WPDII
Web Filename:   DRI1005_1777G_EEHISTORY_EFORENREXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFORENREXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EFORENREXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFORENREXP'


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
WHERE FormatCode = 'EFORENREXP'
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
WHERE ExpFormatCode = 'EFORENREXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFORENREXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFORENREXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFORENREXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFORENREXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFORENREXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFORENREXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFORENREXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFORENREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFORENREXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFORENREXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFORENREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFORENREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFORENREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFORENREXP];
GO
IF OBJECT_ID('U_EFORENREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_PEarHist];
GO
IF OBJECT_ID('U_EFORENREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_PDedHist];
GO
IF OBJECT_ID('U_EFORENREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_File];
GO
IF OBJECT_ID('U_EFORENREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_EEList];
GO
IF OBJECT_ID('U_EFORENREXP_drvPT') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_drvPT];
GO
IF OBJECT_ID('U_EFORENREXP_drvENT') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_drvENT];
GO
IF OBJECT_ID('U_EFORENREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFORENREXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFORENREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFORENREXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFORENREXP','Forma Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EFORENREXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFORENREXPZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFORENREXPZ0','50','D','10','2',NULL,'Company ID',NULL,NULL,'"drvCompanyID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFORENREXPZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFORENREXPZ0','50','D','10','4',NULL,'Employee Work Email',NULL,NULL,'"drvEmployeeWorkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFORENREXPZ0','50','D','10','5',NULL,'Employee Personal Email',NULL,NULL,'"drvEmployeePersonalEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFORENREXPZ0','50','D','10','6',NULL,'Legal Name - First Name',NULL,NULL,'"drvLegalNameFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFORENREXPZ0','50','D','10','7',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFORENREXPZ0','50','D','10','8',NULL,'Legal Name - Last Name',NULL,NULL,'"drvLegalNameLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFORENREXPZ0','50','D','10','9',NULL,'Preferred Name - First Name',NULL,NULL,'"drvPreferredNameFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFORENREXPZ0','50','D','10','10',NULL,'Preferred Name - Last Name',NULL,NULL,'"drvPreferredNameLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFORENREXPZ0','50','D','10','11',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFORENREXPZ0','50','D','10','12',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFORENREXPZ0','50','D','10','13',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFORENREXPZ0','50','D','10','14',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFORENREXPZ0','50','D','10','15',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFORENREXPZ0','50','D','10','16',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFORENREXPZ0','50','D','10','17',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFORENREXPZ0','50','D','10','18',NULL,'Pay Schedule',NULL,NULL,'"drvPaySchedule"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFORENREXPZ0','50','D','10','19',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFORENREXPZ0','50','D','10','20',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EFORENREXPZ0','50','D','10','21',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EFORENREXPZ0','50','D','10','22',NULL,'Cost Center',NULL,NULL,'"drvCostCenter"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EFORENREXPZ0','50','D','10','23',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EFORENREXPZ0','50','D','10','24',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EFORENREXPZ0','50','D','10','25',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EFORENREXPZ0','50','D','10','26',NULL,'Leave Date',NULL,NULL,'"drvLeaveDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EFORENREXPZ0','50','D','10','27',NULL,'HDHP',NULL,NULL,'"drvHDHP"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EFORENREXPZ0','50','D','10','28',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EFORENREXPZ0','50','D','10','29',NULL,'Commuter Eligible',NULL,NULL,'"drvCommuterEligible"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EFORENREXPZ0','50','D','10','30',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFORENREXPZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFORENREXPZ0','50','D','20','2',NULL,'CompanyID',NULL,NULL,'"drvCompanyID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFORENREXPZ0','50','D','20','3',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFORENREXPZ0','50','D','20','4',NULL,'EmployeeWorkEmail',NULL,NULL,'"drvEmployeeWorkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFORENREXPZ0','50','D','20','5',NULL,'AccountType',NULL,NULL,'"drvAccountType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFORENREXPZ0','50','D','20','6',NULL,'PlanStartDate',NULL,NULL,'"drvPlanStartDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFORENREXPZ0','50','D','20','7',NULL,'PlanEndDate',NULL,NULL,'"drvPlanEndDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFORENREXPZ0','50','D','20','8',NULL,'EmployeePayPeriodElection',NULL,NULL,'"drvEmployeePayPeriodElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFORENREXPZ0','50','D','20','9',NULL,'EmployerPayPeriodElection',NULL,NULL,'"drvEmployerPayPeriodElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFORENREXPZ0','50','D','20','10',NULL,'EmployeeElection',NULL,NULL,'"drvEmployeeElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFORENREXPZ0','50','D','20','11',NULL,'EmployerElection',NULL,NULL,'"drvEmployerElection"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFORENREXPZ0','50','D','20','12',NULL,'AccountStatus',NULL,NULL,'"drvAccountStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFORENREXPZ0','50','D','20','13',NULL,'AccountStartDate',NULL,NULL,'"drvAccountStartDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFORENREXPZ0','50','D','20','14',NULL,'AccountEndDate',NULL,NULL,'"drvAccountEndDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFORENREXPZ0','50','D','20','15',NULL,'QLEChange',NULL,NULL,'"drvQLEChange"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFORENREXPZ0','50','D','20','16',NULL,'QLEType',NULL,NULL,'"drvQLEType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFORENREXPZ0','50','D','20','17',NULL,'CoverageTier',NULL,NULL,'"drvCoverageTier"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFORENREXP_20230111.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','J213F',NULL,NULL,NULL,'Active Open Enrollment Export','202301011','EMPEXPORT','OEACTIVE','Jan  3 2023 12:00AM','EFORENREXP',NULL,NULL,NULL,'202301011','Jan  1 2023 12:00AM','Dec 30 1899 12:00AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'us3kEpDRI1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202211259','EMPEXPORT','OEPASSIVE','Nov 23 2022 12:00AM','EFORENREXP',NULL,NULL,NULL,'202211259','Jan  1 2023 12:00AM','Dec 30 1899 12:00AM','202211251',NULL,'','','202211251',dbo.fn_GetTimedKey(),NULL,'us3kEpDRI1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','J213F',NULL,NULL,NULL,'Forma Enrollment Export ONDEM','202301061','EMPEXPORT','ONDEM_XOE','Jan  9 2023 12:00AM','EFORENREXP',NULL,NULL,NULL,'202301061','Jan  6 2023 12:00AM','Jan  1 2023 12:00AM','202301061',NULL,'','','202301061',dbo.fn_GetTimedKey(),NULL,'us3kEpDRI1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','J213F',NULL,NULL,NULL,'FORMA PreTax SCH WK SAT 9P EST','202301069','EMPEXPORT','SCH_EFOREN','Jan 11 2023 12:00AM','EFORENREXP',NULL,NULL,NULL,'202301069','Jan  6 2023 12:00AM','Dec 30 1899 12:00AM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'us3mWaDRI1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','J213F',NULL,NULL,NULL,'Test Purposes Only','202301111','EMPEXPORT','TEST_XOE','Jan 11 2023 12:00AM','EFORENREXP',NULL,NULL,NULL,'202301111','Jan 11 2023 12:00AM','Dec 30 1899 12:00AM','202301011',NULL,'','','202301011',dbo.fn_GetTimedKey(),NULL,'us3kEpDRI1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFORENREXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFORENREXP','D10','dbo.U_EFORENREXP_drvENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFORENREXP','D20','dbo.U_EFORENREXP_drvPT',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFORENREXP
-----------

IF OBJECT_ID('U_dsi_BDM_EFORENREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFORENREXP] (
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
-- Create table U_EFORENREXP_DedList
-----------

IF OBJECT_ID('U_EFORENREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFORENREXP_drvENT
-----------

IF OBJECT_ID('U_EFORENREXP_drvENT') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_drvENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvINitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvCompanyID] varchar(7) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeWorkEmail] varchar(50) NULL,
    [drvEmployeePersonalEmail] varchar(50) NULL,
    [drvLegalNameFirstName] varchar(100) NULL,
    [drvMiddleINitial] varchar(1) NOT NULL,
    [drvLegalNameLastName] varchar(100) NULL,
    [drvPreferredNameFirstName] varchar(1) NOT NULL,
    [drvPreferredNameLastName] varchar(1) NOT NULL,
    [drvAddressLINe1] nvarchar(258) NULL,
    [drvAddressLINe2] nvarchar(258) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvEmploymentStatus] varchar(10) NULL,
    [drvPaySchedule] varchar(9) NULL,
    [drvDateofBirth] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvDepartment] varchar(1) NOT NULL,
    [drvCostCenter] varchar(1) NOT NULL,
    [drvTermINationDate] varchar(1) NOT NULL,
    [drvEffectiveDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvLeaveDate] varchar(1) NOT NULL,
    [drvHDHP] varchar(1) NOT NULL,
    [drvEmploymentType] varchar(1) NOT NULL,
    [drvCommuterEligible] varchar(5) NOT NULL,
    [drvPhone] varchar(50) NULL
);

-----------
-- Create table U_EFORENREXP_drvPT
-----------

IF OBJECT_ID('U_EFORENREXP_drvPT') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_drvPT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvINitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvCompanyID] varchar(7) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeWorkEmail] varchar(50) NULL,
    [drvAccountType] varchar(7) NULL,
    [drvPlanStartDate] datetime NULL,
    [drvPlanEndDate] datetime NULL,
    [drvEmployeePayPeriodElection] varchar(30) NOT NULL,
    [drvEmployerPayPeriodElection] varchar(30) NOT NULL,
    [drvEmployeeElection] varchar(30) NOT NULL,
    [drvEmployerElection] varchar(30) NOT NULL,
    [drvAccountStatus] varchar(10) NOT NULL,
    [drvAccountStartDate] datetime NULL,
    [drvAccountEndDate] datetime NULL,
    [drvQLEChange] varchar(1) NOT NULL,
    [drvQLEType] varchar(1) NOT NULL,
    [drvCoverageTier] varchar(10) NULL
);

-----------
-- Create table U_EFORENREXP_EEList
-----------

IF OBJECT_ID('U_EFORENREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFORENREXP_File
-----------

IF OBJECT_ID('U_EFORENREXP_File') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EFORENREXP_PDedHist
-----------

IF OBJECT_ID('U_EFORENREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPARK] numeric NULL,
    [PdhTRAN] numeric NULL,
    [PdhFSA] numeric NULL,
    [PdhFSAD] numeric NULL,
    [PdhHSA] numeric NULL,
    [PdhERHSA] numeric NULL
);

-----------
-- Create table U_EFORENREXP_PEarHist
-----------

IF OBJECT_ID('U_EFORENREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFORENREXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFORENREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Enverus, INc

Created By: Marco Lagrosa
BusINess Analyst: Kim Ephraim/Lea KINg
Create Date: 11/21/2022
Service Request Number: TekP-2022-09-28-02

Purpose: Forma Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        01/11/2023     TekP-2022-09-28-02  Totally re-worked file. File was populating dupes and BDM needed flattening.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFORENREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFORENREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFORENREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFORENREXP';
SELECT * FROM dbo.U_dsi_INterfaceActivityLog WHERE FormatCode = 'EFORENREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFORENREXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFORENREXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFORENREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFORENREXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFORENREXP', 'SCH_EFOREN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFORENREXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFORENREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFORENREXP';

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
    -- Caution: Careful of cleanINg EE List if INcludINg paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active IN another company (transfer), or active IN more than one company
    DELETE FROM dbo.U_EFORENREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFORENREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'PARK,TRAN,FSA,FSAD,HSAI4,HSAF4,HSCI4,HSCF4,HSAI,HSAF,HSACI,HSACF,ERHSA';
    IF OBJECT_ID('U_EFORENREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFORENREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFORENREXP_DedList
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
    -- Build WorkINg Tables
    --==========================================

    -----------------------------
    -- WorkINg Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFORENREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFORENREXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhPARK     = SUM(CASE WHEN PdhDedCode IN ('PARK') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhTRAN     = SUM(CASE WHEN PdhDedCode IN ('TRAN') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSA      = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFSAD      = SUM(CASE WHEN PdhDedCode IN ('FSAD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhHSA      = SUM(CASE WHEN PdhDedCode IN ('HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF') THEN PdhEECurAmt ELSE 0.00 END) 
        ,PdhERHSA    = SUM(CASE WHEN PdhDedCode IN ('ERHSA') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_EFORENREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFORENREXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, THEN remove or comment out this lINe.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFORENREXP_drvENT
    ---------------------------------
    IF OBJECT_ID('U_EFORENREXP_drvENT','U') IS NOT NULL
        DROP TABLE dbo.U_EFORENREXP_drvENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvINitialSort = eepSSN
        ,drvSubSort = '1'
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'PT'
        ,drvCompanyID = 'enverus'
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeWorkEmail = EepAddressEMail
        ,drvEmployeePersonalEmail = eepAddressEMailAlternate
        ,drvLegalNameFirstName = EepNameFirst
        ,drvMiddleINitial = ''--LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvLegalNameLastName = EepNameLast
        ,drvPreferredNameFirstName = ''
        ,drvPreferredNameLastName = ''
        ,drvAddressLINe1 = QuoteName(EepAddressLINe1,'"')
        ,drvAddressLINe2 = QuoteName(EepAddressLINe2,'"')
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountry = 'US'
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'A' THEN 'Active'
                                    WHEN EecEmplStatus = 'T' THEN 'TermINated'
                                    WHEN EecEmplStatus = 'L' THEN 'LOA'
                                END
        ,drvPaySchedule =CASE WHEN eecpaygroup = 'USDIBW' THEN  'Bi-Weekly' END
        ,drvDateofBirth = eepdateofbirth
        ,drvEmployeeSSN = EepSSN
        ,drvDepartment = ''
        ,drvCostCenter = ''
        ,drvTermINationDate = ''
        ,drvEffectiveDate = dbo.dsi_fnGetMINMaxDates('MAX',BdmBenStartDate, CAST('20230101' as datetime) ) 
        ,drvHireDate = EecDateOfLastHire
        ,drvLeaveDate = ''
        ,drvHDHP = ''/*CASE WHEN bdmdedcode IN ('HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF') and BdmBenStatus = 'A' THEN 'TRUE' Else 'FALSE'
                    END*/
        ,drvEmploymentType = ''
        ,drvCommuterEligible = CASE WHEN bdmdedcode is not null THEN 'TRUE' Else 'FALSE' END
        ,drvPhone = CASE WHEN ISNULL(EepPhoneHomeNumber,'') <> '' THEN EepPhoneHomeNumber
                    ELSE efoPhoneNumber
                    END
                    
      
    INTO dbo.U_EFORENREXP_drvENT
    FROM dbo.U_EFORENREXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_INt_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (  Select  BdmEEID
                        ,BdmCOID
                        ,MAX(CASE WHEN bdmdedcode IN ('TRAN','PARK') THEN bdmdedcode END ) AS bdmdedcode 
                        ,MAX(CASE WHEN bdmdedcode IN ('TRAN','PARK') THEN BdmBenStartDate END) AS BdmBenStartDate 
                        ,MAX(CASE WHEN bdmdedcode IN ('TRAN','PARK') THEN BdmBenStopDate END) AS BdmBenStopDate 
                        FROM dbo.U_dsi_BDM_EFORENREXP
                        Where bdmdedcode IN ('TRAN','PARK')
                        Group by BdmEEID, BdmCOID 
               ) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --JOIN dbo.U_dsi_BDM_EFORENREXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpMPhon  WITH (NOLOCK)
        on efoEEID = xeeid
        and efoPhoneType = 'CEL'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFORENREXP_drvPT
    ---------------------------------
    IF OBJECT_ID('U_EFORENREXP_drvPT','U') IS NOT NULL
        DROP TABLE dbo.U_EFORENREXP_drvPT;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvINitialSort = eepSSN
        ,drvSubSort = '2'
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'EN'
        ,drvCompanyID = 'enverus'
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeWorkEmail = EepAddressEMail
        
        ,drvAccountType = CASE WHEN PARKbdmdedcode IS NOT NULL  THEN 'PARKING'
                               WHEN TRANbdmdedcode IS NOT NULL  THEN 'TRANSIT'
                               WHEN FSAbdmdedcode  IS NOT NULL  THEN 'FSA' 
                               WHEN FSADbdmdedcode IS NOT NULL  THEN 'DCFSA'
                               WHEN HSAbdmdedcode  IS NOT NULL  THEN 'HSA'
                               --WHEN BdmdedCode = 'ERHSA' THEN 'HSAER'
                            END
        ,drvPlanStartDate = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN (FSADbdmdedcode IS NOT NULL or FSAbdmdedcode IS NOT NULL) THEN  CAST(YEAR(getdate()+1) + '0101' as datetime) END
                                 WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN ALLbdmdedcode IS NOT NULL  THEN dbo.dsi_fnGetMINMaxDates('MAX',BdmBenStartDate, CAST(YEAR(getdate()) + '0101' as datetime) )  END
                                END
        ,drvPlanEndDate = CASE WHEN @ExportCode LIKE 'OE%' THEN 
                                    CASE WHEN (FSADbdmdedcode IS NOT NULL or FSAbdmdedcode IS NOT NULL)   THEN CAST(YEAR(getdate()+1) + '1231' as datetime)  END
                               WHEN @ExportCode NOT LIKE 'OE%' THEN 
                                    CASE WHEN ALLbdmdedcode IS NOT NULL  THEN dbo.dsi_fnGetMINMaxDates('MAX',BdmBenStartDate, CAST(YEAR(getdate()) + '1231' as datetime) )  END
                              END
        ,drvEmployeePayPeriodElection =   ISNULL(CASE WHEN PARKbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),PdhPARK) as varchar),'0.00') 
                                               WHEN TRANbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),PdhTRAN) as varchar),'0.00')
                                               WHEN FSAbdmdedcode  IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),PdhFSA) as varchar),'0.00') 
                                               WHEN FSADbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),PdhFSAD ) as varchar),'0.00')
                                               WHEN HSAbdmdedcode  IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),PdhHSA ) as varchar),'0.00')
                                            END,'0.00')
        ,drvEmployerPayPeriodElection =   ISNULL(CASE WHEN ERHSAbdmdedcode IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2),PdhERHSA) as varchar) END,'0.00')
        ,drvEmployeeElection =            ISNULL(CASE WHEN PARKbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),ParkBdmEEGoalAmt) as varchar),'0.00') 
                                               WHEN TRANbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),TRANBdmEEGoalAmt) as varchar),'0.00')
                                               WHEN FSAbdmdedcode  IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),FSABdmEEGoalAmt) as varchar),'0.00') 
                                               WHEN FSADbdmdedcode IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),FSADBdmEEGoalAmt ) as varchar),'0.00')
                                               WHEN HSAbdmdedcode  IS NOT NULL THEN ISNULL(CAST(CONVERT(DECIMAL(10,2),HSABdmEEGoalAmt ) as varchar),'0.00')
                                            END,'0.00')
        ,drvEmployerElection = ISNULL(CASE WHEN ERHSAbdmdedcode IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2),PdhERHSA) as varchar) END,'0.00')
        ,drvAccountStatus = CASE WHEN bdmbenstatus <> 'A' THEN 'TermINated' else 'Active' END
        ,drvAccountStartDate = CASE WHEN ALLbdmdedcode IS NOT NULL THEN dbo.dsi_fnGetMINMaxDates('MAX',BdmBenStartDate, CAST(YEAR(getdate()) + '0101' as datetime) ) END
        ,drvAccountEndDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvQLEChange = ''
        ,drvQLEType = ''
        ,drvCoverageTier = CASE WHEN INDbdmdedcode  IS NOT NULL THEN 'Individual'
                                WHEN FAMbdmdedcode  IS NOT NULL THEN 'Family'
                                WHEN FSADbdmdedcode IS NOT NULL THEN 'Separately'
                            END

    INTO dbo.U_EFORENREXP_drvPT
    FROM dbo.U_EFORENREXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_INt_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID

    JOIN (
                        SELECT  BdmEEID
                        ,BdmCOID
                        ,bdmbenstatus
                        ,bdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('TRAN') THEN bdmdedcode END ) AS TRANbdmdedcode 
                        ,MAX(CASE WHEN bdmdedcode IN ('PARK') THEN bdmdedcode END ) AS PARKbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('FSA') THEN bdmdedcode END ) AS FSAbdmdedcode 
                        ,MAX(CASE WHEN bdmdedcode IN ('FSAD') THEN bdmdedcode END ) AS FSADbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('ERHSA') THEN bdmdedcode END ) AS ERHSAbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('FSA','FSAD') THEN bdmdedcode END ) AS FSA2bdmdedcode 
                        ,MAX(CASE WHEN bdmdedcode IN ('HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF') THEN bdmdedcode END ) AS HSAbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('PARK', 'TRAN', 'FSA', 'FSAD', 'HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF','ERHSA') THEN bdmdedcode END ) AS ALLbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('HSAI4', 'HSCI4', 'HSAI', 'HSACI') THEN bdmdedcode END ) AS INDbdmdedcode
                        ,MAX(CASE WHEN bdmdedcode IN ('HSAF4', 'HSCF4', 'HSAF', 'HSACF') THEN bdmdedcode END ) AS FAMbdmdedcode

                        ,MAX(CASE WHEN bdmdedcode IN ('PARK', 'TRAN', 'FSA', 'FSAD', 'HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF','ERHSA') THEN BdmBenStartDate END ) AS BdmBenStartDate
                        ,MAX(CASE WHEN bdmdedcode IN ('PARK', 'TRAN', 'FSA', 'FSAD', 'HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF','ERHSA') THEN BdmBenStopDate END ) AS BdmBenStopDate

                        ,MAX(CASE WHEN bdmdedcode IN ('FSA', 'FSAD') THEN BdmBenStopDate END ) AS FSABdmBenStopDate
                       
                       
                        ,MAX(CASE WHEN bdmdedcode IN ('FSA') THEN BdmEEGoalAmt END ) as FSABdmEEGoalAmt
                        ,MAX(CASE WHEN bdmdedcode IN ('FSAD') THEN BdmEEGoalAmt END ) as FSADBdmEEGoalAmt
                        ,MAX(CASE WHEN bdmdedcode IN ('HSAI4', 'HSAF4', 'HSCI4', 'HSCF4', 'HSAI', 'HSAF', 'HSACI', 'HSACF','ERHSA') THEN BdmEEGoalAmt END ) as HSABdmEEGoalAmt
                        ,MAX(CASE WHEN bdmdedcode IN ('PARK') THEN  BdmEEGoalAmt END ) as ParkBdmEEGoalAmt
                        ,MAX(CASE WHEN bdmdedcode IN ('TRAN') THEN  BdmEEGoalAmt END ) as TRANBdmEEGoalAmt
                        FROM dbo.U_dsi_BDM_EFORENREXP WITH (NOLOCK)
                        WHERE bdmbenstatus IN ('A', 'T')
                        Group by BdmEEID ,BdmCOID ,bdmbenstatus,bdmdedcode
        
                ) BDM 
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT  JOIN dbo.U_EFORENREXP_PDedHist WITH (NOLOCK) -- MW Changed to Left JOIN 1/3/2023
        on PdhEEID = xeeid
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'TestINg') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFORENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFORENREXP_File (NOLOCK)
    ORDER BY  INitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EFORENREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211141'
       ,expStartPerControl     = '202211141'
       ,expLastEndPerControl   = '202211219'
       ,expEndPerControl       = '202211219'
WHERE expFormatCode = 'EFORENREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFORENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFORENREXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFORENREXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFORENREXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFORENREXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFORENREXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFORENREXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFORENREXP', 'UseFileName', 'V', 'Y'


-- End ripout